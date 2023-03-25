CREATE TABLE "Zamestnanec" (
	"cislo_zamestnance" NUMBER(10, 0) NOT NULL,
	"jmeno" VARCHAR2(20) NOT NULL,
	"primeni" VARCHAR2(20) NOT NULL,
	"pozice" VARCHAR2(20) NOT NULL,
	"rodne_cislo" NUMBER(10, 0) NOT NULL,
	constraint ZAMESTNANEC_PK PRIMARY KEY ("cislo_zamestnance"));

CREATE sequence "ZAMESTNANEC_CISLO_ZAMESTNANCE_SEQ";

CREATE trigger "BI_ZAMESTNANEC_CISLO_ZAMESTNANCE"
  before insert on "Zamestnanec"
  for each row
begin
  select "ZAMESTNANEC_CISLO_ZAMESTNANCE_SEQ".nextval into :NEW."cislo_zamestnance" from dual;
end;

/
CREATE TABLE "Pokladna" (
	"cislo_pokladny" NUMBER(2, 0) NOT NULL,
	"obnos" NUMBER(10, 0) NOT NULL,
	constraint POKLADNA_PK PRIMARY KEY ("cislo_pokladny"));

CREATE sequence "POKLADNA_CISLO_POKLADNY_SEQ";

CREATE trigger "BI_POKLADNA_CISLO_POKLADNY"
  before insert on "Pokladna"
  for each row
begin
  select "POKLADNA_CISLO_POKLADNY_SEQ".nextval into :NEW."cislo_pokladny" from dual;
end;

/
CREATE TABLE "Zbozi" (
	"kod_zbozi" NUMBER(10, 0) NOT NULL,
	"typ" VARCHAR2(20) NOT NULL,
	"dodavatel" VARCHAR2(20) NOT NULL,
	constraint ZBOZI_PK PRIMARY KEY ("kod_zbozi"));


/
CREATE TABLE "Prodejna" (
	"mnostvi_v_prodejne" NUMBER(10, 0) NOT NULL);


/
CREATE TABLE "Sklad" (
	"mnozstvi_ve_skladu" NUMBER(10, 0) NOT NULL);


/
CREATE TABLE "Objednavka" (
	"cislo_objednavky" NUMBER(10, 0) NOT NULL,
	"cena" FLOAT(20) NOT NULL,
	constraint OBJEDNAVKA_PK PRIMARY KEY ("cislo_objednavky"));

CREATE sequence "OBJEDNAVKA_CISLO_OBJEDNAVKY_SEQ";

CREATE trigger "BI_OBJEDNAVKA_CISLO_OBJEDNAVKY"
  before insert on "Objednavka"
  for each row
begin
  select "OBJEDNAVKA_CISLO_OBJEDNAVKY_SEQ".nextval into :NEW."cislo_objednavky" from dual;
end;

/
CREATE TABLE "Faktura" (
	"cislo_faktury" NUMBER(10, 0) NOT NULL,
	"zpusob_platby" VARCHAR2(20) NOT NULL,
	"dodavatel" VARCHAR2(20) NOT NULL);

CREATE sequence "FAKTURA_CISLO_FAKTURY_SEQ";

CREATE trigger "BI_FAKTURA_CISLO_FAKTURY"
  before insert on "Faktura"
  for each row
begin
  select "FAKTURA_CISLO_FAKTURY_SEQ".nextval into :NEW."cislo_faktury" from dual;
end;

/



ALTER TABLE "Prodejna" ADD CONSTRAINT "Prodejna_fk0" FOREIGN KEY ("mnostvi_v_prodejne") REFERENCES "Zbozi"("kod_zbozi");

ALTER TABLE "Sklad" ADD CONSTRAINT "Sklad_fk0" FOREIGN KEY ("mnozstvi_ve_skladu") REFERENCES "Zbozi"("kod_zbozi");


ALTER TABLE "Faktura" ADD CONSTRAINT "Faktura_fk0" FOREIGN KEY ("cislo_faktury") REFERENCES "Objednavka"("cislo_objednavky");

