CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto increment ID',
  DEVICE_CODE varchar(50) NOT NULL COMMENT 'Device code',
  CHANNEL_SEQ bigint(12) unsigned NOT NULL COMMENT 'Channel sequence number',
  CHANNEL_ID varchar(50) NOT NULL COMMENT 'Channel ID',
  FACE_IMAGE_URL varchar(200) DEFAULT NULL COMMENT 'Face image URL',
  HUMAN_IMAGE_URL varchar(200) DEFAULT NULL COMMENT 'Human image URL',
  PICTURE_URL varchar(200) DEFAULT NULL COMMENT 'Scene image URL',
  GENDER tinyint(3) unsigned DEFAULT NULL COMMENT 'Gender',
  COAT tinyint(3) unsigned DEFAULT NULL COMMENT 'Coat, 0 unknown, 1 long sleeve, 2 short sleeve',
  COAT_COLOR tinyint(3) unsigned DEFAULT NULL COMMENT 'Coat color, 0 unknown, 1 white, 2 orange, 3 pink, 4 black, 5 red, 6 yellow, 7 gray, 8 blue, 9 green, 10 purple, 11 brown',
  TROUSERS tinyint(3) unsigned DEFAULT NULL COMMENT 'Trousers, 0 unknown, 1 long pants, 2 shorts, 3 skirt',
  TROUSERS_COLOR tinyint(3) unsigned DEFAULT NULL COMMENT 'Trousers color, same as coat color',
  HAT tinyint(3) unsigned DEFAULT NULL COMMENT 'Hat, 0 unknown, 1 wearing, 2 not wearing',
  BAG tinyint(3) unsigned DEFAULT NULL COMMENT 'Bag, 0 unknown, 1 no bag, 2 with bag',
  EMOTION tinyint(3) unsigned DEFAULT NULL COMMENT 'Emotion, 0 smile, 1 anger, 2 sadness, 3 disgust, 4 fear, 5 surprise, 6 normal, 7 big smile, 8 happy, 9 confused, 10 scream',
  GLASSES tinyint(3) unsigned DEFAULT NULL COMMENT 'Glasses, 0 none, 1 glasses, 2 sunglasses',
  BEARD tinyint(3) unsigned DEFAULT NULL COMMENT 'Beard, 1 not recognized, 2 no beard, 3 with beard',
  MASK tinyint(3) unsigned DEFAULT NULL COMMENT 'Mask, 1 not recognized, 2 no mask, 3 with mask',
  AGE tinyint(3) unsigned DEFAULT NULL COMMENT 'Age',
  CAPTURE_TIME datetime DEFAULT NULL COMMENT 'Capture time',
  FACE_IMG_TOP varchar(10) DEFAULT NULL COMMENT 'Face top coordinate in the image',
  FACE_IMG_LEFT varchar(10) DEFAULT NULL COMMENT 'Face left coordinate in the image',
  FACE_IMG_BOTTOM varchar(10) DEFAULT NULL COMMENT 'Face bottom coordinate in the image',
  FACE_IMG_RIGHT varchar(10) DEFAULT NULL COMMENT 'Face right coordinate in the image',
  HUMAN_IMG_TOP varchar(10) DEFAULT NULL COMMENT 'Human top coordinate in the image',
  HUMAN_IMG_LEFT varchar(10) DEFAULT NULL COMMENT 'Human left coordinate in the image',
  HUMAN_IMG_BOTTOM varchar(10) DEFAULT NULL COMMENT 'Human bottom coordinate in the image',
  HUMAN_IMG_RIGHT varchar(10) DEFAULT NULL COMMENT 'Human right coordinate in the image',
  REPORT_HOUR tinyint(2) unsigned zerofill DEFAULT 00 COMMENT 'Hour of the capture time',
  REPORT_WEEK tinyint(2) unsigned DEFAULT 0 COMMENT 'Week value of the capture time (0-6)',
  REPORT_DAY tinyint(2) unsigned zerofill DEFAULT 01 COMMENT 'Day value of the capture time (1-31)',
  CAPTURE_TIME_UTC bigint(20) DEFAULT NULL COMMENT 'Capture time in UTC',
  CHANNEL_NAME varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Channel name',
  CODE varchar(50) DEFAULT NULL COMMENT 'Human capture information code',
  PRIMARY KEY (ID),
  KEY IDX_HUMAN_CHANNEL_ID (CHANNEL_ID),
  KEY IDX_HUMAN_CAPTURE_TIME (CAPTURE_TIME),
  KEY IDX_ADM_VA_HUMAN_RECORD_CAPTURE_TIME_UTC_REPORT_HOUR_UNION (REPORT_HOUR, CHANNEL_ID, CAPTURE_TIME_UTC),
  KEY IDX_ADM_VA_HUMAN_RECORD_CAPTURE_TIME_UTC_REPORT_WEEK_UNION (REPORT_WEEK, CHANNEL_ID, CAPTURE_TIME_UTC),
  KEY IDX_ADM_VA_HUMAN_RECORD_CAPTURE_TIME_UTC_REPORT_DAY_UNION (REPORT_DAY, CHANNEL_ID, CAPTURE_TIME_UTC),
  KEY IDX_ADM_VA_HUMAN_RECORD_CHANNEL_ID_CAPTURE_TIME_UTC (CAPTURE_TIME_UTC, CHANNEL_ID)
) ENGINE=InnoDB AUTO_INCREMENT=2024092900000000001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Human capture information';
