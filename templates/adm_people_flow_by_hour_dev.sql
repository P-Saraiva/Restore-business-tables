CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Device code',
  UNIT_SEQ int(11) unsigned NOT NULL COMMENT 'Unit sequence number',
  CHANNEL_SEQ int(11) NOT NULL COMMENT 'Channel sequence number',
  DEVICE_RULE_CODE varchar(50) NOT NULL COMMENT 'Device tripwire rule ID',
  RECORD_TIME datetime NOT NULL COMMENT 'Record time (device local time, accurate to hour)',
  ENTERED_SUBTOTAL int(11) DEFAULT 0 COMMENT 'Number of people entered',
  EXITED_SUBTOTAL int(11) DEFAULT 0 COMMENT 'Number of people exited',
  PASSED_SUBTOTAL int(10) DEFAULT 0 COMMENT 'Number of people passed',
  CREATE_TIME_UTC bigint(20) unsigned NOT NULL COMMENT 'Record creation time UTC (milliseconds)',
  RECORD_TIME_UTC bigint(20) unsigned NOT NULL COMMENT 'Record time in UTC (milliseconds)',
  PRIMARY KEY (ID),
  KEY IDX_FLOW_ECORD_TIME (RECORD_TIME)
) ENGINE=InnoDB AUTO_INCREMENT=2024110000000000626 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='People flow statistics table (by device time)';
