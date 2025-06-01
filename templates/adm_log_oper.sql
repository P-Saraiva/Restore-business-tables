CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  USER_ID bigint(20) unsigned NOT NULL COMMENT 'Operator user ID',
  LOGIN_NAME varchar(50) DEFAULT NULL COMMENT 'Operator user name',
  LOG_TYPE tinyint(3) unsigned DEFAULT NULL COMMENT 'Log type',
  OPERATE_MODEL int(10) unsigned NOT NULL COMMENT 'Operation type',
  OPERATE_MEMO longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Operation description',
  CREATE_DATE datetime NOT NULL COMMENT 'Operation time',
  IP_ADDR varchar(50) DEFAULT NULL COMMENT 'Operator IP address',
  CREATE_TIME_UTC bigint(20) DEFAULT NULL COMMENT 'Creation time UTC',
  OPERATE_RESULT varchar(2) DEFAULT NULL COMMENT 'Operation result, 0: Failure, 1: Success, default is empty',
  PRIMARY KEY (ID),
  KEY IDX_LOG_OPER_CREATE_DATE_UTC (CREATE_TIME_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024110000000000302 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
