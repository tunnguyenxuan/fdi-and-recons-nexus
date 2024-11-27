-- Create CPI table -- 
create table CPI (
  country_name varchar(50) not null, 
  country_code varchar(10) not null,
  indicator varchar(50) not null, 
  fy2010 decimal(12,7) null, 
  fy2011 decimal(12,7) null, 
  fy2012 decimal(12,7) null, 
  fy2013 decimal(12,7) null, 
  fy2014 decimal(12,7) null, 
  fy2015 decimal(12,7) null, 
  fy2016 decimal(12,7) null, 
  fy2017 decimal(12,7) null, 
  fy2018 decimal(12,7) null, 
  fy2019 decimal(12,7) null, 
  fy2020 decimal(12,7) null, 
  fy2021 decimal(12,7) null, 
  fy2022 decimal(12,7) null
  )-- Input data into table

  -- Data Cleaning & Transformation --
select * into Conl_CPI 
from
(
	select country_name, country_code, right(year,4) as yr, CPI_val
	from CPI
	UNPIVOT
	(
		CPI_val for year in
		(
			fy2010, fy2011, fy2012, fy2013, fy2014, 
			fy2015, fy2016, fy2017, fy2018, fy2019, 
			fy2020, fy2021, fy2022
		)
	) as UNPIVOT_TABLE
) as CPITable_adj


