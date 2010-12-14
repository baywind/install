CREATE DATABASE 'Contacts' DEFAULT CHARACTER SET utf8;

CREATE TABLE CNT_CONTACT (
  CON_ID int NOT NULL,
  CONTACT_STRING varchar(255),
  CNT_FLAGS smallint NOT NULL,
  KIND_DESRIPT varchar(28),
  PERS_ENTITY smallint NOT NULL,
  PERSON_ID int NOT NULL,
  CNT_TYPE smallint NOT NULL,
  PRIMARY KEY (CON_ID)
);

CREATE TABLE CNT_TYPE (
  CT_ID smallint NOT NULL,
  TYPE_NAME varchar(28),
  UTILISER_CLASS varchar(255),
  PRIMARY KEY (CT_ID)
);
INSERT INTO CNT_TYPE VALUES (1,'e-mail','net.rujel.contacts.EMailUtiliser');

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
);