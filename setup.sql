-- create database
CREATE DATABASE IF NOT EXISTS ticket_sales;

-- use the ticket_sales database
USE ticket_sales;

-- create tables
-- customer
CREATE TABLE IF NOT EXISTS customer
(
  customer_id           INT(15)       PRIMARY KEY,
  first_name            VARCHAR(255),
  last_name             VARCHAR(255),
  address               VARCHAR(255),
  city                  VARCHAR(255),
  state                 VARCHAR(2),
  zip                   INT(5),
  email                 VARCHAR(255),
  phone                 VARCHAR(20)
);

-- events
CREATE TABLE IF NOT EXISTS events
(
  event_id              INT(15)       PRIMARY KEY,
  event_name            VARCHAR(255),
  performers            VARCHAR(255),
  date                  DATE,
  time                  TIME,
  ticket_price          DECIMAL(5,2),
  tickets_sold          INT(3),
  age_restriction       INT(2),
  producer_id           INT(15)
);

-- production contact
CREATE TABLE IF NOT EXISTS production_contact
(
  contact_id            INT(15)       PRIMARY KEY,
  contact_first_name    VARCHAR(255),
  contact_last_name     VARCHAR(255),
  contact_email         VARCHAR(255),
  contact_phone         VARCHAR(20)
);

-- production crew
CREATE TABLE IF NOT EXISTS production_crew
(
  producer_id           INT(15)       PRIMARY KEY,
  producer_name         VARCHAR(255),
  contact_id            INT(15),
  upcoming_events       VARCHAR(255),
  CONSTRAINT fk_crew_contact
    FOREIGN KEY (contact_id)
    REFERENCES production_contact(contact_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- sales
CREATE TABLE IF NOT EXISTS sales
(
  sale_id               CHAR(5)       NOT NULL,
  customer_id           INT(15),
  event_id              INT(15),
  ticket_quantity       INT(1),
  ticket_price          DECIMAL(5,2),
  fees                  DECIMAL(5,2),
  tax                   DECIMAL(5,2),
  sale_total            DECIMAL(5,2),
  CONSTRAINT pk_sales PRIMARY KEY (sale_id),
  CONSTRAINT fk_sales_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_sales_event
    FOREIGN KEY (event_id)
    REFERENCES events(event_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);