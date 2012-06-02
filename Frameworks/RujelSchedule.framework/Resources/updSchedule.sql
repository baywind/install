-- Schema updates for Schedule model --

-- v1 (0.9.1) --

CREATE TABLE SDL_RING (
  R_ID smallint NOT NULL,
  SEQ_NUM smallint NOT NULL,
  TIME_SCHEME smallint NOT NULL DEFAULT 0,
  START_TIME time,
  END_TIME time,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

CREATE TABLE SDL_SCHEDULE (
  S_ID mediumint NOT NULL,
  WEEKDAY_NUM smallint NOT NULL,
  SEQ_NUM smallint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  PLACE_ID smallint NOT NULL DEFAULT 0,
  SDL_FLAGS tinyint NOT NULL,
  OTHER_TEACHER mediumint,
  REASON_ID mediumint,
  VALID_SINCE date,
  VALID_TO date,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE SDL_PLACE (
  P_ID smallint NOT NULL,
  SHORT_TITLE varchar(10) NOT NULL,
  FULL_NAME varchar(255),
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('Schedule',1,'0.9.1');

-- v2 (0.9.4) --

ALTER TABLE SDL_SCHEDULE ADD INDEX (EDU_COURSE);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('Schedule',2,'0.9.4');
