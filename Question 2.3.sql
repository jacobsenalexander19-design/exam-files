-- 1. Create Schema
CREATE SCHEMA IF NOT EXISTS bi_trigger;

-- 2. Create Tables matching Figure 2.3
-- Table: fact_sale
CREATE TABLE bi_trigger.fact_sale (
    product_sk INT,
    product_durable_sk INT,
    date_sk INT,
    sales_quantity INT,
    unit_price INT
);

-- Table: product_current
CREATE TABLE bi_trigger.product_current (
    product_durable_sk INT PRIMARY KEY,
    product_name TEXT,
    product_category TEXT,
    last_update DATE
);

-- Table: product_history
-- Note: product_sk is SERIAL to allow default auto-incrementing
CREATE TABLE bi_trigger.product_history (
    product_sk SERIAL PRIMARY KEY,
    product_durable_sk INT,
    effective_date DATE,
    ineffective_date DATE,
    current_indicator BOOLEAN,
    product_name TEXT,
    product_category TEXT
);

-- 3. Insert Initial Data (Figure 2.3)
-- Insert into fact_sale
INSERT INTO bi_trigger.fact_sale (product_sk, product_durable_sk, date_sk, sales_quantity, unit_price)
VALUES 
(1, 1, 20230202, 10, 349),
(2, 2, 20231018, 5, 20),
(3, 1, 20230915, 15, 503);

-- Insert into product_current
INSERT INTO bi_trigger.product_current (product_durable_sk, product_name, product_category, last_update)
VALUES 
(1, 'Laptop X1 Pro', 'Electronics', '2023-11-09'),
(2, 'Smartphone Z2', 'Mobile Devices', '2023-10-10');

-- Insert into product_history
-- We omit 'product_sk' so it uses the DEFAULT value as requested in 2.3
INSERT INTO bi_trigger.product_history (product_durable_sk, effective_date, ineffective_date, current_indicator, product_name, product_category)
VALUES
(1, '2023-02-01', '2023-10-09', FALSE, 'Laptop X1', 'Electronics'),
(2, '2023-10-10', '9999-10-10', TRUE, 'Smartphone Z2', 'Mobile Devices'),
(1, '2023-11-09', '9999-11-09', TRUE, 'Laptop X1 Pro', 'Electronics');

-- 4. Create Function for SCD Type 2
CREATE OR REPLACE FUNCTION bi_trigger.update_product_scd()
RETURNS TRIGGER AS $$
BEGIN
    -- A. Expire the old active record
    UPDATE bi_trigger.product_history
    SET ineffective_date = CURRENT_DATE,
        current_indicator = FALSE
    WHERE product_durable_sk = OLD.product_durable_sk
      AND current_indicator = TRUE;

    -- B. Insert the new active record
    -- We use default for product_sk
    INSERT INTO bi_trigger.product_history (
        product_durable_sk, 
        effective_date, 
        ineffective_date, 
        current_indicator, 
        product_name, 
        product_category
    )
    VALUES (
        NEW.product_durable_sk, 
        CURRENT_DATE, 
        '9999-12-31', -- Standard far-future date for active records
        TRUE, 
        NEW.product_name, 
        NEW.product_category
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 5. Create Trigger
CREATE TRIGGER trg_product_update
AFTER UPDATE OF product_name ON bi_trigger.product_current
FOR EACH ROW
EXECUTE FUNCTION bi_trigger.update_product_scd();

-- 6. Execute Update and Verify
-- Update 'Laptop X1 Pro' to 'Laptop X1 Pro Business'
UPDATE bi_trigger.product_current
SET product_name = 'Laptop X1 Pro Business'
WHERE product_durable_sk = 1;

-- Verify the change in history table
SELECT * FROM bi_trigger.product_history ORDER BY product_sk;