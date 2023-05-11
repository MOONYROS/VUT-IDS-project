DROP TABLE Koupil;
DROP TABLE Zbozi;
DROP TABLE Zakaznik;

CREATE TABLE Zakaznik (
    cisloZ INT PRIMARY KEY,
    jmeno VARCHAR(50),
    dat_nar DATE,
    mesto VARCHAR(50));

CREATE TABLE Zbozi (
    kodZb INT PRIMARY KEY,
    nazev VARCHAR(50),
    kategorie VARCHAR(50),
    vyrobce VARCHAR(50));

CREATE TABLE Koupil (
    cisloZ INT REFERENCES Zakaznik (cisloZ),
    kodZb INT REFERENCES Zbozi (kodZb),
    datum DATE,
    cena INT,
    CONSTRAINT pk PRIMARY KEY (cisloZ, kodZb));

INSERT INTO Zakaznik VALUES (1,'Franta', TO_DATE('1999-02-02', 'YYYY-MM-DD'), 'Brno');
INSERT INTO Zakaznik VALUES (2, 'Samuel', TO_DATE('1999-01-03', 'YYYY-MM-DD'), 'Brno');
INSERT INTO Zakaznik VALUES (3, 'Richard', TO_DATE('2002-12-12', 'YYYY-MM-DD'), 'Brno');
INSERT INTO Zakaznik VALUES (4, 'Eva', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 'Praha');

INSERT INTO Zbozi VALUES (1, 'Samsung A20', 'mobily', 'Samsung');
INSERT INTO Zbozi VALUES (2, 'Benq 1000mq', 'monitory', 'Benq');
INSERT INTO Zbozi VALUES (3, 'IPhone X', 'mobily', 'Apple'); 

INSERT INTO Koupil VALUES (1, 1, TO_DATE('2020-05-05', 'YYYY-MM-DD'), '1000');
INSERT INTO Koupil VALUES (2, 1, TO_DATE('2020-05-05', 'YYYY-MM-DD'), '800');
INSERT INTO Koupil VALUES (3, 1, TO_DATE('2020-05-05', 'YYYY-MM-DD'), '1000');
INSERT INTO Koupil VALUES (4, 3, TO_DATE('2020-05-05', 'YYYY-MM-DD'), '800');
INSERT INTO Koupil VALUES (3, 3, TO_DATE('2020-05-05', 'YYYY-MM-DD'), '1000');
INSERT INTO Koupil VALUES (2, 2, TO_DATE('2019-05-05', 'YYYY-MM-DD'), '1200');
INSERT INTO Koupil VALUES (1, 2, TO_DATE('2019-06-05', 'YYYY-MM-DD'), '1000');
INSERT INTO Koupil VALUES (4, 2, TO_DATE('2019-06-07', 'YYYY-MM-DD'), '800');

/*A Uvažujte následující tabulky relační databáze internetového obchodu: Zakaznik (cisloZ, jmeno, dat_nar, mesto), Koupil (cisloZ, kodZb, datum, cena) a 
Zbozi (kodZb, nazev, kategorie, vyrobce). o zákazníkovi ukládáme jeho jednoznačné jméno, datum narození a město, kde bydlí, o zboží ukládáme 
jeho kód (jednoznačný), název, kategorii a výrobce. V tabulce Koupil je informace o nákupu jednoho zboží jedním zákazníku, (kdy byl nákup uskutečněn a za jakou cenu). */

-- a) Kolik zboží z kategorie "monitory" Bylo zakoupeno v jednotlivých měsících roku 2019? (mesic, pocet_nakupu)
SELECT to_char(datum, 'MM') mesic, count(*) pocet_nakupu
FROM Koupil NATURAL JOIN Zbozi
WHERE datum BETWEEN to_date('2019-01-01', 'YYYY-MM-DD') AND to_date('2019-12-31', 'YYYY-MM-DD') AND kategorie = 'monitory'
GROUP BY to_char(datum, 'MM');

SELECT *
FROM Koupil NATURAL JOIN Zbozi;

-- b) Která zboží (kodZb, nazev, kategorie) nakupovali pouze zákazníci narození po roce 2000?
SELECT kodZb, nazev, kategorie
FROM Zbozi
WHERE NOT EXISTS(
    SELECT *
    FROM Zakaznik NATURAL JOIN Koupil
    WHERE dat_nar < to_date('2000-01-01', 'YYYY-MM-DD') AND Zbozi.kodZb = kodZb
);

SELECT kodZb, nazev, kategorie
FROM Zakaznik NATURAL JOIN Koupil NATURAL JOIN Zbozi
WHERE dat_nar >= to_date('2000-01-01', 'YYYY-MM-DD');

-- c) Kteří zákazníci (cisloZ, jmeno, mesto) koupili zboží s názvem 'Samsung A20' za nejvyšší cenu? 
-- (může být i více zákazníků, kteří zboží koupili za stejnou nejvyšší cenu)
SELECT cisloZ, jmeno, mesto
FROM Zakaznik NATURAL JOIN Koupil NATURAL JOIN Zbozi
WHERE nazev = 'Samsung A20' AND cena = (
    SELECT max(cena)
    FROM Koupil NATURAL JOIN Zbozi
    WHERE nazev = 'Samsung A20'
);

-- d) Napište příkaz, který uživateli 'user01' přidělí práva ke čtení a modifikacim tabulky Zbozi
GRANT ALL ON Zbozi TO user01;

GRANT SELECT, INSERT, DELETE, UPDATE ON Zbozi TO user01;

-- e) Napište příkaz, který modifikuje databázi tak, aby bylo zajištěno, že při mazaní záznamu z tabulky Zbozi byly smazány všechny nákupy tohoto zboží z tabulky Koupil.
ALTER TABLE Koupil ADD CONSTRAINT klicek FOREIGN KEY (kodZb) REFERENCES Zbozi (kodZb) ON DELETE CASCADE;

-- f) Napište příkaz pro vytvoření materializovaného pohledu, který bude obsahovat informaci o počtu prodejů jednotlivých zboží (kodZb, nazev, pocet_prodeju),
-- včetně zvolené varianty pro provádění aktualizace pohledu. popsat jak může být mp aktualizován
CREATE MATERIALIZED VIEW mp2
REFRESH ON COMMIT AS
    SELECT kodZb, nazev, count(*) pocet_prodeju
    FROM Zbozi NATURAL JOIN Koupil
    GROUP BY kodZb, nazev;

SELECT * FROM MP2;
