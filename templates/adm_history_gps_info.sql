CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Device code',
  LONGITUDE decimal(10,7) DEFAULT NULL COMMENT 'Longitude',
  LATITUDE decimal(10,7) DEFAULT NULL COMMENT 'Latitude',
  CAP_TIME_UTC bigint(20) DEFAULT NULL COMMENT 'Record time',
  DATA_TYPE tinyint(3) DEFAULT 0 COMMENT 'Data reporting type, 0: Real-time data reporting, 1: Re-upload data reporting',
  PRIMARY KEY (ID),
  KEY IDX_ADM_DEVICE_GPS_INFO_DEVICE_CODE (DEVICE_CODE, CAP_TIME_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024120100000000001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Device GPS reporting record table';
