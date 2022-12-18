if not exists ( select * from sys.databases where name = 'project_management_warehouse')
create database project_management_warehouse
GO

use project_management_warehouse
GO 


--down

if exists (select * from information_schema.table_constraints
 where constraint_name = 'fk_inventory_inventory_type_id')
 alter table inventory_types drop constraint fk_inventory_inventory_type_id 

if exists (select * from information_schema.table_constraints
 where constraint_name = 'fk_inventory_inventory_id')
 alter table inventory_types drop constraint fk_inventory_inventory_id 

drop table if exists inventory_types
drop table if exists invtype 
drop table if exists inventory 
drop table if exists supplier

if exists (select * from information_schema.table_constraints
 where constraint_name = 'fk_employees_employee_type_id')
 alter table employees_types drop constraint fk_employees_employee_type_id 

if exists (select * from information_schema.table_constraints
 where constraint_name = 'fk_employees_employee_id')
 alter table employees_types drop constraint fk_employees_employee_id 

drop table if exists emptype
drop table if exists employees_types
drop table if exists employee
drop table if exists store
drop table if exists project
GO



--up


-- creating table consisting of all the projects
CREATE TABLE project (
   Project_ID          INTEGER  NOT NULL PRIMARY KEY 
  ,Project_name        VARCHAR(12) NOT NULL
  ,Project_description VARCHAR(52) NOT NULL
  ,Project_budget      VARCHAR(8) NOT NULL
  ,Project_duration    INTEGER  NOT NULL
);


-- entering the data into the project table
go
INSERT INTO project(Project_ID,Project_name,Project_description,Project_budget,Project_duration) VALUES (1,'Amazon Fresh','Consolidate a new business office','$50,000',10);
INSERT INTO project(Project_ID,Project_name,Project_description,Project_budget,Project_duration) VALUES (2,'Google','Consolidate a new business office','$45,000',12);
INSERT INTO project(Project_ID,Project_name,Project_description,Project_budget,Project_duration) VALUES (3,'McDonald''s','Open a new Amazon Fresh inventory setup at Syracuse','$35,000',9);
INSERT INTO project(Project_ID,Project_name,Project_description,Project_budget,Project_duration) VALUES (4,'Tesla','A warehouse set up with parking spaces for 50 trucks','$80,000',9);
INSERT INTO project(Project_ID,Project_name,Project_description,Project_budget,Project_duration) VALUES (5,'Werner','Consolidate a new business office','$65,000',8);

GO

--creating table with all the stores
CREATE TABLE store(
   Store_ID         INTEGER  NOT NULL PRIMARY KEY 
  ,Store_location   VARCHAR(11) NOT NULL
  ,Store_zipcode    INTEGER  NOT NULL
  ,Store_phone      VARCHAR(12) NOT NULL
  ,Store_address    VARCHAR(24) NOT NULL
  ,Store_project_id INTEGER  NOT NULL FOREIGN KEY REFERENCES project(project_id)
);

GO

-- inserting data into the store table
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (101,'Syracuse',13210,'343-547-8519','65 International Center',1);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (102,'Los Angeles',90011,'478-880-8845','67904 Nancy Road',2);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (103,'Chicago',60629,'186-788-2953','415 David Alley',3);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (104,'Brooklyn',11226,'832-113-7199','1534 Jay Point',4);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (105,'Bronx',10467,'675-901-2335','293 Tennyson Street',5);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (106,'New York',10025,'419-569-0441','6127 Stang Center',1);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (107,'Dallas',75217,'329-641-1787','24946 Mccormick Road',2);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (108,'Atlanta',30349,'541-252-9650','745 Messerschmidt Place',3);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (109,'El Paso',79936,'199-816-8550','2677 Farmco Parkway',4);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (110,'Houston',77084,'280-695-1444','6762 Weeping Birch Way',5);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (111,'Syracuse',13210,'292-416-0067','5671 Kensington Crossing',4);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (112,'Los Angeles',90011,'351-717-6300','837 Del Sol Road',3);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (113,'Chicago',60629,'592-399-8811','7384 Bellgrove Terrace',1);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (114,'Brooklyn',11226,'132-283-4972','65 Leroy Park',5);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (115,'Bronx',10467,'829-646-3321','86 Anzinger Street',2);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (116,'New York',10025,'917-831-2645','44 Scofield Terrace',1);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (117,'Dallas',75217,'799-802-9321','49350 Sundown Pass',2);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (118,'Atlanta',30349,'138-327-1494','1 Rutledge Way',3);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (119,'El Paso',79936,'911-245-5073','71 Kensington Circle',4);
INSERT INTO store(Store_ID,Store_location,Store_zipcode,Store_phone,Store_address,Store_project_id) VALUES (120,'Houston',77084,'721-422-0164','909 Commercial Circle',3);


-- creating table for employees
go
CREATE TABLE employee(
   Employee_ID         INTEGER uNIQUE NOT NULL 
  ,Employee_first_name VARCHAR(15) NOT NULL 
  ,Employee_last_name  VARCHAR(15) NOT NULL
  ,Employee_email      VARCHAR(33) NOT NULL 
  ,Employee_type       VARCHAR(12) NOT NULL
  ,Employee_salary     INTEGER  NOT NULL
  ,Employee_store_id   INTEGER  NOT NULL
  constraint u_employees_employee_email unique (Employee_email),
  constraint pk_employee_employee_id primary key (Employee_ID)
);

CREATE TABLE emptype (
    Employee_type_id INTEGER NOT NULL PRIMARY KEY,
    Employee_type VARCHAR(15) NOT NULL 
);


CREATE TABLE employees_types(
   Employee_id         INTEGER  NOT NULL 
  ,Employee_type_id    INTEGER  NOT NULL 
  CONSTRAINT [pk_employees_employee_id] PRIMARY KEY (Employee_ID),
    CONSTRAINT [fk_employees_employee_type_id] FOREIGN KEY (Employee_type_id) REFERENCES emptype (Employee_type_id) ,
    CONSTRAINT [fk_employees_employee_id] FOREIGN KEY (Employee_id) REFERENCES employee(Employee_ID)
);


GO

insert into emptype(Employee_type_id, Employee_type) values (1, 'Store');
insert into emptype(Employee_type_id, Employee_type) values (2, 'Logistic');
insert into emptype(Employee_type_id, Employee_type) values (3, 'Construction');



--go
-- alter table employees_types add constraint fk_employees_employee_type_id
-- foreign key (Employee_type_id)
-- references emptype (Employee_type_id)

--go
--alter table employees_types add constraint fk_employees_employee_id
--foreign key (Employee_id)
--references employee (Employee_ID)

GO
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1055,'Deanne','Vitall','dvitall1i@digg.com', 'Store', 21576,109);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1056,'Louie','Maleham','lmaleham1j@ucsd.edu','Logistic', 42997,110);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1057,'Rosella','Robken','rrobken1k@google.pl','Store',94822,117);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1058,'Jena','Pley','jpley1l@freewebs.com','Store',80283,115);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1059,'Baudoin','Spandley','bspandley1m@jiathis.com','Store',29631,105);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1060,'Gerda','Seeler','gseeler1n@ovh.net','Logistic',80121,106);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1061,'Merola','Osgar','mosgar1o@blogtalkradio.com','Logistic',93011,108);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1062,'Grata','Lorenzini','glorenzini1p@zdnet.com','Logistic',19299,111);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1063,'Coraline','Choat','cchoat1q@un.org','Construction',34125,113);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1064,'Netta','Freezor','nfreezor1r@ezinearticles.com','Interior',79363,119);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1065,'Willamina','Penchen','wpenchen1s@opera.com','Construction',25200,115);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1066,'Padraig','Patient','ppatient1t@delicious.com','Construction',74872,118);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1067,'Deane','Alexsandrovich','dalexsandrovich1u@baidu.com','Logistic',98294,115);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1068,'Myca','Ladloe','mladloe1v@sohu.com','Construction',80157,107);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1069,'Clayborn','Yves','cyves1w@ox.ac.uk','Construction',77041,117);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1070,'Joli','Jayne','jjayne1x@unblog.fr','Store',53762,113);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1071,'Annaliese','Winterborne','awinterborne1y@tmall.com','Logistic',83522,104);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1072,'Field','Danniell','fdanniell1z@census.gov','Store',95054,101);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1073,'Irina','Thoresby','ithoresby20@amazon.com','Construction',75803,105);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1074,'Reeva','Divall','rdivall21@disqus.com','Logistic',91665,108);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1075,'Isabelita','Sheal','isheal22@answers.com','Construction',49423,106);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1076,'Kiersten','Canet','kcanet23@themeforest.net','Logistic',21161,101);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1077,'Abigail','Cisland','acisland24@unc.edu','Logistic',67838,109);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1078,'Casie','Iglesia','ciglesia25@dmoz.org','Logistic',72086,114);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1079,'Debi','Mewton','dmewton26@mlb.com','Logistic',78089,116);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1080,'Cleon','Newns','cnewns27@cdbaby.com','Construction',95620,119);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1081,'Nikki','Lettley','nlettley28@symantec.com','Logistic',16511,118);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1082,'Lisbeth','Oiseau','loiseau29@discovery.com','Logistic',43607,120);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1083,'Jeni','Benck','jbenck2a@ehow.com','Construction',30197,101);
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1084,'Daniele','Fripps','dfripps2b@nationalgeographic.com','Construction',59574, 103)
INSERT INTO employee(Employee_ID,Employee_first_name,Employee_last_name,Employee_email,Employee_type,Employee_salary,Employee_store_id) VALUES (1085,'jamie','bonds','dblahs2b@nationalgeographic.com','Construction',59014, 106)

-- creating supplier table and inserting data
GO
CREATE TABLE supplier(
   Supplier_ID    INTEGER  NOT NULL PRIMARY KEY 
  ,Supplier_name  VARCHAR(32) NOT NULL
  ,Supplier_item  VARCHAR(21) NOT NULL
  ,Supplier_email VARCHAR(24) NOT NULL
  ,Supplier_cost  INTEGER  NOT NULL
);

go
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5001,'Godrej','Coolers','rdonet3@auda.org.au',1200);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5002,'DELL','Computer systems','gmaus1@mac.com',5000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5003,'Godrej','Heaters','rdonet3@auda.org.au',6042);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5004,'Godrej','Refrigerators','rdonet3@auda.org.au',2798);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5005,'Technavio','Bulbs','mturnock4@craigslist.org',70);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5006,'Constrint','Construction Material','const5@seesaa.net', 50990);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5007,'Werner','Trucks','adredge6@mapquest.com',86309);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5009,'EPSON','Billing Machine','bhincham9@wordpress.com',1243);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5010,'EPSON','Printers','bhincham9@wordpress.com',3214);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5011,'Airdistributor Co.','Industrial fans','zwilmorea@usgs.gov',1892);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5012,'East Coast Storage Equipment Co.','Storage rack','lcattermullb@alibaba.com',923);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5016,'West Coast Storage Equipment Co.','Storage rack','westmullb@alibaba.com',1023);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5019,'Coolcomp','Coolers','cmandrierc@sohu.com',1000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5020,'HP','Computer systems','strownsond@about.me',29119);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5021,'Prince','Heaters','cgrishanine@virginia.edu',7001);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5022,'Hydro','Refrigerators','rnewcombf@cnbc.com',4000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5023,'chamak','Bulbs','cjaaomg@wsj.com',86);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5024,'Cemex','Construction Material','mscneiderh@columbia.edu',48900);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5025,'Styker','Trucks','dgaiteri@weibo.com',30383);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5026,'Lightcomp','Bulbs','bgrafomg@wsj.com',40);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5027,'piomp','Bulbs','afomg@wsj.com',60);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5028,'Microsoft','Computer systems','gmaus1@mac.com',3000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5029,'Apple','Computer systems','gmaus1@mac.com',4000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5030,'Lenovo','Computer systems','gmaus1@mac.com',2000);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5031,'Ubbey','Van','ubbey1@mac.com',30001);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5032,'lego','Van','lego1@mac.com',40121);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5033,'Ahuja agent','Land','ahu12@mac.com',800121);
INSERT INTO supplier(Supplier_ID,Supplier_name,Supplier_item,Supplier_email,Supplier_cost) VALUES (5034,'Leonard agent','Land','leo912@mac.com',120121);

GO

-- creating inventory table and inserting data 
CREATE TABLE inventory(
   Inventory_ID          INTEGER  NOT NULL PRIMARY KEY 
  ,Inventory_type        VARCHAR(21) NOT NULL
  ,Inventory_items       VARCHAR(12) NOT NULL
  ,Inventory_cost        INTEGER  NOT NULL
  ,Inventory_supplier_id INTEGER  NOT NULL FOREIGN KEY REFERENCES supplier (supplier_id)
  ,Inventory_store_id    INTEGER  NOT NULL FOREIGN KEY REFERENCES store (store_id)
);

go

CREATE TABLE invtype (
    Inventory_type_id INTEGER NOT NULL PRIMARY KEY,
    Inventory_type VARCHAR(15) NOT NULL 
);
GO
insert into invtype(Inventory_type_id, Inventory_type) values (1, 'Equipment');
insert into invtype(Inventory_type_id, Inventory_type) values (2, 'Logistic');
insert into invtype(Inventory_type_id, Inventory_type) values (3, 'Construction');
insert into invtype(Inventory_type_id, Inventory_type) values (4, 'Property');

GO
CREATE TABLE inventory_types(
   Inventory_id         INTEGER  NOT NULL 
  ,Inventory_type_id    INTEGER  NOT NULL 
  CONSTRAINT [pk_inventory_inventory_id] PRIMARY KEY (Inventory_id),
    CONSTRAINT [fk_inventory_inventory_type_id] FOREIGN KEY (Inventory_type_id) REFERENCES invtype (Inventory_type_id) ,
    CONSTRAINT [fk_inventory_inventory_id] FOREIGN KEY (Inventory_id) REFERENCES inventory (Inventory_id)
);

GO
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30001,'Industrial fans','Equipment',8500,5011,101);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30002,'Industrial fans','Equipment',6000,5011,102);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30003,'Construction material','Construction',80000,5024,103);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30004,'Trucks','Logistic',250000,5025,104);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30005,'Vans','Logistic',150000,5032,105);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30006,'Printer','Equipment',1120,5010,106);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30007,'Cooler','Equipment',1400,5019,107);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30008,'Bulbs','Equipment',580,5005,108);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30009,'Construction material','Construction',112500,5006,109);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30010,'Refrigerator','Equipment',6750,5004,110);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30011,'Computer systems','Equipment',2900,5020,111);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30012,'Computer systems','Equipment',6000,5028,112);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30013,'Billing machine','Equipment',850,5009,113);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30014,'Billing machine','Equipment',700,5009,114);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30015,'Heater','Equipment',300,5003,115);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30016,'Heater','Equipment',950,5021,116);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30017,'Construction material','Construction',97000,5024,117);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30019,'Heater','Equipment',410,5003,119);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30020,'Cooler','Equipment',1050,5019,120);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30021,'Cooler','Equipment',1030,5001,101);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30022,'Computer systems','Equipment',1400,5029,102);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30023,'Land','Property',540000,5033,103);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30024,'Bulbs','Equipment',100,5023,104);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30025,'Storage racks','Construction',60000,5024,105);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30026,'Storage racks','Construction',50500,5024,106);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30027,'Heater','Equipment',7550,5021,107);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30028,'Computer systems','Equipment',4500,5030,108);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30029,'Heater','Equipment',700,5003,109);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30030,'Heater','Equipment',2600,5003,110);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30031,'Computer systems','Equipment',4250,5029,111);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30032,'Computer systems','Equipment',3900,5030,112);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30033,'Trucks','Logistic',31835,5025,113);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30034,'Construction material','Construction',130809,5024,114);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30035,'Printer','Equipment',1025,5010,115);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30036,'Cooler','Equipment',12878,5019,116);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30037,'Printer','Equipment',1034,5010,117);
INSERT INTO inventory(Inventory_ID,Inventory_type,Inventory_items,Inventory_cost,Inventory_supplier_id,Inventory_store_id) VALUES (30038,'Computer Systems','Equipment',100531,5030,117);


-- queries 

GO
-- finding the details of all employees working under a specific field 
SELECT employee_id, Employee_first_name,employee_type, employee_store_id from employee
where employee_type = 'Construction' 

GO
-- finding the cinstruction employees for a specific store 
SELECT employee_id, Employee_first_name,employee_type, employee_store_id from employee
where employee_type = 'Construction' and employee_store_id = '106'

GO
-- finding the sum of all the inventory 
SELECT sum(Inventory_cost) as total_cost_of_inventory from inventory 

GO
-- finding the sum of a specific product
SELECT sum(Inventory_cost) as total_cost_of_cooler from inventory where Inventory_type = 'Cooler'

GO
-- finding the sum of salary for all the logistic employees
SELECT sum(Employee_salary) as total_cost_logistic from employee where Employee_type = 'Logistic'  

GO
-- finding the count of invenotry items
SELECT count(Inventory_cost) as total_num_heaters from inventory where Inventory_type = 'Heater'

GO
-- finding the supplier detials for a specific product 
SELECT Supplier_name, Supplier_item, Supplier_cost, Supplier_email from supplier 
where  Supplier_item = 'Refrigerators'


GO
-- finding all the suppliers that supply to a specific store

select  Supplier_name, Supplier_email, Supplier_cost, supplier_item from inventory
 join supplier 
 on inventory.Inventory_supplier_id = supplier.Supplier_ID 
 where Inventory_store_id = 104;


GO
-- findindg which supplier costs the most for a specific item 
select  TOP 3 Supplier_item, Supplier_name, Supplier_cost from supplier
 where supplier_item = 'Computer Systems'
 ORDER BY Supplier_cost desc;

-- procedure to add a new supplier into the system 
GO
drop procedure if exists p_upsert_supplier
GO
create procedure p_upsert_supplier (
@supplier_id int,
@supplier_email varchar(50),
@supplier_item char(20),
@supplier_name varchar(20),
@supplier_cost int
) as begin
if exists(select * from supplier where Supplier_email = @supplier_email) begin 
update supplier set Supplier_item = @supplier_item
where Supplier_email = @supplier_email
end
else begin
insert into supplier (Supplier_ID, Supplier_name, Supplier_item, Supplier_email,Supplier_cost) 
values (@supplier_id, @supplier_name, @supplier_item, @supplier_email,@supplier_cost)
end
end 
GO

GO
select * from supplier 

GO
exec p_upsert_supplier 5035, 'pinoor@syr.edu', 'Cleaning products', 'pinoor', 999
select * from supplier 



