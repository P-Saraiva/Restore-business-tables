CREATE TABLE oseadb.{table_name} (
  ID bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  CALLING_PARTY varchar(20) NOT NULL COMMENT 'Calling party',
  CALLED_PARTY varchar(20) NOT NULL COMMENT 'Called party',
  CALL_TIME datetime NOT NULL COMMENT 'Call timestamp',
  CALL_TIME_UTC bigint(20) DEFAULT NULL COMMENT 'Call UTC timestamp',
  END_STATE tinyint(3) NOT NULL COMMENT 'Final state (0 = missed, 1 = answered)',
  TALK_TIME bigint(20) NOT NULL COMMENT 'Talk duration in seconds',
  PICTURE_PATH varchar(250) DEFAULT NULL COMMENT 'Image path',
  RECORD_ID varchar(64) DEFAULT NULL COMMENT 'Record ID',
  PRIMARY KEY (ID),
  KEY IDX_TALK_CALL_TIME (CALL_TIME),
  KEY IDX_TALK_CALL_TIME_UTC (CALL_TIME_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024110000000000009 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Call log table';
