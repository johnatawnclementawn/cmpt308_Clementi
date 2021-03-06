-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 2017/12/04 --
-- Assignment: Database Design Project --
-- File name: legoDB.sql --



-- Clear database of tables --
DROP TRIGGER IF EXISTS checkSet on setPurchased;
DROP VIEW IF EXISTS mostSellingStores;
DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS bricksIn;
DROP TABLE IF EXISTS brkPurchased;
DROP TABLE IF EXISTS setPurchased;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Designers;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Sets; 
DROP TABLE IF EXISTS setThemes;
DROP TABLE IF EXISTS Bricks;
DROP TABLE IF EXISTS Colors;
DROP TABLE IF EXISTS bCategories;
DROP ROLE IF EXISTS lego_admin;
DROP ROLE IF EXISTS lego_designer;
DROP ROLE IF EXISTS lego_cust;


------------------------------------
-- Here begins table declarations --
------------------------------------

-- Brick Categories --
CREATE TABLE bCategories (
    bcID	CHAR(4) PRIMARY KEY NOT NULL,
    name	TEXT NOT NULL
);


-- Colors --
CREATE TABLE Colors (
    colid		CHAR(3) PRIMARY KEY NOT NULL,
    num			VARCHAR(3) NOT NULL, -- Lego's Color ID --
    legoName	TEXT NOT NULL, -- Official Lego color name --
    comName		TEXT -- Common name of color --
);


-- Bricks --
CREATE TABLE Bricks (
    bid			VARCHAR(7) PRIMARY KEY NOT NULL,
    designID	VARCHAR(7) NOT NULL, -- designID is Lego's identifier for a type of brick --
	category	CHAR(4) NOT NULL REFERENCES bCategories(bcID),
    name		TEXT,
    priceUSD	NUMERIC(10,2)
);



-- Set Theme --
CREATE TABLE SetThemes (
    stID	CHAR(4) PRIMARY KEY NOT NULL,
    name	TEXT NOT NULL
);


-- Sets --
CREATE TABLE Sets (
    sid			CHAR(4) PRIMARY KEY NOT NULL,
    setNum		VARCHAR(7) NOT NULL, -- Lego's set identifier --
    theme		CHAR(4) NOT NULL REFERENCES setThemes(stID),
    name		TEXT NOT NULL,
    pieceNum	INT NOT NULL,
    priceUSD	NUMERIC(10,2) NOT NULL
);


-- People --
CREATE TABLE People (
    pid			CHAR(4) PRIMARY KEY NOT NULL,
    fname		TEXT NOT NULL,
    lname		TEXT NOT NULL,
    DOB			DATE NOT NULL
);


-- Customers --
CREATE TABLE Customers (
    pid 		CHAR(4) NOT NULL REFERENCES People(pid),
    prefStore	TEXT NOT NULL, -- Customer’s preferred store --
  PRIMARY KEY(pid)
);


-- Designers --
CREATE TABLE Designers (
    pid 			CHAR(4) NOT NULL REFERENCES People(pid),
    favTheme		CHAR(4) REFERENCES setThemes(stID),
    favBrick		CHAR(4) REFERENCES bricks(bid),
    officeCity		TEXT,
    officeCountry	TEXT,
  PRIMARY KEY(pid)
);


-- Transactions --
CREATE TABLE transactions (
    tid				CHAR(4) PRIMARY KEY NOT NULL,
    customer		CHAR(4) NOT NULL REFERENCES customers(pid),
    storeLoc		TEXT NOT NULL,
    DOP				DATE NOT NULL -- Date of Purchase --
);


-- Bricks purchased --
CREATE TABLE brkPurchased (
    bid			CHAR(4) NOT NULL REFERENCES bricks(bid),
    tid			CHAR(4) NOT NULL REFERENCES transactions(tid),
    quantity 	INT NOT NULL
);


-- Sets purchased --
CREATE TABLE setPurchased (
    sid			CHAR(4) NOT NULL REFERENCES sets(sid),
    tid			CHAR(4) NOT NULL REFERENCES transactions(tid),
    quantity 	INT NOT NULL
);


-- Designs --
-- (Many designers can contribute to design many sets) --
CREATE TABLE designs (
    pid		CHAR(4) NOT NULL REFERENCES designers(pid),
    sid		CHAR(4) NOT NULL REFERENCES sets(sid),
  PRIMARY KEY(pid, sid)
);


-- Bricks In --
-- (Many bricks are in many different sets) --
CREATE TABLE bricksIn (
    bid			  CHAR(4) NOT NULL REFERENCES bricks(bid),
    sid			  CHAR(4) NOT NULL REFERENCES sets(sid),
    colid         CHAR(4) NOT NULL REFERENCES colors(colid),
    quantity	  INT NOT NULL,
  PRIMARY KEY(bid, sid,colid)
);






---------------------------
-- Here begins test data --
---------------------------


-- Insert test data into brick categories --
-- Categories based on category listing from https://shop.lego.com/en-US/Pick-a-Brick --
INSERT INTO bCategories(bcID, name)
VALUES('bc01','Beams'),
      ('bc02','Bricks'),
      ('bc03','Bricks w/ Bows and Arches'),
      ('bc04','Bricks, special'),
      ('bc05','Bricks, Technic 4.85'),
      ('bc06','Connectors'),
      ('bc07','Decoration Elements'),
      ('bc08','Figure parts'),
      ('bc09','Figure Clothing'),
      ('bc10','Figure Heads and Masks'),
      ('bc11','Figure Accessories'),
      ('bc12','Frames, Windows, Walls, Doors'),
      ('bc13','Functional Elements'),
      ('bc14','Plates'),
      ('bc15','Plates, special'),
      ('bc16','Signs, Flags, and Poles'),
      ('bc17','Transportation');
SELECT * FROM bCategories;


-- Insert Test Data into Colors --
-- Colors and color numbers come from http://lego.wikia.com/wiki/Colour_Palette --
INSERT INTO Colors(colid, num, legoName, comName)
VALUES('c01',1,'White','White'),
      ('c02',5,'Brick Yellow','Tan'),
      ('c03',18,'Nougat','Flesh'),
      ('c04',21,'Bright Red','Red'),
      ('c05',23,'Bright Blue','Blue'),
      ('c06',24,'Bright Yellow','Yellow'),
      ('c07',26,'Black','Black'),
      ('c08',28,'Dark Green','Green'),
      ('c09',323,'Aqua','Unikitty Blue'),
      ('c10',326,'Spring Yellowish Green','Unikitty Green'),
      ('c11',40,'Transparent',NULL),
      ('c12',41,'Transparent Red',NULL),
      ('c13',43,'Transparent Blue',NULL),
      ('c14',44,'Transparent Yellow',NULL),
      ('c15',47,'Transparent Dark Orange',NULL),
      ('c16',48,'Transparent Green',NULL),
      ('c17',49,'Transparent Fluorescent Green',NULL),
      ('c18',131,'Silver','Pearl Light Grey'),
      ('c19',310,'Metalized Gold',NULL);
SELECT * FROM Colors;    


-- Insert test data into bricks --
-- Test data comes from https://shop.lego.com/en-US/Pick-a-Brick --
INSERT INTO Bricks(bid, designID, category, name, priceUSD)
VALUES('b001','3005','bc02','Brick 1x1',0.07),
    ('b002','3004','bc02','Brick 1x2',0.10),
    ('b003','3622','bc02','Brick 1x3',0.14),
    ('b004','3010','bc02','Brick 1x4',0.15),
    ('b005','3009','bc02','Brick 1x6',0.24),
    ('b006','3008','bc02','Brick 1x8',0.27),
    ('b007','6111','bc02','Brick 1x10',0.32),
    ('b008','6112','bc02','Brick 1x12',0.39),
    ('b009','2465','bc02','Brick 1x16',0.50),
    ('b010','3245','bc02','Brick 1x2x2',0.17),
    ('b011','3003','bc02','Brick 2x2',0.14),
    ('b012','3002','bc02','Brick 2x3',0.17),
    ('b013','3001','bc02','Brick 2x4',0.20),
    ('b014','44237','bc02','Brick 2x6',0.27),
    ('b015','93888','bc02','Brick 2x8',0.34),
    ('b016','92538','bc02','Brick 2x10',0.56),
    ('b017','2357','bc02','Brick Corner 1x2x2',0.16),
    ('b018','30136','bc02','Palisade Brick 1x2',0.10),
    ('b019','2877','bc02','Profile Brick 1x2',0.10),
    ('b020','92950','bc03','Brick 1x6 W/ Inside Bow',0.20),
    ('b021','30165','bc03','Brick 2x2 W/ Bow and Knobs',0.17),
    ('b022','6091','bc03','Brick W/ Arch 1x1x1 1/3',0.11),
    ('b023','3659','bc03','Brick W/ Bow 1x4',0.14),
    ('b024','50950','bc03','Brick W/ Bow 1/3',0.12),
    ('b025','88292','bc03','Brick W/ Bow 1x3x2',0.17),
    ('b026','11153','bc03','Brick W/ Bow 1/4',0.12),
    ('b027','15068','bc03','Plate W/ Bow 2x2x2/3',0.12),
    ('b028','2420','bc14','Flat Tile 1x1',0.06),
    ('b029','3069','bc14','Flat Tile 1x2',0.07),
    ('b030','63864','bc14','FLat Tile 1x3',0.10),
    ('b031','2431','bc14','Flat Tile 1x4',0.12),
    ('b032','6636','bc14','Flat Tile 1x6',0.14),
    ('b033','4162','bc14','Flat Tile 1x8',0.14),
    ('b034','3068','bc14','Flat Tile 2x2',0.07),
    ('b035','87079','bc14','Flat Tile 2x4',0.20),
    ('b036','2420','bc14','Corner Plate 1x2x2',0.07),
    ('b037','3024','bc14','Plate 1x1',0.06),
    ('b038','3023','bc14','Plate 1x2',0.07),
    ('b039','3623','bc14','Plate 1x3',0.07),
    ('b040','3710','bc14','Plate 1x4',0.10),
    ('b041','3666','bc14','Plate 1x6',0.14),
    ('b042','3460','bc14','Plate 1x8',0.17),
    ('b043','3832','bc14','Plate 2x10',0.24),
    ('b044','2445','bc14','Plate 2x12',0.33),
    ('b045','4282','bc14','Plate 2x16',0.48),
    ('b046','3022','bc14','Plate 2x2',0.10),
    ('b047','3021','bc14','Plate 2x3',0.14),
    ('b048','3020','bc14','Plate 2x4',0.14),
    ('b049','3795','bc14','Plate 2x6',0.18),
    ('b050','3034','bc14','Plate 2x8',0.24),
    ('b051','3030','bc14','Plate 4x10',0.51),
    ('b052','3029','bc14','Plate 4x12',0.67),
    ('b053','3031','bc14','Plate 4x4',0.20),
    ('b054','6179','bc14','Plate 4x4 W/ 4 knobs',0.20),
    ('b055','3032','bc14','Plate 4x6',0.41),
    ('b056','3035','bc14','Plate 4x8',0.44),
    ('b057','3958','bc14','Plate 6x6',0.48),
    ('b058','3036','bc14','Plate 6x8',0.64),
    ('b059','2412','bc14','Radiator Grille 1x2',0.06),
    ('b060','73200','bc08','Mini Body Lower Part',0.38),
    ('b061','41879','bc08','Mini Leg',0.27),
    ('b062','76382','bc08','Mini Upper Part',0.53),
    ('b063','3626','bc10','Mini Head',0.07),
    ('b064','21023','bc10','Mini Head W/ Aviators',0.16),
    ('b065','99566','bc10','Mini Head No 891',0.16);
SELECT * FROM Bricks;


   
-- Insert Test Data into set themes --
-- List of set themes comes from https://en.wikipedia.org/wiki/List_of_Lego_themes --
INSERT INTO SetThemes (stID, name)
VALUES('st01','Architecture'),
	  ('st02','The Lego Movie'),
      ('st03','Boost'),
      ('st04','City'),
      ('st05','City: Octan'),
      ('st06','City: Vehicles'),
      ('st07','Classic'),
      ('st08','Creator'),
      ('st09','Disney'),
      ('st10','Duplo'),
      ('st11','Elves'),
      ('st12','Friends'),
      ('st13','Ghostbusters'),
      ('st14','Ideas'),
      ('st15','Juniors'),
      ('st16','Mindstorms'),
      ('st17','Minecraft'),
      ('st18','Modular Buildings'),
      ('st19','Ninjago'),
      ('st20','Knights'),
      ('st21','Pirates of the Carribean'),
      ('st22','Speed Champions'),
      ('st23','Racing'),
      ('st24','Lego Star Wars'),
      ('st25','Super Heroes'),
      ('st26','Technic'),
      ('st27','Power Functions');
SELECT * FROM SetThemes;      


-- Add sets test data --
-- Lego Set numbers explained at https://goo.gl/KEssUA --
INSERT INTO Sets(sid, setNum, theme, name, pieceNum, priceUSD)
VALUES('s001','10179','st24','Millennium Falcon',5195,3899.99),
      ('s002','10221','st24','Super Star Destroyer',3152,969.99),
      ('s003','10256','st01','Taj Mahal',5922,4499.99),
      ('s004','10214','st08','Tower Bridge',4295,239.99),
      ('s005','10196','st27','Grand Carousal',3263,3897.26),
      ('s006','75059','st24','Sandcrawler',3296,398.00),
      ('s007','10181','st01','Eiffel Tower',3428,3399.99),
      ('s008','10188','st24','Death Star',3803,464.48),
      ('s009','10143','st24','Death Star 2',3417,2799.99),
      ('s010','10234','st08','Sydney Opera House',2989,494.49),
      ('s011','3450','st01','Statue Of Liberty',2882,7997.99),
      ('s012','76042','st25','Shield Helicarrier',2996,349.99),
      ('s013','10178','st24','Walking AT-AT',1137,769.99),
      ('s014','10212','st24','Imperial Shuttle',2503,758.74),
      ('s015','70807','st02','MetalBeards Duel',412,15.99),
      ('s016','76003','st25','Battle of Smallvile',418,59.99),
      ('s017','41052','st09','Princess: Ariels Magical Kiss',250,39.99),
      ('s018','60043','st04','Police Prisoner Transport',196,29.99),
      ('s019','70724','st19','NinjaCopter',516,74.99),
      ('s020','6177','st07','Bricks & More: Builders of Tomorrow',650,34.99),
      ('s021','71042','st09','Pirates of the Carribean: Silent Mary',2200,199.99),
      ('s022','71040','st09','Disney Castle',4080,349.99),
      ('s023','21310','st14','Old Fishing Store',2049,149.99),
      ('s024','60162','st06','Jungle Air Drop Helicopter',1250,149.99),
      ('s025','31313','st16','Ev3 Toy Robot Project Set',601,349.95),
      ('s026','10258','st08','London Bus',1686,139.99),
      ('s027','79253','st17','Blue Drogon Scene',548,32.99),
      ('s028','60181','st06','Forest Tractor',174,19.99),
      ('s029','42009','st26','Mobile Crane MK II',2606,269.00),
      ('s030','42068','st26','Airport Rescue Vehicle',1098,79.99);

SELECT s.sid, s.setNum, st.name AS setTheme, s.name, s.pieceNum, s.priceUSD 
FROM Sets s INNER JOIN setThemes st on s.theme = st.stID;      



-- Test data for people --
INSERT INTO People(pid,fname,lname,DOB)
VALUES('p001','Johnathan','Clementi','1996-05-12'),
      ('p002','Alan','Labouseur','1970-01-15'),
      ('p003','Megan','Clementi','1968-11-15'),
      ('p004','Paul','Clementi','1966-01-25'),
      ('p005','Kathryn','Rivera','1998-11-12'),
      ('p006','Alex','Antaki','1997-12-16'),
      ('p007','Alex','Mahlmeister','1997-09-04'),
      ('p008','Matthew','Oakley','1998-09-03'),
      ('p009','Casimer','DeCusatis','1960-08-09'),
      ('p010','Pablo','Rivas','1978-06-13'),
      ('p011','Ole Kirk','Christiansen','1891-04-07'),
      ('p012','Niels','Christiansen','1966-04-12'),
      ('p013','Jorgen Vig','Knudstorp','1968-11-21'),
      ('p014','Grant','Dixon','1998-01-25'),
      ('p015','Isabella','DiAddario','1998-01-12'),
      ('p016','Yaz','Mohammed Butt','1997-09-16'),
      ('p017','Eric','Seltzer','1949-05-09'),
      ('p018','Natalia','Dobrenko','1998-09-03'),
      ('p019','Bradley','Mobek','1996-08-17'),
      ('p020','Ryan','Scala','2000-09-21'),
      ('p021','Brian','Cranston','2001-04-17'),
      ('p022','Bob','Odenkirk','1966-04-12'),
      ('p023','Gus','Fring','1998-11-23'),
      ('p024','Walter','White','2002-05-25'),
      ('p025','Walter Jr.','White','2005-08-12'),
      ('p026','Skylar','White','2008-09-26'),
      ('p027','Matthew','Harris','1999-03-09'),
      ('p028','Jenna','Boccabella','1998-02-09'),
      ('p029','Ariana','Giordano','1999-01-17'),
      ('p030','Katherine','Clementi','1998-02-09');
SELECT * FROM People;      
     
      
-- Designers test data --
INSERT INTO Designers(pid, favTheme, favBrick, officeCity, officeCountry)
VALUES('p022','st14','b061','Sydney','Australia'),
      ('p014','st04','b046','Sydney','Australia'),
      ('p003','st24','b001','Prague','Czech Republic'),
      ('p004','st26','b052','Singapore','Singapore'),
      ('p027','st27','b027','Shanghai','China'),
      ('p018','st17','b036','Moscow','Russia'),
      ('p013','st10','b038','Philadelphia','United States of America'),
      ('p028','st09','b044','New York City','United States of America'),
      ('p015','st02','b026','Los Angeles','United States of America'),
      ('p024','st12','b026','Dallas','United States of America'),
      ('p026','st07','b044','Toronto','Canada'),
      ('p002','st02','b044','London','England');
SELECT p.fname, p.lname, st.name as favTheme, b.name as favBrick, d.officeCity, d.officeCountry
FROM Designers d INNER JOIN People p ON d.pid = p.pid
				 INNER JOIN setThemes st ON d.favTheme = st.stID
                 INNER JOIN bricks b ON d.favBrick = b.bid;           
      

-- Customers test data --
INSERT INTO Customers(pid, prefStore)
VALUES('p001','King of Prussia'),
      ('p003','San Fransisco'),
      ('p005','New York City'),
      ('p006','Shanghai'),
      ('p008','Dallas'),
      ('p010','Prague'),
      ('p017','Sydney'),
      ('p019','Moscow'),
      ('p021','King of Prussia'),
      ('p016','New York City'),
      ('p007','Singapore'),
      ('p025','Philadelphia');
SELECT p.fname, p.lname, prefStore 
FROM Customers c INNER JOIN People p on c.pid = p.pid; 

 
-- Transaction test data --
INSERT INTO transactions(tid,customer,storeLoc, DOP)
VALUES('t001','p001','King of Prussia','2017-12-01'),
      ('t002','p003','San Francisco','2017-12-02'),
      ('t003','p003','New York City','2017-12-03'),
      ('t004','p005','Shanghai','2017-12-04'),
      ('t005','p006','Shanghai','2017-12-01'),
      ('t006','p008','Moscow','2017-12-02'),
      ('t007','p017','Singapore','2017-12-03'),
      ('t008','p019','Philadelphia','2017-12-04'),
      ('t009','p021','King of Prussia','2017-12-01'),
      ('t010','p007','Singapore','2017-12-02'),
      ('t011','p019','Sydney','2017-12-03'),
      ('t012','p025','Moscow','2017-12-04'),
      ('t013','p003','San Fransisco','2017-12-05'),
      ('t014','p021','Prague','2017-12-01'),
      ('t015','p008','New York City','2017-12-02'),
      ('t016','p005','Sydney','2017-12-03'),
      ('t017','p001','Singapore','2017-12-06'),
      ('t018','p025','King of Prussia','2017-11-30'),
      ('t019','p003','New York City','2017-12-01'),
      ('t020','p006','Shanghai','2017-12-02');
SELECT t.tid, p.fname, p.lname, t.storeLoc, t.DOP 
FROM transactions t INNER JOIN customers c on t.customer = c.pid
					INNER JOIN people p on c.pid = p.pid;            
     

-- Set Purchased test data --
INSERT INTO setPurchased(tid, sid, quantity)
VALUES('t001','s001',1),
      ('t002','s030',2),
      ('t006','s008',2),
      ('t007','s017',1),
      ('t008','s019',3),
      ('t009','s021',5),
      ('t010','s007',1),
      ('t011','s010',1),
      ('t012','s025',2),
      ('t013','s002',2),
      ('t018','s023',1),
      ('t019','s004',1),
      ('t020','s006',1);
SELECT sp.tid, s.name AS setName, p.fname, p.lname, t.storeLoc, t.DOP, sp.quantity
FROM setPurchased sp INNER JOIN sets s on sp.sid = s.sid
					 INNER JOIN transactions t on sp.tid = t.tid
					 INNER JOIN customers c on t.customer = c.pid
					 INNER JOIN people p on c.pid = p.pid;


-- brick Purchased test data --
INSERT INTO brkPurchased(tid, bid, quantity)
VALUES('t002','b030',20),
      ('t003','b013',185),
      ('t004','b005',34),
      ('t005','b006',95),
      ('t006','b008',10),
      ('t014','b022',101),
      ('t015','b021',57),
      ('t016','b015',80),
      ('t017','b029',12),
      ('t019','b003',6),
      ('t020','b006',98);
SELECT bkp.tid, b.name AS brickName, p.fname, p.lname, t.storeLoc, t.DOP, bkp.quantity
FROM brkPurchased bkp INNER JOIN bricks b on bkp.bid = b.bid
					 INNER JOIN transactions t on bkp.tid = t.tid
					 INNER JOIN customers c on t.customer = c.pid
					 INNER JOIN people p on c.pid = p.pid;
 
      
-- bricks in sets test data --
INSERT INTO bricksIn(sid, bid, colid, quantity)
VALUES('s001','b004','c01',2),
      ('s001','b005','c02',234),
      ('s001','b006','c03',13),
      ('s002','b045','c04',52),
      ('s002','b023','c05',65),
      ('s002','b061','c06',24),
      ('s003','b053','c07',54),
      ('s003','b046','c08',4),
      ('s003','b003','c09',23),
      ('s004','b007','c10',67),
      ('s004','b010','c11',73),
      ('s004','b022','c12',33),
      ('s005','b059','c13',73),
      ('s005','b003','c14',34),
      ('s006','b050','c15',76),
      ('s006','b013','c16',83),
      ('s007','b016','c17',32),
      ('s008','b019','c18',345),
      ('s009','b012','c19',34),
      ('s009','b021','c01',53),
      ('s009','b034','c02',233),
      ('s010','b035','c03',34),
      ('s011','b064','c04',38),
      ('s012','b007','c05',34),
      ('s012','b006','c06',09),
      ('s013','b009','c07',67),
      ('s013','b004','c08',38),
      ('s014','b036','c09',87),
      ('s014','b051','c10',23),
      ('s015','b048','c11',84),
      ('s016','b032','c12',32),
      ('s017','b065','c13',74),
      ('s018','b027','c14',46),
      ('s019','b029','c15',45),
      ('s020','b031','c16',23),
      ('s021','b025','c17',2),
      ('s022','b037','c18',35),
      ('s023','b022','c19',76),
      ('s024','b043','c01',34);
SELECT s.name AS setName, b.name AS brickName, c.legoName AS Color, bi.quantity
FROM bricksIn bi INNER JOIN sets s ON bi.sid = s.sid
				 INNER JOIN bricks b ON bi.bid = b.bid
                 INNER JOIN colors c ON bi.colid = c.colid;



-- designers and their designs --
INSERT INTO designs(pid, sid)
VALUES('p022','s001'),
      ('p022','s002'),
      ('p022','s003'),
      ('p014','s004'),
      ('p002','s005'),
      ('p002','s006'),
      ('p014','s007'),
      ('p014','s008'),
      ('p002','s009'),
      ('p002','s010'),
      ('p004','s011'),
      ('p004','s012'),
      ('p004','s013'),
      ('p004','s014'),
      ('p027','s015'),
      ('p027','s016'),
      ('p027','s017'),
      ('p004','s018'),
      ('p018','s019'),
      ('p002','s020'),
      ('p028','s021'),
      ('p028','s022'),
      ('p013','s023'),
      ('p013','s024'),
      ('p002','s025'),
      ('p002','s026'),
      ('p002','s027'),
      ('p013','s028'),
      ('p026','s029'),
      ('p026','s030');
SELECT p.fname, p.lname, s.name AS setName
FROM designs ds INNER JOIN sets s ON ds.sid = s.sid
				INNER JOIN designers d ON ds.pid = d.pid
				INNER JOIN people p ON d.pid = p.pid;




-------------------------------
-- Here begins data analysis --
-------------------------------


-------------
-- REPORTS --
-------------

-- This query will select customers that have bought set(s) but have not bought brick(s) --
SELECT DISTINCT p.pid, p.fname, p.lname
FROM people p INNER JOIN customers c ON p.pid = c.pid
WHERE c.pid IN (Select c1.pid
                FROM setPurchased sp INNER JOIN transactions t1 ON sp.tid = t1.tid
                    				 INNER JOIN customers c1 ON t1.customer = c1.pid
                WHERE c1.pid NOT IN (Select c2.pid
                                     FROM brkPurchased bkp INNER JOIN transactions t2 ON bkp.tid = t2.tid
                                        				   INNER JOIN customers c2 ON t2.customer = c2.pid)
                   )
ORDER BY p.fname ASC;



-- This query will select customers that have bought brick(s) but have not bought set(s) --
SELECT DISTINCT p.pid, p.fname, p.lname
FROM people p INNER JOIN customers c ON p.pid = c.pid
WHERE c.pid IN (Select c1.pid
                FROM brkPurchased bkp INNER JOIN transactions t1 ON bkp.tid = t1.tid
                    				  INNER JOIN customers c1 ON t1.customer = c1.pid
                WHERE c1.pid NOT IN (Select c2.pid
                                     FROM setPurchased sp INNER JOIN transactions t2 ON sp.tid = t2.tid
                                        				  INNER JOIN customers c2 ON t2.customer = c2.pid)
                   )
ORDER BY p.fname ASC;

-----------
-- VIEWS --
-----------


-- This view selects the most selling stores --
CREATE OR REPLACE VIEW mostSellingStores AS
	SELECT t.storeloc, COUNT(t.tid)
    FROM transactions t
    GROUP BY t.storeloc
    HAVING (COUNT(t.tid) >= 0)
    ORDER BY COUNT(t.tid) DESC;
    
SELECT * FROM mostSellingStores;   



-----------------------
-- STORED PROCEDURES --
-----------------------

-- This stored procedure will calculate the cost of a transaction for bricks --
CREATE OR REPLACE FUNCTION transbrkCalc(TEXT, REFCURSOR) RETURNS refcursor AS
$$
	Declare
            transNum TEXT := $1;
            resultSet REFCURSOR := $2;
BEGIN
	OPEN resultSet FOR
    	SELECT t.tid, (b.priceUSD * bkp.quantity) AS totalCostUSD
        FROM transactions t INNER JOIN brkPurchased bkp ON t.tid = bkp.tid
                            INNER JOIN bricks b ON bkp.bid = b.bid
        WHERE t.tid LIKE transNum;
        RETURN resultSet;
        
END;
$$
LANGUAGE plpgsql;
         
select transBrkCalc('t0%%', 'ref');
FETCH ALL FROM ref;



-- This stored procedure will calculate the cost of a transaction for bricks --
CREATE OR REPLACE FUNCTION transSetCalc(TEXT, REFCURSOR) RETURNS refcursor AS
$$
	Declare
            transNum TEXT := $1;
            resultSet REFCURSOR := $2;
BEGIN
	OPEN resultSet FOR
    	SELECT t.tid, (s.priceUSD * sp.quantity) AS totalCostUSD
        FROM transactions t INNER JOIN setPurchased sp ON t.tid = sp.tid
                            INNER JOIN sets s ON sp.sid = s.sid
        WHERE t.tid LIKE transNum;
        RETURN resultSet;
        
END;
$$
LANGUAGE plpgsql;
         
select transSetCalc('t0%%', 'ref1');
FETCH ALL FROM ref1;




--------------
-- Triggers --
--------------

-- checkSet trigger --
-- This trigger determines if a customer is attempting to buy an out of production set (i.e. Statue of Liberty or Taj Mahal) --
-- If a customer trys to buy these two sets, they will instead buy a SHIELD Helicarrier at the same quantity as their original purchase --
CREATE OR REPLACE FUNCTION checkSet()
RETURNS TRIGGER AS
$$
BEGIN
	IF (SELECT sp.sid FROM setPurchased sp WHERE sp.sid = 's003') = NEW.sid
    THEN
    	DELETE from setPurchased sp where sp.sid = NEW.sid;
        INSERT INTO setPurchased(tid, sid, quantity) VALUES (NEW.tid, 's012', NEW.Quantity);
    END IF;
    RETURN NEW;
END;
$$
language plpgsql;

CREATE TRIGGER checkSet
AFTER INSERT ON setPurchased
FOR EACH ROW
EXECUTE PROCEDURE checkSet();


-- Testing checkSet trigger --
INSERT INTO transactions(tid, customer, storeLOC, DOP) VALUES ('t021','p008','Beijing','2017-12-06');
INSERT INTO setPurchased(tid, sid, quantity) VALUES ('t021', 's003', 2);

SELECT * from setPurchased sp where sp.sid = 's003';
SELECT * from setPurchased sp where sp.sid = 's012';

----------------------------
-- Security: Grant/Revoke --
----------------------------

-- LegoDB administrator role --
CREATE ROLE lego_admin;
GRANT ALL ON ALL TABLES 
IN SCHEMA PUBLIC
TO lego_admin;


-- Lego designer role --
CREATE ROLE lego_designer;
GRANT ALL ON designs, setThemes, sets, bricksIn, bricks, bCategories, colors 
TO lego_designer;
GRANT SELECT ON designers
TO lego_designer;


-- Lego customer role --
CREATE ROLE lego_cust;
GRANT SELECT, INSERT ON transactions, brkPurchased, setPurchased 
TO lego_cust;
GRANT SELECT ON bricks, sets, colors, bCategories, setThemes
TO lego_cust;

