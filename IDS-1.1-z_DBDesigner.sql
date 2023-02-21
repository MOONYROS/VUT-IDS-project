CREATE TABLE "Pokladna" (
	"ID_pokl" NUMBER(2, 0) NOT NULL,
	"ID_prac" NUMBER(10, 0) NOT NULL,
	"obnos" FLOAT(10),
	constraint POKLADNA_PK PRIMARY KEY ("ID_pokl"));

CREATE sequence "POKLADNA_ID_POKL_SEQ";

CREATE trigger "BI_POKLADNA_ID_POKL"
  before insert on "Pokladna"
  for each row
begin
  select "POKLADNA_ID_POKL_SEQ".nextval into :NEW."ID_pokl" from dual;
end;

/
CREATE TABLE "Zamestnanec" (
	"ID_zam" NUMBER(10, 0) NOT NULL,
	"jmeno" VARCHAR2(20) NOT NULL,
	"prijmeni" VARCHAR2(20) NOT NULL,
	"pozice" VARCHAR2(20) NOT NULL,
	"rod_cislo" NUMBER(10, 0) NOT NULL,
	"plat" NUMBER(10, 0) NOT NULL,
	constraint ZAMESTNANEC_PK PRIMARY KEY ("ID_zam"));

CREATE sequence "ZAMESTNANEC_ID_ZAM_SEQ";

CREATE trigger "BI_ZAMESTNANEC_ID_ZAM"
  before insert on "Zamestnanec"
  for each row
begin
  select "ZAMESTNANEC_ID_ZAM_SEQ".nextval into :NEW."ID_zam" from dual;
end;

/
CREATE TABLE "Zbozi" (
	"ID_zbozi" NUMBER(10, 0) NOT NULL,
	"ID_po_pr" NUMBER(10, 0) NOT NULL,
	"typ" VARCHAR2(20) NOT NULL,
	"dodav" VARCHAR2(20) NOT NULL,
	constraint ZBOZI_PK PRIMARY KEY ("ID_zbozi"));

CREATE sequence "ZBOZI_ID_ZBOZI_SEQ";

CREATE trigger "BI_ZBOZI_ID_ZBOZI"
  before insert on "Zbozi"
  for each row
begin
  select "ZBOZI_ID_ZBOZI_SEQ".nextval into :NEW."ID_zbozi" from dual;
end;

/
CREATE TABLE "Prodejna" (
	"ID_zb_pr" NUMBER(10, 0) NOT NULL,
	"mno_pr" NUMBER(10, 0));


/
CREATE TABLE "Sklad" (
	"ID_zb_sk" NUMBER(10, 0) NOT NULL,
	"mno_sk" NUMBER(10, 0));


/
CREATE TABLE "Objednavka" (
	"ID_obj" NUMBER(10, 0) NOT NULL,
	"ID_ob_zam" NUMBER(10, 0),
	"ID_ob_zb" NUMBER(10, 0) NOT NULL,
	"cena" FLOAT(20) NOT NULL,
	constraint OBJEDNAVKA_PK PRIMARY KEY ("ID_obj"));

CREATE sequence "OBJEDNAVKA_ID_OBJ_SEQ";

CREATE trigger "BI_OBJEDNAVKA_ID_OBJ"
  before insert on "Objednavka"
  for each row
begin
  select "OBJEDNAVKA_ID_OBJ_SEQ".nextval into :NEW."ID_obj" from dual;
end;

/
CREATE TABLE "Faktura" (
	"ID_fak" NUMBER(10, 0) NOT NULL,
	"zpus_plat" VARCHAR2(20) NOT NULL);


/
ALTER TABLE "Pokladna" ADD CONSTRAINT "Pokladna_fk0" FOREIGN KEY ("ID_prac") REFERENCES "Zamestnanec"("ID_zam");


ALTER TABLE "Zbozi" ADD CONSTRAINT "Zbozi_fk0" FOREIGN KEY ("ID_po_pr") REFERENCES "Pokladna"("ID_pokl");

ALTER TABLE "Prodejna" ADD CONSTRAINT "Prodejna_fk0" FOREIGN KEY ("ID_zb_pr") REFERENCES "Zbozi"("ID_zbozi");

ALTER TABLE "Sklad" ADD CONSTRAINT "Sklad_fk0" FOREIGN KEY ("ID_zb_sk") REFERENCES "Zbozi"("ID_zbozi");

ALTER TABLE "Objednavka" ADD CONSTRAINT "Objednavka_fk0" FOREIGN KEY ("ID_ob_zam") REFERENCES "Zamestnanec"("ID_zam");
ALTER TABLE "Objednavka" ADD CONSTRAINT "Objednavka_fk1" FOREIGN KEY ("ID_ob_zb") REFERENCES "Zbozi"("ID_zbozi");

ALTER TABLE "Faktura" ADD CONSTRAINT "Faktura_fk0" FOREIGN KEY ("ID_fak") REFERENCES "Objednavka"("ID_obj");

