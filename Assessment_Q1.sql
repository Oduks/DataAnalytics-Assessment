-- ==========================================================
-- Customer Savings and Investment Analysis
-- This script calculates the number of savings and investment plans 
-- for each customer and the total amount deposited.
-- ==========================================================

-- Step 1: Identify Savings and Investment Plans for Each Customer
SELECT 
    u.id AS owner_id,                               -- Customer ID
    CONCAT(u.first_name, ' ', u.last_name) AS name, -- Customer Full Name
    
    -- Count of savings plans (identified by plan_id)
    COUNT(plans.plan_id) AS savings_count,           
    
    -- Count of investment plans (identified by is_a_fund)
    COUNT(plans.is_a_fund) AS investment_count,      
    
    -- Total deposit amount (converted from kobo to Naira)
    SUM(plans.amount / 100) AS total_deposits         

FROM 
    users_customuser u -- Main Customer Table

-- Step 2: Subquery - Filter Plans for Savings and Investments
JOIN (
    SELECT 
        s.owner_id,        -- Customer ID (Owner of the Plan)
        s.plan_id,         -- Savings Plan ID
        p.is_a_fund,       -- Investment Plan Indicator
        p.is_regular_savings, -- Savings Plan Indicator
        s.amount           -- Transaction Amount
        
    FROM 
        plans_plan p -- Plans Table
    JOIN 
        savings_savingsaccount s ON p.owner_id = s.owner_id -- Savings Table
    
    -- Only include plans that are both savings and investment
    WHERE 
        p.is_a_fund = 1          -- Only Investment Plans
        AND p.is_regular_savings = 1 -- Only Savings Plans
) plans ON u.id = plans.owner_id -- Join filtered plans with_
