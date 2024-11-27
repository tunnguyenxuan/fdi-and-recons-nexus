-- Create Institutional Quality table -- 
create table IQ (
  country_name varchar(50) not null, 
  country_code varchar(10) not null,
  indicator varchar(50) not null, 
  fy2010 decimal(3,2) null, 
  fy2011 decimal(3,2) null, 
  fy2012 decimal(3,2) null, 
  fy2013 decimal(3,2) null, 
  fy2014 decimal(3,2) null, 
  fy2015 decimal(3,2) null, 
  fy2016 decimal(3,2) null, 
  fy2017 decimal(3,2) null, 
  fy2018 decimal(3,2) null, 
  fy2019 decimal(3,2) null, 
  fy2020 decimal(3,2) null, 
  fy2021 decimal(3,2) null, 
  fy2022 decimal(3,2) null
  )-- Input data into table

  -- Data Cleaning & Transformation --
  select * into Mod_IQ
  from
  (
	  select country_name, country_code, yr, [VoiceandAccountability] as voi_iq, [Political StabilityNoViolence] as pol_iq, 
	  [GovernmentEffectiveness] as gov_iq, [RegulatoryQuality] as reg_iq, [RuleofLaw] as rul_iq, [ControlofCorruption] as con_iq
	  from
	  (
		  select country_name, country_code, indicator, right(year,4) as yr, IQ_val
		  from IQ
		  UNPIVOT
		  (
			IQ_val for year in 
				(
				  fy2010, fy2011, fy2012, fy2013, fy2014, 
				  fy2015, fy2016, fy2017, fy2018, fy2019, 
				  fy2020, fy2021, fy2022
				) 
		  )as UNPIVOT_TABLE
	   ) as IQ_TABLE
	   PIVOT
	   (
		max(IQ_val) for indicator in
			(
			[VoiceandAccountability], [Political StabilityNoViolence], [GovernmentEffectiveness], 
			 [RegulatoryQuality], [RuleofLaw], [ControlofCorruption]
			)
		) as PIVOT_TABLE
	) as IQTable_adj

			
	


