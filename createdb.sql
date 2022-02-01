BEGIN;

------- create db ---------
-- CREATE DATABASE "CourierCompanyManagementSystem"
--    WITH
--    OWNER = postgres
--    ENCODING = 'UTF8'
--    LC_COLLATE = 'Turkish_Turkey.1254'
--    LC_CTYPE = 'Turkish_Turkey.1254'
--    TABLESPACE = pg_default
--    CONNECTION LIMIT = -1;

-------- create schema ------------
CREATE SCHEMA public
    AUTHORIZATION postgres;

-------- create tables -------------
CREATE TABLE public."Courier"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "From_Customer_ID" integer,
    "To_Customer_ID" integer,
    "Route_ID" integer,
    "Deliver_Date" date,
    "Price" bigint,
    "Cargo_Number" bigint,
    "Weight" integer,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Customers"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "Name" text NOT NULL,
    "Address" text,
    "Telephone" text,
    "Mail_Address" text,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Locations"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "Country" text NOT NULL,
    "City" text NOT NULL,
    "ZipCode" text NOT NULL,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Carriers"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "Name" text NOT NULL,
    "Surname" text NOT NULL,
    "Plaque" text,
    "PassportID" text,
    "Transport_ID" integer,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Transport"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100 CACHE 10 ),
    "Name" text NOT NULL,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Route"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "From_Location_ID" integer,
    "To_Location_ID" integer,
    PRIMARY KEY ("ID")
);

CREATE TABLE public."Path"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 1000 CACHE 100 ),
    "From_Location_ID" integer,
    "To_Location_ID" integer,
    "Carrier_ID" integer,
    "Route_ID" integer,
    "Price" bigint,
    PRIMARY KEY ("ID")
);

ALTER TABLE public."Carriers"
    ADD FOREIGN KEY ("Transport_ID")
    REFERENCES public."Transport" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Courier"
    ADD FOREIGN KEY ("Route_ID")
    REFERENCES public."Route" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Route"
    ADD FOREIGN KEY ("From_Location_ID")
    REFERENCES public."Locations" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Route"
    ADD FOREIGN KEY ("To_Location_ID")
    REFERENCES public."Locations" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Path"
    ADD FOREIGN KEY ("From_Location_ID")
    REFERENCES public."Locations" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Path"
    ADD FOREIGN KEY ("To_Location_ID")
    REFERENCES public."Locations" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Path"
    ADD FOREIGN KEY ("Carrier_ID")
    REFERENCES public."Carriers" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Courier"
    ADD FOREIGN KEY ("From_Customer_ID")
    REFERENCES public."Customers" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Courier"
    ADD FOREIGN KEY ("To_Customer_ID")
    REFERENCES public."Customers" ("ID")
    ON DELETE CASCADE;


ALTER TABLE public."Path"
    ADD FOREIGN KEY ("Route_ID")
    REFERENCES public."Route" ("ID")
    ON DELETE CASCADE;

---------add records to tables -----------------
INSERT INTO public."Customers"(
	"Name", "Address", "Telephone", "Mail_Address")
	VALUES
	('Bosch', 'Manisa OSB', '023612345678', 'info@bosch.com.tr'),
	('CMS', 'Izmir AOSB', '023211223344', 'info@cms.com.tr'),
	('Vestel', 'Manisa OSB', '0236324252', 'info@vestel.com.tr'),
	('Ege Seramik', 'Izmir Kemalpasa', '0232567483', 'info@egeseramik.com.tr'),
	('Siemens', 'Istanbul Kartal', '0216879901', 'info@siemens.com.tr'),
	('Aselsan', 'Ankara', '0312456980', 'info@aselsan.com'),
	('Linens', 'Denizli Merkez', '0258769978', 'info@linens.com.tr'),
	('Tubitak', 'Ankara', '0312587090', 'info@tubitak.gov.tr'),
	('BMC', 'Izmir Isıkkent', '0232232425', 'info@bmc.com.tr'),
	('Arcelik', 'Istanbul', '0212556677', 'info@arcelik.com.tr');

INSERT INTO public."Transport"("Name")
	VALUES
	('Car'),
	('Truck'),
	('Ship'),
	('Train'),
	('Plane'),
	('Motorcycle'),
	('Helicopter'),
	('Crane'),
	('Bicycle'),
	('Person');

INSERT INTO public."Locations"(
	"Country", "City", "ZipCode")
	VALUES
	('Turkey', 'Istanbul', '34500'),
	('Germany', 'Munich', '12345'),
	('France', 'Paris', '334455'),
	('England', 'London', '667788'),
	('Germany', 'Hamburg', '676899'),
	('France', 'Lion', '654321'),
	('Russia', 'Moscov', '009878'),
	('Turkey', 'Mersin', '786544'),
	('USA', 'New York', '668750'),
	('Portugal', 'Porto', '998076'),
	('Italy', 'Venice', '114536');

INSERT INTO public."Carriers"(
	"Name", "Surname", "Plaque", "PassportID", "Transport_ID")
	VALUES
	( 'Ahmet', 'Cetin', '23EE345', '1233ED233', 2),
	( 'Mehmet', 'Dag', '34ASD12', 'UT45336', 1),
	( 'Yusuf', 'Guney', NULL, '1233ED233', 4),
	( 'Mert', 'Can', 'Speedy' , 'HGT67859', 3),
	( 'Polat', 'Gozupek', '34AFD223', 'RTG67950', 2),
	( 'Can', 'Yavas', NULL, 'CCS223211', 4),
	( 'Refik', 'Tulu', NULL, '45TT77U8', 5),
	( 'Soner', 'Cetin', '45TGF67', 'GG679907', 1),
	( 'Burak', 'Ay', NULL, 'TT567804', 5),
	( 'Ayse', 'Durmaz', NULL, 'RFD23005', 4);

INSERT INTO public."Route"(
	"From_Location_ID", "To_Location_ID")
	VALUES
	(1, 2),
	(1, 4),
	(2, 5),
	(10, 8),
	(3, 6),
	(7, 8),
	(1, 8),
	(3, 11),
	(9, 4),
	(5, 2);

INSERT INTO public."Courier"(
	"From_Customer_ID", "To_Customer_ID", "Route_ID", "Deliver_Date", "Price", "Cargo_Number", "Weight")
	VALUES
	(1,2 ,1 ,'2019-11-23' ,1200 ,11343 , 500),
	(2,5 ,2 ,'2021-02-13' ,800 ,18765 , 1500),
	(3,1 ,3 ,'2018-10-08' ,1300 ,22345 , 1000),
	(4,8 ,4 ,'2020-11-11' ,700 ,666742 , 900),
	(9,7 ,5 ,'2020-06-28' ,2000 ,562227 , 800),
	(6,9 ,6 ,'2021-03-15', 1200 , 0054674 , 1200),
	(4,3 ,7 ,'2021-03-03' ,900 ,442316 , 700),
	(3,10,8 ,'2021-12-20' ,1000 ,66372 , 700),
	(8,1 ,9 ,'2021-02-12' ,1100 ,141413 , 600),
	(7,5 ,10 ,'2020-01-17' ,900 ,66262 , 1200);

INSERT INTO public."Path"(
	"From_Location_ID", "To_Location_ID", "Carrier_ID", "Route_ID", "Price")
	VALUES
	(1, 3, 1, 1, 200),
	(3, 2, 2, 1, 500),
	(1, 4, 7, 2, 1000),
	(2, 5, 6, 3, 1200),
	(10, 6, 10, 4, 500),
	(6, 8, 5, 4, 800),
	(3, 6, 8, 5, 400),
	(7, 8, 6, 6, 900),
	(1, 8, 3, 7, 400),
	(3, 11, 4, 8, 700),
	(9, 10, 4, 9, 1700),
	(10, 4, 1, 9, 400),
	(5, 2, 10, 10, 1300);
------------ create view -------------------
-- View: public.Train_Carriers

-- DROP VIEW public."Train_Carriers";

CREATE OR REPLACE VIEW public."Train_Carriers"
 AS
 SELECT c."Name",
    c."Surname",
    c."PassportID",
    c."Transport_ID"
   FROM "Carriers" c
  WHERE c."Transport_ID" = 4;

ALTER TABLE public."Train_Carriers"
    OWNER TO postgres;
------------ add record to view ------------------
INSERT INTO public."Train_Carriers"(
	"Name", "Surname", "PassportID", "Transport_ID")
	VALUES ('Fatma', 'Yolcu', 'FJY789K87', 4);
-------------- delete statements -------------------
DELETE FROM public."Carriers"
	WHERE "Name"='Fatma';

DELETE FROM public."Courier"
	WHERE "Price"=1100;

DELETE FROM public."Customers"
	WHERE "Name"='Bosch';

DELETE FROM public."Locations"
	WHERE "Country"='Italy';

DELETE FROM public."Path"
	WHERE "Carrier_ID"=2;

DELETE FROM public."Route"
	WHERE "From_Location_ID"=9;

DELETE FROM public."Transport"
	WHERE "Name"='Bicycle';

DELETE FROM public."Train_Carriers"
        WHERE "Name"='Yusuf';

------------- Update statements --------------
UPDATE public."Carriers"
	SET "Name"='Ece', "Surname"='Ozgur'
	WHERE "PassportID"='RFD23005';

UPDATE public."Courier"
	SET "Price"=750
	WHERE "Cargo_Number"='666742';

UPDATE public."Customers"
	SET "Mail_Address"='bilgi@cms.com.tr'
	WHERE "Name"='CMS';

UPDATE public."Locations"
	SET "ZipCode"='123456'
	WHERE "Country"='Germany' AND "City"='Munich';

UPDATE public."Path"
	SET "Price"=300
	WHERE "From_Location_ID"=1 AND "To_Location_ID"=3;

UPDATE public."Route"
	SET "From_Location_ID"=6, "To_Location_ID"=3
	WHERE "ID"=5;

UPDATE public."Transport"
	SET "Name"='People'
	WHERE "Name"='Person';

UPDATE public."Train_Carriers"
	SET "Name"='Savas'
	WHERE "PassportID"='CCS223211';
--------------- Alter Table --------------

ALTER TABLE "Customers" ADD COLUMN "Contact_Person" Text;
-------------------------------------------

END;