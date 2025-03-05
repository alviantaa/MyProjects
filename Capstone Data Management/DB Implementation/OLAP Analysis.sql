-- grouping set
SELECT cust_id, account_id, SUM(balance) AS total_balance
FROM finproDimCustomers
GROUP BY GROUPING SETS (
    (cust_id),
    (account_id),
    (cust_id, account_id),
    ()
);

-- Rollup
SELECT branch_code, account_type, SUM(amount) AS total_transaction
FROM finproFactTransactions t
JOIN finproDimCustomers c ON t.account_id = c.account_id
GROUP BY ROLLUP (branch_code, account_type);

-- Cube
SELECT 
    EXTRACT(YEAR FROM date_joined) AS year_of_joining,
    country,
    SUM(balance + COALESCE(amount, 0)) AS closing_balance
FROM finproDimCustomers c
LEFT JOIN finproFactTransactions t ON c.account_id = t.account_id
GROUP BY CUBE (EXTRACT(YEAR FROM date_joined), country);

-- MQT
CREATE MATERIALIZED VIEW Total_transaction_per_branch AS
SELECT c.branch_code, SUM(t.amount) AS total_transaction
FROM finproFactTransactions t
JOIN finproDimCustomers c ON t.account_id = c.account_id
GROUP BY c.branch_code;

REFRESH MATERIALIZED VIEW Total_transaction_per_branch;
SELECT * FROM Total_transaction_per_branch;


select * from finprodimcountries;