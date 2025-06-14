CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Alarm device code',
  DEVICE_NAME varchar(50) DEFAULT NULL COMMENT 'Device name',
  UNIT_TYPE tinyint(3) unsigned DEFAULT NULL COMMENT 'Alarm unit type',
  UNIT_SEQ int(10) unsigned DEFAULT NULL COMMENT 'Alarm unit sequence number',
  CHANNEL_SEQ int(10) unsigned DEFAULT NULL COMMENT 'Alarm channel sequence number',
  CHANNEL_NAME varchar(50) DEFAULT NULL COMMENT 'Channel name',
  ALARM_STAT tinyint(3) unsigned NOT NULL COMMENT 'Alarm status; 1: Alarm generated, 2: Alarm cleared',
  ALARM_TYPE mediumint(8) unsigned NOT NULL COMMENT 'Alarm type',
  ALARM_DATE bigint(20) NOT NULL COMMENT 'Alarm time',
  ALARM_GRADE tinyint(3) unsigned NOT NULL COMMENT 'Alarm level',
  HANDLE_USER varchar(50) DEFAULT NULL COMMENT 'User login name who handled the alarm',
  HANDLE_DATE bigint(20) DEFAULT NULL COMMENT 'Handling time',
  HANDLE_MESSAGE varchar(600) DEFAULT NULL COMMENT 'Handling message',
  HANDLE_STAT smallint(5) unsigned DEFAULT NULL COMMENT 'Handling status',
  ALARM_PICTURE varchar(2000) DEFAULT NULL COMMENT 'Alarm picture path',
  ALARM_PICTURE_SIZE bigint(10) unsigned DEFAULT NULL COMMENT 'Alarm picture size',
  ALARM_CODE varchar(50) NOT NULL COMMENT 'Alarm code',
  MAIL_RECEIVERS longtext DEFAULT NULL COMMENT 'Email recipients',
  CHANNEL_ID varchar(100) DEFAULT NULL COMMENT 'Channel code',
  MEMO text DEFAULT NULL COMMENT 'Memo',
  GPSX float DEFAULT 0 COMMENT 'Longitude',
  GPSY float DEFAULT 0 COMMENT 'Latitude',
  HEIGHT float DEFAULT 0 COMMENT 'Altitude',
  ANGLE float DEFAULT 0 COMMENT 'Azimuth angle',
  SPEED float DEFAULT 0 COMMENT 'Speed',
  STREAM_TYPE tinyint(3) DEFAULT NULL COMMENT 'Stream type',
  RECORD_TIME int(10) DEFAULT NULL COMMENT 'Recording time in seconds',
  PRE_RECORD_TIME int(10) DEFAULT NULL COMMENT 'Pre-record time in seconds',
  LINK_CHANNEL_INFO text DEFAULT NULL COMMENT 'Link channel information',
  PRIMARY KEY (ID),
  KEY IDX_LOG_ALARM_ALARMCODE (ALARM_CODE, ALARM_DATE),
  KEY IDX_ALARM_CHANNEL_ID_DATE (CHANNEL_ID, ALARM_DATE),
  KEY IDX_LOG_ALARM_HANDLE_USER_CHANNEL_DATE (HANDLE_USER, CHANNEL_ID, ALARM_DATE),
  KEY IDX_LOG_ALARM_GRADE_USER_CHANNEL_DATE (ALARM_GRADE, CHANNEL_ID, ALARM_DATE),
  KEY IDX_LOG_ALARM_TYPE_USER_CHANNEL_DATE (ALARM_TYPE, CHANNEL_ID, ALARM_DATE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
