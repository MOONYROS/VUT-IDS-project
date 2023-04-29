-- VYPRACOVALI: xlukas15 a xmorku03

DROP TABLE Pokladna cascade constraints;
DROP TABLE Zbozi cascade constraints;
DROP TABLE Objednavka cascade constraints;
DROP TABLE Osoba cascade constraints;
DROP TABLE Faktura cascade constraints;
DROP TABLE Zames cascade constraints;
DROP TABLE Zakaznik cascade constraints;

-- 4. ODEVZDANI
DROP TABLE Nepovolena_objednavka_log cascade constraints;
DROP TABLE malo_kontaktu_log cascade constraints;

DROP SEQUENCE auto_num;

CREATE TABLE Pokladna (
	ID_pokl NUMBER(2, 0) NOT NULL,
	ID_oso NUMBER(10, 0) NOT NULL,
	obnos FLOAT(10));


/
CREATE TABLE Osoba (
	ID_osoby NUMBER(10, 0) NOT NULL,
	jmeno VARCHAR2(20),
	prijmeni VARCHAR2(20),
	email VARCHAR2(40),
	rod_cislo VARCHAR2(11) NOT NULL
    CONSTRAINT check_rc CHECK (REGEXP_LIKE(rod_cislo, '^\d{6}/\d{4}$')));


/
CREATE TABLE Zbozi (
	ID_zbozi NUMBER(10, 0) NOT NULL,
	ID_po_pr NUMBER(10, 0),
	typ VARCHAR2(20),
	dodav VARCHAR2(50));


/
CREATE TABLE Objednavka (
	ID_obj NUMBER(10, 0) NOT NULL,
	ID_ob_zb NUMBER(10, 0) NOT NULL,
	ID_ob_oso NUMBER(10, 0),
	cena FLOAT(20));


/
CREATE TABLE Faktura (
	ID_fak NUMBER(10, 0),
	zpus_plat VARCHAR2(20));


/
CREATE TABLE Zames (
    ID_zames NUMBER(10, 0),
	ID_zam NUMBER(10, 0),
	pozice VARCHAR2(20),
	plat NUMBER(10, 0),
	telefon NUMBER(9, 0),
	prac_pom VARCHAR2(20));


/
CREATE TABLE Zakaznik (
    ID_zakaznik NUMBER(10, 0),
	ID_zak NUMBER(10, 0),
	zak_karta VARCHAR2(4),
	sleva VARCHAR2(10),
	utrata FLOAT(10));


-- ALTER TABLES --
/
-- PRIMARNI KLICE
ALTER TABLE Pokladna ADD CONSTRAINT POKLADNA_PK PRIMARY KEY (ID_pokl);
ALTER TABLE Osoba ADD CONSTRAINT OSOBA_PK PRIMARY KEY (ID_osoby);
ALTER TABLE Zbozi ADD CONSTRAINT ZBOZI_PK PRIMARY KEY (ID_zbozi);
ALTER TABLE Objednavka ADD CONSTRAINT OBJEDNAVKA_PK PRIMARY KEY (ID_obj);
ALTER TABLE Zames ADD CONSTRAINT ZAMES_PK PRIMARY KEY (ID_zames);
ALTER TABLE Zakaznik ADD CONSTRAINT ZAKAZNIK_PK PRIMARY KEY (ID_zakaznik);

-- CIZI KLICE
ALTER TABLE Pokladna ADD CONSTRAINT Pokladna_fk0 FOREIGN KEY (ID_oso) REFERENCES Osoba(ID_osoby);
ALTER TABLE Zbozi ADD CONSTRAINT Zbozi_fk0 FOREIGN KEY (ID_po_pr) REFERENCES Pokladna(ID_pokl);
ALTER TABLE Objednavka ADD CONSTRAINT Objednavka_fk0 FOREIGN KEY (ID_ob_zb) REFERENCES Zbozi(ID_zbozi);
ALTER TABLE Objednavka ADD CONSTRAINT Objednavka_fk1 FOREIGN KEY (ID_ob_oso) REFERENCES Osoba(ID_osoby);
ALTER TABLE Faktura ADD CONSTRAINT Faktura_fk0 FOREIGN KEY (ID_fak) REFERENCES Objednavka(ID_obj);

-- tady probiha generalizace-specializace tim, ze bereme ID_osoby jako cizi klic a podle nej vytvarime ID_zam/ID_zak
ALTER TABLE Zames ADD CONSTRAINT Zames_fk0 FOREIGN KEY (ID_zam) REFERENCES Osoba(ID_osoby);
ALTER TABLE Zakaznik ADD CONSTRAINT Zakaznik_fk0 FOREIGN KEY (ID_zak) REFERENCES Osoba(ID_osoby);

CREATE SEQUENCE auto_num
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 10;


-- PRIDAVANI DO DATABAZE (2. ODEVZDANI)
-- Osoby
INSERT INTO Osoba
VALUES(2341,'Daniel','Vavra','vvr@whs.cz', '751102/5618');

INSERT INTO Osoba
VALUES(2351,'Leonidas','Moznar','nevim@neco.cz', '600122/3219');

INSERT INTO Osoba
VALUES(2361,'Johny','Zepy','hodne@makam.cz', '871012/7652');

INSERT INTO Osoba
VALUES(2371,'Kage','Belcova','zakaznicka@podpora.cz', '739285/6688');

INSERT INTO Osoba
VALUES(2372,'Alena','Amplionova','', '010101/2104');

INSERT INTO Osoba
VALUES(3381,'Pan','Zakaznik','nejaky@mail.com', '521130/1112');

INSERT INTO Osoba
VALUES(3382,'Pani','Zakaznikova','', '510417/8193');

INSERT INTO Osoba
VALUES(3383,'Hans','Kezda','', '810329/4880');

INSERT INTO Osoba
VALUES(3384,'Jan','Neruda','trojuhelnik@pythagoras.com', '150930/0001');

INSERT INTO Osoba
VALUES(3385,'Karolina','Svetla','kaja@marik.cz', '351224/7894');

INSERT INTO Osoba
VALUES(3386,'Alena','424','Alena.Tesarova@vutbr.cz', '975525/8524');

INSERT INTO Osoba
VALUES(3387,'Martin','Omacht','martas.omachtu@gmail.com', '970812/6483');

INSERT INTO Osoba
VALUES(3388,'Tomas','Bari','', '020202/0202');

INSERT INTO Osoba
VALUES(2373,'Ricardo','Milos','lf@gf.tf', '851111/1111');

INSERT INTO Osoba
VALUES(2374,'Roman','Plachetka','romanek@plachtim.pl', '000101/0101');

-- Zamestnanci
INSERT INTO Zames
VALUES(0001, 2341,'reditel', 100000, 777888999, 'HPP');

INSERT INTO Zames
VALUES(0002, 2351, 'vedouci', 50000, 859876231, 'HPP');

INSERT INTO Zames
VALUES(0003, 2361, 'skladnik', 40000, 958858758, 'DPP');

INSERT INTO Zames
VALUES(0004,2371, 'pokladni', 25000, '', 'HPP');

INSERT INTO Zames
VALUES(0005, 2372, 'pokladni', 20000, 999888555, 'DPP');

INSERT INTO Zames
VALUES(0006, 2373, 'pokladni', 22000, 111111111, 'DPP');

INSERT INTO Zames
VALUES(0007, 2374, 'spravce_site', 17300, '', 'HPP');

-- Zakaznici
INSERT INTO Zakaznik
VALUES(1000, 3381,'NE','0%', 61256.55);

INSERT INTO Zakaznik
VALUES(2000, 3382, 'ANO','10%', 154282.64);

INSERT INTO Zakaznik
VALUES(3000, 3383, 'ANO','4%', 21456.00);

INSERT INTO Zakaznik
VALUES(4000, 3384, 'ANO','8%', 35000.00);

INSERT INTO Zakaznik
VALUES(5000, 3385, 'NE','0%', 2800.00);

INSERT INTO Zakaznik
VALUES(6000, 3386, 'NE','1%', 1500.00);

INSERT INTO Zakaznik
VALUES(7000, 3387, 'ANO','40%', 154282.64);

INSERT INTO Zakaznik
VALUES(8000, 3388, 'NE','0%', 10.90);

-- Pokladny
INSERT INTO Pokladna
VALUES(1, 2371, 50000);

INSERT INTO Pokladna
VALUES(2, 2372, 50000);

INSERT INTO Pokladna
VALUES(3, 2373, 50000);

-- Zbozi
INSERT INTO Zbozi
VALUES(1001, 1, 'jablka', 'Sady s.r.o');

INSERT INTO Zbozi
VALUES(1002, 2, 'hrusky', 'Sady s.r.o');

INSERT INTO Zbozi
VALUES(1003, 2, 'pivo', 'Pivovar a.s.');

INSERT INTO Zbozi
VALUES(1004, '', 'rum', 'Rumovar s.r.o');

INSERT INTO Zbozi
VALUES(1005, 3, 'svestky', 'Sady s.r.o');

INSERT INTO Zbozi
VALUES(1006, 3, 'Sejvovice', 'Rumovar s.r.o');

INSERT INTO Zbozi
VALUES(1007, 1, 'Handlovane Hennessy', 'Dobre Piticko a.s.');

INSERT INTO Zbozi
VALUES(1008, 3, 'banany', 'Lidl');

INSERT INTO Zbozi
VALUES(1009, 2, 'kokosy', 'Palmy s.r.o');

INSERT INTO Zbozi
VALUES(1010, '', 'Malibu', 'Dobre Piticko a.s.');

-- Objednavky a faktury
INSERT INTO Objednavka
VALUES(auto_num.nextval, 1001, 2341, 8950);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1002, '', 5800);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1004, 3381, 15000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'hotove');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1003, 2361, 10500);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1003, 2361, 20000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1003, 2361, 14000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'hotove');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1005, 3386, 150);
INSERT INTO Faktura
VALUES(auto_num.currval, 'prevodem');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1006, '', 35000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'hotove');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1007, 3386, 899);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1008, 2361, 20000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1009, 3382, 10000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'hotove');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1010, 3381, 25000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1010, '', 10000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'prevodem');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1003, 2351, 40000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'prevodem');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1006, 2351, 60000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1006, 2351, 35000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1006, 2341, 5000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'kartou');

INSERT INTO Objednavka
VALUES(auto_num.nextval, 1006, 2341, 13000);
INSERT INTO Faktura
VALUES(auto_num.currval, 'hotove');

-- DOTAZY SELECT (3. ODEVZDANI)

-- Vybira, za kolik penez se v objednavkach koupilo dane zbozi (Spojeni 2 tabulek).
-- SELECT ID_ob_zb, cena
-- FROM Objednavka INNER JOIN Faktura ON Faktura.ID_fak = Objednavka.ID_obj;
--
-- -- Vybira, kolik utratil zakaznik se jmenem Pan Zakaznik (Spojeni 2 tabulek).
-- SELECT jmeno, prijmeni, utrata
-- FROM Osoba INNER JOIN Zakaznik ON Osoba.ID_osoby = Zakaznik.ID_zak
-- WHERE jmeno = 'Pan' AND prijmeni = 'Zakaznik';
--
-- -- Vybira, prijmeni zamestancu, kteri pracuji na ktere pokladne a zaroven jejichz pracovni pomer je DPP (Spojeni 3 tabulek).
-- SELECT prijmeni, ID_pokl
-- FROM Osoba INNER JOIN Zames ON Osoba.ID_osoby = Zames.ID_zam INNER JOIN Pokladna ON Osoba.ID_osoby = Pokladna.ID_oso
-- WHERE prac_pom = 'DPP';
--
-- -- Vybira pocet objednavek podle typu zbozi s cenou vyssi nez 10.000 (GROUP BY + AGREGACNI FUNKCE).
-- SELECT typ, count(*) pocet_obj
-- FROM Zbozi INNER JOIN Objednavka ON Zbozi.ID_zbozi = Objednavka.ID_ob_zb
-- WHERE cena >= 10000
-- GROUP BY typ;
--
-- -- Vybira, kolik utratili zakaznici co kartu maji nebo nemaji (GROUP BY + AGREGACNI FUNKCE).
-- SELECT zak_karta, sum(utrata)
-- FROM Zakaznik
-- GROUP BY zak_karta;
--
-- -- Vybira zamestance, co maji zadany jak email, tak telefonni cislo (POUZITI OPERATORU EXISTS).
-- SELECT jmeno, prijmeni
-- FROM Osoba
-- WHERE EXISTS(SELECT * FROM Zames WHERE Osoba.ID_osoby = Zames.ID_zam AND telefon IS NOT NULL AND email IS NOT NULL);
--
-- -- Vybira, jaky typ zbozi dodavaji dodavatele, co jsou spolecnost s rucenim omezenym (POUZITI OPERATORU IN).
-- SELECT dodav, typ
-- FROM Zbozi
-- WHERE ID_zbozi IN(SELECT ID_zbozi FROM Zbozi WHERE dodav LIKE '%s.r.o');

-- 4. ODEVZDANI
-- TRIGGER 1
CREATE TABLE Nepovolena_objednavka_log (
    ID_ob_oso NUMBER(10),
    zprava VARCHAR2(50),
    cena FLOAT(20)
);

CREATE OR REPLACE TRIGGER Povolena_objednavka
    AFTER INSERT ON Objednavka
    FOR EACH ROW
    WHEN (NEW.cena > 50000)
DECLARE
	cislo_osoby Objednavka.ID_ob_oso%TYPE := :NEW.ID_ob_oso;
	castka Objednavka.cena%TYPE := :NEW.cena;
	Nepovolena_objednavka EXCEPTION;
BEGIN
	IF cislo_osoby <> 2341 THEN
		RAISE Nepovolena_objednavka;
	END IF;
EXCEPTION
	WHEN Nepovolena_objednavka THEN
		INSERT INTO Nepovolena_objednavka_log(ID_ob_oso, zprava, cena)
		    VALUES (cislo_osoby, 'Pouze reditel muze vytvorit objednavku v hodnote:', castka);
END;
/

INSERT INTO Objednavka
VALUES(123456, 1007, 3386, 60000);
INSERT INTO Faktura
VALUES(123456, 'kartou');

INSERT INTO Objednavka
VALUES(123457, 1007, 2341, 80000);
INSERT INTO Faktura
VALUES(123457, 'kartou');

INSERT INTO Objednavka
VALUES(123458, 1005, 3386, 10000);
INSERT INTO Faktura
VALUES(123458, 'kartou');

INSERT INTO Objednavka
VALUES(123459, 1003, 2361, 100000);
INSERT INTO Faktura
VALUES(123459, 'kartou');

SELECT * FROM Nepovolena_objednavka_log;

-- TRIGGER 2
CREATE TABLE malo_kontaktu_log (
    ID_osoby NUMBER(10),
    zprava VARCHAR2(70)
);

CREATE OR REPLACE TRIGGER kontrola_kontaktu
    BEFORE INSERT ON Zames
    FOR EACH ROW
DECLARE
    t_email Osoba.email%TYPE;
    t_telefon Zames.telefon%TYPE;
    malo_kontaktu EXCEPTION;
BEGIN
    SELECT email INTO t_email
    FROM Osoba
    WHERE ID_osoby = :new.ID_zam;

    t_telefon := :new.telefon;

    IF t_email IS NULL AND t_telefon IS NULL THEN
        RAISE malo_kontaktu;
    END IF;

EXCEPTION
    WHEN malo_kontaktu THEN
        INSERT INTO malo_kontaktu_log(ID_osoby, zprava)
            VALUES (:new.ID_zam, 'Zamestnanec nema ani jeden z kontaktu. Je potreba alespon jeden.');
END;
/


INSERT INTO Osoba
VALUES (2362, 'Miluju', 'Triggery', '', '999999/9999');
INSERT INTO Zames
VALUES (8, 2362, 'skladnik', 38000, '', 'HPP');

SELECT * FROM malo_kontaktu_log;

-- PROCEDURA 1
CREATE OR REPLACE PROCEDURE ZmenaPlatuPozice (
	pozice IN VARCHAR2,
	plat IN NUMBER
)
IS
	p_pozice VARCHAR2(20);
	p_plat NUMBER(10, 0);
BEGIN
    p_pozice := pozice;
    p_plat := plat;
	UPDATE Zames
	SET plat = plat + p_plat
	WHERE pozice = p_pozice;
	COMMIT;
END;

SELECT ID_zam, pozice, plat FROM Zames WHERE pozice = 'reditel'
										  OR pozice = 'pokladni'
										  OR pozice = 'vedouci';

BEGIN
	ZmenaPlatuPozice('reditel', 5001);
END;

BEGIN
	ZmenaPlatuPozice('pokladni', 1002);
END;

BEGIN
	ZmenaPlatuPozice('vedouci', -999);
END;

SELECT ID_zam, pozice, plat FROM Zames WHERE pozice = 'reditel'
										  OR pozice = 'pokladni'
										  OR pozice = 'vedouci';

-- TODO PROCEDURA 2 (+ kurzor)
CREATE OR REPLACE PROCEDURE zmen_dodav(
    p_old_dodav VARCHAR2,
    p_new_dodav VARCHAR2
)
IS
    v_old_dodav VARCHAR2(50) := p_old_dodav;
    v_new_dodav VARCHAR2(50) := p_new_dodav;
    CURSOR c_zbozi IS
        SELECT *
        FROM Zbozi
        WHERE dodav = v_old_dodav
        FOR UPDATE;

    v_zbozi Zbozi%ROWTYPE;
BEGIN
    OPEN c_zbozi;
    LOOP
        FETCH c_zbozi INTO v_zbozi;

        EXIT WHEN c_zbozi%NOTFOUND;

        UPDATE Zbozi
        SET dodav = v_new_dodav
        WHERE CURRENT OF c_zbozi;
    END LOOP;

    CLOSE c_zbozi;

    COMMIT;
END;
/

SELECT dodav FROM Zbozi;

BEGIN
    zmen_dodav('Rumovar s.r.o', 'Rumovarna u modreho stromu s.r.o');
end;

SELECT dodav FROM Zbozi;


-- EXPLAIN PLAN (prakticke pouziti)
-- Spocitame cenu vsech objednavek podle zpusobu platby
-- Chceme zjistit, jestli ma smysl setrit penize na zavedeni levnejsich samoobsluznych pokladen (pouze placeni kartou)
-- nebo jestli utratit vice penez za pokladny, ktere prijimaji hotovost.
SELECT zpus_plat, sum(cena)
FROM Objednavka INNER JOIN Faktura ON ID_obj = ID_fak
GROUP BY zpus_plat;

EXPLAIN PLAN FOR
	SELECT zpus_plat, sum(cena)
	FROM Objednavka INNER JOIN Faktura ON ID_obj = ID_fak
	GROUP BY zpus_plat;
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


CREATE INDEX ind_zpus ON Faktura (ID_fak, zpus_plat);

EXPLAIN PLAN FOR
	SELECT zpus_plat, sum(cena)
	FROM Objednavka INNER JOIN Faktura ON ID_obj = ID_fak
	GROUP BY zpus_plat;
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX ind_zpus;

-- KOMPLEXNI SELECT
-- Dotaz ukazuje, kolik se objednalo ktereho typu zbozi za urcitou cenu, pricemz musel
-- objednavku vytvorit zamestnanec.
-- nejdrive si predvytvorime tabulku spojujici Zbozi a Obejdnavku
WITH objednane_zbozi AS (
    SELECT ID_ob_oso, ID_obj, typ, cena
    FROM Zbozi INNER JOIN Objednavka ON Zbozi.ID_zbozi = Objednavka.ID_ob_zb
)
-- Spocitame si pocet objednavek urciteho typu zbozi podle cenove kategorie.
-- Objednavku MUSEL vytvorit zamestnanec (tedy ne automat nebo zakaznik)
SELECT typ, count(ID_obj) AS pocet_obj_zbozi,
	CASE
	    WHEN cena < 25000
	        THEN 'Do 25000 Kc'
		WHEN cena >= 25000 AND cena < 50000
	    	THEN 'Od 25000 do 50000 Kc'
	    WHEN cena >= 50000
	    	THEN 'Za 50000 Kc a vice'
    END AS cenova_kategorie
-- Dotaz spojime s predvytvorenou tabulkou, na kterou jsme pouzili WITH
FROM Osoba INNER JOIN Zames ON Osoba.ID_osoby = Zames.ID_zam
		   INNER JOIN objednane_zbozi ON objednane_zbozi.ID_ob_oso = Osoba.ID_osoby
-- Nakonec seradime podle typu zbozi
GROUP BY typ,
    CASE
        WHEN cena < 25000
            THEN 'Do 25000 Kc'
        WHEN cena >= 25000 AND cena < 50000
            THEN 'Od 25000 do 50000 Kc'
        WHEN cena >= 50000
            THEN 'Za 50000 Kc a vice'
    END;

-- pripadne vymenit GRANT za REVOKE
GRANT ALL ON Osoba TO xmorku03;
GRANT ALL ON Zakaznik TO xmorku03;
GRANT ALL ON Zames TO xmorku03;
GRANT ALL ON Pokladna TO xmorku03;
GRANT ALL ON Zbozi TO xmorku03;
GRANT ALL ON Objednavka TO xmorku03;
GRANT ALL ON Faktura TO xmorku03;
GRANT ALL ON malo_kontaktu_log TO xmorku03;
GRANT ALL ON Nepovolena_objednavka_log TO xmorku03;
GRANT ALL ON vybrat_neco TO xmorku03;

CREATE MATERIALIZED VIEW vybrat_neco
BUILD IMMEDIATE
REFRESH
ON COMMIT
AS
SELECT *
FROM XLUKAS15.ZBOZI;

DROP MATERIALIZED VIEW vybrat_neco;

SELECT typ, dodav
FROM vybrat_neco;
