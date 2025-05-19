-- ==========================================================
-- Customer Inactive Transactions Analysis
-- This script identifies customers with inactive plans 
-- (no transactions for over a year) and categorizes the type of plan.
-- ==========================================================

-- Step 1: Calculate the latest transaction date for each plan and owner
WITH latest_transactions AS (
    SELECT 
        s.plan_id,                    -- Plan ID associated with the transaction
        s.owner_id,                   -- Owner ID (Customer ID)
        MAX(s.transaction_date) AS last_transaction_date -- Most recent transaction date
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.plan_id, s.owner_id
),

-- Step 2: Categorize plans and calculate inactivity duration
transaction_tb AS (
    SELECT 
        p.id,                         -- Plan ID
        p.owner_id,                   -- Owner ID (Customer ID)
        
        -- Categorize each plan as Investment, Savings, or Other
        CASE 
            WHEN p.is_a_fund = 1 THEN 'Investment'
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            ELSE 'Other'
        END AS type,
        
        lt.last_transaction_date,     -- Last transaction date for the plan
        
        -- Calculate inactivity period in days
        DATEDIFF(SYSDATE(), DATE(lt.last_transaction_date)) AS inactive_days
    FROM 
        plans_plan p
    JOIN 
        latest_transactions lt ON p.id = lt.plan_id AND p.owner_id = lt.owner_id
)

-- Step 3: Filter for inactive plans (over 365 days of inactivity)
SELECT 
    id AS plan_id,                   -- Plan ID
    owner_id,                        -- Customer ID
    type,                            -- Plan type (Investment, Savings, Other)
    last_transaction_date,           -- Most recent transaction date
    inactive_days                    -- Number of inactive days
FROM 
    transaction_tb 
WHERE 
    inactive_days > 365;             -- Only include inactive plans (over 1 year)
