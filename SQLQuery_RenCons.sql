-- Create Renewable Energy Consumption table -- 
create table RenCons (
  country varchar(50) not null, 
  product varchar(50) not null, 
  flow varchar(30) not null, 
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
) -- Input Raw Data in RenCons Table -- 

-- Data Cleaning & Transformation --
select 
  * into RenCons_1 
from 
  (
    select 
      country, 
      product, 
      flow, 
      year, 
      val 
    from 
      RenCons unpivot (
        val for year in (
          fy2010, fy2011, fy2012, fy2013, fy2014, 
          fy2015, fy2016, fy2017, fy2018, fy2019, 
          fy2020, fy2021, fy2022
        )
      ) as UNPIVOT_TABLE
  ) as RenCons_adj --unpivot year columns into rows

  GO 

select * into Dep_RenCon 
from 
  (
    select 
      country as country_name, 
      right(year, 4) as yr, 
      CAST(SUM([Renewables and waste]) as float)/ CAST(SUM([Total]) as float) as RenConsRatio 
	  --converting to float for divison logicality
    from 
      (
        select 
          country, 
          product, 
          year, 
          [Residential (PJ) ], 
          [Total final consumption (PJ) ], 
          (
            [Total final consumption (PJ) ] - [Residential (PJ) ]
          ) as diff 
        from 
          RenCons_1 pivot (
            max(val) for flow in (
              [Residential (PJ) ], 
              [Total final consumption (PJ) ]
            )
          ) as PIVOT_TABLE --pivot Residental, and Total final consumption rows into columns
          ) as RenCons_pivoted pivot (
        max(diff) for product in (
          [Renewables and waste], [Total]
        )
      ) as PIVOT2_TABLE --continue to pivot Renewables and waste, and Total rows into columns
    group by 
      country, 
      right(year, 4)
  ) as RenCon_adj2 





		


