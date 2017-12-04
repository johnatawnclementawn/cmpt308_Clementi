-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 2017/12/04 --
-- Assignment: Database Design Project --
-- File name: legoDB.sql --



-- Clear database of tables --
DROP TABLE IF EXISTS brkColor;
DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS bricksIn;
DROP TABLE IF EXISTS brkPurchased;
DROP TABLE IF EXISTS setPurchased;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Designers;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Sets; 
DROP TABLE IF EXISTS setThemes;
DROP TABLE IF EXISTS Bricks;
DROP TABLE IF EXISTS Colors;
DROP TABLE IF EXISTS bCategories;




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


-- brkColor --
CREATE TABLE brkColor(
    bid			CHAR(4) NOT NULL REFERENCES bricks(bid),
    cid			CHAR(4) NOT NULL REFERENCES colors(colid),
  PRIMARY KEY(bid,cid)
);


-- Set Theme --
CREATE TABLE setThemes (
    stID	CHAR(4) PRIMARY KEY NOT NULL,
    name	TEXT NOT NULL
);


-- Sets --
CREATE TABLE sets (
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
    DOB			DATE
);


-- Customers --
CREATE TABLE Customers (
    pid 			CHAR(4) NOT NULL REFERENCES People(pid),
    prefStore	TEXT NOT NULL,
  PRIMARY KEY(pid)
);


-- Designers --
CREATE TABLE designers (
    pid 			CHAR(4) NOT NULL REFERENCES People(pid),
    officeAddress	TEXT,
    officeCity		TEXT,
    officeCountry	TEXT,
    favTheme		CHAR(4) REFERENCES setThemes(stID),
    favBrick		CHAR(4) REFERENCES bricks(bid),
  PRIMARY KEY(pid)
);


-- Transaction --
CREATE TABLE transaction(
    tid				CHAR(4) PRIMARY KEY NOT NULL,
    customer		CHAR(4) NOT NULL REFERENCES customers(pid),
    storeLoc		TEXT NOT NULL
);


-- Bricks purchased --
CREATE TABLE brkPurchased(
    bid			CHAR(4) NOT NULL REFERENCES bricks(bid),
    tid			CHAR(4) NOT NULL REFERENCES transaction(tid),
    quantity 	INT
);


-- Sets purchased --
CREATE TABLE setPurchased(
    sid			CHAR(4) NOT NULL REFERENCES sets(sid),
    tid			CHAR(4) NOT NULL REFERENCES transaction(tid),
    quantity 	INT
);


-- Designs --
-- (Many designers can contribute to design many sets) --
CREATE TABLE designs(
    pid		CHAR(4) NOT NULL REFERENCES designers(pid),
    sid		CHAR(4) NOT NULL REFERENCES sets(sid),
  PRIMARY KEY(pid, sid)
);


-- Bricks In --
-- (Many bricks are in many different sets) --
CREATE TABLE bricksIn(
    bid		CHAR(4) NOT NULL REFERENCES bricks(bid),
    sid		CHAR(4) NOT NULL REFERENCES sets(sid),
  PRIMARY KEY(bid, sid)
);




---------------------------
-- Here begins test data --
---------------------------




-- Insert test data into brick categories --
-- Categories based on category listing from https://shop.lego.com/en-US/Pick-a-Brick --
INSERT INTO bCategories(bcID, name)
VALUES('bc01','Animals and Creatures'),
	  ('bc02','Beams'),
      ('bc03','Botanic'),
      ('bc04','Bricks'),
      ('bc05','Bricks w/ Bows and Arches'),
      ('bc06','Bricks w/ special Bows and Angles'),
      ('bc07','Bricks, special'),
      ('bc08','Bricks, special Circles and Angles'),
      ('bc09','Bricks, Technic 4.85'),
      ('bc10','Bricks w/ slope'),
      ('bc11','Connectors'),
      ('bc12','Crains and Scaffold'),
      ('bc13','Decoration Elements'),
      ('bc14','Fences and Ladders'),
      ('bc15','Figure accessories Up/Low body'),
      ('bc16','Figure accessories Up/Low part'),
      ('bc17','Figure parts'),
      ('bc18','Figure Head Clothing'),
      ('bc19','Figure Heads and Masks'),
      ('bc20','Figure Weapons'),
      ('bc21','Figure Wigs'),
      ('bc22','Foodstuffs'),
      ('bc23','Frames, Windows, Walls, Doors'),
      ('bc24','Functional Elements'),
      ('bc25','Functional Elements, Gear Wheels and Racks'),
      ('bc26','Functional Elements, others'),
      ('bc27','Interior'),
      ('bc28','Plates'),
      ('bc29','Plates, special'),
      ('bc30','Plates, special Circles and Angles'),
      ('bc31','Rubbers and Strings'),
      ('bc32','Signs, Flags, and Poles'),
      ('bc33','Transportation, Aviation'),
      ('bc34','Transportation, Trains'),
      ('bc35','Transporation, Vehicles'),
      ('bc36','Tubes'),
      ('bc37','Tires and Rims, snap 3.2'),
      ('bc38','Tires and Rims, Technic 4.85'),
      ('bc39','Tires and Rims, special'),
      ('bc40','Wheel Base'),
      ('bc41','Windscreens and Cockpits');

Select * from bCategories;

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
      ('c09',37,'Bright Green','Bright Green'),
      ('c10',38,'Dark Orange','Dark Orange'),
      ('c11',102,'Medium Blue','Medium Blue'),
      ('c12',106,'Bright Orange','Orange'),
      ('c13',119,'Bright Yellowish-Green','Lime'),
      ('c14',124,'Bright Reddish Violet','Magenta'),
      ('c15',135,'Sand Blue','Sand Blue'),
      ('c16',138,'Sand Yellow','Dark Tan'),
      ('c17',140,'Earth Blue','Dark Blue'),
      ('c18',141,'Earth Green','Dark Green'),
      ('c19',151,'Sand Green','Sand Green'),
      ('c20',154,'Dark Red','Dark Red'),
      ('c21',191,'Flame Yellowish Orange','Bright Light Orange'),
      ('c22',192,'Reddish Brown','Reddish Brown'),
      ('c23',194,'Medium Stone Grey','Light Grey'),
      ('c24',199,'Dark Stone Grey','Dark Grey'),
      ('c25',208,'Light Stone Grey','Very Light Grey'),
      ('c26',212,'Light Royal Blue','Light Blue'),
      ('c27',221,'Bright Purple','Bright Pink'),
      ('c28',222,'Light Purple','Light Pink'),
      ('c29',226,'Cool Yellow','Blonde'),
      ('c30',268,'Medium Lilac','Dark Purple'),
      ('c31',283,'Light Nougat','Light Flesh'),
      ('c32',308,'Dark Brown','Dark Brown'),
      ('c33',312,'Medium Nougat','Medium Dark Flesh'),
      ('c34',321,'Dark Azur',NULL),
      ('c35',322,'Medium Azur','Azure'),
      ('c36',323,'Aqua','Unikitty Blue'),
      ('c37',324,'Medium Lavender',NULL),
      ('c38',325,'Lavender','Lavender'),
      ('c39',329,'White Glow','Glow-in-the-Dark'),
      ('c40',326,'Spring Yellowish Green','Unikitty Green'),
      ('c41',330,'Olive Green','Olive Green'),
      ('c42',331,'Medium-Yellowish Green','Medium Lime'),
      ('c43',40,'Transparent',NULL),
      ('c44',41,'Transparent Red',NULL),
      ('c45',42,'Transparent Light Blue',NULL),
      ('c46',43,'Transparent Blue',NULL),
      ('c47',44,'Transparent Yellow',NULL),
      ('c48',47,'Transparent Dark Orange',NULL),
      ('c49',48,'Transparent Green',NULL),
      ('c50',49,'Transparent Fluorescent Green',NULL),
      ('c51',111,'Transparent Brown (Smoke)',NULL),
      ('c52',113,'Transparent Medium Reddish-Yellow',NULL),
      ('c53',126,'Transparent Bright Bluish-Violet',NULL),
      ('c54',143,'Transparent Fluorescent Blue',NULL),
      ('c55',182,'Transparent Bright Orange',NULL),
      ('c56',311,'Transparent Bright Green',NULL),
      ('c57',131,'Silver','Pearl Light Grey'),
      ('c58',148,'Metallic Dark Grey','Pearl Dark Grey'),
      ('c59',294,'Phosphorescent Green','Glow-in-Dark Trans Green'),
      ('c60',297,'Warm Gold','Pearl Gold'),
      ('c61',309,'Metalized Silver',NULL),
      ('c62',310,'Metalized Gold',NULL),
      ('c63',315,'Silver Metallic',NULL),
      ('c64',316,'Titanium Metallic',NULL);
      
Select * from Colors;


-- Insert test data into bricks --
-- Test data comes from https://shop.lego.com/en-US/Pick-a-Brick --
INSERT INTO Bricks(bid, designID, category, name, priceUSD)
VALUES('b001','3005','bc04','Brick 1x1',0.07),
	  ('b002','3004','bc04','Brick 1x2',0.10),
      ('b003','3622','bc04','Brick 1x3',0.14),
	  ('b004','3010','bc04','Brick 1x4',0.15),
      ('b005','3009','bc04','Brick 1x6',0.24),
	  ('b006','3008','bc04','Brick 1x8',0.27),
      ('b007','6111','bc04','Brick 1x10',0.32),
	  ('b008','6112','bc04','Brick 1x12',0.39),
      ('b009','2465','bc04','Brick 1x16',0.50),
      ('b010','3245','bc04','Brick 1x2x2',0.17),
      ('b011','3003','bc04','Brick 2x2',0.14),
	  ('b012','3002','bc04','Brick 2x3',0.17),
      ('b013','3001','bc04','Brick 2x4',0.20),
	  ('b014','44237','bc04','Brick 2x6',0.27),
      ('b015','93888','bc04','Brick 2x8',0.34),
	  ('b016','92538','bc04','Brick 2x10',0.56),
      ('b017','2357','bc04','Brick Corner 1x2x2',0.16),
	  ('b018','30136','bc04','Palisade Brick 1x2',0.10),
      ('b019','2877','bc04','Profile Brick 1x2',0.10),
      ('b020','92950','bc05','Brick 1x6 W/ Inside Bow',0.20),
      ('b021','30165','bc05','Brick 2x2 W/ Bow and Knobs',0.17),
	  ('b022','6091','bc05','Brick W/ Arch 1x1x1 1/3',0.11),
      ('b023','3659','bc05','Brick W/ Bow 1x4',0.14),
	  ('b024','50950','bc05','Brick W/ Bow 1/3',0.12),
      ('b025','88292','bc05','Brick W/ Bow 1x3x2',0.17),
	  ('b026','11153','bc05','Brick W/ Bow 1/4',0.12),
      ('b027','15068','bc05','Plate W/ Bow 2x2x2/3',0.12),
	  ('b028','2420','bc28','Flat Tile 1x1',0.06),
      ('b029','3069','bc28','Flat Tile 1x2',0.07),
      ('b030','63864','bc28','FLat Tile 1x3',0.10),
      ('b031','2431','bc28','Flat Tile 1x4',0.12),
	  ('b032','6636','bc28','Flat Tile 1x6',0.14),
      ('b033','4162','bc28','Flat Tile 1x8',0.14),
	  ('b034','3068','bc28','Flat Tile 2x2',0.07),
      ('b035','87079','bc28','Flat Tile 2x4',0.20),
	  ('b036','2420','bc28','Corner Plate 1x2x2',0.07),
      ('b037','3024','bc28','Plate 1x1',0.06),
	  ('b038','3023','bc28','Plate 1x2',0.07),
      ('b039','3623','bc28','Plate 1x3',0.07),
      ('b040','3710','bc28','Plate 1x4',0.10),
      ('b041','3666','bc28','Plate 1x6',0.14),
	  ('b042','3460','bc28','Plate 1x8',0.17),
      ('b043','3832','bc28','Plate 2x10',0.24),
	  ('b044','2445','bc28','Plate 2x12',0.33),
      ('b045','4282','bc28','Plate 2x16',0.48),
	  ('b046','3022','bc28','Plate 2x2',0.10),
      ('b047','3021','bc28','Plate 2x3',0.14),
	  ('b048','3020','bc28','Plate 2x4',0.14),
      ('b049','3795','bc28','Plate 2x6',0.18),
      ('b050','3034','bc28','Plate 2x8',0.24),
      ('b051','3030','bc28','Plate 4x10',0.51),
	  ('b052','3029','bc28','Plate 4x12',0.67),
      ('b053','3031','bc28','Plate 4x4',0.20),
	  ('b054','6179','bc28','Plate 4x4 W/ 4 knobs',0.20),
      ('b055','3032','bc28','Plate 4x6',0.41),
	  ('b056','3035','bc28','Plate 4x8',0.44),
      ('b057','3958','bc28','Plate 6x6',0.48),
	  ('b058','3036','bc28','Plate 6x8',0.64),
      ('b059','2412','bc28','Radiator Grille 1x2',0.06),
      ('b060','73200','bc17','Mini Body Lower Part',0.38),
      ('b061','41879','bc17','Mini Leg',0.27),
	  ('b062','76382','bc17','Mini Upper Part',0.53),
      ('b063','3626','bc19','Mini Head',0.07),
	  ('b064','21023','bc19','Mini Head W/ Aviators',0.16),
      ('b065','99566','bc19','Mini Head No 891',0.16);

Select * from Bricks;

   
-- Insert Test Data into set themes --
-- List of set themes comes from https://en.wikipedia.org/wiki/List_of_Lego_themes --
INSERT INTO setThemes (stID, name)
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
      
Select * from setThemes;


-- Add sets test data --
-- Lego Set numbers explained at https://goo.gl/KEssUA --
INSERT INTO sets(sid, setNum, theme, name, pieceNum, priceUSD)
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
      
Select * from sets;


  
      
      
      
		
        
        