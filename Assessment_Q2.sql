-- ==========================================================
-- Customer Transaction Frequency Analysis
-- This script categorizes customers into frequency groups 
-- (High, Medium, Low) based on their average monthly transaction count.
-- It also calculates the average transactions per month for each category.
-- ==========================================================

WITH transaction_summary AS (
    -- Calculate average transactions per month for each customer
    SELECT 
        u.id AS customer_id, 
        COUNT(s.savings_id) / COUNT(DISTINCT CONCAT(YEAR(s.transaction_date), '-', MONTH(s.transaction_date))) AS avg_transaction_per_month,
        
        -- Categorize customers based on transaction frequency
        CASE 
            WHEN (COUNT(s.savings_id) / COUNT(DISTINCT CONCAT(YEAR(s.transaction_date), '-', MONTH(s.transaction_date)))) > 10 THEN 'High Frequency'
            WHEN (COUNT(s.savings_id) / COUNT(DISTINCT CONCAT(YEAR(s.transaction_date), '-', MONTH(s.transaction_date)))) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id
)
-- Aggregate results to provide a summary for each frequency category
SELECT 
    frequency_category,                    -- Transaction frequency category (High, Medium, Low)
    COUNT(*) AS customer_count,            -- Total number of customers in each category
    ROUND(AVG(avg_transaction_per_month), 2) AS avg_transactions_per_month -- Average monthly transactions in each category
FROM 
    transaction_summary
GROUP BY 
    frequency_category;
