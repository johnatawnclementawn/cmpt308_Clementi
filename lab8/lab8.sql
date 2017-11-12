-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 11/12/2017 --
-- Assignment: DBS Lab 8 --
-- File name: lab8Queries --


DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS ActsIn;
DROP TABLE IF EXISTS Directs;
DROP TABLE IF EXISTS Movies;


-- People --
CREATE TABLE People (
  pid           char(3) not null,
  fname         text,
  lname         text, 
  city          text,
  state         text,
  zip           char(5),
  spouse_fname  text,
  spouse_lname  text,
 primary key(pid)
);


-- Actors --
CREATE TABLE Actors (
  aid            char(3) not null,
  pid            char(3) not null references People(pid),
  haircolor      text,
  eyecolor       text,
  height_inches  numeric(5,2),
  weight_lbs     numeric(5,2),
  favColor       text,
  SAG_anvDate    date,
 primary key(aid)
);        


-- Directors --
CREATE TABLE Directors (
  did            char(3) not null,
  pid            char(3) not null references People(pid),
  filmSchool     text,
  DAG_anvDate    date,
  lensMaker      text,
 primary key(did)
);


-- Movies -- 
CREATE TABLE Movies (
  MPAA_num         char(6) not null,
  name             text,
  yearReleased     date,
  domBoxOffice_USD decimal(5,2),
  forBoxOffice_USD decimal(5,2),
  DVDSales_USD     decimal(5,2),
 primary key(MPAA_num)
);


-- ActsIn --
CREATE TABLE ActsIn (
  aid        char(3) not null references Actors(aid),
  MPAA_num   char(6) not null references Movies(MPAA_num),
primary key(aid, MPAA_num)
);


-- Directs --
CREATE TABLE Directs (
  did        char(3) not null references Actors(aid),
  MPAA_num   char(6) not null references Movies(MPAA_num),
primary key(did, MPAA_num)
);


-- Select directors who have worked with actor Roger Moore --
select d.name
from directors d INNER JOIN directs dt ON d.did = dt.did
                 INNER JOIN movies mo ON dt.MPAA_num = mo.MPAA_num
                 INNER JOIN actsin ai ON mo.MPAA_num = ai.MPAA_num
                 INNER JOIN actors a ON ai.aid = a.aid
where a.fname = "Roger" AND a.lname = "Moore";




