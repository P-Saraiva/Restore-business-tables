CREATE TABLE oseadb.{table_name} (
  ID bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  PERSON_ID varchar(64) DEFAULT NULL COMMENT 'Personnel information ID',
  CHANNEL_ID varchar(50) NOT NULL COMMENT 'Channel ID',
  CAPTURE_TIME bigint(20) NOT NULL COMMENT 'Capture time',
  FACE_FEATURE_VECTOR text DEFAULT NULL COMMENT 'Feature vector value',
  FACE_FEATURE_VERSION varchar(64) DEFAULT NULL COMMENT 'Face recognition algorithm version',
  CODE varchar(50) NOT NULL COMMENT 'Personnel capture information CODE, controlled by upper-level business, unique key, corresponds to CODE in the personnel capture table',
  PRIMARY KEY (ID),
  KEY IDX_FACE_FEATURE_TIME (CAPTURE_TIME)
) ENGINE=InnoDB AUTO_INCREMENT=2024092900000000001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Face feature value record table';
