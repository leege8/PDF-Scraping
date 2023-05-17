REM Advanced Relational Database Management
REM This file is used to create, and add data to entity objects.


BEGIN   
    EXECUTE IMMEDIATE 'DROP TABLE COMPANY CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COMPANYCONTACT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CONTRACT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EVALUATION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE INVENTORY CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ORDERLINE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE REFERRAL CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ROUTE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SHIPMENT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SHIPMENTLINE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TAX CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE VEHICLE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DELIVERY CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BILLING CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE billing (
    billingid       VARCHAR2(6) NOT NULL,
    companyid       VARCHAR2(6) NOT NULL,
    orderid         VARCHAR2(6),
    contractid      VARCHAR2(6),
    Paid            CHAR(1) NOT NULL,
    billingamount   NUMBER(14, 2) DEFAULT 0
);

CREATE UNIQUE INDEX billing__idx ON
    billing (
        contractid
    ASC );

CREATE UNIQUE INDEX billing__idxv1 ON
    billing (
        orderid
    ASC );

ALTER TABLE billing ADD CONSTRAINT billing_pk PRIMARY KEY ( billingid );



CREATE TABLE company (
    companyid           VARCHAR2(6) NOT NULL,
    companyname         VARCHAR2(50) NOT NULL,
    deposit_waived     CHAR(1) NOT NULL,
    street              VARCHAR2(40),
    city                VARCHAR2(25),
    state               VARCHAR2(2),
    zip                 VARCHAR2(10),
    companysize         VARCHAR2(12) NOT NULL,
    status              VARCHAR2(12) NOT NULL,
    county              VARCHAR2(20),
    routeid             VARCHAR2(6) NOT NULL,
    employeeid          VARCHAR2(6) NOT NULL,
    contactid           VARCHAR2(6) NOT NULL,
    taxid               VARCHAR2(6) NOT NULL,
    deposit_watercooler NUMBER(6),
    communication       VARCHAR2(30)
);

CREATE UNIQUE INDEX company__idx ON
    company (
        contactid
    ASC );

CREATE UNIQUE INDEX company__idxv1 ON
    company (
        taxid
    ASC );

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( companyid );

CREATE TABLE companycontact (
    contactid   VARCHAR2(6) NOT NULL,
    fname       VARCHAR2(25) NOT NULL,
    lname       VARCHAR2(25) NOT NULL,
    tel         CHAR(15) NOT NULL
);

ALTER TABLE companycontact ADD CONSTRAINT companycontact_pk PRIMARY KEY ( contactid );

CREATE TABLE contract (
    contractid                     VARCHAR2(6) NOT NULL,
    contract_description           VARCHAR2(30) NOT NULL,
    contract_start_date            DATE NOT NULL,
    contract_end_date              DATE NOT NULL,
    contract_signed_date           DATE NOT NULL,
    renewal_date                   DATE NOT NULL,
    contracted_number_of_bottles   INTEGER NOT NULL,
    contract_amount                NUMBER(10, 2) NOT NULL,
    frequency                      VARCHAR2(10) NOT NULL,
    companyid                      VARCHAR2(6) NOT NULL
);

ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( contractid );
ALTER TABLE contract ADD CONSTRAINT end_date_later_than_start_date_CK CHECK (contract_start_date <= contract_end_date) ;



CREATE TABLE delivery (
    deliveryid          VARCHAR2(6) NOT NULL,
    deliverydate        DATE NOT NULL,
    customer_comments   VARCHAR2(40),
    driver_comments     VARCHAR2(40),
    employeeid          VARCHAR2(6),
    vehicleid           VARCHAR2(6) NOT NULL
);

ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( deliveryid );

CREATE TABLE employee (
    employeeid        VARCHAR2(6) NOT NULL,
    role              VARCHAR2(20) NOT NULL,
    fname             VARCHAR2(25) NOT NULL,
    lname             VARCHAR2(25) NOT NULL,
    employment_date   DATE NOT NULL,
    gender            CHAR(1) NOT NULL,
    salary            NUMBER(10, 2) NOT NULL,
    age               INTEGER NOT NULL,
    race              VARCHAR2(10),
    managerid         VARCHAR2(6),
    routeid           VARCHAR2(6)
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employeeid );

CREATE TABLE evaluation (
    evaluationid     VARCHAR2(6) NOT NULL,
    evaluationdate   DATE NOT NULL,
    employeeid       VARCHAR2(6) NOT NULL,
    evalComments     VARCHAR2(50)
);

ALTER TABLE evaluation ADD CONSTRAINT evaluation_pk PRIMARY KEY ( evaluationid );

CREATE TABLE inventory (
    inventoryid         VARCHAR2(7) NOT NULL,
    description         VARCHAR2(20) NOT NULL,
    RetailPrice         NUMBER(6, 2) NOT NULL,
    inventoryquantity   INTEGER NOT NULL
);

ALTER TABLE inventory ADD CONSTRAINT inventory_pk PRIMARY KEY ( inventoryid );
ALTER TABLE inventory ADD CONSTRAINT inventory_qty_CK CHECK (inventoryquantity >0);


CREATE TABLE ORDERS (
    orderid                VARCHAR2(6) NOT NULL,
    orderdate              DATE NOT NULL,
    futureorder            CHAR(1),
    expecteddeliverydate   DATE,
    employeeid             VARCHAR2(6),
    companyid              VARCHAR2(6)
);

ALTER TABLE ORDERS ADD CONSTRAINT orders_pk PRIMARY KEY ( orderid );
ALTER TABLE ORDERS ADD CONSTRAINT expected_delivery_CK CHECK (orderdate  <= expecteddeliverydate ) ;


CREATE TABLE orderline (
    orderlineid   VARCHAR2(6) NOT NULL,
    quantity      INTEGER NOT NULL,
    orderid       VARCHAR2(6) NOT NULL
);

ALTER TABLE orderline ADD CONSTRAINT orderline_pk PRIMARY KEY ( orderlineid );

CREATE TABLE referral (
    referralid              VARCHAR2(6) NOT NULL,
    referral_company_name   VARCHAR2(50) NOT NULL,
    referral_company_size   VARCHAR2(12) NOT NULL,
    deliveryid              VARCHAR2(6),
    companyid               VARCHAR2(6),
    convertedToCustomer     VARCHAR2(1)
);

ALTER TABLE referral ADD CONSTRAINT referral_pk PRIMARY KEY ( referralid );

CREATE TABLE route (
    routeid             VARCHAR2(6) NOT NULL,
    deliverymanagerid   VARCHAR2(6) NOT NULL,
    route_difficulty    VARCHAR2(12) NOT NULL,
    route_description   VARCHAR2(30),
    routedistance       NUMBER NOT NULL
);

ALTER TABLE route ADD CONSTRAINT route_pk PRIMARY KEY ( routeid );

CREATE TABLE shipment (
    shipmentid        VARCHAR2(6) NOT NULL,
    Contract          CHAR(1) NOT NULL,
    shippeddate       DATE,
    contractid        VARCHAR2(6),
    orderid           VARCHAR2(6),
    deliveryid        VARCHAR2(6) NOT NULL
);

CREATE UNIQUE INDEX shipment__idx ON
    shipment (
        contractid
    ASC );

CREATE UNIQUE INDEX shipment__idxv1 ON
    shipment (
        orderid
    ASC );

ALTER TABLE shipment ADD CONSTRAINT shipment_pk PRIMARY KEY ( shipmentid );

CREATE TABLE shipmentline (
    shipmentline_id   VARCHAR2(6) NOT NULL,
    receiveddate      DATE,
    quantity          INTEGER NOT NULL,
    inventoryid       VARCHAR2(7),
    shipmentid        VARCHAR2(6) NOT NULL
);

ALTER TABLE shipmentline ADD CONSTRAINT shipmentline_pk PRIMARY KEY ( shipmentline_id );

CREATE TABLE tax (
    taxid        VARCHAR2(6) NOT NULL,
    tax_amount   NUMBER(8, 2) NOT NULL
);

ALTER TABLE tax ADD CONSTRAINT tax_pk PRIMARY KEY ( taxid );

CREATE TABLE vehicle (
    vehicleid   VARCHAR2(6) NOT NULL,
    make        VARCHAR2(20) NOT NULL,
    model       VARCHAR2(20) NOT NULL,
    color       VARCHAR2(12) NOT NULL
);

ALTER TABLE vehicle ADD CONSTRAINT vehicle_pk PRIMARY KEY ( vehicleid );


CREATE UNIQUE INDEX COMPANY_ALT_IDX
	ON COMPANY (COMPANYNAME);

CREATE INDEX EMPLOYEE_ALT_IDX
	ON EMPLOYEE (LNAME);

ALTER TABLE employee
    ADD CONSTRAINT employee_employee_fk FOREIGN KEY ( managerid )
        REFERENCES employee ( employeeid )
        DEFERRABLE INITIALLY DEFERRED;

INSERT INTO Employee VALUES('E001','Sales Manager','Maria','Garcia',to_date('11/20/2009', 'mm/dd/yyyy'),'F',80000,26,'White','E007',NULL);
INSERT INTO Employee VALUES('E002','Delivery Person','Robert ','Smith',to_date('6/1/2008', 'mm/dd/yyyy'),'M',60000,23,'Asian','E003','R003');
INSERT INTO Employee VALUES('E003','Delivery Manager','Taylor','Jones',to_date('5/13/2012', 'mm/dd/yyyy'),'M',90000,33,'Black','E004',NULL);
INSERT INTO Employee VALUES('E004','Manager','Michael','Davis',to_date('7/1/2009', 'mm/dd/yyyy'),'M',100000,41,'White','E004',NULL);
INSERT INTO Employee VALUES('E005','HR Manager','Brianna','Reeves',to_date('6/16/2008', 'mm/dd/yyyy'),'F',80000,29,'Hispanic','E004',NULL);
INSERT INTO Employee VALUES('E006','Delivery Manager','John','Killian',to_date('9/3/2012', 'mm/dd/yyyy'),'M',90000,35,'White','E004',NULL);
INSERT INTO Employee VALUES('E007','Sales Manager','Destini','Koss',to_date('6/16/2017', 'mm/dd/yyyy'),'F',90000,25,'Black','E004',NULL);
INSERT INTO Employee VALUES('E008','Delivery Person','Jose','Davis',to_date('9/15/2008', 'mm/dd/yyyy'),'M',60000,26,'Asian','E006','R005');
INSERT INTO Employee VALUES('E009','SalesManager','Robert','Parsons',to_date('5/13/2014', 'mm/dd/yyyy'),'M',80000,25,'White','E007',NULL);
INSERT INTO Employee VALUES('E010','SalesManager','Shawn','Cropper',to_date('2/16/2015', 'mm/dd/yyyy'),'M',80000,24,'Hispanic','E007',NULL);
INSERT INTO Employee VALUES('E011','Delivery Manager','Arthur','Dietreich',to_date('3/25/2013', 'mm/dd/yyyy'),'M',60000,26,'Asian','E006',NULL);
INSERT INTO Employee VALUES('E012','Sales Manager','Fanny','Runte',to_date('6/16/2015', 'mm/dd/yyyy'),'F',80000,21,'Hispanic','E007',NULL);
INSERT INTO Employee VALUES('E013','Delivery Person','Daniel','Higa',to_date('1/9/2017', 'mm/dd/yyyy'),'M',60000,27,'Asian','E006','R003');
INSERT INTO Employee VALUES('E014','Delivery Person','Evelyn ','Vrabel',to_date('8/13/2012', 'mm/dd/yyyy'),'F',60000,36,'Asian','E006','R002');
INSERT INTO Employee VALUES('E015','Delivery Person','Lawrence','Snyder',to_date('6/16/2017', 'mm/dd/yyyy'),'M',60000,25,'White','E003','R004');
INSERT INTO Employee VALUES('E016','Delivery Person','Eugene','Lewis',to_date('8/3/2015', 'mm/dd/yyyy'),'M',60000,39,'White','E003','R005');
INSERT INTO Employee VALUES('E017','Delivery Person','Hebert','Bothello',to_date('9/30/2013', 'mm/dd/yyyy'),'M',60000,35,'White','E003','R001');
INSERT INTO Employee VALUES('E018','Delivery Person','Bradley','Rodregez',to_date('10/6/2014', 'mm/dd/yyyy'),'M',60000,31,'Hispanic','E003','R003');
INSERT INTO Employee VALUES('E019','Delivery Person','Brandon','Linn',to_date('6/16/2014', 'mm/dd/yyyy'),'M',60000,28,'Asian','E006','R001');
INSERT INTO Employee VALUES('E020','Delivery Person','Julie','Williams',to_date('11/13/2017', 'mm/dd/yyyy'),'F',60000,25,'Black','E006','R005');
INSERT INTO Employee VALUES('E021','Delivery Person','Erica','Smith',to_date('1/9/2017', 'mm/dd/yyyy'),'F',60000,27,'White','E024','R005');
INSERT INTO Employee VALUES('E022','Delivery Person','Tyler','Ping',to_date('8/13/2012', 'mm/dd/yyyy'),'M',60000,24,'Asian','E025','R004');
INSERT INTO Employee VALUES('E023','Delivery Person','Chadwick','Bosnan',to_date('6/16/2017', 'mm/dd/yyyy'),'M',60000,24,'Black','E026','R001');
INSERT INTO Employee VALUES('E024','Delivery Manager','John','Jones',to_date('8/3/2015', 'mm/dd/yyyy'),'M',90000,36,'White','E004','R002');
INSERT INTO Employee VALUES('E025','Sales Manager','Linda','Mendoza',to_date('9/30/2013', 'mm/dd/yyyy'),'F',80000,29,'Hispanic','E007',NULL);


INSERT INTO Billing VALUES('BIV001','C001',NULL,'CA002','Y',0);
INSERT INTO Billing VALUES('BIV002','C002',NULL,'CA008','Y',0);
INSERT INTO Billing VALUES('BIV003','C003',NULL,'CA003','Y',0);
INSERT INTO Billing VALUES('BIV004','C004',NULL,'CA001','Y',0);
INSERT INTO Billing VALUES('BIV005','C005',NULL,'CA006','Y',0);
INSERT INTO Billing VALUES('BIV006','C006',NULL,'CA005','Y',0);
INSERT INTO Billing VALUES('BIV007','C007',NULL,'CA004','Y',0);
INSERT INTO Billing VALUES('BIV008','C001','OA001',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV009','C001','OA002',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV010','C004','OA003',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV011','C007','OA004',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV012','C010','OA005',NULL,'N',0);
INSERT INTO Billing VALUES('BIV013','C002','OA006',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV014','C006','OA007',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV015','C002','OA008',NULL,'N',0);
INSERT INTO Billing VALUES('BIV016','C005','OA009',NULL,'N',0);
INSERT INTO Billing VALUES('BIV017','C008',NULL,'CA007','N',0);
INSERT INTO Billing VALUES('BIV018','C009',NULL,'CA010','N',0);
INSERT INTO Billing VALUES('BIV019','C010',NULL,'CA009','Y',0);
INSERT INTO Billing VALUES('BIV020','C008','OA010',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV021','C006','OA011',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV022','C010','OA012',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV023','C005','OA013',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV024','C008','OA014',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV025','C008','OA015',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV026','C003','OA016',NULL,'N',0);
INSERT INTO Billing VALUES('BIV027','C010','OA017',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV028','C007','OA018',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV029','C005','OA019',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV030','C006','OA020',NULL,'N',0);
INSERT INTO Billing VALUES('BIV031','C002','OA021',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV032','C007','OA022',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV033','C010','OA023',NULL,'N',0);
INSERT INTO Billing VALUES('BIV034','C005','OA024',NULL,'N',0);
INSERT INTO Billing VALUES('BIV035','C003','OA025',NULL,'N',0);
INSERT INTO Billing VALUES('BIV036','C001','OA026',NULL,'N',0);
INSERT INTO Billing VALUES('BIV037','C001','OA027',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV038','C004','OA028',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV039','C007','OA029',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV040','C010','OA030',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV041','C002','OA031',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV042','C006','OA032',NULL,'N',0);
INSERT INTO Billing VALUES('BIV043','C002','OA033',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV044','C005','OA034',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV045','C008','OA035',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV046','C006','OA036',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV047','C010','OA037',NULL,'N',0);
INSERT INTO Billing VALUES('BIV048','C005','OA038',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV049','C008','OA039',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV050','C008','OA040',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV051','C003','OA041',NULL,'N',0);
INSERT INTO Billing VALUES('BIV052','C010','OA042',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV053','C007','OA043',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV054','C005','OA044',NULL,'N',0);
INSERT INTO Billing VALUES('BIV055','C006','OA045',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV056','C002','OA046',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV057','C007','OA047',NULL,'N',0);
INSERT INTO Billing VALUES('BIV058','C010','OA048',NULL,'N',0);
INSERT INTO Billing VALUES('BIV059','C005','OA049',NULL,'N',0);
INSERT INTO Billing VALUES('BIV060','C003','OA050',NULL,'N',0);
INSERT INTO Billing VALUES('BIV061','C001','OA051',NULL,'N',0);
INSERT INTO Billing VALUES('BIV062','C001','OA052',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV063','C004','OA053',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV064','C007','OA054',NULL,'N',0);
INSERT INTO Billing VALUES('BIV065','C010','OA055',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV066','C002','OA056',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV067','C006','OA057',NULL,'N',0);
INSERT INTO Billing VALUES('BIV068','C002','OA058',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV069','C005','OA059',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV070','C008','OA060',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV071','C006','OA061',NULL,'N',0);
INSERT INTO Billing VALUES('BIV072','C010','OA062',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV073','C005','OA063',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV074','C008','OA064',NULL,'N',0);
INSERT INTO Billing VALUES('BIV075','C008','OA065',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV076','C003','OA066',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV077','C010','OA067',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV078','C007','OA068',NULL,'N',0);
INSERT INTO Billing VALUES('BIV079','C005','OA069',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV080','C006','OA070',NULL,'N',0);
INSERT INTO Billing VALUES('BIV081','C002','OA071',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV082','C007','OA072',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV083','C010','OA073',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV084','C005','OA074',NULL,'N',0);
INSERT INTO Billing VALUES('BIV085','C003','OA075',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV086','C001','OA076',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV087','C001','OA077',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV088','C004','OA078',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV089','C007','OA079',NULL,'N',0);
INSERT INTO Billing VALUES('BIV090','C010','OA080',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV091','C002','OA081',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV092','C006','OA082',NULL,'N',0);
INSERT INTO Billing VALUES('BIV093','C002','OA083',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV094','C005','OA084',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV095','C008','OA085',NULL,'N',0);
INSERT INTO Billing VALUES('BIV096','C006','OA086',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV097','C010','OA087',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV098','C005','OA088',NULL,'Y',0);
INSERT INTO Billing VALUES('BIV099','C008','OA089',NULL,'N',0);
INSERT INTO Billing VALUES('BIV100','C008','OA090',NULL,'N',0);

INSERT INTO Contract VALUES('CA010',' ', to_date('11/1/2022', 'mm/dd/yyyy'),to_date('10/31/2023', 'mm/dd/yyyy'),to_date('9/15/2022', 'mm/dd/yyyy'),to_date('11/1/2023', 'mm/dd/yyyy'),40,900,8,'C009');
INSERT INTO Contract VALUES('CA009',' ', to_date('11/1/2022', 'mm/dd/yyyy'),to_date('10/31/2023', 'mm/dd/yyyy'),to_date('9/15/2022', 'mm/dd/yyyy'),to_date('11/1/2023', 'mm/dd/yyyy'),50,1000,12,'C010');
INSERT INTO Contract VALUES('CA008',' ', to_date('8/13/2022', 'mm/dd/yyyy'),to_date('8/12/2023', 'mm/dd/yyyy'),to_date('7/20/2022', 'mm/dd/yyyy'),to_date('8/13/2023', 'mm/dd/yyyy'),115,5750,12,'C002');
INSERT INTO Contract VALUES('CA007',' ', to_date('7/1/2022', 'mm/dd/yyyy'),to_date('6/30/2023', 'mm/dd/yyyy'),to_date('6/14/2022', 'mm/dd/yyyy'),to_date('7/1/2023', 'mm/dd/yyyy'),210,10500,6,'C008');
INSERT INTO Contract VALUES('CA006',' ', to_date('6/1/2022', 'mm/dd/yyyy'),to_date('6/1/2023', 'mm/dd/yyyy'),to_date('5/1/2022', 'mm/dd/yyyy'),to_date('6/1/2023', 'mm/dd/yyyy'),60,3000,12,'C005');
INSERT INTO Contract VALUES('CA005',' ', to_date('9/15/2022', 'mm/dd/yyyy'),to_date('9/15/2023', 'mm/dd/yyyy'),to_date('8/15/2022', 'mm/dd/yyyy'),to_date('9/15/2023', 'mm/dd/yyyy'),250,12500,12,'C006');
INSERT INTO Contract VALUES('CA004',' ', to_date('5/1/2022', 'mm/dd/yyyy'),to_date('5/1/2023', 'mm/dd/yyyy'),to_date('3/27/2022', 'mm/dd/yyyy'),to_date('5/1/2023', 'mm/dd/yyyy'),100,5000,12,'C007');
INSERT INTO Contract VALUES('CA003',' ', to_date('2/15/2022', 'mm/dd/yyyy'),to_date('2/15/2023', 'mm/dd/yyyy'),to_date('2/1/2022', 'mm/dd/yyyy'),to_date('2/15/2023', 'mm/dd/yyyy'),150,7500,6,'C003');
INSERT INTO Contract VALUES('CA002',' ', to_date('4/3/2022', 'mm/dd/yyyy'),to_date('4/3/2023', 'mm/dd/yyyy'),to_date('4/1/2022', 'mm/dd/yyyy'),to_date('4/3/2023', 'mm/dd/yyyy'),80,4000,12,'C001');
INSERT INTO Contract VALUES('CA001',' ', to_date('2/15/2022', 'mm/dd/yyyy'),to_date('2/15/2023', 'mm/dd/yyyy'),to_date('2/1/2022', 'mm/dd/yyyy'),to_date('2/15/2023', 'mm/dd/yyyy'),60,700,9,'C004');

INSERT INTO Company VALUES('C001','Carnegie Art Museum','N','412 Walnut St','Oakland','PA',15213,'Large','Active','Allegheny County','R005','E001',1,'T001',300,'In-person Visit');
INSERT INTO Company VALUES('C002','Pittsburgh Tattoo Company','N','5863 Hobart St','Squirrel Hill','PA',15217,'Small','Active','Allegheny County','R002','E005',2,'T002',300,'Over the phone');
INSERT INTO Company VALUES('C003','Minadeo Elementary School','Y','3312 Murray Ave','Homestead','PA',15120,'Small','Active','Allegheny County','R003','E010',3,'T003',200,'Over the phone');
INSERT INTO Company VALUES('C004','Dave and Busters','N','152 11th St','Braddock','PA',15104,'Large','Inactive','Allegheny County','R003','E005',4,'T004',0,'In-person Visit');
INSERT INTO Company VALUES('C005','Monterey Bay Fish Grotto','N','400, 9th St','Pittsburgh','PA',15204,'Large','Active','Allegheny County','R005','E009',5,'T005',200,'In-person Visit');
INSERT INTO Company VALUES('C006','UPMC Childrens Community Pediatrics','N','514, Mellon St','Liberty','PA',15133,'Small','Active','Allegheny County','R003','E009',6,'T006',100,'Over the phone');
INSERT INTO Company VALUES('C007','UPMC Hospital','Y','1500 5th Ave','McKeesport','PA',15123,'Large','Active','Allegheny County','R002','E010',7,'T007',200,'Over the phone');
INSERT INTO Company VALUES('C008','Rivers Casino','N','200, N Negley','Shadyside','PA',15250,'Large','Active','Allegheny County','R001','E012',8,'T008',100,'In-person Visit');
INSERT INTO Company VALUES('C009','Maloy-Schleifer Funeral Home','Y','915 Kennedy Ave','Duquesne','PA',15110,'Small','Inactive','Allegheny County','R004','E001',9,'T009',0,'In-person Visit');
INSERT INTO Company VALUES('C010','Eddie Vs Prime Seafood','Y','313N, 6th St','Pittsburgh','PA',15203,'Small','Active','Allegheny County','R005','E012',10,'T010',400,'Over the phone');


INSERT INTO CompanyContact VALUES('1','Kimberley','Guerra','(368) 850-1828');
INSERT INTO CompanyContact VALUES('2','Syeda','Gregory','(848) 874-1381');
INSERT INTO CompanyContact VALUES('3','Agnes','Clark','(438) 347-2905');
INSERT INTO CompanyContact VALUES('4','Princess','Todd','(880) 225-7729');
INSERT INTO CompanyContact VALUES('5','Mustafa','Hanson','(837) 863-3116');
INSERT INTO CompanyContact VALUES('6','Izabella','Jennings','(442) 945-3163');
INSERT INTO CompanyContact VALUES('7','Natalie','Daniels','(846) 889-3887');
INSERT INTO CompanyContact VALUES('8','Deacon','Pacheco','(417) 439-1041');
INSERT INTO CompanyContact VALUES('9','William','Chen','(833) 877-0278');
INSERT INTO CompanyContact VALUES('10','Caiden','Kramer','(360) 992-1216');

INSERT INTO Evaluation VALUES('EV0001', to_date('1/31/2023', 'mm/dd/yyyy'),'E002','Great work this month. Keep up the good work.');
INSERT INTO Evaluation VALUES('EV0002', to_date('1/31/2023', 'mm/dd/yyyy'),'E008','Very focused and productive. Nice job.');
INSERT INTO Evaluation VALUES('EV0003', to_date('1/31/2023', 'mm/dd/yyyy'),'E011','Not your best month, but we are still pleased.');
INSERT INTO Evaluation VALUES('EV0004', to_date('1/31/2023', 'mm/dd/yyyy'),'E013','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0005', to_date('1/31/2023', 'mm/dd/yyyy'),'E014','A huge asset for our company this month.');
INSERT INTO Evaluation VALUES('EV0006', to_date('1/31/2023', 'mm/dd/yyyy'),'E015','Seems ready for a promotion.');
INSERT INTO Evaluation VALUES('EV0007', to_date('1/31/2023', 'mm/dd/yyyy'),'E016','A huge asset for our company this month.');
INSERT INTO Evaluation VALUES('EV0008', to_date('1/31/2023', 'mm/dd/yyyy'),'E017','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0009', to_date('1/31/2023', 'mm/dd/yyyy'),'E018','A little slower than last month. Keep working.');
INSERT INTO Evaluation VALUES('EV0010', to_date('1/31/2023', 'mm/dd/yyyy'),'E019','Great work this month. Keep up the good work.');
INSERT INTO Evaluation VALUES('EV0011', to_date('1/31/2023', 'mm/dd/yyyy'),'E020','Not your best month, but we are still overall.');
INSERT INTO Evaluation VALUES('EV0012', to_date('12/31/2022', 'mm/dd/yyyy'),'E002','Very focused and productive. Nice job.');
INSERT INTO Evaluation VALUES('EV0013', to_date('12/31/2022', 'mm/dd/yyyy'),'E008','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0014', to_date('12/31/2022', 'mm/dd/yyyy'),'E011','Not your best month, but we are still overall.');
INSERT INTO Evaluation VALUES('EV0015', to_date('12/31/2022', 'mm/dd/yyyy'),'E013','A huge asset for our company this month.');
INSERT INTO Evaluation VALUES('EV0016', to_date('12/31/2022', 'mm/dd/yyyy'),'E014','Fantastic work over the last two weeks.');
INSERT INTO Evaluation VALUES('EV0017', to_date('12/31/2022', 'mm/dd/yyyy'),'E015','Great work this month. Keep up the good work.');
INSERT INTO Evaluation VALUES('EV0018', to_date('12/31/2022', 'mm/dd/yyyy'),'E016','A huge asset for our company this month.');
INSERT INTO Evaluation VALUES('EV0019', to_date('12/31/2022', 'mm/dd/yyyy'),'E017','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0020', to_date('12/31/2022', 'mm/dd/yyyy'),'E018','Seems ready for a promotion.');
INSERT INTO Evaluation VALUES('EV0021', to_date('12/31/2022', 'mm/dd/yyyy'),'E019','Very focused and productive. Nice job.');
INSERT INTO Evaluation VALUES('EV0022', to_date('12/31/2022', 'mm/dd/yyyy'),'E020','A little slower than last month. Keep working.');
INSERT INTO Evaluation VALUES('EV0023', to_date('11/30/2022', 'mm/dd/yyyy'),'E002','Not your best month, but we are still pleased.');
INSERT INTO Evaluation VALUES('EV0024', to_date('11/30/2022', 'mm/dd/yyyy'),'E008','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0025', to_date('11/30/2022', 'mm/dd/yyyy'),'E011','A huge asset for our company this month.');
INSERT INTO Evaluation VALUES('EV0026', to_date('11/30/2022', 'mm/dd/yyyy'),'E013','Fantastic work over the last two weeks.');
INSERT INTO Evaluation VALUES('EV0027', to_date('11/30/2022', 'mm/dd/yyyy'),'E014','Great work this month. Keep up the good work.');
INSERT INTO Evaluation VALUES('EV0028', to_date('11/30/2022', 'mm/dd/yyyy'),'E015','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0029', to_date('11/30/2022', 'mm/dd/yyyy'),'E016','Not your best month, but we are still overall.');
INSERT INTO Evaluation VALUES('EV0030', to_date('11/30/2022', 'mm/dd/yyyy'),'E017','A little slower than last month. Keep working.');
INSERT INTO Evaluation VALUES('EV0031', to_date('11/30/2022', 'mm/dd/yyyy'),'E018','Very focused and productive. Nice job.');
INSERT INTO Evaluation VALUES('EV0032', to_date('11/30/2022', 'mm/dd/yyyy'),'E019','Fantastic numbers this month. Great work!');
INSERT INTO Evaluation VALUES('EV0033', to_date('11/30/2022', 'mm/dd/yyyy'),'E020','A huge asset for our company this month.');


INSERT INTO Tax VALUES('T001',0.06);
INSERT INTO Tax VALUES('T002',0.07);
INSERT INTO Tax VALUES('T003',0.06);
INSERT INTO Tax VALUES('T004',0.06);
INSERT INTO Tax VALUES('T005',0.06);
INSERT INTO Tax VALUES('T006',0.06);
INSERT INTO Tax VALUES('T007',0.06);
INSERT INTO Tax VALUES('T008',0.06);
INSERT INTO Tax VALUES('T009',0.06);
INSERT INTO Tax VALUES('T010',0.06);


INSERT INTO Route VALUES('R001','E003','Medium','Shadyside',20);
INSERT INTO Route VALUES('R002','E003','High','Squirrel Hill',25);
INSERT INTO Route VALUES('R003','E003','Low','Liberty',15);
INSERT INTO Route VALUES('R004','E003','Low','Turtle Creek',18);
INSERT INTO Route VALUES('R005','E003','Medium','Pittsburgh',22);

INSERT INTO Delivery VALUES('DL001',to_date('8/7/2022','mm/dd/yyyy'),NULL,NULL,'E011','VNZ001');
INSERT INTO Delivery VALUES('DL002',to_date('5/1/2022','mm/dd/yyyy'),'Interested in a long term contract','Accuired potential referral','E008','VNZ004');
INSERT INTO Delivery VALUES('DL003',to_date('6/7/2022','mm/dd/yyyy'),NULL,NULL,'E002','VNZ005');
INSERT INTO Delivery VALUES('DL004',to_date('7/1/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ008');
INSERT INTO Delivery VALUES('DL005',to_date('12/5/2022','mm/dd/yyyy'),NULL,NULL,'E014','VNZ002');
INSERT INTO Delivery VALUES('DL006',to_date('6/20/2022','mm/dd/yyyy'),'Interested in a yearly contract','Accuired potential referral','E015','VNZ011');
INSERT INTO Delivery VALUES('DL007',to_date('2/9/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ006');
INSERT INTO Delivery VALUES('DL008',to_date('8/1/2022','mm/dd/yyyy'),'Interested in a yearly contract','Accuired potential referral','E017','VNZ003');
INSERT INTO Delivery VALUES('DL009',to_date('5/18/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ009');
INSERT INTO Delivery VALUES('DL010',to_date('8/1/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ011');
INSERT INTO Delivery VALUES('DL011',to_date('9/5/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ003');
INSERT INTO Delivery VALUES('DL012',to_date('3/7/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ002');
INSERT INTO Delivery VALUES('DL013',to_date('8/1/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ010');
INSERT INTO Delivery VALUES('DL014',to_date('7/4/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ006');
INSERT INTO Delivery VALUES('DL015',to_date('1/4/2022','mm/dd/yyyy'),'Interested in a long term contract','Accuired potential referral','E011','VNZ001');
INSERT INTO Delivery VALUES('DL016',to_date('2/16/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ008');
INSERT INTO Delivery VALUES('DL017',to_date('6/6/2022','mm/dd/yyyy'),NULL,NULL,'E002','VNZ007');
INSERT INTO Delivery VALUES('DL018',to_date('1/13/2022','mm/dd/yyyy'),'Interested in a long term contract','Accuired potential referral','E023','VNZ004');
INSERT INTO Delivery VALUES('DL019',to_date('3/25/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ006');
INSERT INTO Delivery VALUES('DL020',to_date('7/1/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ008');
INSERT INTO Delivery VALUES('DL021',to_date('5/1/2022','mm/dd/yyyy'),NULL,NULL,'E002','VNZ011');
INSERT INTO Delivery VALUES('DL022',to_date('5/16/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ009');
INSERT INTO Delivery VALUES('DL023',to_date('4/25/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ007');
INSERT INTO Delivery VALUES('DL024',to_date('8/1/2022','mm/dd/yyyy'),NULL,NULL,'E011','VNZ003');
INSERT INTO Delivery VALUES('DL025',to_date('3/25/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ002');
INSERT INTO Delivery VALUES('DL026',to_date('12/24/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ005');
INSERT INTO Delivery VALUES('DL027',to_date('10/21/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ002');
INSERT INTO Delivery VALUES('DL028',to_date('8/3/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ010');
INSERT INTO Delivery VALUES('DL029',to_date('2/3/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ007');
INSERT INTO Delivery VALUES('DL030',to_date('5/21/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ008');
INSERT INTO Delivery VALUES('DL031',to_date('1/20/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ007');
INSERT INTO Delivery VALUES('DL032',to_date('5/22/2022','mm/dd/yyyy'),NULL,NULL,'E008','VNZ003');
INSERT INTO Delivery VALUES('DL033',to_date('6/25/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ009');
INSERT INTO Delivery VALUES('DL034',to_date('3/5/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ005');
INSERT INTO Delivery VALUES('DL035',to_date('7/1/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ007');
INSERT INTO Delivery VALUES('DL036',to_date('7/2/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ001');
INSERT INTO Delivery VALUES('DL037',to_date('10/14/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ003');
INSERT INTO Delivery VALUES('DL038',to_date('1/16/2022','mm/dd/yyyy'),NULL,NULL,'E002','VNZ006');
INSERT INTO Delivery VALUES('DL039',to_date('8/13/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ002');
INSERT INTO Delivery VALUES('DL040',to_date('3/2/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ004');
INSERT INTO Delivery VALUES('DL041',to_date('5/25/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ001');
INSERT INTO Delivery VALUES('DL042',to_date('4/3/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ008');
INSERT INTO Delivery VALUES('DL043',to_date('12/27/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ002');
INSERT INTO Delivery VALUES('DL044',to_date('1/18/2022','mm/dd/yyyy'),NULL,NULL,'E017','VNZ002');
INSERT INTO Delivery VALUES('DL045',to_date('2/13/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ006');
INSERT INTO Delivery VALUES('DL046',to_date('3/16/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ004');
INSERT INTO Delivery VALUES('DL047',to_date('5/1/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ009');
INSERT INTO Delivery VALUES('DL048',to_date('11/14/2022','mm/dd/yyyy'),NULL,NULL,'E008','VNZ007');
INSERT INTO Delivery VALUES('DL049',to_date('4/23/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ001');
INSERT INTO Delivery VALUES('DL050',to_date('1/27/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ004');
INSERT INTO Delivery VALUES('DL051',to_date('3/28/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ002');
INSERT INTO Delivery VALUES('DL052',to_date('6/27/2022','mm/dd/yyyy'),NULL,NULL,'E014','VNZ008');
INSERT INTO Delivery VALUES('DL053',to_date('12/10/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ001');
INSERT INTO Delivery VALUES('DL054',to_date('2/24/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ010');
INSERT INTO Delivery VALUES('DL055',to_date('6/13/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ006');
INSERT INTO Delivery VALUES('DL056',to_date('7/7/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ011');
INSERT INTO Delivery VALUES('DL057',to_date('7/11/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ003');
INSERT INTO Delivery VALUES('DL058',to_date('3/12/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ009');
INSERT INTO Delivery VALUES('DL059',to_date('7/7/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ007');
INSERT INTO Delivery VALUES('DL060',to_date('9/17/2022','mm/dd/yyyy'),NULL,NULL,'E017','VNZ001');
INSERT INTO Delivery VALUES('DL061',to_date('2/12/2022','mm/dd/yyyy'),NULL,NULL,'E017','VNZ003');
INSERT INTO Delivery VALUES('DL062',to_date('1/12/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ007');
INSERT INTO Delivery VALUES('DL063',to_date('2/20/2022','mm/dd/yyyy'),NULL,NULL,'E014','VNZ004');
INSERT INTO Delivery VALUES('DL064',to_date('8/15/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ007');
INSERT INTO Delivery VALUES('DL065',to_date('8/7/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ002');
INSERT INTO Delivery VALUES('DL066',to_date('4/9/2022','mm/dd/yyyy'),NULL,NULL,'E015','VNZ004');
INSERT INTO Delivery VALUES('DL067',to_date('5/6/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ003');
INSERT INTO Delivery VALUES('DL068',to_date('5/19/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ004');
INSERT INTO Delivery VALUES('DL069',to_date('4/26/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ009');
INSERT INTO Delivery VALUES('DL070',to_date('9/26/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ007');
INSERT INTO Delivery VALUES('DL071',to_date('10/22/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ006');
INSERT INTO Delivery VALUES('DL072',to_date('2/18/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ011');
INSERT INTO Delivery VALUES('DL073',to_date('5/14/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ005');
INSERT INTO Delivery VALUES('DL074',to_date('10/27/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ008');
INSERT INTO Delivery VALUES('DL075',to_date('6/8/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ008');
INSERT INTO Delivery VALUES('DL076',to_date('11/3/2022','mm/dd/yyyy'),NULL,NULL,'E016','VNZ004');
INSERT INTO Delivery VALUES('DL077',to_date('5/7/2022','mm/dd/yyyy'),NULL,NULL,'E023','VNZ006');
INSERT INTO Delivery VALUES('DL078',to_date('6/6/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ008');
INSERT INTO Delivery VALUES('DL079',to_date('10/21/2022','mm/dd/yyyy'),NULL,NULL,'E017','VNZ008');
INSERT INTO Delivery VALUES('DL080',to_date('10/18/2022','mm/dd/yyyy'),NULL,NULL,'E015','VNZ005');
INSERT INTO Delivery VALUES('DL081',to_date('1/10/2022','mm/dd/yyyy'),NULL,NULL,'E002','VNZ003');
INSERT INTO Delivery VALUES('DL082',to_date('4/20/2022','mm/dd/yyyy'),NULL,NULL,'E021','VNZ005');
INSERT INTO Delivery VALUES('DL083',to_date('6/18/2022','mm/dd/yyyy'),NULL,NULL,'E018','VNZ010');
INSERT INTO Delivery VALUES('DL084',to_date('7/22/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ007');
INSERT INTO Delivery VALUES('DL085',to_date('4/17/2022','mm/dd/yyyy'),NULL,NULL,'E015','VNZ006');
INSERT INTO Delivery VALUES('DL086',to_date('12/26/2022','mm/dd/yyyy'),NULL,NULL,'E022','VNZ007');
INSERT INTO Delivery VALUES('DL087',to_date('7/19/2022','mm/dd/yyyy'),NULL,NULL,'E020','VNZ011');
INSERT INTO Delivery VALUES('DL088',to_date('7/4/2022','mm/dd/yyyy'),NULL,NULL,'E019','VNZ001');
INSERT INTO Delivery VALUES('DL089',to_date('4/23/2022','mm/dd/yyyy'),NULL,NULL,'E014','VNZ006');
INSERT INTO Delivery VALUES('DL090',to_date('10/20/2022','mm/dd/yyyy'),NULL,NULL,'E013','VNZ002');


INSERT INTO Shipment VALUES('SP001','N',to_date('6/1/2022','mm/dd/yyyy'),NULL,'OA001','DL003');
INSERT INTO Shipment VALUES('SP002','N',to_date('5/1/2022','mm/dd/yyyy'),NULL,'OA002','DL002');
INSERT INTO Shipment VALUES('SP003','N',to_date('8/1/2022','mm/dd/yyyy'),NULL,'OA003','DL001');
INSERT INTO Shipment VALUES('SP004','N',to_date('5/18/2022','mm/dd/yyyy'),NULL,'OA004','DL009');
INSERT INTO Shipment VALUES('SP005','N',to_date('8/1/2022','mm/dd/yyyy'),NULL,'OA005','DL010');
INSERT INTO Shipment VALUES('SP006','N',to_date('9/5/2022','mm/dd/yyyy'),NULL,'OA006','DL011');
INSERT INTO Shipment VALUES('SP007','N',to_date('7/1/2022','mm/dd/yyyy'),NULL,'OA008','DL004');
INSERT INTO Shipment VALUES('SP008','N',to_date('3/7/2022','mm/dd/yyyy'),NULL,'OA007','DL012');
INSERT INTO Shipment VALUES('SP009','N',to_date('12/5/2022','mm/dd/yyyy'),NULL,'OA010','DL005');
INSERT INTO Shipment VALUES('SP010','N',to_date('8/1/2022','mm/dd/yyyy'),NULL,'OA009','DL013');
INSERT INTO Shipment VALUES('SP011','N',to_date('6/20/2022','mm/dd/yyyy'),NULL,'OA013','DL006');
INSERT INTO Shipment VALUES('SP012','N',to_date('7/4/2022','mm/dd/yyyy'),NULL,'OA011','DL014');
INSERT INTO Shipment VALUES('SP013','N',to_date('1/4/2022','mm/dd/yyyy'),NULL,'OA012','DL015');
INSERT INTO Shipment VALUES('SP014','N',to_date('2/9/2022','mm/dd/yyyy'),NULL,'OA017','DL007');
INSERT INTO Shipment VALUES('SP015','N',to_date('2/16/2022','mm/dd/yyyy'),NULL,'OA014','DL016');
INSERT INTO Shipment VALUES('SP016','N',to_date('6/6/2022','mm/dd/yyyy'),NULL,'OA015','DL017');
INSERT INTO Shipment VALUES('SP017','N',to_date('1/13/2022','mm/dd/yyyy'),NULL,'OA016','DL018');
INSERT INTO Shipment VALUES('SP018','N',to_date('8/1/2022','mm/dd/yyyy'),NULL,'OA021','DL008');
INSERT INTO Shipment VALUES('SP019','N',to_date('3/25/2022','mm/dd/yyyy'),NULL,'OA018','DL019');
INSERT INTO Shipment VALUES('SP020','N',to_date('7/1/2022','mm/dd/yyyy'),NULL,'OA019','DL020');
INSERT INTO Shipment VALUES('SP021','N',to_date('5/1/2022','mm/dd/yyyy'),NULL,'OA020','DL021');
INSERT INTO Shipment VALUES('SP022','N',to_date('5/16/2022','mm/dd/yyyy'),NULL,'OA023','DL022');
INSERT INTO Shipment VALUES('SP023','N',to_date('4/25/2022','mm/dd/yyyy'),NULL,'OA024','DL023');
INSERT INTO Shipment VALUES('SP024','N',to_date('8/1/2022','mm/dd/yyyy'),NULL,'OA025','DL024');
INSERT INTO Shipment VALUES('SP025','Y',to_date('11/15/2022','mm/dd/yyyy'),'CA010',NULL,'DL025');
INSERT INTO Shipment VALUES('SP026','N',to_date('7/10/2022','mm/dd/yyyy'),NULL,'OA026','DL042');
INSERT INTO Shipment VALUES('SP027','N',to_date('12/8/2022','mm/dd/yyyy'),NULL,'OA027','DL022');
INSERT INTO Shipment VALUES('SP050','Y',to_date('11/15/2022','mm/dd/yyyy'),'CA009',NULL,'DL085');
INSERT INTO Shipment VALUES('SP029','N',to_date('6/12/2022','mm/dd/yyyy'),NULL,'OA028','DL074');
INSERT INTO Shipment VALUES('SP030','N',to_date('2/2/2022','mm/dd/yyyy'),NULL,'OA029','DL024');
INSERT INTO Shipment VALUES('SP031','N',to_date('8/6/2022','mm/dd/yyyy'),NULL,'OA030','DL090');
INSERT INTO Shipment VALUES('SP032','N',to_date('1/13/2022','mm/dd/yyyy'),NULL,'OA031','DL075');
INSERT INTO Shipment VALUES('SP033','N',to_date('4/6/2022','mm/dd/yyyy'),NULL,'OA032','DL019');
INSERT INTO Shipment VALUES('SP034','N',to_date('2/5/2022','mm/dd/yyyy'),NULL,'OA033','DL046');
INSERT INTO Shipment VALUES('SP081','Y',to_date('8/20/2022','mm/dd/yyyy'),'CA008',NULL,'DL023');
INSERT INTO Shipment VALUES('SP036','N',to_date('2/4/2022','mm/dd/yyyy'),NULL,'OA034','DL018');
INSERT INTO Shipment VALUES('SP037','N',to_date('12/4/2022','mm/dd/yyyy'),NULL,'OA035','DL078');
INSERT INTO Shipment VALUES('SP038','N',to_date('8/25/2022','mm/dd/yyyy'),NULL,'OA036','DL046');
INSERT INTO Shipment VALUES('SP039','N',to_date('10/13/2022','mm/dd/yyyy'),NULL,'OA037','DL033');
INSERT INTO Shipment VALUES('SP040','N',to_date('10/10/2022','mm/dd/yyyy'),NULL,'OA038','DL045');
INSERT INTO Shipment VALUES('SP035','Y',to_date('7/8/2022','mm/dd/yyyy'),'CA007',NULL,'DL013');
INSERT INTO Shipment VALUES('SP042','N',to_date('7/7/2022','mm/dd/yyyy'),NULL,'OA039','DL010');
INSERT INTO Shipment VALUES('SP043','N',to_date('10/20/2022','mm/dd/yyyy'),NULL,'OA040','DL065');
INSERT INTO Shipment VALUES('SP044','N',to_date('1/25/2022','mm/dd/yyyy'),NULL,'OA041','DL084');
INSERT INTO Shipment VALUES('SP045','N',to_date('4/14/2022','mm/dd/yyyy'),NULL,'OA042','DL088');
INSERT INTO Shipment VALUES('SP046','N',to_date('12/26/2022','mm/dd/yyyy'),NULL,'OA043','DL021');
INSERT INTO Shipment VALUES('SP047','N',to_date('4/15/2022','mm/dd/yyyy'),NULL,'OA044','DL034');
INSERT INTO Shipment VALUES('SP048','N',to_date('12/23/2022','mm/dd/yyyy'),NULL,'OA045','DL023');
INSERT INTO Shipment VALUES('SP049','N',to_date('3/2/2022','mm/dd/yyyy'),NULL,'OA046','DL018');
INSERT INTO Shipment VALUES('SP089','Y',to_date('6/10/2022','mm/dd/yyyy'),'CA006',NULL,'DL077');
INSERT INTO Shipment VALUES('SP051','Y',to_date('9/30/2022','mm/dd/yyyy'),'CA005',NULL,'DL026');
INSERT INTO Shipment VALUES('SP052','N',to_date('2/15/2022','mm/dd/yyyy'),NULL,'OA047','DL041');
INSERT INTO Shipment VALUES('SP053','N',to_date('3/27/2022','mm/dd/yyyy'),NULL,'OA048','DL055');
INSERT INTO Shipment VALUES('SP054','N',to_date('4/10/2022','mm/dd/yyyy'),NULL,'OA049','DL012');
INSERT INTO Shipment VALUES('SP055','N',to_date('11/22/2022','mm/dd/yyyy'),NULL,'OA050','DL084');
INSERT INTO Shipment VALUES('SP056','N',to_date('10/10/2022','mm/dd/yyyy'),NULL,'OA051','DL017');
INSERT INTO Shipment VALUES('SP057','Y',to_date('5/20/2022','mm/dd/yyyy'),'CA004',NULL,'DL084');
INSERT INTO Shipment VALUES('SP058','N',to_date('7/7/2022','mm/dd/yyyy'),NULL,'OA052','DL042');
INSERT INTO Shipment VALUES('SP059','N',to_date('5/5/2022','mm/dd/yyyy'),NULL,'OA053','DL039');
INSERT INTO Shipment VALUES('SP060','N',to_date('10/12/2022','mm/dd/yyyy'),NULL,'OA054','DL082');
INSERT INTO Shipment VALUES('SP061','N',to_date('11/5/2022','mm/dd/yyyy'),NULL,'OA055','DL031');
INSERT INTO Shipment VALUES('SP062','N',to_date('3/26/2022','mm/dd/yyyy'),NULL,'OA056','DL059');
INSERT INTO Shipment VALUES('SP063','N',to_date('5/17/2022','mm/dd/yyyy'),NULL,'OA057','DL040');
INSERT INTO Shipment VALUES('SP064','N',to_date('2/15/2022','mm/dd/yyyy'),NULL,'OA058','DL037');
INSERT INTO Shipment VALUES('SP065','N',to_date('4/25/2022','mm/dd/yyyy'),NULL,'OA059','DL010');
INSERT INTO Shipment VALUES('SP066','N',to_date('7/18/2022','mm/dd/yyyy'),NULL,'OA060','DL064');
INSERT INTO Shipment VALUES('SP067','N',to_date('9/22/2022','mm/dd/yyyy'),NULL,'OA061','DL082');
INSERT INTO Shipment VALUES('SP068','N',to_date('3/3/2022','mm/dd/yyyy'),NULL,'OA062','DL049');
INSERT INTO Shipment VALUES('SP069','N',to_date('7/1/2022','mm/dd/yyyy'),NULL,'OA063','DL054');
INSERT INTO Shipment VALUES('SP070','N',to_date('8/16/2022','mm/dd/yyyy'),NULL,'OA064','DL055');
INSERT INTO Shipment VALUES('SP071','N',to_date('5/12/2022','mm/dd/yyyy'),NULL,'OA065','DL034');
INSERT INTO Shipment VALUES('SP072','N',to_date('7/10/2022','mm/dd/yyyy'),NULL,'OA066','DL029');
INSERT INTO Shipment VALUES('SP073','N',to_date('3/22/2022','mm/dd/yyyy'),NULL,'OA067','DL014');
INSERT INTO Shipment VALUES('SP074','N',to_date('1/26/2022','mm/dd/yyyy'),NULL,'OA068','DL051');
INSERT INTO Shipment VALUES('SP075','N',to_date('9/4/2022','mm/dd/yyyy'),NULL,'OA069','DL021');
INSERT INTO Shipment VALUES('SP041','Y',to_date('2/20/2022','mm/dd/yyyy'),'CA003',NULL,'DL031');
INSERT INTO Shipment VALUES('SP077','N',to_date('2/16/2022','mm/dd/yyyy'),NULL,'OA070','DL036');
INSERT INTO Shipment VALUES('SP078','N',to_date('12/18/2022','mm/dd/yyyy'),NULL,'OA071','DL035');
INSERT INTO Shipment VALUES('SP079','N',to_date('10/27/2022','mm/dd/yyyy'),NULL,'OA072','DL050');
INSERT INTO Shipment VALUES('SP080','N',to_date('10/18/2022','mm/dd/yyyy'),NULL,'OA073','DL074');
INSERT INTO Shipment VALUES('SP028','Y',to_date('4/25/2022','mm/dd/yyyy'),'CA002',NULL,'DL076');
INSERT INTO Shipment VALUES('SP082','N',to_date('7/2/2022','mm/dd/yyyy'),NULL,'OA074','DL012');
INSERT INTO Shipment VALUES('SP083','N',to_date('8/10/2022','mm/dd/yyyy'),NULL,'OA075','DL017');
INSERT INTO Shipment VALUES('SP084','N',to_date('8/22/2022','mm/dd/yyyy'),NULL,'OA076','DL017');
INSERT INTO Shipment VALUES('SP085','N',to_date('1/9/2022','mm/dd/yyyy'),NULL,'OA077','DL084');
INSERT INTO Shipment VALUES('SP086','N',to_date('11/9/2022','mm/dd/yyyy'),NULL,'OA078','DL051');
INSERT INTO Shipment VALUES('SP087','N',to_date('5/9/2022','mm/dd/yyyy'),NULL,'OA079','DL013');
INSERT INTO Shipment VALUES('SP088','N',to_date('8/13/2022','mm/dd/yyyy'),NULL,'OA080','DL087');
INSERT INTO Shipment VALUES('SP076','Y',to_date('3/1/2022','mm/dd/yyyy'),'CA001',NULL,'DL075');
INSERT INTO Shipment VALUES('SP090','N',to_date('3/21/2022','mm/dd/yyyy'),NULL,'OA081','DL010');
INSERT INTO Shipment VALUES('SP091','N',to_date('2/10/2022','mm/dd/yyyy'),NULL,'OA082','DL056');
INSERT INTO Shipment VALUES('SP092','N',to_date('11/11/2022','mm/dd/yyyy'),NULL,'OA083','DL043');
INSERT INTO Shipment VALUES('SP093','N',to_date('2/17/2022','mm/dd/yyyy'),NULL,'OA084','DL036');
INSERT INTO Shipment VALUES('SP094','N',to_date('5/10/2022','mm/dd/yyyy'),NULL,'OA085','DL044');
INSERT INTO Shipment VALUES('SP095','N',to_date('4/6/2022','mm/dd/yyyy'),NULL,'OA086','DL087');
INSERT INTO Shipment VALUES('SP096','N',to_date('5/16/2022','mm/dd/yyyy'),NULL,'OA087','DL058');
INSERT INTO Shipment VALUES('SP097','N',to_date('2/17/2022','mm/dd/yyyy'),NULL,'OA088','DL074');
INSERT INTO Shipment VALUES('SP098','N',to_date('9/1/2022','mm/dd/yyyy'),NULL,'OA089','DL043');
INSERT INTO Shipment VALUES('SP099','N',to_date('2/27/2022','mm/dd/yyyy'),NULL,'OA090','DL083');


INSERT INTO ShipmentLine VALUES('SL001',to_date('6/1/2022','mm/dd/yyyy'),3,'IV-0003', 'SP001');
INSERT INTO ShipmentLine VALUES('SL002',to_date('6/1/2022','mm/dd/yyyy'),4,'IV-0004', 'SP001');
INSERT INTO ShipmentLine VALUES('SL003',to_date('5/1/2022','mm/dd/yyyy'),3,'IV-0003', 'SP002');
INSERT INTO ShipmentLine VALUES('SL004',to_date('5/1/2022','mm/dd/yyyy'),7,'IV-0004', 'SP002');
INSERT INTO ShipmentLine VALUES('SL005',to_date('8/1/2022','mm/dd/yyyy'),3,'IV-0004', 'SP003');
INSERT INTO ShipmentLine VALUES('SL006',to_date('5/18/2022','mm/dd/yyyy'),14,'IV-0003', 'SP004');
INSERT INTO ShipmentLine VALUES('SL007',to_date('5/18/2022','mm/dd/yyyy'),1,'IV-0004', 'SP004');
INSERT INTO ShipmentLine VALUES('SL008',to_date('8/1/2022','mm/dd/yyyy'),5,'IV-0003', 'SP005');
INSERT INTO ShipmentLine VALUES('SL009',to_date('8/1/2022','mm/dd/yyyy'),5,'IV-0004', 'SP005');
INSERT INTO ShipmentLine VALUES('SL010',to_date('8/1/2022','mm/dd/yyyy'),12,'IV-0002', 'SP005');
INSERT INTO ShipmentLine VALUES('SL011',to_date('9/5/2022','mm/dd/yyyy'),2,'IV-0003', 'SP006');
INSERT INTO ShipmentLine VALUES('SL012',to_date('9/5/2022','mm/dd/yyyy'),12,'IV-0004', 'SP006');
INSERT INTO ShipmentLine VALUES('SL013',to_date('7/1/2022','mm/dd/yyyy'),5,'IV-0004', 'SP007');
INSERT INTO ShipmentLine VALUES('SL014',to_date('3/7/2022','mm/dd/yyyy'),12,'IV-0002', 'SP008');
INSERT INTO ShipmentLine VALUES('SL015',to_date('3/7/2022','mm/dd/yyyy'),4,'IV-0003', 'SP008');
INSERT INTO ShipmentLine VALUES('SL016',to_date('3/7/2022','mm/dd/yyyy'),14,'IV-0004', 'SP008');
INSERT INTO ShipmentLine VALUES('SL017',to_date('12/5/2022','mm/dd/yyyy'),2,'IV-0004', 'SP009');
INSERT INTO ShipmentLine VALUES('SL018',to_date('8/1/2022','mm/dd/yyyy'),12,'IV-0003', 'SP010');
INSERT INTO ShipmentLine VALUES('SL019',to_date('6/20/2022','mm/dd/yyyy'),8,'IV-0004', 'SP011');
INSERT INTO ShipmentLine VALUES('SL020',to_date('7/4/2022','mm/dd/yyyy'),3,'IV-0004', 'SP012');
INSERT INTO ShipmentLine VALUES('SL021',to_date('1/4/2022','mm/dd/yyyy'),4,'IV-0003', 'SP013');
INSERT INTO ShipmentLine VALUES('SL022',to_date('1/4/2022','mm/dd/yyyy'),8,'IV-0004', 'SP013');
INSERT INTO ShipmentLine VALUES('SL023',to_date('2/9/2022','mm/dd/yyyy'),11,'IV-0004', 'SP014');
INSERT INTO ShipmentLine VALUES('SL024',to_date('2/16/2022','mm/dd/yyyy'),9,'IV-0004', 'SP015');
INSERT INTO ShipmentLine VALUES('SL025',to_date('6/6/2022','mm/dd/yyyy'),5,'IV-0004', 'SP016');
INSERT INTO ShipmentLine VALUES('SL026',to_date('6/6/2022','mm/dd/yyyy'),8,'IV-0003', 'SP016');
INSERT INTO ShipmentLine VALUES('SL027',to_date('6/6/2022','mm/dd/yyyy'),2,'IV-0002', 'SP016');
INSERT INTO ShipmentLine VALUES('SL028',to_date('1/13/2022','mm/dd/yyyy'),7,'IV-0004', 'SP017');
INSERT INTO ShipmentLine VALUES('SL029',to_date('8/1/2022','mm/dd/yyyy'),42,'IV-0004', 'SP018');
INSERT INTO ShipmentLine VALUES('SL030',to_date('8/1/2022','mm/dd/yyyy'),10,'IV-0003', 'SP018');
INSERT INTO ShipmentLine VALUES('SL031',to_date('3/25/2022','mm/dd/yyyy'),13,'IV-0004', 'SP019');
INSERT INTO ShipmentLine VALUES('SL032',to_date('3/25/2022','mm/dd/yyyy'),19,'IV-0003', 'SP019');
INSERT INTO ShipmentLine VALUES('SL033',to_date('7/1/2022','mm/dd/yyyy'),6,'IV-0004', 'SP020');
INSERT INTO ShipmentLine VALUES('SL034',to_date('5/1/2022','mm/dd/yyyy'),18,'IV-0004', 'SP021');
INSERT INTO ShipmentLine VALUES('SL035',to_date('5/1/2022','mm/dd/yyyy'),2,'IV-0003', 'SP021');
INSERT INTO ShipmentLine VALUES('SL036',to_date('5/16/2022','mm/dd/yyyy'),17,'IV-0004', 'SP022');
INSERT INTO ShipmentLine VALUES('SL037',to_date('5/16/2022','mm/dd/yyyy'),11,'IV-0003', 'SP022');
INSERT INTO ShipmentLine VALUES('SL038',to_date('4/25/2022','mm/dd/yyyy'),7,'IV-0004', 'SP023');
INSERT INTO ShipmentLine VALUES('SL039',to_date('4/25/2022','mm/dd/yyyy'),17,'IV-0003', 'SP023');
INSERT INTO ShipmentLine VALUES('SL040',to_date('8/1/2022','mm/dd/yyyy'),12,'IV-0004', 'SP024');
INSERT INTO ShipmentLine VALUES('SL041',to_date('8/1/2022','mm/dd/yyyy'),6,'IV-0003', 'SP024');
INSERT INTO ShipmentLine VALUES('SL042',to_date('8/1/2022','mm/dd/yyyy'),10,'IV-0002', 'SP024');
INSERT INTO ShipmentLine VALUES('SL043',to_date('11/15/2022','mm/dd/yyyy'),3,'IV-0004', 'SP025');
INSERT INTO ShipmentLine VALUES('SL044',to_date('7/10/2022','mm/dd/yyyy'),17,'IV-0004', 'SP026');
INSERT INTO ShipmentLine VALUES('SL045',to_date('7/10/2022','mm/dd/yyyy'),15,'IV-0003', 'SP026');
INSERT INTO ShipmentLine VALUES('SL046',to_date('12/8/2022','mm/dd/yyyy'),8,'IV-0004', 'SP027');
INSERT INTO ShipmentLine VALUES('SL047',to_date('11/15/2022','mm/dd/yyyy'),10,'IV-0004', 'SP028');
INSERT INTO ShipmentLine VALUES('SL048',to_date('11/15/2022','mm/dd/yyyy'),19,'IV-0003', 'SP028');
INSERT INTO ShipmentLine VALUES('SL049',to_date('11/15/2022','mm/dd/yyyy'),12,'IV-0002', 'SP028');
INSERT INTO ShipmentLine VALUES('SL050',to_date('6/12/2022','mm/dd/yyyy'),14,'IV-0004', 'SP029');
INSERT INTO ShipmentLine VALUES('SL051',to_date('2/2/2022','mm/dd/yyyy'),10,'IV-0004', 'SP030');
INSERT INTO ShipmentLine VALUES('SL052',to_date('2/2/2022','mm/dd/yyyy'),20,'IV-0003', 'SP030');
INSERT INTO ShipmentLine VALUES('SL053',to_date('8/6/2022','mm/dd/yyyy'),10,'IV-0004', 'SP031');
INSERT INTO ShipmentLine VALUES('SL054',to_date('1/13/2022','mm/dd/yyyy'),18,'IV-0004', 'SP032');
INSERT INTO ShipmentLine VALUES('SL055',to_date('4/6/2022','mm/dd/yyyy'),3,'IV-0004', 'SP033');
INSERT INTO ShipmentLine VALUES('SL056',to_date('4/6/2022','mm/dd/yyyy'),4,'IV-0003', 'SP033');
INSERT INTO ShipmentLine VALUES('SL057',to_date('4/6/2022','mm/dd/yyyy'),3,'IV-0002', 'SP033');
INSERT INTO ShipmentLine VALUES('SL058',to_date('2/5/2022','mm/dd/yyyy'),7,'IV-0004', 'SP034');
INSERT INTO ShipmentLine VALUES('SL059',to_date('8/20/2022','mm/dd/yyyy'),15,'IV-0004', 'SP035');
INSERT INTO ShipmentLine VALUES('SL060',to_date('2/4/2022','mm/dd/yyyy'),19,'IV-0004', 'SP036');
INSERT INTO ShipmentLine VALUES('SL061',to_date('2/4/2022','mm/dd/yyyy'),7,'IV-0003', 'SP036');
INSERT INTO ShipmentLine VALUES('SL062',to_date('12/4/2022','mm/dd/yyyy'),16,'IV-0004', 'SP037');
INSERT INTO ShipmentLine VALUES('SL063',to_date('8/25/2022','mm/dd/yyyy'),16,'IV-0004', 'SP038');
INSERT INTO ShipmentLine VALUES('SL064',to_date('10/13/2022','mm/dd/yyyy'),8,'IV-0004', 'SP039');
INSERT INTO ShipmentLine VALUES('SL065',to_date('10/10/2022','mm/dd/yyyy'),12,'IV-0004', 'SP040');
INSERT INTO ShipmentLine VALUES('SL066',to_date('10/10/2022','mm/dd/yyyy'),9,'IV-0003', 'SP040');
INSERT INTO ShipmentLine VALUES('SL067',to_date('10/10/2022','mm/dd/yyyy'),4,'IV-0002', 'SP040');
INSERT INTO ShipmentLine VALUES('SL068',to_date('7/8/2022','mm/dd/yyyy'),14,'IV-0004', 'SP041');
INSERT INTO ShipmentLine VALUES('SL069',to_date('7/7/2022','mm/dd/yyyy'),14,'IV-0004', 'SP042');
INSERT INTO ShipmentLine VALUES('SL070',to_date('10/20/2022','mm/dd/yyyy'),4,'IV-0004', 'SP043');
INSERT INTO ShipmentLine VALUES('SL071',to_date('10/20/2022','mm/dd/yyyy'),17,'IV-0003', 'SP043');
INSERT INTO ShipmentLine VALUES('SL072',to_date('10/20/2022','mm/dd/yyyy'),4,'IV-0002', 'SP043');
INSERT INTO ShipmentLine VALUES('SL073',to_date('1/25/2022','mm/dd/yyyy'),13,'IV-0004', 'SP044');
INSERT INTO ShipmentLine VALUES('SL074',to_date('4/14/2022','mm/dd/yyyy'),20,'IV-0004', 'SP045');
INSERT INTO ShipmentLine VALUES('SL075',to_date('12/26/2022','mm/dd/yyyy'),14,'IV-0004', 'SP046');
INSERT INTO ShipmentLine VALUES('SL076',to_date('12/26/2022','mm/dd/yyyy'),10,'IV-0003', 'SP046');
INSERT INTO ShipmentLine VALUES('SL077',to_date('4/15/2022','mm/dd/yyyy'),7,'IV-0004', 'SP047');
INSERT INTO ShipmentLine VALUES('SL078',to_date('12/23/2022','mm/dd/yyyy'),6,'IV-0004', 'SP048');
INSERT INTO ShipmentLine VALUES('SL079',to_date('3/2/2022','mm/dd/yyyy'),11,'IV-0004', 'SP049');
INSERT INTO ShipmentLine VALUES('SL080',to_date('3/2/2022','mm/dd/yyyy'),10,'IV-0003', 'SP049');
INSERT INTO ShipmentLine VALUES('SL081',to_date('6/10/2022','mm/dd/yyyy'),13,'IV-0004', 'SP050');
INSERT INTO ShipmentLine VALUES('SL082',to_date('9/30/2022','mm/dd/yyyy'),11,'IV-0004', 'SP051');
INSERT INTO ShipmentLine VALUES('SL083',to_date('9/30/2022','mm/dd/yyyy'),4,'IV-0003', 'SP051');
INSERT INTO ShipmentLine VALUES('SL084',to_date('2/15/2022','mm/dd/yyyy'),14,'IV-0004', 'SP052');
INSERT INTO ShipmentLine VALUES('SL085',to_date('3/27/2022','mm/dd/yyyy'),2,'IV-0004', 'SP053');
INSERT INTO ShipmentLine VALUES('SL086',to_date('4/10/2022','mm/dd/yyyy'),17,'IV-0004', 'SP054');
INSERT INTO ShipmentLine VALUES('SL087',to_date('4/10/2022','mm/dd/yyyy'),19,'IV-0003', 'SP054');
INSERT INTO ShipmentLine VALUES('SL088',to_date('4/10/2022','mm/dd/yyyy'),3,'IV-0002', 'SP054');
INSERT INTO ShipmentLine VALUES('SL089',to_date('11/22/2022','mm/dd/yyyy'),18,'IV-0004', 'SP055');
INSERT INTO ShipmentLine VALUES('SL090',to_date('10/10/2022','mm/dd/yyyy'),8,'IV-0004', 'SP056');
INSERT INTO ShipmentLine VALUES('SL091',to_date('5/20/2022','mm/dd/yyyy'),3,'IV-0004', 'SP057');
INSERT INTO ShipmentLine VALUES('SL092',to_date('7/7/2022','mm/dd/yyyy'),10,'IV-0004', 'SP058');
INSERT INTO ShipmentLine VALUES('SL093',to_date('7/7/2022','mm/dd/yyyy'),3,'IV-0003', 'SP058');
INSERT INTO ShipmentLine VALUES('SL094',to_date('5/5/2022','mm/dd/yyyy'),4,'IV-0004', 'SP059');
INSERT INTO ShipmentLine VALUES('SL095',to_date('10/12/2022','mm/dd/yyyy'),12,'IV-0004', 'SP060');
INSERT INTO ShipmentLine VALUES('SL096',to_date('10/12/2022','mm/dd/yyyy'),16,'IV-0003', 'SP060');
INSERT INTO ShipmentLine VALUES('SL097',to_date('11/5/2022','mm/dd/yyyy'),8,'IV-0004', 'SP061');
INSERT INTO ShipmentLine VALUES('SL098',to_date('3/26/2022','mm/dd/yyyy'),5,'IV-0004', 'SP062');
INSERT INTO ShipmentLine VALUES('SL099',to_date('5/17/2022','mm/dd/yyyy'),11,'IV-0004', 'SP063');
INSERT INTO ShipmentLine VALUES('SL100',to_date('2/15/2022','mm/dd/yyyy'),10,'IV-0004', 'SP064');
INSERT INTO ShipmentLine VALUES('SL101',to_date('2/15/2022','mm/dd/yyyy'),10,'IV-0003', 'SP064');
INSERT INTO ShipmentLine VALUES('SL102',to_date('4/25/2022','mm/dd/yyyy'),12,'IV-0004', 'SP065');
INSERT INTO ShipmentLine VALUES('SL103',to_date('7/18/2022','mm/dd/yyyy'),19,'IV-0004', 'SP066');
INSERT INTO ShipmentLine VALUES('SL104',to_date('9/22/2022','mm/dd/yyyy'),12,'IV-0004', 'SP067');
INSERT INTO ShipmentLine VALUES('SL105',to_date('9/22/2022','mm/dd/yyyy'),1,'IV-0003', 'SP067');
INSERT INTO ShipmentLine VALUES('SL106',to_date('3/3/2022','mm/dd/yyyy'),12,'IV-0004', 'SP068');
INSERT INTO ShipmentLine VALUES('SL107',to_date('7/1/2022','mm/dd/yyyy'),3,'IV-0004', 'SP069');
INSERT INTO ShipmentLine VALUES('SL108',to_date('8/16/2022','mm/dd/yyyy'),17,'IV-0004', 'SP070');
INSERT INTO ShipmentLine VALUES('SL109',to_date('8/16/2022','mm/dd/yyyy'),9,'IV-0003', 'SP070');
INSERT INTO ShipmentLine VALUES('SL110',to_date('5/12/2022','mm/dd/yyyy'),14,'IV-0004', 'SP071');
INSERT INTO ShipmentLine VALUES('SL111',to_date('7/10/2022','mm/dd/yyyy'),8,'IV-0004', 'SP072');
INSERT INTO ShipmentLine VALUES('SL112',to_date('3/22/2022','mm/dd/yyyy'),18,'IV-0004', 'SP073');
INSERT INTO ShipmentLine VALUES('SL113',to_date('3/22/2022','mm/dd/yyyy'),14,'IV-0003', 'SP073');
INSERT INTO ShipmentLine VALUES('SL114',to_date('1/26/2022','mm/dd/yyyy'),1,'IV-0004', 'SP074');
INSERT INTO ShipmentLine VALUES('SL115',to_date('1/26/2022','mm/dd/yyyy'),6,'IV-0003', 'SP074');
INSERT INTO ShipmentLine VALUES('SL116',to_date('9/4/2022','mm/dd/yyyy'),3,'IV-0004', 'SP075');
INSERT INTO ShipmentLine VALUES('SL117',to_date('9/4/2022','mm/dd/yyyy'),3,'IV-0003', 'SP075');
INSERT INTO ShipmentLine VALUES('SL118',to_date('2/20/2022','mm/dd/yyyy'),16,'IV-0004', 'SP076');
INSERT INTO ShipmentLine VALUES('SL119',to_date('2/20/2022','mm/dd/yyyy'),3,'IV-0003', 'SP076');
INSERT INTO ShipmentLine VALUES('SL120',to_date('2/20/2022','mm/dd/yyyy'),14,'IV-0002', 'SP076');
INSERT INTO ShipmentLine VALUES('SL121',to_date('2/16/2022','mm/dd/yyyy'),18,'IV-0004', 'SP077');
INSERT INTO ShipmentLine VALUES('SL122',to_date('12/18/2022','mm/dd/yyyy'),12,'IV-0004', 'SP078');
INSERT INTO ShipmentLine VALUES('SL123',to_date('12/18/2022','mm/dd/yyyy'),3,'IV-0003', 'SP078');
INSERT INTO ShipmentLine VALUES('SL124',to_date('10/27/2022','mm/dd/yyyy'),16,'IV-0004', 'SP079');
INSERT INTO ShipmentLine VALUES('SL125',to_date('10/18/2022','mm/dd/yyyy'),18,'IV-0004', 'SP080');
INSERT INTO ShipmentLine VALUES('SL126',to_date('4/25/2022','mm/dd/yyyy'),6,'IV-0004', 'SP081');
INSERT INTO ShipmentLine VALUES('SL127',to_date('7/2/2022','mm/dd/yyyy'),19,'IV-0004', 'SP082');
INSERT INTO ShipmentLine VALUES('SL128',to_date('7/2/2022','mm/dd/yyyy'),16,'IV-0003', 'SP082');
INSERT INTO ShipmentLine VALUES('SL129',to_date('7/2/2022','mm/dd/yyyy'),9,'IV-0002', 'SP082');
INSERT INTO ShipmentLine VALUES('SL130',to_date('8/10/2022','mm/dd/yyyy'),14,'IV-0004', 'SP083');
INSERT INTO ShipmentLine VALUES('SL131',to_date('8/22/2022','mm/dd/yyyy'),10,'IV-0004', 'SP084');
INSERT INTO ShipmentLine VALUES('SL132',to_date('8/22/2022','mm/dd/yyyy'),15,'IV-0003', 'SP084');
INSERT INTO ShipmentLine VALUES('SL133',to_date('1/9/2022','mm/dd/yyyy'),4,'IV-0004', 'SP085');
INSERT INTO ShipmentLine VALUES('SL134',to_date('11/9/2022','mm/dd/yyyy'),19,'IV-0004', 'SP086');
INSERT INTO ShipmentLine VALUES('SL135',to_date('5/9/2022','mm/dd/yyyy'),5,'IV-0004', 'SP087');
INSERT INTO ShipmentLine VALUES('SL136',to_date('5/9/2022','mm/dd/yyyy'),11,'IV-0003', 'SP087');
INSERT INTO ShipmentLine VALUES('SL137',to_date('5/9/2022','mm/dd/yyyy'),12,'IV-0002', 'SP087');
INSERT INTO ShipmentLine VALUES('SL138',to_date('8/13/2022','mm/dd/yyyy'),14,'IV-0004', 'SP088');
INSERT INTO ShipmentLine VALUES('SL139',to_date('3/1/2022','mm/dd/yyyy'),1,'IV-0004', 'SP089');
INSERT INTO ShipmentLine VALUES('SL140',to_date('3/1/2022','mm/dd/yyyy'),17,'IV-0003', 'SP089');
INSERT INTO ShipmentLine VALUES('SL141',to_date('3/21/2022','mm/dd/yyyy'),7,'IV-0004', 'SP090');
INSERT INTO ShipmentLine VALUES('SL142',to_date('2/10/2022','mm/dd/yyyy'),7,'IV-0004', 'SP091');
INSERT INTO ShipmentLine VALUES('SL143',to_date('11/11/2022','mm/dd/yyyy'),2,'IV-0004', 'SP092');
INSERT INTO ShipmentLine VALUES('SL144',to_date('11/11/2022','mm/dd/yyyy'),19,'IV-0003', 'SP092');
INSERT INTO ShipmentLine VALUES('SL145',to_date('11/11/2022','mm/dd/yyyy'),16,'IV-0002', 'SP092');
INSERT INTO ShipmentLine VALUES('SL146',to_date('2/17/2022','mm/dd/yyyy'),13,'IV-0004', 'SP093');
INSERT INTO ShipmentLine VALUES('SL147',to_date('5/10/2022','mm/dd/yyyy'),16,'IV-0004', 'SP094');
INSERT INTO ShipmentLine VALUES('SL148',to_date('5/10/2022','mm/dd/yyyy'),19,'IV-0003', 'SP094');
INSERT INTO ShipmentLine VALUES('SL149',to_date('4/6/2022','mm/dd/yyyy'),11,'IV-0004', 'SP095');
INSERT INTO ShipmentLine VALUES('SL150',to_date('5/16/2022','mm/dd/yyyy'),18,'IV-0004', 'SP096');
INSERT INTO ShipmentLine VALUES('SL151',to_date('5/16/2022','mm/dd/yyyy'),16,'IV-0003', 'SP096');
INSERT INTO ShipmentLine VALUES('SL152',to_date('2/17/2022','mm/dd/yyyy'),18,'IV-0004', 'SP097');
INSERT INTO ShipmentLine VALUES('SL153',to_date('2/17/2022','mm/dd/yyyy'),13,'IV-0003', 'SP097');
INSERT INTO ShipmentLine VALUES('SL154',to_date('2/17/2022','mm/dd/yyyy'),3,'IV-0002', 'SP097');
INSERT INTO ShipmentLine VALUES('SL155',to_date('9/1/2022','mm/dd/yyyy'),6,'IV-0004', 'SP098');
INSERT INTO ShipmentLine VALUES('SL156',to_date('2/27/2022','mm/dd/yyyy'),2,'IV-0004', 'SP099');

INSERT INTO ORDERS VALUES('OA001', to_date('6/1/2022', 'mm/dd/yyyy'),'Y',to_date('6/7/2022', 'mm/dd/yyyy'),'E014','C001');
INSERT INTO ORDERS VALUES('OA002', to_date('5/1/2022', 'mm/dd/yyyy'),'N',to_date('5/1/2022', 'mm/dd/yyyy'),'E016','C001');
INSERT INTO ORDERS VALUES('OA003', to_date('8/1/2022', 'mm/dd/yyyy'),'Y',to_date('8/7/2022', 'mm/dd/yyyy'),'E002','C004');
INSERT INTO ORDERS VALUES('OA004', to_date('5/18/2022', 'mm/dd/yyyy'),'Y',to_date('5/24/2022', 'mm/dd/yyyy'),'E002','C007');
INSERT INTO ORDERS VALUES('OA005', to_date('8/1/2022', 'mm/dd/yyyy'),'Y',to_date('8/7/2022', 'mm/dd/yyyy'),'E008','C010');
INSERT INTO ORDERS VALUES('OA006', to_date('9/5/2022', 'mm/dd/yyyy'),'Y',to_date('9/11/2022', 'mm/dd/yyyy'),'E011','C002');
INSERT INTO ORDERS VALUES('OA007', to_date('3/7/2022', 'mm/dd/yyyy'),'Y',to_date('3/7/2022', 'mm/dd/yyyy'),'E023','C006');
INSERT INTO ORDERS VALUES('OA008', to_date('7/1/2022', 'mm/dd/yyyy'),'N',to_date('7/1/2022', 'mm/dd/yyyy'),'E014','C002');
INSERT INTO ORDERS VALUES('OA009', to_date('8/1/2022', 'mm/dd/yyyy'),'Y',to_date('8/7/2022', 'mm/dd/yyyy'),'E023','C005');
INSERT INTO ORDERS VALUES('OA010', to_date('12/5/2022', 'mm/dd/yyyy'),'N',to_date('12/5/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA011', to_date('7/4/2022', 'mm/dd/yyyy'),'Y',to_date('7/10/2022', 'mm/dd/yyyy'),'E017','C006');
INSERT INTO ORDERS VALUES('OA012', to_date('1/4/2022', 'mm/dd/yyyy'),'Y',to_date('1/10/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA013', to_date('6/20/2022', 'mm/dd/yyyy'),'N',to_date('6/20/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA014', to_date('2/16/2022', 'mm/dd/yyyy'),'Y',to_date('2/22/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA015', to_date('6/6/2022', 'mm/dd/yyyy'),'Y',to_date('6/12/2022', 'mm/dd/yyyy'),'E016','C008');
INSERT INTO ORDERS VALUES('OA016', to_date('1/13/2022', 'mm/dd/yyyy'),'Y',to_date('1/19/2022', 'mm/dd/yyyy'),'E022','C003');
INSERT INTO ORDERS VALUES('OA017', to_date('2/9/2022', 'mm/dd/yyyy'),'N',to_date('2/9/2022', 'mm/dd/yyyy'),'E013','C010');
INSERT INTO ORDERS VALUES('OA018', to_date('3/25/2022', 'mm/dd/yyyy'),'Y',to_date('3/31/2022', 'mm/dd/yyyy'),'E021','C007');
INSERT INTO ORDERS VALUES('OA019', to_date('7/1/2022', 'mm/dd/yyyy'),'Y',to_date('7/7/2022', 'mm/dd/yyyy'),'E011','C005');
INSERT INTO ORDERS VALUES('OA020', to_date('5/1/2022', 'mm/dd/yyyy'),'Y',to_date('5/7/2022', 'mm/dd/yyyy'),'E018','C006');
INSERT INTO ORDERS VALUES('OA021', to_date('8/1/2022', 'mm/dd/yyyy'),'N',to_date('8/1/2022', 'mm/dd/yyyy'),'E013','C002');
INSERT INTO ORDERS VALUES('OA022', to_date('3/25/2022', 'mm/dd/yyyy'),'N',to_date('3/25/2022', 'mm/dd/yyyy'),'E008','C007');
INSERT INTO ORDERS VALUES('OA023', to_date('5/16/2022', 'mm/dd/yyyy'),'Y',to_date('5/22/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA024', to_date('4/25/2022', 'mm/dd/yyyy'),'Y',to_date('5/1/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA025', to_date('8/1/2022', 'mm/dd/yyyy'),'Y',to_date('8/7/2022', 'mm/dd/yyyy'),'E015','C003');
INSERT INTO ORDERS VALUES('OA026', to_date('7/10/2022', 'mm/dd/yyyy'),'Y',to_date('7/17/2022', 'mm/dd/yyyy'),'E014','C001');
INSERT INTO ORDERS VALUES('OA027', to_date('12/8/2022', 'mm/dd/yyyy'),'N',to_date('12/15/2022', 'mm/dd/yyyy'),'E016','C001');
INSERT INTO ORDERS VALUES('OA028', to_date('6/12/2022', 'mm/dd/yyyy'),'Y',to_date('6/19/2022', 'mm/dd/yyyy'),'E002','C004');
INSERT INTO ORDERS VALUES('OA029', to_date('2/2/2022', 'mm/dd/yyyy'),'Y',to_date('2/9/2022', 'mm/dd/yyyy'),'E002','C007');
INSERT INTO ORDERS VALUES('OA030', to_date('8/6/2022', 'mm/dd/yyyy'),'Y',to_date('8/13/2022', 'mm/dd/yyyy'),'E008','C010');
INSERT INTO ORDERS VALUES('OA031', to_date('1/13/2022', 'mm/dd/yyyy'),'Y',to_date('1/20/2022', 'mm/dd/yyyy'),'E011','C002');
INSERT INTO ORDERS VALUES('OA032', to_date('4/6/2022', 'mm/dd/yyyy'),'Y',to_date('4/13/2022', 'mm/dd/yyyy'),'E023','C006');
INSERT INTO ORDERS VALUES('OA033', to_date('2/5/2022', 'mm/dd/yyyy'),'N',to_date('2/12/2022', 'mm/dd/yyyy'),'E014','C002');
INSERT INTO ORDERS VALUES('OA034', to_date('2/4/2022', 'mm/dd/yyyy'),'Y',to_date('2/11/2022', 'mm/dd/yyyy'),'E023','C005');
INSERT INTO ORDERS VALUES('OA035', to_date('12/4/2022', 'mm/dd/yyyy'),'N',to_date('12/11/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA036', to_date('8/25/2022', 'mm/dd/yyyy'),'Y',to_date('9/1/2022', 'mm/dd/yyyy'),'E017','C006');
INSERT INTO ORDERS VALUES('OA037', to_date('10/13/2022', 'mm/dd/yyyy'),'Y',to_date('10/20/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA038', to_date('10/10/2022', 'mm/dd/yyyy'),'N',to_date('10/17/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA039', to_date('7/7/2022', 'mm/dd/yyyy'),'Y',to_date('7/14/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA040', to_date('10/20/2022', 'mm/dd/yyyy'),'Y',to_date('10/27/2022', 'mm/dd/yyyy'),'E016','C008');
INSERT INTO ORDERS VALUES('OA041', to_date('1/25/2022', 'mm/dd/yyyy'),'Y',to_date('2/1/2022', 'mm/dd/yyyy'),'E022','C003');
INSERT INTO ORDERS VALUES('OA042', to_date('4/14/2022', 'mm/dd/yyyy'),'N',to_date('4/21/2022', 'mm/dd/yyyy'),'E013','C010');
INSERT INTO ORDERS VALUES('OA043', to_date('12/26/2022', 'mm/dd/yyyy'),'Y',to_date('1/2/2023', 'mm/dd/yyyy'),'E021','C007');
INSERT INTO ORDERS VALUES('OA044', to_date('4/15/2022', 'mm/dd/yyyy'),'Y',to_date('4/22/2022', 'mm/dd/yyyy'),'E011','C005');
INSERT INTO ORDERS VALUES('OA045', to_date('12/23/2022', 'mm/dd/yyyy'),'Y',to_date('12/30/2022', 'mm/dd/yyyy'),'E018','C006');
INSERT INTO ORDERS VALUES('OA046', to_date('3/2/2022', 'mm/dd/yyyy'),'N',to_date('3/9/2022', 'mm/dd/yyyy'),'E013','C002');
INSERT INTO ORDERS VALUES('OA047', to_date('2/15/2022', 'mm/dd/yyyy'),'N',to_date('2/22/2022', 'mm/dd/yyyy'),'E008','C007');
INSERT INTO ORDERS VALUES('OA048', to_date('3/27/2022', 'mm/dd/yyyy'),'Y',to_date('4/3/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA049', to_date('4/10/2022', 'mm/dd/yyyy'),'Y',to_date('4/17/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA050', to_date('11/22/2022', 'mm/dd/yyyy'),'Y',to_date('11/29/2022', 'mm/dd/yyyy'),'E015','C003');
INSERT INTO ORDERS VALUES('OA051', to_date('10/10/2022', 'mm/dd/yyyy'),'Y',to_date('10/17/2022', 'mm/dd/yyyy'),'E014','C001');
INSERT INTO ORDERS VALUES('OA052', to_date('7/7/2022', 'mm/dd/yyyy'),'N',to_date('7/14/2022', 'mm/dd/yyyy'),'E016','C001');
INSERT INTO ORDERS VALUES('OA053', to_date('5/5/2022', 'mm/dd/yyyy'),'Y',to_date('5/12/2022', 'mm/dd/yyyy'),'E002','C004');
INSERT INTO ORDERS VALUES('OA054', to_date('10/12/2022', 'mm/dd/yyyy'),'Y',to_date('10/19/2022', 'mm/dd/yyyy'),'E002','C007');
INSERT INTO ORDERS VALUES('OA055', to_date('11/5/2022', 'mm/dd/yyyy'),'Y',to_date('11/12/2022', 'mm/dd/yyyy'),'E008','C010');
INSERT INTO ORDERS VALUES('OA056', to_date('3/26/2022', 'mm/dd/yyyy'),'Y',to_date('4/2/2022', 'mm/dd/yyyy'),'E011','C002');
INSERT INTO ORDERS VALUES('OA057', to_date('5/17/2022', 'mm/dd/yyyy'),'Y',to_date('5/24/2022', 'mm/dd/yyyy'),'E023','C006');
INSERT INTO ORDERS VALUES('OA058', to_date('2/15/2022', 'mm/dd/yyyy'),'N',to_date('2/22/2022', 'mm/dd/yyyy'),'E014','C002');
INSERT INTO ORDERS VALUES('OA059', to_date('4/25/2022', 'mm/dd/yyyy'),'Y',to_date('5/2/2022', 'mm/dd/yyyy'),'E023','C005');
INSERT INTO ORDERS VALUES('OA060', to_date('7/18/2022', 'mm/dd/yyyy'),'N',to_date('7/25/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA061', to_date('9/22/2022', 'mm/dd/yyyy'),'Y',to_date('9/29/2022', 'mm/dd/yyyy'),'E017','C006');
INSERT INTO ORDERS VALUES('OA062', to_date('3/3/2022', 'mm/dd/yyyy'),'Y',to_date('3/10/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA063', to_date('7/1/2022', 'mm/dd/yyyy'),'N',to_date('7/8/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA064', to_date('8/16/2022', 'mm/dd/yyyy'),'Y',to_date('8/23/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA065', to_date('5/12/2022', 'mm/dd/yyyy'),'Y',to_date('5/19/2022', 'mm/dd/yyyy'),'E016','C008');
INSERT INTO ORDERS VALUES('OA066', to_date('7/10/2022', 'mm/dd/yyyy'),'Y',to_date('7/17/2022', 'mm/dd/yyyy'),'E022','C003');
INSERT INTO ORDERS VALUES('OA067', to_date('3/22/2022', 'mm/dd/yyyy'),'N',to_date('3/29/2022', 'mm/dd/yyyy'),'E013','C010');
INSERT INTO ORDERS VALUES('OA068', to_date('1/26/2022', 'mm/dd/yyyy'),'Y',to_date('2/2/2022', 'mm/dd/yyyy'),'E021','C007');
INSERT INTO ORDERS VALUES('OA069', to_date('9/4/2022', 'mm/dd/yyyy'),'Y',to_date('9/11/2022', 'mm/dd/yyyy'),'E011','C005');
INSERT INTO ORDERS VALUES('OA070', to_date('2/16/2022', 'mm/dd/yyyy'),'Y',to_date('2/23/2022', 'mm/dd/yyyy'),'E018','C006');
INSERT INTO ORDERS VALUES('OA071', to_date('12/18/2022', 'mm/dd/yyyy'),'N',to_date('12/25/2022', 'mm/dd/yyyy'),'E013','C002');
INSERT INTO ORDERS VALUES('OA072', to_date('10/27/2022', 'mm/dd/yyyy'),'N',to_date('11/3/2022', 'mm/dd/yyyy'),'E008','C007');
INSERT INTO ORDERS VALUES('OA073', to_date('10/18/2022', 'mm/dd/yyyy'),'Y',to_date('10/25/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA074', to_date('7/2/2022', 'mm/dd/yyyy'),'Y',to_date('7/9/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA075', to_date('8/10/2022', 'mm/dd/yyyy'),'Y',to_date('8/17/2022', 'mm/dd/yyyy'),'E015','C003');
INSERT INTO ORDERS VALUES('OA076', to_date('8/22/2022', 'mm/dd/yyyy'),'Y',to_date('8/29/2022', 'mm/dd/yyyy'),'E014','C001');
INSERT INTO ORDERS VALUES('OA077', to_date('1/9/2022', 'mm/dd/yyyy'),'N',to_date('1/16/2022', 'mm/dd/yyyy'),'E016','C001');
INSERT INTO ORDERS VALUES('OA078', to_date('11/9/2022', 'mm/dd/yyyy'),'Y',to_date('11/16/2022', 'mm/dd/yyyy'),'E002','C004');
INSERT INTO ORDERS VALUES('OA079', to_date('5/9/2022', 'mm/dd/yyyy'),'Y',to_date('5/16/2022', 'mm/dd/yyyy'),'E002','C007');
INSERT INTO ORDERS VALUES('OA080', to_date('8/13/2022', 'mm/dd/yyyy'),'Y',to_date('8/20/2022', 'mm/dd/yyyy'),'E008','C010');
INSERT INTO ORDERS VALUES('OA081', to_date('3/21/2022', 'mm/dd/yyyy'),'Y',to_date('3/28/2022', 'mm/dd/yyyy'),'E011','C002');
INSERT INTO ORDERS VALUES('OA082', to_date('2/10/2022', 'mm/dd/yyyy'),'Y',to_date('2/17/2022', 'mm/dd/yyyy'),'E023','C006');
INSERT INTO ORDERS VALUES('OA083', to_date('11/11/2022', 'mm/dd/yyyy'),'N',to_date('11/18/2022', 'mm/dd/yyyy'),'E014','C002');
INSERT INTO ORDERS VALUES('OA084', to_date('2/17/2022', 'mm/dd/yyyy'),'Y',to_date('2/24/2022', 'mm/dd/yyyy'),'E023','C005');
INSERT INTO ORDERS VALUES('OA085', to_date('5/10/2022', 'mm/dd/yyyy'),'N',to_date('5/17/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA086', to_date('4/6/2022', 'mm/dd/yyyy'),'Y',to_date('4/13/2022', 'mm/dd/yyyy'),'E017','C006');
INSERT INTO ORDERS VALUES('OA087', to_date('5/16/2022', 'mm/dd/yyyy'),'Y',to_date('5/23/2022', 'mm/dd/yyyy'),'E021','C010');
INSERT INTO ORDERS VALUES('OA088', to_date('2/17/2022', 'mm/dd/yyyy'),'N',to_date('2/24/2022', 'mm/dd/yyyy'),'E019','C005');
INSERT INTO ORDERS VALUES('OA089', to_date('9/1/2022', 'mm/dd/yyyy'),'Y',to_date('9/8/2022', 'mm/dd/yyyy'),'E020','C008');
INSERT INTO ORDERS VALUES('OA090', to_date('2/27/2022', 'mm/dd/yyyy'),'Y',to_date('3/6/2022', 'mm/dd/yyyy'),'E016','C008');


INSERT INTO OrderLine VALUES('OL001',15,'OA001');
INSERT INTO OrderLine VALUES('OL002',15,'OA001');
INSERT INTO OrderLine VALUES('OL003',20,'OA001');
INSERT INTO OrderLine VALUES('OL004',10,'OA002');
INSERT INTO OrderLine VALUES('OL005',30,'OA003');
INSERT INTO OrderLine VALUES('OL006',30,'OA003');
INSERT INTO OrderLine VALUES('OL007',30,'OA003');
INSERT INTO OrderLine VALUES('OL008',15,'OA004');
INSERT INTO OrderLine VALUES('OL009',14,'OA005');
INSERT INTO OrderLine VALUES('OL010',50,'OA006');
INSERT INTO OrderLine VALUES('OL011',45,'OA007');
INSERT INTO OrderLine VALUES('OL012',6,'OA007');
INSERT INTO OrderLine VALUES('OL013',20,'OA008');
INSERT INTO OrderLine VALUES('OL014',15,'OA009');
INSERT INTO OrderLine VALUES('OL015',25,'OA010');
INSERT INTO OrderLine VALUES('OL016',12,'OA010');
INSERT INTO OrderLine VALUES('OL017',27,'OA011');
INSERT INTO OrderLine VALUES('OL018',30,'OA012');
INSERT INTO OrderLine VALUES('OL019',6,'OA012');
INSERT INTO OrderLine VALUES('OL020',30,'OA012');
INSERT INTO OrderLine VALUES('OL021',15,'OA013');
INSERT INTO OrderLine VALUES('OL022',25,'OA014');
INSERT INTO OrderLine VALUES('OL023',30,'OA015');
INSERT INTO OrderLine VALUES('OL024',15,'OA016');
INSERT INTO OrderLine VALUES('OL025',20,'OA016');
INSERT INTO OrderLine VALUES('OL026',10,'OA017');
INSERT INTO OrderLine VALUES('OL027',30,'OA018');
INSERT INTO OrderLine VALUES('OL028',32,'OA019');
INSERT INTO OrderLine VALUES('OL029',22,'OA020');
INSERT INTO OrderLine VALUES('OL030',10,'OA020');
INSERT INTO OrderLine VALUES('OL031',26,'OA021');
INSERT INTO OrderLine VALUES('OL032',11,'OA022');
INSERT INTO OrderLine VALUES('OL033',16,'OA022');
INSERT INTO OrderLine VALUES('OL034',10,'OA023');
INSERT INTO OrderLine VALUES('OL035',26,'OA023');
INSERT INTO OrderLine VALUES('OL036',19,'OA023');
INSERT INTO OrderLine VALUES('OL037',22,'OA023');
INSERT INTO OrderLine VALUES('OL038',24,'OA023');
INSERT INTO OrderLine VALUES('OL039',29,'OA025');
INSERT INTO OrderLine VALUES('OL040',25,'OA025');
INSERT INTO OrderLine VALUES('OL041',26,'OA026');
INSERT INTO OrderLine VALUES('OL042',30,'OA026');
INSERT INTO OrderLine VALUES('OL043',16,'OA027');
INSERT INTO OrderLine VALUES('OL044',16,'OA027');
INSERT INTO OrderLine VALUES('OL045',12,'OA027');
INSERT INTO OrderLine VALUES('OL046',25,'OA028');
INSERT INTO OrderLine VALUES('OL047',17,'OA028');
INSERT INTO OrderLine VALUES('OL048',17,'OA028');
INSERT INTO OrderLine VALUES('OL049',13,'OA029');
INSERT INTO OrderLine VALUES('OL050',14,'OA029');
INSERT INTO OrderLine VALUES('OL051',28,'OA031');
INSERT INTO OrderLine VALUES('OL052',18,'OA032');
INSERT INTO OrderLine VALUES('OL053',17,'OA034');
INSERT INTO OrderLine VALUES('OL054',13,'OA034');
INSERT INTO OrderLine VALUES('OL055',12,'OA034');
INSERT INTO OrderLine VALUES('OL056',19,'OA034');
INSERT INTO OrderLine VALUES('OL057',18,'OA035');
INSERT INTO OrderLine VALUES('OL058',27,'OA035');
INSERT INTO OrderLine VALUES('OL059',20,'OA035');
INSERT INTO OrderLine VALUES('OL060',29,'OA036');
INSERT INTO OrderLine VALUES('OL061',11,'OA036');
INSERT INTO OrderLine VALUES('OL062',29,'OA036');
INSERT INTO OrderLine VALUES('OL063',10,'OA037');
INSERT INTO OrderLine VALUES('OL064',21,'OA037');
INSERT INTO OrderLine VALUES('OL065',29,'OA038');
INSERT INTO OrderLine VALUES('OL066',12,'OA038');
INSERT INTO OrderLine VALUES('OL067',27,'OA039');
INSERT INTO OrderLine VALUES('OL068',28,'OA039');
INSERT INTO OrderLine VALUES('OL069',15,'OA040');
INSERT INTO OrderLine VALUES('OL070',22,'OA040');
INSERT INTO OrderLine VALUES('OL071',16,'OA042');
INSERT INTO OrderLine VALUES('OL072',15,'OA042');
INSERT INTO OrderLine VALUES('OL073',11,'OA042');
INSERT INTO OrderLine VALUES('OL074',19,'OA042');
INSERT INTO OrderLine VALUES('OL075',20,'OA042');
INSERT INTO OrderLine VALUES('OL076',11,'OA042');
INSERT INTO OrderLine VALUES('OL077',14,'OA042');
INSERT INTO OrderLine VALUES('OL078',13,'OA043');
INSERT INTO OrderLine VALUES('OL079',24,'OA043');
INSERT INTO OrderLine VALUES('OL080',17,'OA043');
INSERT INTO OrderLine VALUES('OL081',21,'OA045');
INSERT INTO OrderLine VALUES('OL082',21,'OA045');
INSERT INTO OrderLine VALUES('OL083',16,'OA045');
INSERT INTO OrderLine VALUES('OL084',20,'OA046');
INSERT INTO OrderLine VALUES('OL085',21,'OA046');
INSERT INTO OrderLine VALUES('OL086',10,'OA047');
INSERT INTO OrderLine VALUES('OL087',27,'OA049');
INSERT INTO OrderLine VALUES('OL088',28,'OA049');
INSERT INTO OrderLine VALUES('OL089',24,'OA049');
INSERT INTO OrderLine VALUES('OL090',13,'OA050');
INSERT INTO OrderLine VALUES('OL091',28,'OA050');
INSERT INTO OrderLine VALUES('OL092',11,'OA050');
INSERT INTO OrderLine VALUES('OL093',13,'OA050');
INSERT INTO OrderLine VALUES('OL094',26,'OA051');
INSERT INTO OrderLine VALUES('OL095',27,'OA051');
INSERT INTO OrderLine VALUES('OL096',22,'OA051');
INSERT INTO OrderLine VALUES('OL097',24,'OA052');
INSERT INTO OrderLine VALUES('OL098',16,'OA052');
INSERT INTO OrderLine VALUES('OL099',10,'OA052');
INSERT INTO OrderLine VALUES('OL100',26,'OA053');
INSERT INTO OrderLine VALUES('OL101',28,'OA054');
INSERT INTO OrderLine VALUES('OL102',29,'OA055');
INSERT INTO OrderLine VALUES('OL103',10,'OA055');
INSERT INTO OrderLine VALUES('OL104',16,'OA055');
INSERT INTO OrderLine VALUES('OL105',23,'OA055');
INSERT INTO OrderLine VALUES('OL106',11,'OA056');
INSERT INTO OrderLine VALUES('OL107',23,'OA056');
INSERT INTO OrderLine VALUES('OL108',15,'OA056');
INSERT INTO OrderLine VALUES('OL109',23,'OA056');
INSERT INTO OrderLine VALUES('OL110',28,'OA058');
INSERT INTO OrderLine VALUES('OL111',18,'OA059');
INSERT INTO OrderLine VALUES('OL112',30,'OA060');
INSERT INTO OrderLine VALUES('OL113',15,'OA061');
INSERT INTO OrderLine VALUES('OL114',21,'OA061');
INSERT INTO OrderLine VALUES('OL115',14,'OA062');
INSERT INTO OrderLine VALUES('OL116',15,'OA062');
INSERT INTO OrderLine VALUES('OL117',21,'OA062');
INSERT INTO OrderLine VALUES('OL118',30,'OA063');
INSERT INTO OrderLine VALUES('OL119',12,'OA064');
INSERT INTO OrderLine VALUES('OL120',16,'OA064');
INSERT INTO OrderLine VALUES('OL121',30,'OA064');
INSERT INTO OrderLine VALUES('OL122',15,'OA065');
INSERT INTO OrderLine VALUES('OL123',26,'OA065');
INSERT INTO OrderLine VALUES('OL124',25,'OA066');
INSERT INTO OrderLine VALUES('OL125',23,'OA066');
INSERT INTO OrderLine VALUES('OL126',28,'OA066');
INSERT INTO OrderLine VALUES('OL127',16,'OA066');
INSERT INTO OrderLine VALUES('OL128',11,'OA066');
INSERT INTO OrderLine VALUES('OL129',11,'OA067');
INSERT INTO OrderLine VALUES('OL130',12,'OA067');
INSERT INTO OrderLine VALUES('OL131',18,'OA067');
INSERT INTO OrderLine VALUES('OL132',20,'OA068');
INSERT INTO OrderLine VALUES('OL133',23,'OA068');
INSERT INTO OrderLine VALUES('OL134',14,'OA069');
INSERT INTO OrderLine VALUES('OL135',25,'OA069');
INSERT INTO OrderLine VALUES('OL136',12,'OA069');
INSERT INTO OrderLine VALUES('OL137',23,'OA069');
INSERT INTO OrderLine VALUES('OL138',18,'OA070');
INSERT INTO OrderLine VALUES('OL139',17,'OA070');
INSERT INTO OrderLine VALUES('OL140',19,'OA070');
INSERT INTO OrderLine VALUES('OL141',19,'OA071');
INSERT INTO OrderLine VALUES('OL142',27,'OA071');
INSERT INTO OrderLine VALUES('OL143',20,'OA071');
INSERT INTO OrderLine VALUES('OL144',25,'OA071');
INSERT INTO OrderLine VALUES('OL145',28,'OA072');
INSERT INTO OrderLine VALUES('OL146',19,'OA073');
INSERT INTO OrderLine VALUES('OL147',25,'OA073');
INSERT INTO OrderLine VALUES('OL148',18,'OA073');
INSERT INTO OrderLine VALUES('OL149',27,'OA073');
INSERT INTO OrderLine VALUES('OL150',10,'OA073');
INSERT INTO OrderLine VALUES('OL151',14,'OA075');
INSERT INTO OrderLine VALUES('OL152',10,'OA075');
INSERT INTO OrderLine VALUES('OL153',19,'OA075');
INSERT INTO OrderLine VALUES('OL154',13,'OA075');
INSERT INTO OrderLine VALUES('OL155',19,'OA077');
INSERT INTO OrderLine VALUES('OL156',11,'OA077');
INSERT INTO OrderLine VALUES('OL157',27,'OA077');
INSERT INTO OrderLine VALUES('OL158',17,'OA077');
INSERT INTO OrderLine VALUES('OL159',12,'OA078');
INSERT INTO OrderLine VALUES('OL160',17,'OA078');
INSERT INTO OrderLine VALUES('OL161',20,'OA078');
INSERT INTO OrderLine VALUES('OL162',21,'OA079');
INSERT INTO OrderLine VALUES('OL163',28,'OA079');
INSERT INTO OrderLine VALUES('OL164',19,'OA080');
INSERT INTO OrderLine VALUES('OL165',21,'OA081');
INSERT INTO OrderLine VALUES('OL166',28,'OA081');
INSERT INTO OrderLine VALUES('OL167',17,'OA081');
INSERT INTO OrderLine VALUES('OL168',24,'OA081');
INSERT INTO OrderLine VALUES('OL169',21,'OA081');
INSERT INTO OrderLine VALUES('OL170',29,'OA081');
INSERT INTO OrderLine VALUES('OL171',30,'OA083');
INSERT INTO OrderLine VALUES('OL172',26,'OA083');
INSERT INTO OrderLine VALUES('OL173',23,'OA084');
INSERT INTO OrderLine VALUES('OL174',18,'OA084');
INSERT INTO OrderLine VALUES('OL175',22,'OA085');
INSERT INTO OrderLine VALUES('OL176',11,'OA086');
INSERT INTO OrderLine VALUES('OL177',22,'OA086');
INSERT INTO OrderLine VALUES('OL178',20,'OA086');
INSERT INTO OrderLine VALUES('OL179',25,'OA087');
INSERT INTO OrderLine VALUES('OL180',17,'OA087');
INSERT INTO OrderLine VALUES('OL181',21,'OA088');
INSERT INTO OrderLine VALUES('OL182',15,'OA088');
INSERT INTO OrderLine VALUES('OL183',13,'OA088');
INSERT INTO OrderLine VALUES('OL184',17,'OA088');
INSERT INTO OrderLine VALUES('OL185',16,'OA089');
INSERT INTO OrderLine VALUES('OL186',15,'OA090');

INSERT INTO Inventory VALUES('IV-0001','Small Bottles',20,500);
INSERT INTO Inventory VALUES('IV-0002','Cups',5,200);
INSERT INTO Inventory VALUES('IV-0003','Holders',2,100);
INSERT INTO Inventory VALUES('IV-0004','Large Bottles',50,600);

INSERT INTO Vehicle VALUES('VNZ001','Toyota','Tacoma','White');
INSERT INTO Vehicle VALUES('VNZ002','Ford','Transit Connect','Black');
INSERT INTO Vehicle VALUES('VNZ003','Chevrolet','Colorado','Grey');
INSERT INTO Vehicle VALUES('VNZ004','Mercedes-Benz','Sprinter','White');
INSERT INTO Vehicle VALUES('VNZ005','Toyota','Tacoma','Red');
INSERT INTO Vehicle VALUES('VNZ006','Ford','Transit Connect','Black');
INSERT INTO Vehicle VALUES('VNZ007','Chevrolet','Colorado','Grey');
INSERT INTO Vehicle VALUES('VNZ008','Mercedes-Benz','Sprinter','Blue');
INSERT INTO Vehicle VALUES('VNZ009','Toyota','Tacoma','White');
INSERT INTO Vehicle VALUES('VNZ010','Ford','Transit Connect','White');
INSERT INTO Vehicle VALUES('VNZ011','Chevrolet','Colorado','Grey');


INSERT INTO Referral VALUES('RF001','UPMC Hospital','Large','DL008','C007','Y');
INSERT INTO Referral VALUES('RF002','Minadeo Elementary School','Small','DL006','C003','Y');
INSERT INTO Referral VALUES('RF003','Maloy-Schleifer Funeral Home','Small','DL015','C009','Y');
INSERT INTO Referral VALUES('RF004','Eddie Vs Prime Seafood','Large','DL002','C010','Y');
INSERT INTO Referral VALUES('RF005','UPMC Childrens Community Pediatrics','Small','DL018','C006','Y');














ALTER TABLE billing
    ADD CONSTRAINT billing_company_fk FOREIGN KEY ( companyid )
        REFERENCES company ( companyid );

ALTER TABLE billing
    ADD CONSTRAINT billing_contract_fk FOREIGN KEY ( contractid )
        REFERENCES contract ( contractid );

ALTER TABLE billing
    ADD CONSTRAINT billing_order_fk FOREIGN KEY ( orderid )
        REFERENCES orders ( orderid );
        

ALTER TABLE company
    ADD CONSTRAINT company_companycontact_fk FOREIGN KEY ( contactid )
        REFERENCES companycontact ( contactid );

ALTER TABLE company
    ADD CONSTRAINT company_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE company
    ADD CONSTRAINT company_route_fk FOREIGN KEY ( routeid )
        REFERENCES route ( routeid );

ALTER TABLE company
    ADD CONSTRAINT company_tax_fk FOREIGN KEY ( taxid )
        REFERENCES tax ( taxid );

ALTER TABLE contract
    ADD CONSTRAINT contract_company_fk FOREIGN KEY ( companyid )
        REFERENCES company ( companyid );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_vehicle_fk FOREIGN KEY ( vehicleid )
        REFERENCES vehicle ( vehicleid );

ALTER TABLE employee
    ADD CONSTRAINT employee_route_fk FOREIGN KEY ( routeid )
        REFERENCES route ( routeid );

ALTER TABLE evaluation
    ADD CONSTRAINT evaluation_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE ORDERS
    ADD CONSTRAINT orders_company_fk FOREIGN KEY ( companyid )
        REFERENCES company ( companyid );

ALTER TABLE ORDERS
    ADD CONSTRAINT orders_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE orderline
    ADD CONSTRAINT orderline_order_fk FOREIGN KEY ( orderid )
        REFERENCES orders ( orderid );

ALTER TABLE referral
    ADD CONSTRAINT referral_company_fk FOREIGN KEY ( companyid )
        REFERENCES company ( companyid );

ALTER TABLE referral
    ADD CONSTRAINT referral_delivery_fk FOREIGN KEY ( deliveryid )
        REFERENCES delivery ( deliveryid );

ALTER TABLE shipment
    ADD CONSTRAINT shipment_contract_fk FOREIGN KEY ( contractid )
        REFERENCES contract ( contractid );

ALTER TABLE shipment
    ADD CONSTRAINT shipment_delivery_fk FOREIGN KEY ( deliveryid )
        REFERENCES delivery ( deliveryid );

ALTER TABLE shipment
    ADD CONSTRAINT shipment_order_fk FOREIGN KEY ( orderid )
        REFERENCES orders ( orderid );

ALTER TABLE shipmentline
    ADD CONSTRAINT shipmentline_inventory_fk FOREIGN KEY ( inventoryid )
        REFERENCES inventory ( inventoryid );

ALTER TABLE shipmentline
    ADD CONSTRAINT shipmentline_shipment_fk FOREIGN KEY ( shipmentid )
        REFERENCES shipment ( shipmentid );








create or replace Function CalculateBilling
   ( BillingID IN varchar2 )
   RETURN number
IS
   BillingAmount number;

   cursor c1 is
   SELECT decode(BillingAmount, null, 0, BillingAmount) AS BillingAmount
     from
     (select orderID, SUM(quantity * retailprice) as BillingAmount from orders
      left join shipment using (orderid)
      left join shipmentline using (shipmentid)
      left join inventory using (inventoryid)
      group by orderID 
      union all
      select contractID, CONTRACT_Amount
      from contract)
      WHERE ORDERID = BillingID;

BEGIN

   open c1;
   fetch c1 into BillingAmount;

   if c1%notfound then
      BillingAmount := 0;
   end if;

   close c1;

RETURN BillingAmount;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

create or replace FUNCTION employee_rating_calc (employeeidIn employee.employeeid%TYPE, monthIn NUMBER)
RETURN NUMBER IS

    outScore NUMBER;

BEGIN

    SELECT score INTO outScore
    FROM (
    SELECT 
        e.employeeid, 
        CASE 
            WHEN routedistance <= 10 THEN 1
            WHEN routedistance BETWEEN 11 AND 20 THEN 2
            WHEN routedistance > 20 THEN 3
            ELSE 0
        END AS distance_value,
        CASE 
            WHEN route_difficulty = 'Low' THEN 1
            WHEN route_difficulty = 'Medium' THEN 2
            WHEN route_difficulty = 'High' THEN 3
            ELSE 0 
        END AS difficulty_value,
        nvl(delivery_count, 0) as delivery_count,
        nvl(referral_count, 0) as referral_count,
        (CASE 
            WHEN routedistance <= 10 THEN 1
            WHEN routedistance BETWEEN 11 AND 20 THEN 2
            WHEN routedistance > 20 THEN 3
            ELSE 0
         END * 0.5) + 
        (CASE 
            WHEN route_difficulty = 'Low' THEN 1
            WHEN route_difficulty = 'Medium' THEN 2
            WHEN route_difficulty = 'High' THEN 3
            ELSE 0 
         END * 0.3) +
        (nvl(delivery_count, 0) * 0.7) +
        (nvl(referral_count, 0) * 0.25) as score
    FROM employee e
    LEFT OUTER JOIN route r ON r.routeid = e.routeid
    LEFT OUTER JOIN (SELECT employeeid, count(deliveryid) as delivery_count
          FROM delivery   
          WHERE EXTRACT(MONTH FROM deliverydate) = monthIn AND EXTRACT(YEAR FROM deliverydate) = 2022 AND employeeid = employeeidIn
          GROUP BY employeeid) c ON c.employeeid = e.employeeid
    LEFT OUTER JOIN (SELECT e.employeeid, count(referralid) as referral_count
                     FROM employee e
                     LEFT OUTER JOIN delivery d ON e.employeeid = d.employeeid
                     LEFT OUTER JOIN referral r ON d.deliveryid = r.deliveryid
                     WHERE EXTRACT(MONTH FROM deliverydate) = monthIn AND EXTRACT(YEAR FROM deliverydate) = 2022 AND e.employeeid = employeeidIn
                     GROUP BY e.employeeid) l ON e.employeeid = l.employeeid
    WHERE e.employeeid = employeeidIn);

    RETURN outScore;
END employee_rating_calc;
/









create or replace TRIGGER inventory_quantity_alarm
    AFTER DELETE OR INSERT OR UPDATE ON inventory

DECLARE
    InventoryQuant_smallBottle number(38);
    InventoryQuant_largeBottle number(38);
    InventoryQuant_cups number(38);
    InventoryQuant_holders number(38);

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Inventory Summary: ');
    select InventoryQuantity into InventoryQuant_smallBottle FROM inventory where inventoryID = 'IV-0001';
    if InventoryQuant_smallBottle >100 then 
    DBMS_OUTPUT.PUT_LINE('Number of Small bottle: ' ||InventoryQuant_smallBottle ||' Sufficient stock!');
    elsif (InventoryQuant_smallBottle <100 and InventoryQuant_smallBottle >10) then 
    DBMS_OUTPUT.PUT_LINE('Number of Small bottle: ' ||InventoryQuant_smallBottle ||' Moderate stock!');
    else 
    DBMS_OUTPUT.PUT_LINE('Number of Small bottle: ' || InventoryQuant_smallBottle ||' Low stock! Time to order from the vendor.');
    END IF;

    select InventoryQuantity into InventoryQuant_largeBottle FROM inventory where inventoryID = 'IV-0004';
    if InventoryQuant_largeBottle >100 then 
    DBMS_OUTPUT.PUT_LINE('Number of Large bottle: ' ||InventoryQuant_largeBottle ||' Sufficient stock!');
    elsif (InventoryQuant_largeBottle <=100 and InventoryQuant_largeBottle >10) then 
    DBMS_OUTPUT.PUT_LINE('Number of Large bottle: ' ||InventoryQuant_largeBottle ||' Moderate stock!');
    else 
    DBMS_OUTPUT.PUT_LINE('Number of Large bottle: ' || InventoryQuant_largeBottle ||' Low stock! Time to order from the vendor.');
    END IF;

    select InventoryQuantity into InventoryQuant_cups FROM inventory where inventoryID = 'IV-0002';
    if InventoryQuant_cups >100 then 
    DBMS_OUTPUT.PUT_LINE('Number of Cups: ' ||InventoryQuant_cups ||' Sufficient stock!');
    elsif (InventoryQuant_cups <=100 and InventoryQuant_cups >10) then 
    DBMS_OUTPUT.PUT_LINE('Number of Cups: ' ||InventoryQuant_cups ||' Moderate stock!');
    else 
    DBMS_OUTPUT.PUT_LINE('Number of Cups: ' || InventoryQuant_cups ||' Low stock! Time to order from the vendor.');
    END IF;

    select InventoryQuantity into InventoryQuant_holders FROM inventory where inventoryID = 'IV-0003';
    if InventoryQuant_holders >100 then 
    DBMS_OUTPUT.PUT_LINE('Number of Holders: ' ||InventoryQuant_holders ||' Sufficient stock!');
    elsif (InventoryQuant_holders <=100 and InventoryQuant_holders >10) then 
    DBMS_OUTPUT.PUT_LINE('Number of Holders: ' ||InventoryQuant_holders ||' Moderate stock!');
    else 
    DBMS_OUTPUT.PUT_LINE('Number of Holders: ' || InventoryQuant_holders ||' Low stock! Time to order from the vendor.');
    END IF;

END;
/


create or replace TRIGGER inventory_update_alarm
    AFTER INSERT OR UPDATE ON Inventory
FOR EACH ROW

BEGIN
    IF UPDATING ('inventoryquantity') THEN 

    DBMS_OUTPUT.PUT_LINE('Update number of ' || :OLD.description ||' to ' || :NEW.inventoryquantity);

    END IF;
END;
/


create or replace TRIGGER update_billingAmount
    BEFORE INSERT OR UPDATE ON billing
FOR EACH ROW

BEGIN
    :NEW.billingamount := CalculateBilling(case when :NEW.contractid is null then :NEW.orderid else :NEW.contractid end);
END;
/


create or replace TRIGGER lead_update 
AFTER INSERT ON company  

BEGIN
    UPDATE referral
    SET convertedtocustomer = 'Y'
    WHERE referral.referral_company_name IN (SELECT companyname FROM company);
    DBMS_OUTPUT.PUT_LINE('A lead has been added to the COMPANY table. If the company exists in the referral table, its status has been updated.');
END;
/

















SET SERVEROUTPUT ON;
-- DROPPING ALL THE PROCEDURES, SCHEDULED JOBS AND MATERIALIZED VIEWS.

--begin
--      DBMS_SCHEDULER.DROP_JOB (job_name=>'company_billing_job');
--      DBMS_SCHEDULER.DROP_JOB (job_name=>'billing_history_job');
--end;
/

--DROP PROCEDURE get_company_billing;
--DROP PROCEDURE get_billing_history;
--DROP MATERIALIZED VIEW MV_COMPANY_BILLING;
--DROP MATERIALIZED VIEW MV_BILLING_HISTORY;
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE ' || 'get_company_billing';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE ' || 'get_billing_history';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW ' || 'MV_COMPANY_BILLING';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -12003 THEN
      RAISE;
    END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW ' || 'MV_BILLING_HISTORY';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -12003 THEN
      RAISE;
    END IF;
END;
/

REM CREATING A MATERIALIZED VIEW USING A STORED PROCEDURE WHICH IS THEN EXECUTED BY A SCHEDULED JOB.
REM This materialized view displays the company id, and the outstanding billing amount for that company.
CREATE MATERIALIZED VIEW mv_company_billing
REFRESH COMPLETE
AS  SELECT companyId, SUM(billingamount) as Total_Outstanding 
    FROM billing where paid='N' 
    GROUP BY CompanyId 
    ORDER BY Total_Outstanding DESC;

REM THIS IS A STORED PROCEDURE.
REM Calls the materialized view mv_company_billing
CREATE OR REPLACE PROCEDURE get_company_billing AS
  CURSOR C1 IS
    SELECT * FROM mv_company_billing;
  company_billing_record C1%ROWTYPE;
BEGIN
  OPEN C1;
  DBMS_OUTPUT.PUT_LINE('CompanyID' || ' | ' || 'Total Outstanding');
  DBMS_OUTPUT.NEW_LINE;
  LOOP
    FETCH C1 INTO company_billing_record;
    EXIT WHEN C1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(company_billing_record.CompanyId || '      |      ' || company_billing_record.Total_Outstanding);
  END LOOP;
  CLOSE C1;
  COMMIT;
END;
/

REM CREATING THE JOB company_billing_job
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'company_billing_job',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'get_company_billing',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'freq=MINUTELY;INTERVAL= 5;',
        end_date        => '01-MAY-23 09.00.00 PM America/New_York',
        enabled         => TRUE,
        comments        => 'Job for calculating the total outstanding bill of the companies till the current date.');
 END;
/

-- CHECK WHETHER THE JOB IS EXECUTED, AND EXECUTE THE PROCEDURE get_company_billing.

SELECT log_id, log_date, job_name, status  
FROM USER_SCHEDULER_JOB_LOG 
WHERE job_name LIKE'COMPANY_BILLING_JOB' 
ORDER BY log_date desc;

EXECUTE get_company_billing;

REM CREATING A MATERIALIZED VIEW USING A STORED PROCEDURE WHICH IS THEN EXECUTED BY A SCHEDULED JOB.
REM This materialized view displays the company details, and the billing amount, order date and whether the bill is paid or not.
CREATE MATERIALIZED VIEW mv_billing_history
REFRESH COMPLETE
AS  SELECT  b.companyid,c.companyname,
        c.street || ' ' || c.city || ' ' || c.state || ' ' || c.zip as address,
        b.billingamount,o.orderdate, paid AS Paid_Status  
    FROM billing b INNER JOIN orders o USING(orderid) 
                   INNER JOIN company c ON c.companyid = b.companyid
    ORDER BY b.companyid, o.orderdate DESC, Paid_Status ASC;

REM CREATE A PROCEDURE get_billing_history
REM This procedure calls the mv_billing_history materialized view.
CREATE OR REPLACE PROCEDURE get_billing_history AS
  CURSOR C1 IS
    SELECT * FROM mv_billing_history;
    billing_history_record C1%ROWTYPE;
BEGIN
  OPEN C1;
  DBMS_OUTPUT.PUT_LINE('CompanyID' || ' | ' || 'Company Name    '
  || '             |' || 'Address                ' || '  |       ' 
  || 'Billing Amount' || '  |  ' || 'OrderDate' || '   |   ' || 'Paid Status');
  DBMS_OUTPUT.NEW_LINE;
  LOOP
    FETCH C1 INTO billing_history_record;
    EXIT WHEN C1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(billing_history_record.CompanyId || '      |' ||
    billing_history_record.companyname || '           |' || 
    billing_history_record.address || ' |     ' || 
    billing_history_record.billingamount || ' |     ' || 
    billing_history_record.orderdate || ' |        ' || billing_history_record.Paid_Status);
  END LOOP;
  CLOSE C1;
  COMMIT;
END;
/

REM CREATING THE JOB- billing_history_job
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'billing_history_job',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'get_billing_history',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'freq=MINUTELY;INTERVAL= 5;',
        end_date        => '01-MAY-23 09.00.00 PM America/New_York',
        enabled         => TRUE,
        comments        => 'Job for fetching the bill history');
 END;
/
-- CHECK WHETHER THE JOB IS EXECUTED, AND EXECUTE THE PROCEDURE get_company_order_billing.
SELECT log_id, log_date, job_name, status  
FROM USER_SCHEDULER_JOB_LOG 
WHERE job_name LIKE'BILLING_HISTORY_JOB' 
ORDER BY log_date desc;

EXECUTE get_billing_history;


CREATE OR REPLACE VIEW latest_employee_reports
AS
    SELECT employeeid, employee_rating_calc(employeeid, EXTRACT(MONTH from sysdate)-1) as last_month_score, evalcomments as latest_comments, evaluationdate as last_eval_date
    FROM employee 
    LEFT OUTER JOIN (SELECT evaluationid, employeeid, evaluationdate, evalcomments, RANK() OVER (PARTITION BY employeeid ORDER BY evaluationdate) as latest 
                     FROM evaluation
                     ORDER BY employeeid) USING (employeeid)
    WHERE latest = 1
    ORDER BY last_month_score DESC;
/

create or replace PACKAGE billing_management AS 
   FUNCTION CalculateBilling ( BillingID IN varchar2 )
      RETURN NUMBER;  
   PROCEDURE get_billing_history; 
   PROCEDURE get_company_billing; 
END billing_management; 
/

begin
  execute immediate 'CREATE ROLE Billing_manager'; 
exception
  when others then
    --"ORA-01921: role name 'x' conflicts with another user or role name"
    if sqlcode = -01921 then 
      null;
    else
      raise;
    end if;
end;
/
begin
  execute immediate 'CREATE ROLE HR_manager'; 
exception
  when others then
    --"ORA-01921: role name 'x' conflicts with another user or role name"
    if sqlcode = -01921 then 
      null;
    else
      raise;
    end if;
end;
/
begin
  execute immediate 'CREATE ROLE Sale_manager'; 
exception
  when others then
    --"ORA-01921: role name 'x' conflicts with another user or role name"
    if sqlcode = -01921 then 
      null;
    else
      raise;
    end if;
end;
/


GRANT EXECUTE, DEBUG ON billing_management TO Billing_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON EMPLOYEE TO HR_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON EVALUATION TO HR_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON COMPANY TO Sale_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON COMPANYCONTACT TO Sale_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON CONTRACT TO Sale_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON REFERRAL TO Sale_manager;
