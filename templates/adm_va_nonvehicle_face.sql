CREATE TABLE oseadb.{table_name} (
  ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto increment ID',
  FACE_ID varchar(50) NOT NULL COMMENT 'Non-vehicle related face ID',
  FACE_ORDER int(11) DEFAULT NULL COMMENT 'Order',
  FACE_URL varchar(200) DEFAULT NULL COMMENT 'Face image URL',
  BODY_URL varchar(200) DEFAULT NULL COMMENT 'Body image URL',
  SEX tinyint(3) unsigned DEFAULT NULL COMMENT 'Gender',
  COMPLEXION tinyint(3) unsigned DEFAULT NULL COMMENT 'Complexion',
  MASK tinyint(3) unsigned DEFAULT NULL COMMENT 'Mask status, 0 unrecognized, 1 no, 2 yes',
  GLASS tinyint(3) unsigned DEFAULT NULL COMMENT 'Glasses status, 0 unrecognized, 1 no, 2 yes',
  MOUTH tinyint(3) unsigned DEFAULT NULL COMMENT 'Mouth status',
  EMOTION tinyint(3) DEFAULT -1 COMMENT 'Emotion, -1 unrecognized, 0 smile, 1 anger, 2 sadness, 3 disgust, 4 fear, 5 surprise, 6 normal, 7 big smile, 8 happy, 9 confused, 10 scream',
  IS_CALL tinyint(3) unsigned DEFAULT NULL COMMENT 'Is making a call, 0 unrecognized, 1 no, 2 yes',
  CARRIER_BAG tinyint(3) unsigned DEFAULT NULL COMMENT 'Is carrying a handbag, 0 unrecognized, 1 no, 2 yes',
  BAG tinyint(3) unsigned DEFAULT NULL COMMENT 'Is carrying a bag, 0 unrecognized, 1 no, 2 yes',
  UMBRELLA tinyint(3) unsigned DEFAULT NULL COMMENT 'Is holding an umbrella, 0 unrecognized, 1 no, 2 yes',
  UP_CLOTHES tinyint(3) unsigned DEFAULT NULL COMMENT 'Upper clothing',
  DOWN_CLOTHES tinyint(3) unsigned DEFAULT NULL COMMENT 'Lower clothing',
  UPPER_BODY_COLOR tinyint(3) unsigned DEFAULT NULL COMMENT 'Upper body clothing color',
  LOWER_BODY_COLOR tinyint(3) unsigned DEFAULT NULL COMMENT 'Lower body clothing color',
  CAPTURE_TIME datetime DEFAULT NULL COMMENT 'Capture time',
  CAPTURE_TIME_UTC bigint(20) DEFAULT NULL COMMENT 'Capture time in UTC',
  PRIMARY KEY (ID),
  KEY IDX_NONVEHICLE_FACE_ID (FACE_ID),
  KEY IDX_NONVEHICLE_FACE_UTC (CAPTURE_TIME_UTC)
) ENGINE=InnoDB AUTO_INCREMENT=2024092900000000001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Non-vehicle related face capture information';
