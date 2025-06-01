CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  ALARM_CODE varchar(50) NOT NULL COMMENT 'Alarm code',
  HANDLE_USER varchar(50) DEFAULT NULL COMMENT 'Processing user login',
  HANDLE_DATE datetime DEFAULT NULL COMMENT 'Processing timestamp',
  HANDLE_MESSAGE varchar(4000) DEFAULT NULL COMMENT 'Processing details',
  HANDLE_STAT smallint(5) unsigned DEFAULT NULL COMMENT 'Processing status',
  HANDLE_TIME_STAMP bigint(20) DEFAULT NULL COMMENT 'Processing UNIX timestamp',
  PRIMARY KEY (ID),
  KEY IDX_LOG_ALARM_PRO_ALARMCODE (ALARM_CODE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
