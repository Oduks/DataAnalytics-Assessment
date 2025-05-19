# DataAnalytics-Assessment
customer analysis using SQL queries to  identify high-value customers,  analyze transaction frequency,  Detect inactive accounts and estimate Customer Lifetime Value (CLV)

## Repository Structure
DataAnalytics-Assessment/  
│  
├── Assessment_Q1.sql  
├── Assessment_Q2.sql  
├── Assessment_Q3.sql  
├── Assessment_Q4.sql  
│  
└── README.md  
  
Assessment_Q1.sql: High-value customers with savings and investment plans.  
Assessment_Q2.sql: Customer transaction frequency analysis.  
Assessment_Q3.sql: Inactive account detection.  
Assessment_Q4.sql: Customer Lifetime Value (CLV) estimation.  

README.md: Project documentation (this file).  

## How to Use
Clone this repository:  
git clone <[DataAnalytics-Assessment](https://github.com/Oduks/DataAnalytics-Assessment)>  
Set up MySQL Database: Ensure you have the following tables:  
  -**users_customuse**r: Customer information.  
  -**savings_savingsaccount**: Records of deposits.  
  -**plans_plan**: Savings and investment plans.  
  -**withdrawals_withdrawal**: Withdrawal records.  
Run each SQL file in your database client to generate the expected results. 

## Assessment Questions and Explanations

### Q1: High-Value Customers with Multiple Products
Scenario: Identify customers with at least one funded savings plan AND one funded investment plan.  
Approach:  
-Joined users_customuser, savings_savingsaccount, and plans_plan tables.  
-Filtered for customers with both savings and investment plans.  
-Calculated total deposits while keeping in mind that the amount is in kobo so tghere's a need to convert to naira.   

### Q2: Transaction Frequency Analysis
Scenario: Categorize customers based on transaction frequency.  
Approach:  
Calculated average transactions per month for each customer.  
Categorized customers using a CASE statement (High, Medium, Low).  

### Q3: Account Inactivity Alert
Scenario: Detect accounts with no inflow transactions for over a year.  
Approach:  
Used a CTE for the latest transaction date.  
Filtered accounts with inactivity over 365 days.  

### Customer Lifetime Value (CLV) Estimation
Scenario: Estimate CLV using account tenure and transaction volume.  
Approach:  
Calculated tenure in months and total transactions.  
Used the formula:  
CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction  

 ## Project Requirements
MySQL Database (version 8.0 or higher)  
Access to the specified tables.

## Challenges Faced
Optimizing queries for performance: I used **Common Table Expressions (CTE)** to optimize my query.

## Author
Your Name: **Tobiloba Odukunle**  
Date: 18/05/2025
