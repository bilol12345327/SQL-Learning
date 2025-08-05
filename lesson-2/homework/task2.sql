CREATE TABLE Xodimlar (
    XodimID INT,
    Ismi VARCHAR(50),
    Maosh DECIMAL(10,2)
);

INSERT INTO Xodimlar (XodimID, Ismi, Maosh) VALUES (1, 'Ali', 6000.00);
INSERT INTO Xodimlar (XodimID, Ismi, Maosh) VALUES (2, 'Malika', 5500.00);
INSERT INTO Xodimlar (XodimID, Ismi, Maosh) VALUES (3, 'Jasur', 5000.00);

UPDATE Xodimlar SET Maosh = 7000 WHERE XodimID = 1;

DELETE FROM Xodimlar WHERE XodimID = 2;

ALTER TABLE Xodimlar ALTER COLUMN Ismi VARCHAR(100);

ALTER TABLE Xodimlar ADD Bolim VARCHAR(50);

ALTER TABLE Xodimlar ALTER COLUMN Maosh FLOAT;



DELETE - tanlab yozuvni o‘chiradi (WHERE ishlaydi), jadval qoladi.
TRUNCATE - barcha yozuvlarni birdan o‘chiradi, lekin tuzilma qoladi.
DROP - butun jadvalni o‘chiradi (tuzilmasi va ma’lumotlari bilan birga).






CREATE TABLE Bolimlar (
    BolimID INT PRIMARY KEY,
    BolimNomi VARCHAR(50)
);

TRUNCATE TABLE Xodimlar;

INSERT INTO Bolimlar (BolimID, BolimNomi)
SELECT 1, 'Boshqaruv' UNION ALL
SELECT 2, 'Hisob-kitob' UNION ALL
SELECT 3, 'Axborot texnologiyalari' UNION ALL
SELECT 4, 'Savdo' UNION ALL
SELECT 5, 'Marketing';

UPDATE Xodimlar SET Bolim = 'Boshqaruv' WHERE Maosh > 5000;

TRUNCATE TABLE Xodimlar;

ALTER TABLE Xodimlar DROP COLUMN Bolim;

EXEC sp_rename 'Xodimlar', 'HodimlarRoyxati';

DROP TABLE Bolimlar;

CREATE TABLE Mahsulotlar (
    MahsulotID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(100),
    Turi VARCHAR(50),
    Narxi DECIMAL(10,2),
    Tavsif VARCHAR(200)
);

ALTER TABLE Mahsulotlar ADD CONSTRAINT chk_Narx CHECK (Narxi > 0);

ALTER TABLE Mahsulotlar ADD SkladMiqdori INT DEFAULT 50;

EXEC sp_rename 'Mahsulotlar.Turi', 'MahsulotTuri', 'COLUMN';

INSERT INTO Mahsulotlar (MahsulotID, MahsulotNomi, MahsulotTuri, Narxi, Tavsif)
VALUES
(1, 'Noutbuk', 'Elektronika', 1200.00, 'O‘yin uchun noutbuk'),
(2, 'Telefon', 'Elektronika', 850.00, 'Smartfon'),
(3, 'Stol', 'Mebel', 300.00, 'Yog‘och stol'),
(4, 'Stul', 'Mebel', 150.00, 'Ofis stuli'),
(5, 'Naushnik', 'Elektronika', 200.00, 'Shovqinni yo‘qotuvchi');

SELECT * INTO Mahsulotlar_Zaxira FROM Mahsulotlar;

EXEC sp_rename 'Mahsulotlar', 'Ombor';

ALTER TABLE Ombor ALTER COLUMN Narxi FLOAT;

ALTER TABLE Ombor ADD MahsulotKodi INT IDENTITY(1000, 5);
