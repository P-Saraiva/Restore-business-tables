CREATE TABLE oseadb.{table_name} (
  ID bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Device code',
  DEVICE_NAME varchar(50) NOT NULL COMMENT 'Device name',
  CALL_TYPE tinyint(2) NOT NULL COMMENT 'Call type',
  ROOM_ID varchar(30) NOT NULL COMMENT 'Room number',
  CALL_ID bigint(20) DEFAULT NULL COMMENT 'Call record ID',
  CREATE_DATE datetime NOT NULL COMMENT 'Creation timestamp',
  CREATE_DATE_UTC bigint(20) DEFAULT NULL COMMENT 'Creation UTC timestamp',
  PRIMARY KEY (ID),
  KEY IDX_VTALK_CALL_ID (CALL_ID),
  KEY IDX_VTALK_DEVICE_CALL_REC_UTC (CREATE_DATE_UTC),
  KEY IDX_VTALK_DEVICE_CALL_REC_DEVICE_UTC (DEVICE_CODE, CREATE_DATE_UTC),
  KEY IDX_VTALK_DEVICE_CALL_REC_ROOM_UTC (ROOM_ID, CREATE_DATE_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024110000000000014 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Device call record table';
