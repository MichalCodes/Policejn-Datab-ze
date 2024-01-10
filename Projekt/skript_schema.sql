-- Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2023-11-30 10:00:05 SEÈ
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE
/*
ALTER TABLE cases drop CONSTRAINT if exists case_criminal_history_fk 
ALTER TABLE criminal_history drop CONSTRAINT if exists criminal_history_person_fk
ALTER TABLE defendant drop CONSTRAINT if exists defendant_cases_fk
ALTER TABLE defendant drop CONSTRAINT if exists defendant_person_fk
ALTER TABLE evidence drop CONSTRAINT if exists evidence_case_fk
ALTER TABLE person drop CONSTRAINT if exists person_address_fk
ALTER TABLE witness drop CONSTRAINT if exists witness_case_fk
ALTER TABLE witness drop CONSTRAINT if exists witness_person_fk


drop table if exists adresa
drop table if exists cases
drop table if exists criminal_history
drop table if exists defendant
drop table if exists evidence
drop table if exists person
drop table if exists witness
*/

CREATE TABLE adresa (
    address_id  INTEGER NOT NULL,
    city        VARCHAR(20) NOT NULL,
    postal_code INTEGER NOT NULL,
    district    VARCHAR(20),
    street      VARCHAR(20) NOT NULL
);


CREATE TABLE cases (
    case_id             INTEGER NOT NULL,
    name                VARCHAR(20) NOT NULL,
    description         VARCHAR(1000) NOT NULL,
    type                VARCHAR(20) NOT NULL,
    detective           VARCHAR(20),
    judge               VARCHAR(20),
    strat_date          DATE NOT NULL,
    end_date            DATE,
    criminal_history_id INTEGER
);


CREATE TABLE criminal_history (
    criminal_history_id INTEGER NOT NULL,
    crime               VARCHAR(20),
    trest_type          VARCHAR(20),
    start_date          DATE,
    end_date            DATE,
    person_person_id    INTEGER
);

CREATE TABLE defendant (
    case_id   INTEGER NOT NULL,
    person_id INTEGER NOT NULL
);


CREATE TABLE evidence (
    evidence_id  INTEGER NOT NULL,
    type         VARCHAR(20) NOT NULL,
    description  VARCHAR(1000) NOT NULL,
    case_case_id INTEGER
);

CREATE TABLE person (
    person_id    INTEGER NOT NULL,
    first_name   VARCHAR(20) NOT NULL,
    last_name    VARCHAR(20) NOT NULL,
    fingerprint  IMAGE,
    phone_number INTEGER,
    birthdate    DATE NOT NULL,
    sex          CHAR(1) NOT NULL,
    address_id   INTEGER NOT NULL
);


CREATE TABLE witness (
    witness_id       int NOT NULL,
    statement        VARCHAR(1000),
    protection       CHAR(1) NOT NULL,
    person_person_id INTEGER,
    case_case_id     INTEGER
);
