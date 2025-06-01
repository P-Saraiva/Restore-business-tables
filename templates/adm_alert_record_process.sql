CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing ID',
  ALERT_ID bigint(20) unsigned NOT NULL COMMENT 'Alert ID',
  HANDLE_USER varchar(50) DEFAULT NULL COMMENT 'Handler username',
  HANDLE_TIME bigint(20) DEFAULT NULL COMMENT 'Handling time',
  HANDLE_MESSAGE varchar(1000) DEFAULT NULL COMMENT 'Handling message',
  HANDLE_STAT smallint(5) unsigned DEFAULT NULL COMMENT 'Handling status: 1 = Pending, 2 = In progress, 3 = Completed',
  USER_ID bigint(20) unsigned DEFAULT NULL COMMENT 'User ID',
  USER_NAME varchar(50) NOT NULL COMMENT 'Username',
  PRIMARY KEY (ID)
) ENGINE=InnoDB AUTO_INCREMENT=2024092900000000001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Operations and maintenance alert processing table';
