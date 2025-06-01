package main

import (
	"database/sql"
	"embed"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strings"
	"unicode"

	//"log" implementar log

	"github.com/go-sql-driver/mysql"
)

// Configuração do banco de dados
var DBConfig = struct {
	Host     string
	User     string
	Password string
	Database string
	Port     string
}{
	Host:     "localhost",
	User:     "",
	Password: "DmRVBOUNHCZuTJG3",
	Database: "",
	Port:     "",
}

//go:embed templates
var templates embed.FS

func getParentDirectory() (string, error) {
	cmd := exec.Command("powershell", "-Command", fmt.Sprintf(`
		$service = Get-Service | Where-Object { $_.Name -like '%s*' } | Select-Object -First 1
		if ($service) {
			$serviceConfig = (Get-WmiObject -Class Win32_Service -Filter "Name='$($service.Name)'").PathName
			$servicePath = ($serviceConfig -split '"')[1]
			(Get-Item $servicePath).Directory.Parent.FullName
		} else {
			""
		}`, "Intelbras Defense"))

	out, err := cmd.Output()
	if err != nil {
		return "", fmt.Errorf("falha ao executar o comando PowerShell: %w", err)
	}

	parentPath := strings.TrimSpace(string(out))
	if parentPath == "" {
		return "", fmt.Errorf("diretório pai não encontrado")
	}

	return parentPath, nil
}

// Função para carregar os templates SQL dos arquivos
func loadTableTemplates() (map[string]string, error) {
	templatesMap := make(map[string]string)

	// Listar arquivos no diretório templates
	files, err := templates.ReadDir("templates")
	if err != nil {
		return nil, err
	}

	// Carregar o conteúdo dos arquivos templates
	for _, file := range files {
		if strings.HasSuffix(file.Name(), ".sql") {
			templateName := strings.TrimSuffix(file.Name(), ".sql")
			templateContent, err := templates.ReadFile(fmt.Sprintf("templates/%s", file.Name()))
			if err != nil {
				return nil, err
			}
			templatesMap[templateName] = string(templateContent)
		}
	}

	return templatesMap, nil
}

// Função para ler o arquivo my.ini e extrair a porta da seção [mysqld]
func getPortFromMyIni(filePath string) (string, error) {
	content, err := os.ReadFile(filePath)
	if err != nil {
		return "", err
	}

	re := regexp.MustCompile(`(?m)^\[mysqld\][^[]*?port\s*=\s*(\d+)`)
	match := re.FindStringSubmatch(string(content))
	if len(match) > 1 {
		return match[1], nil
	}

	return "", fmt.Errorf("porta não encontrada na seção [mysqld]")
}

// Função para validar a senha
func isValidPassword(password string) bool {
	if len(password) != 16 {
		return false
	}
	for _, char := range password {
		if !unicode.IsLetter(char) && !unicode.IsDigit(char) {
			return false
		}
	}
	return true
}

func setDbInfo(path string) (string, error) {
	DBConfig.User = "mysql"
	DBConfig.Database = "oseadb"
	DBConfig.Host = "localhost"
	DBConfig.Password = os.Args[1]
	password := DBConfig.Password
	if !isValidPassword(password) {
		return "", fmt.Errorf("senha inválida: deve ter 16 caracteres alfanuméricos")
	}
	// Ler a porta do arquivo my.ini
	port, err := getPortFromMyIni(path + "/etc/my.ini")
	if err != nil {
		return "", err
	}
	DBConfig.Port = port
	return "mysql info", err
}

// Função para testar a conexão com o banco de dados
func testDBConnection() error {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", DBConfig.User, DBConfig.Password, DBConfig.Host, DBConfig.Port, DBConfig.Database)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return err
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		return fmt.Errorf("falha ao conectar ao banco de dados: %w", err)
	}

	fmt.Println("Conexão com o banco de dados bem-sucedida!")
	return nil
}

// Função para extrair nomes das tabelas a partir dos arquivos
func getTableNamesFromFiles(directory string, templates map[string]string) ([][3]string, error) {
	var tableData [][3]string
	fmt.Println("Procurando arquivos no diretório:", directory)

	// Regex para capturar o nome base e a data
	re := regexp.MustCompile(`([a-zA-Z0-9_]+)_(\d{8})(?:_(\d+))?`)

	// Função recursiva para buscar arquivos em subdiretórios
	var searchFiles func(string) ([]os.DirEntry, error)
	searchFiles = func(dir string) ([]os.DirEntry, error) {
		var allFiles []os.DirEntry
		files, err := os.ReadDir(dir)
		if err != nil {
			return nil, err
		}

		for _, file := range files {
			if file.IsDir() {
				subDirFiles, err := searchFiles(dir + "/" + file.Name())
				if err != nil {
					return nil, err
				}
				allFiles = append(allFiles, subDirFiles...)
			} else {
				allFiles = append(allFiles, file)
			}
		}
		return allFiles, nil
	}

	// Buscar arquivos em todos os subdiretórios
	files, err := searchFiles(directory)
	if err != nil {
		return nil, err
	}

	// Verificar se o nome do arquivo corresponde ao padrão
	for _, file := range files {
		if match := re.FindStringSubmatch(file.Name()); match != nil {
			templateKey := match[1] // Nome base do arquivo
			tableName := match[0]   // Nome completo do arquivo
			date := match[2]        // Data no nome do arquivo

			// Verificar se temos um template para esse tipo de tabela
			if _, ok := templates[templateKey]; ok {
				tableData = append(tableData, [3]string{tableName, templateKey, date})
			}
		}
	}

	return tableData, nil
}

func populateTable(filePath string) error {

	// Executar o comando mysql para popular a tabela
	cmd := exec.Command(os.Getenv("MYSQL_BIN")+"/mysql", "-u"+DBConfig.User, "-p"+DBConfig.Password, DBConfig.Database, "-e", "source "+filePath)
	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("erro ao executar o comando mysql: %w, output: %s", err, string(output))
	}

	// Ler o conteúdo do arquivo SQL
	content, err := os.ReadFile(filePath)
	if err != nil {
		return fmt.Errorf("erro ao ler o arquivo %s: %w", filePath, err)
	}

	// Conectar ao banco de dados
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", DBConfig.User, DBConfig.Password, DBConfig.Host, DBConfig.Port, DBConfig.Database)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return fmt.Errorf("erro ao conectar ao banco de dados: %w", err)
	}
	defer db.Close()

	// Executar o conteúdo do arquivo SQL
	_, err = db.Exec(string(content))
	if err != nil {
		return fmt.Errorf("erro ao executar o SQL do arquivo %s: %w", filePath, err)
	}

	return nil
}

// Função para criar as tabelas no banco de dados
func createTablesInDB(tableData [][3]string, templates map[string]string, directory string) error {
	// Conectar ao banco de dados
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", DBConfig.User, DBConfig.Password, DBConfig.Host, DBConfig.Port, DBConfig.Database)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return err
	}
	defer db.Close()

	// Criar tabelas usando os templates
	for _, data := range tableData {
		tableName := data[0]
		templateKey := data[1]
		date := data[2][:6]
		createTableSQL := strings.Replace(templates[templateKey], "{table_name}", tableName, -1)
		_, err := db.Exec(createTableSQL)
		if err != nil {
			// Verificar se o erro é "Table already exists"
			if mysqlErr, ok := err.(*mysql.MySQLError); ok && mysqlErr.Number == 1050 {
				fmt.Printf("Tabela %s já existe, ignorando...\n", tableName)
			} else {
				return err
			}
		} else {
			fmt.Printf("Tabela %s criada com sucesso!\n", tableName)
		}

		// Chamar a função para popular a tabela
		fmt.Printf("Populando a tabela %s...\n", tableName)
		filePath := fmt.Sprintf("%s\\%s\\%s\\%s.sql", directory, templateKey, templateKey+"_"+date, tableName)
		fmt.Printf("Caminho: %s\n", filePath)
		err = populateTable(filePath)
		if err != nil {
			fmt.Printf("Erro ao popular a tabela %s: %v\n", tableName, err)
		} else {
			fmt.Printf("Tabela %s populada com sucesso!\n", tableName)
		}
	}

	return nil
}

func main() {
	parentPath, err := getParentDirectory()
	if err != nil {
		fmt.Println("Erro ao obter o diretório pai:", err)
		return
	}
	// Carregar templates SQL
	templates, err := loadTableTemplates()
	if err != nil {
		fmt.Println("Erro ao carregar templates:", err)
		return
	}

	// Diretório onde os arquivos de dados estão localizados
	directory := parentPath + "\\bak\\business_table\\oseadb"

	// Diretório da pasta mysql
	mysqlPath := parentPath + "/mysql"

	// Define o diretório bin como variável de ambiente
	os.Setenv("MYSQL_BIN", mysqlPath+"/bin")
	// Verifica se a variável foi setada corretamente
	fmt.Println("MYSQL_BIN:", os.Getenv("MYSQL_BIN"))

	_, err = setDbInfo(mysqlPath)
	if err != nil {
		fmt.Println("Erro ao configurar informações do banco de dados:", err)
		return
	}

	// Testar a conexão com o banco de dados
	err = testDBConnection()
	if err != nil {
		fmt.Println(err)
		return
	}

	// Obter nomes das tabelas a partir dos arquivos
	tableData, err := getTableNamesFromFiles(directory, templates)
	if err != nil {
		fmt.Println("Erro ao obter nomes de tabelas:", err)
		return
	}

	// Criar as tabelas no banco de dados
	if len(tableData) > 0 {
		err = createTablesInDB(tableData, templates, directory)
		if err != nil {
			fmt.Println("Erro ao criar tabelas:", err)
		}
	} else {
		fmt.Println("Nenhuma tabela encontrada para criar.")
	}
}
