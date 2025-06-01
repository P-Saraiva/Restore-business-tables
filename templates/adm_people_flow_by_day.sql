CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto increment ID',
  RECORD_TIME datetime NOT NULL COMMENT 'Date (yyyy-MM-dd)',
  RECORD_TIME_UTC bigint(20) unsigned NOT NULL COMMENT 'Start time of the day (in milliseconds)',
  DEVICE_CODE varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Device code',
  UNIT_SEQ int(10) unsigned NOT NULL COMMENT 'Unit sequence number',
  CHANNEL_SEQ int(5) NOT NULL COMMENT 'Channel sequence number',
  CHANNEL_ID varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Channel code',
  DEVICE_RULE_CODE varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'Rule ID on the device',
  ENTERED_SUBTOTAL int(5) unsigned NOT NULL DEFAULT 0 COMMENT 'Total number of people entered during the day',
  EXITED_SUBTOTAL int(5) unsigned NOT NULL DEFAULT 0 COMMENT 'Total number of people exited during the day',
  PASSED_SUBTOTAL int(10) DEFAULT 0 COMMENT 'Number of people passed',
  STAT int(2) DEFAULT NULL COMMENT 'Record status: 1 = Device reported, 2 = Active retransmission',
  PRIMARY KEY (ID),
  KEY IDX_PEOPLE_FLOW_DRECORD_TIME (RECORD_TIME),
  KEY IDX_PEOPLE_FLOW_DRECORD_TIME_UTC (RECORD_TIME_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024120000000000283 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Daily people flow statistics table';
