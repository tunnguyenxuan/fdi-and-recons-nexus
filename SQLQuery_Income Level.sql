-- Create Income_Level Table
create table Income_Level
(
  country_name varchar(50) not null, 
  country_code varchar(10) not null,
  fy2010 int null, 
  fy2011 int null, 
  fy2012 int null, 
  fy2013 int null, 
  fy2014 int null, 
  fy2015 int null, 
  fy2016 int null, 
  fy2017 int null,
  fy2018 int null, 
  fy2019 int null, 
  fy2020 int null, 
  fy2021 int null, 
  fy2022 int null
) --Input Data into Table

-- Data Cleaning & Transformation --
select * into Mod_Inc from
(
	select country_name, country_code, right(year,4) as yr, Inc_val 
	from Income_Level
	UNPIVOT
	(
		Inc_val for year in 
		(
			fy2010, fy2011, fy2012, fy2013, fy2014, 
			fy2015, fy2016, fy2017, fy2018, fy2019, 
			fy2020, fy2021, fy2022
		)
	) as UNPIVOT_TABLE
) as Inc_Table_adj

