create  database F38Class_3;
use F38Class_3


BULK INSERT — bu SQL Serverda tashqi fayldan (odatda CSV yoki TXT formatdagi fayl) jadvalga katta miqdordagi malumotlarni tezda yuklash uchun ishlatiladigan buyruqdir.



Katta hajmdagi malumotlarni qolda INSERT yozmasdan yuklab olish mumkin

Tezlik va samaradorlikni oshiradi.


1. .csv – Comma Separated Values


2. .txt – Matnli fayl


3. .xls / .xlsx – Excel fayllari


4. .json – JSON fayllari (SQL Server 2016 dan boshlab)







Create Table Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
)




Insert into Products values (1, 'Phone', 299.00)
Insert into Products values (2, 'Mouse', 15.00)
Insert into Products values (3, 'Keyboard', 27.00)




NULL — qiymat hali belgilanmagan, nomalum yoki yoq degani.

NOT NULL — ustunga har doim qiymat berilishi shart, bosh qoldirish mumkinmas.





6. ProductName ustuniga UNIQUE constraint qoshish

Alter Table Products
Add Constraint UQ_ProductName UNIQUE(ProductName)





Select * from Products





Alter Table Products
Add CategoryID INT





Create Table Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
)





IDENTITY — bu ustun avtomatik tarzda raqam beradi (odatda PRIMARY KEY uchun ishlatiladi).

Misolchun IDENTITY(1,1) — 1 dan boshlaydi, har safar 1 ga oshadi.
Foydasi — foydalanuvchi ID kiritmaydi, SQL Server avtomatik qiladi.




BULK INSERT Products
FROM 'C:\Path\To\Products.txt'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
)





Alter Table Products
Add Constraint FK_Category
Foreign Key (CategoryID) References Categories(CategoryID)





PRIMARY KEY UNIQUE

Bitta jadvalda faqat 1 dona boladi Kopta bolishi mumkin
NULL qiymat qabul qilmaydi 1 ta NULL bolishi mumkin
Odatda ID uchun ishlatiladi No-takror ustunlar uchun ishlatiladi






Alter Table Products
Add Constraint CK_Price CHECK (Price > 0)



Alter Table Products
Add Stock INT NOT NULL DEFAULT 0





Select ProductID, ProductName, ISNULL(Price, 0) as FinalPrice
From Products






FOREIGN KEY – bu boshqa jadvaldagi PRIMARY KEY ustuniga boglovchi ustun.

Foydasi - Jadval orasidagi aloqani (relationship) yaratadi

Malumotlar yaxlitligini (integrity) taminlaydi


Misolchun - Products.CategoryID → Categories.CategoryID





Create Table Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
)






Create Table Logs (
    LogID INT IDENTITY(100, 10) PRIMARY KEY,
    Message VARCHAR(100)
)



Create Table OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
)






 ISNULL - 1 ta alternativ qiymat
Select ISNULL(NULL, 'No Value') -- 'No Value'

 COALESCE - bir nechta alternativdan birinchisini oladi
Select COALESCE(NULL, NULL, 'First Available', 'Another') -- 'First Available'






Create Table Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
)





Create Table Payments (
    PaymentID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    Foreign Key (CustomerID) References Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)


