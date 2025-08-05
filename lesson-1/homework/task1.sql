CREATE DATABASE SchoolIdb;
USE SchoolIdb;


   
   Data (bu Malumot)  Bu kompyuterda saqlanadigan raqmla matnla yoki boshqa malumotla.

Database (Malumotla bazasi)  Bu malumotlani saqlash va boshqarish  uchun joy.

Relational Database (Nisbiy malumotla bazasi)  Bu turdigi bazada malumotla bir nechta jadvallada saqlanadi va ular orasida boglanish boladi.

Table (Jadval)  Bu bazadigi malumotlani qatorda va ustunda saqlovchi tuzilma.



2. SQL Serverning 5 ta muhim xususiyati:

Kotta hajmdigi malumotlani boshqarolidi .

Malumotlarni xavfsiz saqliydi.

Bir nechta foydalanuvchi bilan ishlolidi.

Zapas nusxani tiklash imkoniyati bor.

Tillarni qollab-quvvatliydi (misolchun, T-SQL).



3. SQL Serverga ulanayotganda qanday autentifikatsiya (kirish) turlari bor? (kamida 2 ta)

Windows Authentication

SQL Server Authentication







CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);


SQL Server – BU Malumotlani bazasini saqliydigan va boshqaradigan tizim.

SSMS – BU SQL Serverni boshqarish uchun ishlatiladigan dastur .

SQL – BU Malumotla bilan ishlash uchun yoziladigan sorov tili.



DQL Data Query Language Malumotni sorash SELECT * FROM Students;
DML Data Manipulation Language Malumot qoshish, ochirish, yengilash INSERT INTO Students VALUES (1, 'Ali', 20);
DDL Data Definition Language Jadval yaratish yoki ozgartirish CREATE TABLE ..., ALTER TABLE ...
DCL Data Control Language Ruxsatlar bilan ishlash GRANT, REVOKE
TCL Transaction Control Language Transaction larni boshqarish BEGIN, COMMIT, ROLLBACK





INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Bilol', 20);
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Zuhra', 22);
INSERT INTO Students (StudentID, Name, Age) VALUES (3, 'Kamol',19 );
