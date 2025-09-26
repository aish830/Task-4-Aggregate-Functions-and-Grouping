# Task 4: Aggregate Functions and Grouping

## Objective
Use aggregate functions (SUM, COUNT, AVG, MIN, MAX) and GROUP BY / HAVING to summarize and analyze tabular data in PostgreSQL.

## Files
- `Task4_Aggregates.sql` : SQL script that creates a sample `orders` table, inserts sample data, and demonstrates aggregate queries.


## What is covered
- COUNT, SUM, AVG, MIN, MAX on numeric columns
- GROUP BY to summarize by customer and by product
- HAVING to filter groups (e.g., customers with total_sales > 60000)
- DATE_TRUNC grouping for monthly totals
- Using COALESCE to present safe default values
- LIMIT to fetch top N groups

## How to run
1. Open pgAdmin and connect to your database.
2. Open the Query Tool and load `Task4_Aggregates.sql`.
3. Run the script (or run selected sections).
4. Review results in the Data Output panel.


## Notes
- The sample table `orders` is created and populated by the script (DROP TABLE IF EXISTS used for safety).
- Modify sample data or thresholds (like HAVING > 60000) to match your assignment or local currency.
