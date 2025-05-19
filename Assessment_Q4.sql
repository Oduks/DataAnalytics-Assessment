-- ==========================================================
-- Customer Lifetime Value (CLV) Estimation
-- This script calculates the estimated CLV for each customer 
-- based on their transaction history and profit per transaction.
-- ==========================================================

-- Step 1: Calculate Transaction Metrics for Each Customer
WITH user_transactions AS (
    SELECT
        u.id AS customer_id,                    -- Customer ID
        CONCAT(u.first_name, ' ', u.last_name) AS name, -- Customer Full Name
        
        -- Calculate customer tenure in months since their first transaction
        TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), SYSDATE()) AS tenure_months,
        
        -- Total number of transactions for the customer
        COUNT(s.plan_id) AS total_transactions,
        
        -- Average profit per transaction (0.1% of transaction value)
        AVG((s.amount / 100) * 0.001) AS avg_profit_per_transaction
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id, u.first_name, u.last_name
)

-- Step 2: Calculate Estimated Customer Lifetime Value (CLV)
SELECT 
    customer_id,                              -- Customer ID
    name,                                      -- Customer Full Name
    tenure_months,                            -- Customer Tenure in Months
    total_transactions,                       -- Total Transactions Made
    ROUND(
        (total_transactions / GREATEST(tenure_months, 1)) * 12 * avg_profit_per_transaction, 2
    ) AS estimated_CLV -- Estimated Customer Lifetime Value (CLV)
FROM 
    user_transactions;
