/*
===============================================================
Project: SQL Business Analytics Portfolio
Case Study 01: Enterprise RFM Customer Intelligence Framework
Database: AdventureWorks2022
Platform: Microsoft SQL Server
Author: Filipe Guerra
===============================================================
*/
WITH Base_Aggregation AS
(
	SELECT
		A.CustomerKey
		, C.FirstName
		, C.LastName
		, COUNT(A.SalesOrderNumber) AS Frequency
		, SUM(A.SalesAmount) AS Monetary
		, MAX(B.FullDateAlternateKey) AS Last_Purchase_Date
	FROM FactInternetSales AS A
	INNER JOIN DimDate AS B ON A.OrderDateKey = B.DateKey
	INNER JOIN DimCustomer AS C ON A.CustomerKey = C.CustomerKey
	GROUP BY
		A.CustomerKey
		, C.FirstName
		, C.LastName
),
MaxDate AS
(
	SELECT
		CustomerKey
		, CONCAT(FirstName, ' ', LastName) AS Customer_Name
		, Frequency
		, Monetary
		, Last_Purchase_Date
		, MAX(Last_Purchase_Date) OVER() AS Max_Order_Date
	FROM Base_Aggregation
),
Recency_Table AS
(
	SELECT
		CustomerKey
		, Customer_Name
		, Frequency
		, Monetary
		, Last_Purchase_Date
		, Max_Order_Date
		, DATEDIFF(D, Last_Purchase_Date, Max_Order_Date) AS Recency
	FROM MaxDate
),
RFM_Scoring AS
(
	SELECT
		CustomerKey
		, Customer_Name
		, Frequency
		, CASE
			WHEN Frequency = 1 THEN 1
			WHEN Frequency BETWEEN 2 AND 3 THEN 2
			WHEN Frequency BETWEEN 4 AND 6 THEN 3
			WHEN Frequency BETWEEN 7 AND 10 THEN 4
			ELSE 5
		END AS Frequency_Score
		, Monetary
		, NTILE(5) OVER(ORDER BY Monetary ASC) AS Monetary_Score
		, Last_Purchase_Date
		, Max_Order_Date
		, Recency
		, NTILE(5) OVER(ORDER BY Recency DESC) AS Recency_Score
	FROM Recency_Table
),
Final_Score AS
(
SELECT
	CustomerKey
	, Customer_Name
	, Frequency
	, Frequency_Score
	, Monetary
	, Monetary_Score
	, Last_Purchase_Date
	, Max_Order_Date
	, Recency
	, Recency_Score
	, CONCAT(Recency_Score, Frequency_Score, Monetary_Score) AS Score
FROM RFM_Scoring
),
Finish AS
(
SELECT
		CustomerKey
		, Customer_Name
		, Frequency
		, Frequency_Score
		, Monetary
		, Monetary_Score
		, Last_Purchase_Date
		, Max_Order_Date
		, Recency
		, Recency_Score
		, Score
		, CASE
			WHEN Recency_Score >= 4 AND Frequency_Score >= 4 AND Monetary_Score >= 4 
				THEN 'Champions'
			WHEN Recency_Score >= 4 AND Frequency_Score >= 3  AND Monetary_Score >= 3
				THEN 'Loyal Customers'
			WHEN Recency_Score <= 2 AND Frequency_Score >= 3
				THEN 'At Risk'
			WHEN Recency_Score <= 2 AND Frequency_Score <= 2 
				THEN 'Lost Customers'
			WHEN Recency_Score = 3 AND Frequency_Score >= 3 
				THEN 'Core Customers'
		ELSE 'Emerging Customers'
	END AS Segment_Name
	FROM Final_Score
)
SELECT
    *
FROM Finish
