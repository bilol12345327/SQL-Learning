use homework
go



DROP TABLE IF EXISTS #RegionSales;
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);

INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT r.Region, d.Distributor, ISNULL(s.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales s 
    ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY d.Distributor, r.Region;

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    id INT, 
    name VARCHAR(255), 
    department VARCHAR(255), 
    managerId INT
);

INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), 
(102, 'Dan', 'A', 101), 
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), 
(105, 'Anne', 'A', 101), 
(106, 'Ron', 'B', 101);

SELECT e.name
FROM Employee e
JOIN Employee m ON e.id = m.managerId
GROUP BY e.id, e.name
HAVING COUNT(*) >= 5;


DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Products (
  product_id INT, 
  product_name VARCHAR(40), 
  product_category VARCHAR(40)
);

CREATE TABLE Orders (
  product_id INT, 
  order_date DATE, 
  unit INT
);

INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), 
(4, 'Lenovo', 'Laptop'), 
(5, 'Leetcode Kit', 'T-shirt');

INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);

INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

WITH CTE AS (
  SELECT CustomerID, Vendor, SUM([Count]) AS TotalCount,
         ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rn
  FROM Orders
  GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM CTE
WHERE rn = 1;

DECLARE @Check_Prime INT = 91, @i INT = 2, @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i += 1;
END

IF @isPrime = 1 AND @Check_Prime > 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


DROP TABLE IF EXISTS Device;
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);

INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

WITH SignalCount AS (
  SELECT Device_id, Locations, COUNT(*) AS signals
  FROM Device
  GROUP BY Device_id, Locations
),
MaxLoc AS (
  SELECT Device_id, Locations,
         ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rn
  FROM Device
  GROUP BY Device_id, Locations
)
SELECT s.Device_id,
       COUNT(DISTINCT s.Locations) AS no_of_location,
       m.Locations AS max_signal_location,
       COUNT(*) AS no_of_signals
FROM Device s
JOIN MaxLoc m ON s.Device_id = m.Device_id AND m.rn = 1
GROUP BY s.Device_id, m.Locations;


DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);

INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_sal
    FROM Employee
    GROUP BY DeptID
) a ON e.DeptID = a.DeptID
WHERE e.Salary > a.avg_sal;

DROP TABLE IF EXISTS Numbers;
CREATE TABLE Numbers (Number INT);

INSERT INTO Numbers VALUES (25), (45), (78);

DROP TABLE IF EXISTS Tickets;
CREATE TABLE Tickets (TicketID VARCHAR(10), Number INT);

INSERT INTO Tickets VALUES
('A23423', 25),('A23423', 45),('A23423', 78),
('B35643', 25),('B35643', 45),('B35643', 98),
('C98787', 67),('C98787', 86),('C98787', 91);

WITH CheckWin AS (
    SELECT t.TicketID,
           SUM(CASE WHEN t.Number IN (SELECT Number FROM Numbers) THEN 1 ELSE 0 END) AS match_count,
           COUNT(*) AS total_nums
    FROM Tickets t
    GROUP BY t.TicketID
)
SELECT SUM(
    CASE WHEN match_count = (SELECT COUNT(*) FROM Numbers) THEN 100
         WHEN match_count > 0 THEN 10
         ELSE 0 END
) AS Total_Winnings
FROM CheckWin;


DROP TABLE IF EXISTS Spending;
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);

INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH Base AS (
    SELECT User_id, Spend_date,
           MAX(CASE WHEN Platform='Mobile' THEN 1 ELSE 0 END) AS has_mobile,
           MAX(CASE WHEN Platform='Desktop' THEN 1 ELSE 0 END) AS has_desktop,
           SUM(Amount) AS total_amt
    FROM Spending
    GROUP BY User_id, Spend_date
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date,
       CASE WHEN has_mobile=1 AND has_desktop=1 THEN 'Both'
            WHEN has_mobile=1 THEN 'Mobile'
            WHEN has_desktop=1 THEN 'Desktop' END AS Platform,
       SUM(total_amt) AS Total_Amount,
       COUNT(User_id) AS Total_users
FROM Base
GROUP BY Spend_date, has_mobile, has_desktop;


DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped (
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);

INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

WITH Numbers AS (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity;
