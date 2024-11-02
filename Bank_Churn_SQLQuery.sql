SELECT TOP (1000) [CustomerId]
      ,[Surname]
      ,[CreditScore]
      ,[Geography]
      ,[Gender]
      ,[Age]
      ,[Tenure]
      ,[Balance]
      ,[NumOfProducts]
      ,[HasCrCard]
      ,[IsActiveMember]
      ,[EstimatedSalary]
      ,[Exited]
  FROM [ProtofolioProject1].[dbo].[Bank_Churn]

--- Check for Null Values in All Columns 
  SELECT 
    SUM(CASE WHEN CustomerId IS NULL THEN 1 ELSE 0 END) AS Null_CustomerId,
    SUM(CASE WHEN Geography IS NULL THEN 1 ELSE 0 END) AS Null_Geography,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
    SUM(CASE WHEN Balance IS NULL THEN 1 ELSE 0 END) AS Null_Balance,
    SUM(CASE WHEN EstimatedSalary IS NULL THEN 1 ELSE 0 END) AS Null_EstimatedSalary
FROM Bank_Churn;


----------------------------------

--- 1.Customers per Country
SELECT Geography, COUNT(*) AS TotalCustomers 
FROM Bank_Churn 
GROUP BY Geography;
---------------------------

--- 2.Gender Distribution
SELECT Gender,COUNT(*) AS Total
FROM Bank_Churn
GROUP BY Gender
------------------------------

-- 3.Churn Rate
SELECT Exited, COUNT(*) AS Total 
FROM Bank_Churn 
GROUP BY Exited;
------------------------

--- 4.Credit Card Holders
SELECT HasCrCard, COUNT(*) AS Total 
FROM Bank_Churn 
GROUP BY HasCrCard;
-----------------------------

--- 5. Average Age
SELECT AVG(Age) AS AverageAge 
FROM Bank_Churn;

-------------------------------

--- 6. Average Balance (Churned vs. Stayed)
SELECT Exited, ROUND(AVG(Balance),2) AS AvgBalance 
FROM Bank_Churn 
GROUP BY Exited;
----------------------------------

--- 7. Churn by Country
SELECT Geography, 
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned, 
       COUNT(*) AS TotalCustomers 
FROM Bank_Churn 
GROUP BY Geography;
----------------------------

--- 8.Number of Products vs. Churn
SELECT NumOfProducts, 
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned 
FROM Bank_Churn 
GROUP BY NumOfProducts;

--------------------------

--- 9.Credit Score (Churned vs. Stayed):
SELECT Exited, AVG(CreditScore) AS AvgCreditScore 
FROM Bank_Churn 
GROUP BY Exited;
--------------------------

--- 10.Salary Comparison by Gender
SELECT Gender, ROUND(AVG(EstimatedSalary),2) AS AvgSalary 
FROM Bank_Churn 
GROUP BY Gender;
--------------------------

--- 11.High-Value Customers by Country
SELECT Geography, COUNT(*) AS HighValueCustomers 
FROM Bank_Churn 
WHERE Balance > 100000 
GROUP BY Geography;
-------------------------------


--- 12.What attributes are more common among churners than non-churners? Can churn be predicted?
SELECT Exited, 
       AVG(CreditScore) AS AvgCreditScore, 
       AVG(Age) AS AvgAge, 
       ROUND(AVG(Balance),2) AS AvgBalance, 
       AVG(Tenure) AS AvgTenure, 
       AVG(NumOfProducts) AS AvgNumProducts 
FROM Bank_Churn 
GROUP BY Exited;

SELECT Surname,IsActiveMember, Exited, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY Surname,IsActiveMember, Exited;

SELECT Gender, Geography, Exited, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY Gender, Geography, Exited;

------------------------------------------------------------------------

--- 13.What do the overall demographics of the bank's customers look like?
SELECT Age, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY Age 
ORDER BY Age;

SELECT Gender, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY Gender;


SELECT Geography, COUNT(*) AS Total 
FROM Bank_Churn 
GROUP BY Geography;

SELECT 
   CASE 
      WHEN EstimatedSalary < 50000 THEN 'Low'
      WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Medium'
      ELSE 'High'
   END AS SalaryRange, 
   COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY EstimatedSalary;

-----------------------------------------------------------------------------------

--- 14.Is there a difference between German, French, and Spanish customers in terms of account behavior?
SELECT Geography, AVG(Balance) AS AvgBalance 
FROM Bank_Churn 
GROUP BY Geography;


SELECT Geography, AVG(NumOfProducts) AS AvgNumProducts 
FROM Bank_Churn 
GROUP BY Geography;



SELECT Geography, 
       SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ChurnRate 
FROM Bank_Churn 
GROUP BY Geography;

---------------------------------------------------------

--- 15.What types of segments exist within the bank's customers?
SELECT 
   CASE 
      WHEN Balance = 0 THEN 'No Balance'
      WHEN Balance < 50000 THEN 'Low Balance'
      WHEN Balance BETWEEN 50000 AND 100000 THEN 'Medium Balance'
      ELSE 'High Balance'
   END AS BalanceSegment, 
   COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY Balance;


SELECT IsActiveMember, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY IsActiveMember;


SELECT NumOfProducts, Exited, COUNT(*) AS Count 
FROM Bank_Churn 
GROUP BY NumOfProducts, Exited 
ORDER BY NumOfProducts, Exited;
