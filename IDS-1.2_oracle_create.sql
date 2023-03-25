DROP TABLE Pokladna cascade constraints;
DROP TABLE Zbozi cascade constraints;
DROP TABLE Objednavka cascade constraints;
DROP TABLE Osoba cascade constraints;
DROP TABLE Faktura cascade constraints;
DROP TABLE Zames cascade constraints;
DROP TABLE Zakaznik cascade constraints;

CREATE TABLE Pokladna (
	ID_pokl NUMBER(2, 0) NOT NULL,
	ID_oso NUMBER(10, 0) NOT NULL,
	obnos FLOAT(10));


/
CREATE TABLE Osoba (
	ID_osoby NUMBER(10, 0) NOT NULL,
	jmeno VARCHAR2(20),
	prijmeni VARCHAR2(20),
	email VARCHAR2(20),
	rod_cislo NUMBER(10, 0));


/
CREATE TABLE Zbozi (
	ID_zbozi NUMBER(10, 0) NOT NULL,
	ID_po_pr NUMBER(10, 0) NOT NULL,
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
	ID_zam NUMBER(10, 0),
	pozice VARCHAR2(20),
	plat FLOAT(10),
	telefon NUMBER(9, 0),
	prac_pom VARCHAR2(20));


/
CREATE TABLE Zakaznik (
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

-- CIZI KLICE
ALTER TABLE Pokladna ADD CONSTRAINT Pokladna_fk0 FOREIGN KEY (ID_oso) REFERENCES Osoba(ID_osoby);
ALTER TABLE Zbozi ADD CONSTRAINT Zbozi_fk0 FOREIGN KEY (ID_po_pr) REFERENCES Pokladna(ID_pokl);
ALTER TABLE Objednavka ADD CONSTRAINT Objednavka_fk0 FOREIGN KEY (ID_ob_zb) REFERENCES Zbozi(ID_zbozi);
ALTER TABLE Objednavka ADD CONSTRAINT Objednavka_fk1 FOREIGN KEY (ID_ob_oso) REFERENCES Osoba(ID_osoby);
ALTER TABLE Faktura ADD CONSTRAINT Faktura_fk0 FOREIGN KEY (ID_fak) REFERENCES Objednavka(ID_obj);
ALTER TABLE Zames ADD CONSTRAINT Zames_fk0 FOREIGN KEY (ID_zam) REFERENCES Osoba(ID_osoby);
ALTER TABLE Zakaznik ADD CONSTRAINT Zakaznik_fk0 FOREIGN KEY (ID_zak) REFERENCES Osoba(ID_osoby);


-- PRIDAVANI DO DATABAZE
INSERT INTO Osoba (ID_osoby, jmeno, prijmeni, email, rod_cislo) VALUES (123, 'Franta', 'Voprsalek', 'franta@voprsalek.cz', 1403954112);
INSERT INTO Zames (ID_zam, pozice, telefon, prac_pom, plat) VALUES (123,'vedouci', 123456789, 'HPP', '50000');

SELECT * FROM Osoba;
SELECT * FROM Zames;
