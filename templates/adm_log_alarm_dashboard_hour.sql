CREATE TABLE oseadb.{table_name} (
  ID bigint(20) NOT NULL AUTO_INCREMENT,
  NODE_CODE varchar(50) NOT NULL COMMENT 'Node ID',
  NODE_NAME varchar(255) NOT NULL COMMENT 'Node name',
  ALARM_TYPE varchar(255) NOT NULL COMMENT 'Alarm type',
  ALARM_LEVEL tinyint(3) NOT NULL COMMENT 'Alarm level, 1: High, 2: Medium, 3: Low',
  AMOUNT int(11) DEFAULT 0 COMMENT 'Total alarm count',
  PENDING_AMOUNT int(11) DEFAULT 0 COMMENT 'Total pending alarms',
  PROCESSED_AMOUNT int(11) DEFAULT 0 COMMENT 'Total processed alarms',
  ALARM_TIME bigint(20) NOT NULL COMMENT 'Alarm timestamp',
  CREATE_TIME datetime NOT NULL COMMENT 'Entry timestamp',
  MISREPORTED_AMOUNT int(11) DEFAULT 0 COMMENT 'Total alarms marked as false reports',
  PRIMARY KEY (ID),
  KEY ALARM_ANALYSIS_HOUR_TIME (ALARM_TIME, NODE_CODE)
) ENGINE=InnoDB AUTO_INCREMENT=1123 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Alarm dashboard statistics - hourly';
