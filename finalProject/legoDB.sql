-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 2017/12/04 --
-- Assignment: Database Design Project --
-- File name: legoDB.sql --

-- Clear database of tables --


--DROP TABLE IF EXISTS bSets;
DROP TABLE IF EXISTS Bricks;
DROP TABLE IF EXISTS Colors;
DROP TABLE IF EXISTS bCategories;


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
    bid			CHAR(4) PRIMARY KEY NOT NULL,
    elementID	VARCHAR(20) NOT NULL, -- ElementID is Lego's unique identifier (based on type of brick and color) --
    designID	VARCHAR(8) NOT NULL, -- designID is Lego's identifier for a type of brick --
	category	INT NOT NULL REFERENCES bCategory(bcID),
    color		INT NOT NULL REFERENCES colors(cid),
    name		TEXT,
    priceUSD	NUMERIC(10,2)
);


-- Set Theme --
CREATE TABLE setTheme(
    stID	CHAR(4) PRIMARY KEY NOT NULL,
    name	TEXT NOT NULL
);

S
-- Designer --
CREATE TABLE designers(
    did 			CHAR(4) PRIMARY KEY NOT NULL,
    fname			TEXT NOT NULL,
    lname			TEXT NOT NULL,
    officeAddress	TEXT,
    officeCity		TEXT,
    officeCountry	TEXT,
    favTheme		CHAR(4) REFERENCES setTheme(stID),
    favBrick		CHAR(4) REFERENCES bricks(bid)
);


-- Sets --
CREATE TABLE sets(
    sid			CHAR(4) PRIMARY KEY NOT NULL,
    name		TEXT,
    priceUSD	NUMERIC(10,2),
    designer	INT NOT NULL REFERENCES 
);

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
   

 -- Insert test data into Bricks --
INSERT INTO Bricks(bnum, lenByStud, widByStud, name, priceUSD, bType)
VALUES(3005, 1, 1, '1x1 Brick', 0.07, 'brick');

     
      
      
      
		
        
        