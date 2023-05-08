-- Use the ticket_sales database
USE ticket_sales;

-- Customer entries
INSERT INTO customer (customer_id, first_name, last_name, address, city, state, zip, email, phone)
VALUES
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'John', 'Doe', '123 Main St', 'Anytown', 'CA', 12345, 'john.doe@example.com', '555-1234'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Jane', 'Smith', '456 Elm St', 'Somewhere', 'NY', 67890, 'jane.smith@example.com', '555-5678'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Bob', 'Johnson', '789 Oak St', 'Nowhere', 'TX', 54321, 'bob.johnson@example.com', '555-9012'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Jimmy', 'Doe', '123 Main St', 'Anytown', 'CA', 12345, 'jimmy.doe@example.com', '555-1235'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Jane', 'Doe', '456 High St', 'Sometown', 'CA', 67890, 'jane.doe@example.com', '555-5678'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Bob', 'Smith', '789 Maple Ave', 'Othertown', 'CA', 24680, 'bob.smith@example.com', '555-2468'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Alice', 'Jones', '321 Oak St', 'Somewhere', 'CA', 13579, 'alice.jones@example.com', '555-1357'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Tom', 'Brown', '654 Pine St', 'Anywhere', 'CA', 97531, 'tom.brown@example.com', '555-9753'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Samantha', 'Wilson', '987 Cedar Ave', 'Nowhere', 'CA', 80246, 'samantha.wilson@example.com', '555-8024'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Mike', 'Lee', '246 Birch Blvd', 'Everytown', 'CA', 36901, 'mike.lee@example.com', '555-3690');

-- Production Contact entries
INSERT INTO production_contact (contact_id, contact_first_name, contact_last_name, contact_email, contact_phone)
VALUES
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'John', 'Doe', 'johndoe@example.com', '123-456-7890'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Jane', 'Smith', 'janesmith@example.com', '987-654-3210'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Alex', 'Johnson', 'alexjohnson@example.com', '555-555-5555');

INSERT INTO production_crew (producer_id, producer_name, contact_id, upcoming_events)
VALUES
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'John Doe', (SELECT contact_id FROM production_contact ORDER BY RAND() LIMIT 1), 'Crash Tour, Fever to Tell 20th Anniversary'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Jane Smith', (SELECT contact_id FROM production_contact ORDER BY RAND() LIMIT 1), '10,000 Gecs Tour, Juno Tour'),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Bob Johnson', (SELECT contact_id FROM production_contact ORDER BY RAND() LIMIT 1), 'Late Night Sessions');

-- Event entries
INSERT INTO events (event_id, event_name, performers, date, time, ticket_price, tickets_sold, age_restriction, producer_id)
VALUES
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Crash Tour', 'Charli XCX, A.G. Cook', '2023-05-15', '19:30:00', 50.00, 0, 18, (SELECT producer_id FROM production_crew ORDER BY RAND() LIMIT 1)),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Fever to Tell 20th Anniversary', 'Yeah Yeah Yeahs', '2023-05-17', '20:00:00', 25.00, 0, 21, (SELECT producer_id FROM production_crew ORDER BY RAND() LIMIT 1)),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), '10,000 Gecs Tour', '100gecs', '2023-05-20', '19:00:00', 35.00, 0, 16, (SELECT producer_id FROM production_crew ORDER BY RAND() LIMIT 1)),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Juno Tour', 'Remi Wolf', '2023-05-22', '14:00:00', 20.00, 0, 12, (SELECT producer_id FROM production_crew ORDER BY RAND() LIMIT 1)),
  (LPAD(FLOOR(RAND() * 99999), 5, '0'), 'Late Night Sessions', 'Bonobo', '2023-05-25', '00:30:00', 15.00, 0, 0, (SELECT producer_id FROM production_crew ORDER BY RAND() LIMIT 1));

-- Sales entries
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;


SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 4;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 1;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;
SET @quantity = 3;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

SET @quantity = 2;

INSERT INTO sales (sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total)
SELECT
  FLOOR(RAND() * 100000) AS sale_id,
  customer.customer_id,
  events.event_id,
  @quantity AS ticket_quantity,
  events.ticket_price AS ticket_price,
  events.ticket_price * @quantity * 0.05 AS fees,
  events.ticket_price * @quantity * 0.10 AS tax,
  (@quantity * events.ticket_price) + (events.ticket_price * 0.05) + (events.ticket_price * 0.10) AS sale_total
FROM customer
CROSS JOIN events
ORDER BY RAND()
LIMIT 1;

-- Calculate fees, tax, and sale_total columns
UPDATE sales
JOIN events ON sales.event_id = events.event_id
SET sales.ticket_price = events.ticket_price,
    sales.fees = events.ticket_price * 0.05,
    sales.tax = events.ticket_price * 0.10,
    sales.sale_total = (sales.ticket_quantity * events.ticket_price) + sales.fees + sales.tax;

UPDATE events
SET tickets_sold = (
  SELECT COALESCE(SUM(ticket_quantity), 0)
  FROM sales
  WHERE sales.event_id = events.event_id
);

SELECT event_id, SUM(sale_total) AS total_revenue
FROM sales
GROUP BY event_id;
ALTER TABLE events ADD COLUMN revenue DECIMAL(10, 2) DEFAULT 0.00;

UPDATE events
SET revenue = (
  SELECT SUM(sale_total) 
  FROM sales
  WHERE event_id = events.event_id
);
