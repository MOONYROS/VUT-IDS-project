-- VYPRACOVALI: xlukas15 a xmorku03
-- od prvniho odevzdani se lehce pozmenil ER diagram
-- chteli jsme ho dat do odevzdani, ale je podporovan pouze jeden soubor
-- dali jsme ho tedy na nase studentske stranky:
-- http://www.stud.fit.vutbr.cz/~xlukas15/

DROP TABLE Pokladna cascade constraints;
DROP TABLE Zbozi cascade constraints;
DROP TABLE Objednavka cascade constraints;
DROP TABLE Osoba cascade constraints;
DROP TABLE Faktura cascade constraints;
DROP TABLE Zames cascade constraints;
DROP TABLE Zakaznik cascade constraints;

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
	dodav VARCHAR2(20));


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
	plat FLOAT(10),
	telefon NUMBER(9, 0),
	prac_pom VARCHAR2(20));


/
CREATE TABLE Zakaznik (
    ID_zakaznik NUMBER(10, 0),
	ID_zak NUMBER(10, 0),
	zak_karta NUMBER(10, 0),
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

-- Zamestnanci
INSERT INTO Zames
VALUES(0001, 2341,'reditel',100000,777888999,'HPP');

INSERT INTO Zames
VALUES(0002, 2351,'vedouci',50000,859876231,'HPP');

INSERT INTO Zames
VALUES(0003, 2361,'skladnik',40000,958858758,'DPP');

INSERT INTO Zames
VALUES(0004,2371,'pokladni',25000,'','HPP');

INSERT INTO Zames
VALUES(0005, 2372,'pokladni',25000,999888555,'DPP');

-- Zakaznici
INSERT INTO Zakaznik
VALUES(1000, 3381,'','0%',61256.55);

INSERT INTO Zakaznik
VALUES(2000, 3382,0004585,'10%',154282.64);

-- Pokladny
INSERT INTO Pokladna
VALUES(1, 2371, 50000);

INSERT INTO Pokladna
VALUES(2, 2372, 50000);

-- Zbozi
INSERT INTO Zbozi
VALUES(1001, 1, 'jablka', 'Sady s.r.o');

INSERT INTO Zbozi
VALUES(1002, 2, 'hrusky', 'Sady s.r.o');

INSERT INTO Zbozi
VALUES(1003, 2, 'pivo', 'Pivovar a.s.');

INSERT INTO Zbozi
VALUES(1004, '', 'rum', 'Rumovar s.r.o');

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


-- DOTAZY SELECT (3. ODEVZDANI)
