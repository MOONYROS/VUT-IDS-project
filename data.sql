-- Osoby
INSERT INTO Osoba
VALUES(2341,'Daniel','Vavra','vvr@whs.cz',7511025618);

INSERT INTO Osoba
VALUES(2351,'Leonidas','Moznar','nevim@neco.cz',6001223219);

INSERT INTO Osoba
VALUES(2361,'Johny','Zepy','hodne@makam.cz',8710127652);

INSERT INTO Osoba
VALUES(2371,'Kage','Belcova','zakaznicka@podpora.cz',739286688);

INSERT INTO Osoba
VALUES(2372,'Alena','Amplionova','',0101012104);

INSERT INTO Osoba
VALUES(3381,'Pan','Zakaznik','nejaky@mail.com',5211301112);

INSERT INTO Osoba
VALUES(3382,'Pani','Zakaznikova','',5104178193);

-- Zamestnanci
INSERT INTO Zames
VALUES(2341,'reditel',100000,777888999,'HPP');

INSERT INTO Zames
VALUES(2351,'vedouci',50000,859876231,'HPP');

INSERT INTO Zames
VALUES(2361,'skladnik',40000,958858758,'DPP');

INSERT INTO Zames
VALUES(2371,'pokladni',25000,'','HPP');

INSERT INTO Zames
VALUES(2372,'pokladni',25000,999888555,'DPP');

-- Zakaznici
INSERT INTO Zakaznik
VALUES(3381,'','0%',61256.55);

INSERT INTO Zakaznik
VALUES(3382,0004585,'10%',154282.64);

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

-- Objednavky
INSERT INTO Objednavka
VALUES(000284, 1001, 2341, 8950);

INSERT INTO Objednavka
VALUES(000285, 1002, '', 5800);

INSERT INTO Objednavka
VALUES(000286, 1004, 3381, 15000);

INSERT INTO Objednavka
VALUES(000287, 1003, 2361, 10500);

-- Faktury
INSERT INTO Faktura
VALUES(000284, 'kartou');

INSERT INTO Faktura
VALUES(000285, 'kartou');

INSERT INTO Faktura
VALUES(000286, 'hotove');

INSERT INTO Faktura
VALUES(000287, 'kartou');