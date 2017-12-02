-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 2017/12/04 --
-- Assignment: Database Design Project --
-- File name: legoDB.sql --

-- Clear database of tables --
DROP TABLE IF EXISTS Bricks;
DROP TABLE IF EXISTS Color;
DROP TABLE IF EXISTS bSets;


-- Bricks --
CREATE TABLE Bricks (
    bid			SERIAL PRIMARY KEY,
    bnum		VARCHAR(20) NOT NULL,
	lenByStud	INT,
    widByStud	INT,
    name		TEXT,
    priceUSD	NUMERIC(10,2),
    btype		VARCHAR(20) CHECK(btype IN('brick', 'plate', 'tile', 'specialty', 'miniFigure'))
);

-- Color --
CREATE TABLE Color(
    cid			SERIAL PRIMARY KEY,
    colorNum	VARCHAR(20) NOT NULL,
    colorName	TEXT NOT NULL
);


-- Insert test data into Bricks --
INSERT INTO Bricks(bnum, lenByStud, widByStud, name, priceUSD, bType)
VALUES(3005, 1, 1, '1x1 Brick', 0.07, 'brick');
