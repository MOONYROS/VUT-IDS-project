DROP TABLE Koupil; 
DROP TABLE Zbozi; 
DROP TABLE Zakaznik; 

CREATE TABLE Zakaznik (cisloZ INT PRIMARY KEY, jmeno VARCHAR(50), dat_nar DATE, mesto VARCHAR(50));
CREATE TABLE Zbozi (kodZb INT PRIMARY KEY, nazev VARCHAR(50), kategorie VARCHAR(50), vyrobce VARCHAR(50)); 
CREATE TABLE Koupil (cisloZ INT REFERENCES Zakaznik (cisloZ), kodZb INT REFERENCES Zbozi (kodZb), datum DATE, cena INT, CONSTRAINT pk PRIMARY KEY (cisloZ, kodZb));

INSERT INTO Zakaznik VALUES (1,'Samuel', TO_DATE('1999-02-02', 'YYYY-MM-DD'), 'Brno');
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

-- a) Kolik zboží z kategorie "Monitory" Tylo zakoupeno v jednotlivých měsících oku 2019? (mesic, pocet_nakupu) 


-- b) Která zboží (kodZb, nazev, kategorie) nakupovali pouze zákazníci narození po roce 2000?


-- c) Kteří zákazníci (cisloZ, jmeno, mesto) koupili zboží s názvem 'Samsung A20' za nejvyšší cenu? 
-- (může být i více zákazníků, kteří zboží koupili za stejnou nejvyšší cenu)


-- d) Napište příkaz, který uživateli 'user01' přidělí práva ke čtení a modifika Lm tabulky Zbozi 


-- e) Napište příkaz, který modifikuje databázi tak, aby bylo zajištěno, že při =mazaní záznamu z tabulky Zbozi byly smazány všechny nákupy tohoto zboží z tabulky Koupil.


-- f) Napište příkaz pro vztvoření materializovaného pohledu, který bude obsahovat informaci o počtu prodejů jednotlivých zboží (kodZb, nazev, pocet_prodeju),
-- včetně zvolené varianty pro provádění aktualizace pohledu. popsat jak může být mp aktualizován

