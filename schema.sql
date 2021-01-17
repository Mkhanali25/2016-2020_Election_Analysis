-- Create a table for the full dataset 
CREATE TABLE aggregrate(
	county varchar(100) NOT NULL,
	state1 varchar(4) NOT NULL,
	votes16_Donald_Trump float NOT NULL,
    votes16_Hillary_Clinton float NOT NULL,
	total_votes16 float NOT NULL,
	total_votes20 float NOT NULL,
	votes20_Donald_Trump float NOT NULL,
    votes20_Joe_Biden float NOT NULL,
	cases float NOT NULL,
	deaths float NOT NULL,
	men float NOT NULL,
	Women float NOT NULL,
	Hispanic float NOT NULL,
	White float NOT NULL,
	Black float NOT NULL,
	Native1 float NOT NULL,
	Asian float NOT NULL,
	Pacific float NOT NULL,
	TotalPop float NOT NULL,
	Poverty float NOT NULL,
	Income float NOT NULL,
	IncomePerCap float NOT NULL,
	Unemployment float NOT NULL,
	PRIMARY KEY (county, state1),
	UNIQUE (county,state1)
);
-- Create a table for 2016 Election Results
CREATE TABLE Election_Results16 (
    county varchar(40) NOT NULL,
	state1 varchar(4) NOT NULL,
	votes16_Donald_Trump float NOT NULL,
    votes16_Hillary_Clinton float NOT NULL,
	total_votes16 float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);
-- Create a table for 2020 Election Results
CREATE TABLE Election_Results20 (
    county varchar(40) NOT NULL,
	state1 varchar(4) NOT NULL,
	votes20_Donald_Trump float NOT NULL,
    votes20_Joe_Biden float NOT NULL,
	total_votes20 float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);

-- Creating tables for Covid Cases by State
CREATE TABLE Covid (
	county varchar(40) NOT NULL,
	state1 varchar(4) NOT NULL,
	cases float NOT NULL,
	deaths float NOT NULL,
	TotalPop float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);
-- Creating Tables for Wealth_Distribution
CREATE TABLE Wealth_Distribution (
	county varchar(40) NOT NULL,
	state1 varchar(4) NOT NULL,
	Poverty float NOT NULL,
	Income float NOT NULL,
	IncomePerCap float NOT NULL,
	Unemployment float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);

-- Creating a Demographics table
CREATE TABLE Demographics(
	county varchar(100) NOT NULL,
	state1 varchar(4) NOT NULL,
	TotalPop float NOT NULL,
	Hispanic float NOT NULL,
	White float NOT NULL,
	Black float NOT NULL,
	Native1 float NOT NULL,
	Asian float NOT NULL,
	Pacific float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);

-- Create a Gender table
CREATE TABLE gender(
	county varchar(100) NOT NULL,
	state1 varchar(4) NOT NULL,
	men float NOT NULL,
	Women float NOT NULL,
	Foreign KEY (county, state1) REFERENCES aggregrate (county, state1),
	PRIMARY KEY (county, state1)
);

	
-- Perform a join on the election tables
SELECT e16.county, e16.state1, e16.votes16_Donald_Trump,
	e16.votes16_hillary_clinton, e16.total_votes16,
	e20.votes20_Donald_trump, e20.votes20_joe_biden, e20.total_votes20
	INTO elections_combined 
	FROM Election_results16 as e16
	JOIN election_results20 as e20
	ON e16.state1 = e20.state1
	AND e16.county = e20.county
;

-- Perform a join on 2020 Election results and Covid table
SELECT e20.county, e20.state1, e20.votes20_Donald_trump, e20.votes20_joe_biden, 
	e20.total_votes20, cc.cases, cc.deaths, cc.totalpop
	INTO covid_impact
	FROM election_results20 as e20
	JOIN covid as cc
	ON e20.state1 = cc.state1
	AND e20.county = cc.county
;

-- Perform a join on Coivd and Wealth Distribution tables
SELECT cc.county, cc.state1, cc.cases, cc.deaths, cc.totalpop,
	wd.Poverty, wd.Income, wd.Unemployment
	INTO Economic_impact
	FROM Covid as cc
	JOIN wealth_distribution as wd
	ON cc.state1 = wd.state1
	AND cc.county = wd.county
;

