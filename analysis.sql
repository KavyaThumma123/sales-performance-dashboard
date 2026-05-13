--Overall KPIs
SELECT
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Profit_Margin_Pct,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders,
    COUNT(DISTINCT Customer_ID)                                 AS Total_Customers,
    ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID), 0)               AS Avg_Order_Value
FROM sales_master;

--sales & profit by year
SELECT
    Order_Year,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders
FROM sales_master
GROUP BY Order_Year
ORDER BY Order_Year;

--Category& Sub-category performance
SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct,
    SUM(Quantity)                                               AS Total_Quantity
FROM sales_master
GROUP BY Category, Sub_Category
ORDER BY Total_Profit DESC;

--Loss making sub-category
SELECT
    Sub_Category,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    COUNT(*)                                                    AS Total_Orders,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct
FROM sales_master
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

--Regional Performance
SELECT
    Region,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders,
    ROUND(AVG(Discount)*100, 1)                                 AS Avg_Discount_Pct
FROM sales_master
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Top 10 Customers
SELECT TOP 10
    Customer_Name,
    Segment,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct
FROM sales_master
GROUP BY Customer_Name, Segment
ORDER BY Total_Sales DESC;	

--Discount Impact on profit
SELECT
    Discount_Band,
    COUNT(*)                                                    AS Total_Orders,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(AVG(Profit), 1)                                       AS Avg_Profit_Per_Order,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct
FROM sales_master
GROUP BY Discount_Band
ORDER BY Discount_Band;

-- Monthly sales Trend
SELECT
    Order_Year,
    Order_Month_Number,
    Order_Month_Name,
    ROUND(SUM(Sales), 0)                                        AS Monthly_Sales,
    ROUND(SUM(Profit), 0)                                       AS Monthly_Profit,
    COUNT(DISTINCT Order_ID)                                    AS Orders
FROM sales_master
GROUP BY Order_Year, Order_Month_Number, Order_Month_Name
ORDER BY Order_Year, Order_Month_Number;

-- shipping performance
SELECT
    Ship_Mode,
    COUNT(*)                                                    AS Total_Orders,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(AVG(Shipping_Days), 1)                                AS Avg_Shipping_Days,
    MIN(Shipping_Days)                                          AS Min_Days,
    MAX(Shipping_Days)                                          AS Max_Days
FROM sales_master
GROUP BY Ship_Mode
ORDER BY Avg_Shipping_Days;

-- Top 15 state by profit
SELECT TOP 15
    State,
    Region,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders
FROM sales_master
GROUP BY State, Region
ORDER BY Total_Profit DESC;

-- Segment Performance
SELECT
    Segment,
    COUNT(DISTINCT Customer_ID)                                 AS Total_Customers,
    COUNT(DISTINCT Order_ID)                                    AS Total_Orders,
    ROUND(SUM(Sales), 0)                                        AS Total_Sales,
    ROUND(SUM(Profit), 0)                                       AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 1)                        AS Margin_Pct,
    ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID), 0)               AS Avg_Order_Value
FROM sales_master
GROUP BY Segment
ORDER BY Total_Sales DESC;