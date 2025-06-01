CREATE TABLE oseadb.{table_name} (
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Device code',
  CHANNEL_SEQ int(11) NOT NULL COMMENT 'Channel sequence number',
  DEVICE_RULE_CODE varchar(50) NOT NULL COMMENT 'Rule ID on the device',
  RECORD_TIME date NOT NULL COMMENT 'Date (device local time, yyyy-MM-dd)',
  ENTERED_SUBTOTAL int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Total number of people entered during the day',
  EXITED_SUBTOTAL int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Total number of people exited during the day',
  PASSED_SUBTOTAL int(10) DEFAULT 0 COMMENT 'Number of people passed',
  RECORD_TIME_UTC bigint(20) unsigned NOT NULL COMMENT 'Date in UTC (milliseconds)',
  UNIT_SEQ int(11) unsigned NOT NULL COMMENT 'Unit sequence number',
  PRIMARY KEY (DEVICE_CODE, CHANNEL_SEQ, DEVICE_RULE_CODE, RECORD_TIME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Daily people flow statistics table (based on device time)';
