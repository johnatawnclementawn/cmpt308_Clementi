-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 11/27/2017 --
-- Assignment: DBS Lab 10 --
-- File name: lab10Deliverables --

--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;

/*

--
-- An example stored procedure ("function")
--
create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;

select get_courses_by_credits(0, 'results');
Fetch all from results;

*/


-- Number 1 --
create or replace function get_prereqs_for_courses(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int       := $1;
   resultset    REFCURSOR := $2;
begin
   open resultset for 
      select preReqNum
      from   Prerequisites
       where  courseNum = courseNumber;
   return resultset;
end;
$$ 
language plpgsql;

select get_prereqs_for_courses(499, 'results');
Fetch all from results;



-- Number 2 --
create or replace function is_prereqs_for_courses(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int       := $1;
   resultset    REFCURSOR := $2;
begin
   open resultset for 
      select courseNum
      from   Prerequisites
       where  preReqNum = courseNumber;
   return resultset;
end;
$$ 
language plpgsql;

select is_prereqs_for_courses(120, 'results');
Fetch all from results;


