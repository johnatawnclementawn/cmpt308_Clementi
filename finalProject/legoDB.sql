-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 2017/12/04 --
-- Assignment: Database Design Project --
-- File name: legoDB.sql --

-- Clear database of tables --


DROP TABLE IF EXISTS Bricks;
DROP TABLE IF EXISTS Color;
DROP TABLE IF EXISTS bCategory;


--DROP TABLE IF EXISTS bSets;


-- Bricks --
CREATE TABLE Bricks (
    bid			SERIAL PRIMARY KEY NOT NULL,
    elementID	VARCHAR(20) NOT NULL, -- ElementID is Lego's unique identifier (based on type of brick and color) --
    designID	VARCHAR(8) NOT NULL, -- designID is Lego's identifier for a type of brick --
	category	INT NOT NULL REFERENCES bCategory(bcID),
    name		TEXT,
    priceUSD	NUMERIC(10,2)
);

-- Brick Categories --
CREATE TABLE bCategories (
    bcID	SERIAL PRIMARY KEY NOT NULL,
    name	TEXT NOT NULL
);

-- Colors --
CREATE TABLE Colors (
    cid			SERIAL PRIMARY KEY,
    num			VARCHAR(3) NOT NULL, -- Lego's Color ID
    legoName	TEXT NOT NULL, -- Official Lego color name
    comName		TEXT, -- Common name of color
);




-- Insert test data into Bricks --
INSERT INTO Bricks(bnum, lenByStud, widByStud, name, priceUSD, bType)
VALUES(3005, 1, 1, '1x1 Brick', 0.07, 'brick');


-- Insert test data into brick categories --
INSERT INTO bCategories(name)
VALUES('Animals and Creatures'),
	  ('Beams'),
      ('Botanic'),
      ('Bricks'),
      ('Bricks w/ Bows and Arches'),
      ('Bricks w/ special Bows and Angles'),
      ('Bricks, special'),
      ('Bricks, special Circles and Angles'),
      ('Bricks, Technic 4.85'),
      ('Bricks w/ slope'),
      ('Connectors'),
      ('Crains and Scaffold'),
      ('Decoration Elements'),
      ('Fences and Ladders'),
      ('Figure accessories Up/Low body'),
      ('Figure accessories Up/Low part'),
      ('Figure parts'),
      ('Figure Head Clothing'),
      ('Figure Heads and Masks'),
      ('Figure Weapons'),
      ('Figure Wigs'),
      ('Foodstuffs'),
      ('Frames, Windows, Walls, Doors'),
      ('Functional Elements'),
      ('Functional Elements, Gear Wheels and Racks'),
      ('Functional Elements, others'),
      ('Interior'),
      ('Plates'),
      ('Plates, special'),
      ('Plates, special Circles and Angles'),
      ('Rubbers and Strings'),
      ('Signs, Flags, and Poles'),
      ('Transportation, Aviation'),
      ('Transportation, Trains'),
      ('Transporation, Vehicles'),
      ('Tubes'),
      ('Tires and Rims, snap 3.2'),
      ('Tires and Rims, Technic 4.85'),
      ('Tires and Rims, special'),
      ('Wheel Base'),
      ('Windscreens and Cockpits');


-- Insert Test Data into Colors --
INSERT INTO Colors(num, legoName, comName)
VALUES(1,'White','White'),
	  (5,'Brick Yellow','Tan'),
      (18,'Nougat','Flesh'),
      (21,'Bright Red','Red'),
      (23,'Bright Blue','Blue'),
      (24,'Bright Yellow','Yellow'),
      (26,'Black','Black'),
      (28,'Dark Green','Green'),
      (37,'Bright Green','Bright Green'),
      (38,'Dark Orange','Dark Orange'),
      (102,'Medium Blue','Medium Blue'),
      (106,'Bright Orange','Orange'),
      (119,'Bright Yellowish-Green','Lime'),
      (124,'Bright Reddish Violet','Magenta'),
      (135,'Sand Blue','Sand Blue'),
      (138,'Sand Yellow','Dark Tan'),
      (140,'Earth Blue','Dark Blue'),
      (141,'Earth Green','Dark Green'),
      (151,'Sand Green','Sand Green'),
      (154,'Dark Red','Dark Red'),
      (191,'Flame Yellowish Orange','Bright Light Orange'),
      (192,'Reddish Brown','Reddish Brown'),
      (194,'Medium Stone Grey','Light Grey'),
      (199,'Dark Stone Grey','Dark Grey'),
      (208,'Light Stone Grey','Very Light Grey'),
      (212,'Light Royal Blue','Light Blue'),
      (221,'Bright Purple','Bright Pink'),
      (222,'Light Purple','Light Pink'),
      (226,'Cool Yellow','Blonde'),
      (268,'Medium Lilac','Dark Purple'),
      (283,'Light Nougat','Light Flesh'),
      (308,'Dark Brown','Dark Brown'),
      (312,'Medium Nougat','Medium Dark Flesh'),
      (321,'Dark Azur'),
      (322,'Medium Azur','Azure'),
      (323,'Aqua','Unikitty Blue'),
      (324,'Medium Lavender'),
      (325,'Lavender','Lavender'),
      (329,'White Glow','Glow-in-the-Dark'),
      (326,'Spring Yellowish Green','Unikitty Green'),
      (330,'Olive Green','Olive Green'),
      (331,'Medium-Yellowish Green','Medium Lime'),
      (40,'Transparent'),
      (41,'Transparent Red'),
      (42,'Transparent Light Blue'),
      (43,'Transparent Blue'),
      (44,'Transparent Yellow'),
      (47,'Transparent Dark Orange'),
      (48,'Transparent Green'),
      (49,'Transparent Fluorescent Green'),
      (111,'Transparent Brown (Smoke)'),
      (113,'Transparent Medium Reddish-Yellow'),
      (126,'Transparent Bright Bluish-Violet'),
      (143,'Transparent Fluorescent Blue'),
      (182,'Transparent Bright Orange'),
      (311,'Transparent Bright Green'),
      (131,'Silver','Pearl Light Grey'),
      (148,'Metallic Dark Grey','Pearl Dark Grey'),
      (294,'Phosphorescent Green','Glow-in-Dark Trans Green'),
      (297,'Warm Gold','Pearl Gold'),
      (309,'Metalized Silver'),
      (310,'Metalized Gold'),
      (315,'Silver Metallic'),
      (316,'Titanium Metallic');
      
      
      
      
      
      
		
        
        