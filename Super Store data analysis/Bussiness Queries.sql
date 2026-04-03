-- ================================================
-- Super Store Data Analysis | 15 Business Queries
-- Tool: Microsoft SQL Server
-- Skills: CTEs, Window Functions, RFM Analysis,
--         Aggregations, CASE, LAG, RANK, NTILE,
--         Views, Stored Procedures
-- ================================================


--To See table details
select * from fact_sales;

 --1).What are total orders, sales, profit, and margin % for each region?
 select Region, 
 COUNT(distinct Order_ID) as [Total Order],
 ROUND(SUM(Sales),2) as [Total Sales], 
 ROUND(SUM(profit),2) as [Total Profit],
 ROUND(SUM(profit) / SUM(Sales) * 100, 2) as [Total Margin %]
 from fact_sales
 group by Region;

-- INSIGHT: 
-- Central region has high volume (1,175 orders, $501K sales)
-- but the worst margin at 7.92% -- even South with fewer orders
-- earns better margin (11.93%). Central needs pricing/discount review.


--2). What is total sales and profit for each sub-category — 
--	  sorted from biggest loss to biggest profit?
select Sub_Category,
ROUND(SUM(Sales), 2) as [Total Sales],
ROUND(SUM(Profit), 2) as [Total Profit],
ROUND(AVG(Discount) * 100, 2) as [Average Discount]
from fact_sales
group by Sub_Category
order by [Total Profit] asc;

-- INSIGHTS:
-- The biggest loss for the Tables sub_category(-17725.48).
-- "Reason: Average discount of 26.13% on Tables
-- is directly causing -$17,725 loss despite
-- $206,965 in sales — a -8.56% profit margin"
-- Solution:- We can reduce losses and improve profitability by controlling discounts and optimizing costs, 
-- while maintaining a healthy profit margin.

-- The biggest Profit is in the Copiers sub_category(55617.82).
-- Reason:- Less discount(average 16.18% discount) and good profit margin.

-- ADDITIONAL INSIGHT: 
-- Binders have 37.23% avg discount but still 
-- profit $30K. Tables only 26.13% discount but lose $17K.
-- This means Tables has a fundamental cost/pricing problem
-- beyond just discounting.
-- Supplies also loses money at only 7.68% discount — cost issue confirmed.


--3). What are monthly sales and profit totals from 2023 to 2026?
select Order_Year, Order_Month, Order_Month_Name,
SUM(Sales) as [Total Sales],
SUM(Profit) as [Total Profit]
from fact_sales
WHERE Order_Year BETWEEN 2023 AND 2026
group by Order_Year, Order_Month, Order_Month_Name
order by Order_Year, Order_Month;

-- Insights:
-- The maximum profit is 17k+ in the december month of 2025.
-- The minimum profit is -3k+ in the january month of 2024.

 --4). Which are the top 10 most profitable products? Which are the bottom 10 (biggest losses)? 
 select top 10 Product_Name, 
 ROUND(SUM(Profit),2) as [Total Profit]
 from fact_sales
 group by Product_Name
 order by [Total Profit] desc;

 select top 10 Product_Name, 
 ROUND(SUM(Profit),2) as [Total Profit]
 from fact_sales
 group by Product_Name
 order by [Total Profit] asc;

 -- Insights:
 -- Canon imageCLASS 2200 Advanced Copier is the most profitable Product(25k+) 
 -- followed by Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind.

 -- Where as Cubify CubeX 3D Printer Double Head Print are most loss making Product(-8k+) 
 -- followed by Lexmark MX611dhe Monochrome Laser Printer.

 -- Reason: Higher discount and low selling price 
 -- are the primary drivers of product-level losses.

 -- Solution: Optimize the product cost, minimize the discount value, increase profit margin.

 -- Using this approach we can make profit from it.


 --5).  What is the average profit per order for each discount band (None / Low / Med / High / Very High)? 
 select Discount_Band as [Discount_Band], 
 ROUND(AVG(Profit),2) as [Average Profit]
 from fact_sales
 group by Discount_Band;

 -- Insights:
 -- From the observation we saw that Higher Discount band can making high loss(-134.62), followed by Med(-78) and very high(-98.35) band .
 -- The only Profit making band is Low(26.5) and None(66.9).

 -- Reason: Higher Discount band reduce the selling price ,which directly impact the profit margin and make loss.

 -- Solution: Avoid Excessive Discount and increase profit margin, balance between sells and Profitability.


 --6).  What are total sales, order count, average order value, and margin % by customer segment? 
 select Segment as [Customer Segment],
 ROUND(SUM(Sales), 2) as [Total Sales], 
 COUNT(Order_ID) as [Total Order], 
 ROUND(AVG(Sales), 2) as [Average Order Value],
 ROUND(SUM(Profit)/SUM(Sales) * 100, 2) as [Margin %]
 from fact_sales
 group by Segment;

 -- Insights:
 -- From the observation we saw that the consumer segment higest sales.
 -- However, it has less margin % (11.55), average order value(223.73) from Corporate and Home Office.
 -- It has high amount of Orders(5191) and Maximum Sales(1161401.35)

 -- where as the corporate segment have better margin%(13) and average order value(233.82) than consumer segment
 -- leading to higher profit per order.
 -- They have high amount of order(3020) and also sales value(706146.37).

 -- Home Office segment shows strong profitability with the highest margin and highest average order value. 
 -- It has high margin%(14) and also the highest average order value among the segment(240.95)
 
 -- Reason: 
 -- Due to low margin %(11.55) and the average order value(223.73) of Consumer segment are less
 -- the orders(5191) are high and also sales(1161401.35) are maximun and highest.
 -- Here, sales are highest but they do not generate high profit.

 -- The corporate and Home office Segment have a better margin% and Average Order Value
 -- due to this they generate better profit as compare to consumer segment.

 -- Solution:
 -- Avoid Excessive Discount.
 -- Increase profit margin.
 -- Balance between cost and margin.


 --7). What is the average days to ship and order count for each shipping mode? 
 select Ship_Mode as [Ship Mode],
 COUNT( Distinct Order_ID) as [Total Order],
 ROUND(AVG(Days_to_Ship), 2) as [Average Days to Ship]
 from fact_sales
 group by Ship_Mode;

 -- Insights:
 -- The most used ship mode is Standard Class.
 -- However, they take maximum number of days(5) to ship.
 -- This could be due to less shipping charge and people choose economical class.

 -- The Same Day(0), First Class(2) and Second Class(3) ship mode have taken less number of days 
 -- but they could have high shipping charges.

 -- That's why people choose Standard Class.


--8). How much did sales grow year-over year from 2023 to 2026? Show % growth per year. 
with YearlySales as (
	select 
	Order_Year,
	sum(Sales) as [Total Sales]
	from fact_sales
	group by Order_Year
),
SalesWithPrev as (
	select 
	Order_Year,
	[Total Sales],
	LAG([Total Sales]) over (order by order_year) as [Previous Year Sales]
	from YearlySales
)
select
Order_year,
[Total Sales],
[Previous Year Sales],
ROUND(([Total Sales] - [Previous Year Sales]) * 100.0 / NULLIF([Previous Year Sales], 0), 2)  as [YOY Growth %]
from SalesWithPrev;

-- Insights:
-- Sales decreased by 2.78% in 2024 compared to 2023, indicating a short-term decline.
-- In 2025, sales bounced back strongly with 29.47% growth compared to 2024.
-- 2025 recorded the highest year-over-year sales growth.
-- In 2026, sales continued to grow, but at a slightly lower rate (20.36%) compared to 2025.
-- Overall, after a decline in 2024, the business shows a strong recovery and consistent growth trend from 2025 onwards.



	--9).  What does the running cumulative sales total look like across all order dates?
	select Order_Date,
	SUM(Sales) as [Total Sales],
	SUM(SUM(Sales)) over (Order by order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as [Cumulative Sales]
	from fact_sales
	group by Order_Date
	order by Order_Date;

	-- Insights:
	-- Cumulative sales show a continuous upward trend over time, indicating consistent sales growth.
	-- On certain dates, the cumulative sales increase more sharply, which reflects higher sales on those days.
	-- The varying rate of increase suggests fluctuations in daily sales performance.


	--10). Who are the top 20 customers by revenue — and are all of them actually profitable? 
	select top 20
	Customer_Name,
	SUM(Sales) as [Total Revenue],
	SUM(Profit) as [Total Profit]
	from fact_sales
	group by Customer_Name
	order by [Total Revenue] desc;


	-- Insights:
	-- Despite having top revenues, not all of them are actually profitable.
	-- Sean Miller has the highest revenue but makes a loss (-1980.73).
	-- Whereas Edward Hooks has the least revenue in this list but still makes a profit.

	-- This clearly indicates that higher revenue does not guarantee profit.


	--11). For all loss-making orders, classify each by severity: Critical Loss, Moderate Loss, or Small Loss.
	select 
	Order_ID,
	Profit,
	case 
		when Profit between -100 and -1 then 'Small Loss'
		when Profit between -200 and -101 then 'Moderate Loss'
		else 'Critical Loss'
	end as Severity
	from fact_sales
	where Profit < 0;


	--12).  Within each category, how do subcategories rank by profit from best to worst? 
	select Category	,
	sub_category,
	SUM(Profit) as [Total Profit],
	RANK() over (partition by category order by SUM(profit) desc) as [Profit Ranking]
	from fact_sales
	group by Category, Sub_Category;

	-- Insights:
	-- Identify best and worst subcategories for each category.
	-- Top-ranked subcategories contribute the highest profit in each category.
	-- Low-ranked subcategories contribute the least profit and may need improvement.
	-- This ranking helps in focusing on high-performing areas and improving low-performing ones.

	--13). Build an RFM table — for each customer calculate Recency (days since last order), 
	-- Frequency (order count), and Monetary (total spend). Then score each 1–4. 
	with RFM_base as (
	select 
	Customer_ID,
	MAX(Order_Date) as Last_Order_Date,
	COUNT(Distinct Order_ID) as Frequency,
	SUM(Sales) as Monetary
	from fact_sales
	group by Customer_ID
	),
	RFM_Calc AS (
    SELECT 
        Customer_ID,
        DATEDIFF(DAY, Last_Order_Date, GETDATE()) AS Recency,
        Frequency,
        Monetary
    FROM RFM_Base
),
 RFM_Score AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Calc
)
SELECT *,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Segment
FROM RFM_Score;

-- Insights:
-- Customers with high RFM scores are most valuable and loyal
-- Low recency + low frequency customers are at risk of churn
-- High monetary customers should be targeted for premium offers


--14).List every single order where profit is negative with full details: product, region, discount, profit. 
select *
from fact_sales
where Profit < 0
order by Profit asc;

-- Insights:
-- This table shows loss for each single order.
-- Lower the profit value, higher the loss and vice versa.

--15).What is quarterly sales and profit broken down by region for all 4 years?
select 
DATEPART(YEAR, Order_Date) as year,
DATEPART(QUARTER, Order_Date) as Quarter,
Region,
SUM(Sales) as [Total Sales],
SUM(Profit) as [Total profit]
from fact_sales
group by DATEPART(YEAR, Order_Date), DATEPART(QUARTER, Order_Date), Region
order by year, Quarter, Region;

-- Insights:
-- In each year and quarter, we can find the best and worst performing region.
-- Helps to identify seasonal trends in sales and profit across all 4 years.



-- CREATE VIEW 
create view vw_Sales_Summary as 
select 
ROUND(SUM(Sales), 2) as [Total Sales],
ROUND(SUM(Profit), 2) as [Total profit],
COUNT(Distinct Order_ID) as [Total Order],
Order_Year,
Order_Month,
Region,
Category,
Sub_Category,
Segment
from fact_sales
group by Order_Year, Order_Month, Region, Category, Sub_Category, Segment
go

select * from vw_Sales_Summary;


-- CREATE PROCEDURE 
create procedure sp_Region_KPI
@Region Varchar(50),
@Year int
as
begin
	select 
		Sub_Category,
		ROUND(SUM(Sales), 2) as [Total Sales],
		ROUND(SUM(Profit), 2) as [Total profit],
		ROUND(AVG(Discount), 2) as [Average Discount]
	from fact_sales
	where Region = @Region 
	  and Order_Year = @Year
	group by Sub_Category;
end;
Go

EXEC sp_Region_KPI 'West', 2023;

