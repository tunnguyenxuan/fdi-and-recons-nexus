-- Joining Table for Necessary Data --

select * into Fact_DataforStata from
(
	select r.country_name, f.country_code, r.yr, r.RenConsRatio as rencons, 
	f.fdival as fdi, i.voi_iq, i.pol_iq, i.reg_iq, i.gov_iq, i.con_iq,i.rul_iq,
	c.CPI_val as cpi, g.GDPpcGrowth_val as gdppc_growth, il.Inc_val as income_level
	from Dep_RenCon as r
	left join Indep_FDI as f
	on r.country_name = f.country_name and r.yr=f.yr
	left join Mod_IQ as i
	on i.country_name=r.country_name and i.yr=r.yr
	left join Conl_CPI as c
	on c.country_name=r.country_name and c.yr=r.yr
	left join Conl_GDPpcGrowth as g
	on g.country_name=r.country_name and g.yr=r.yr
	left join Mod_Inc as il
	on il.country_name=r.country_name and il.yr=r.yr
	order by country_name, yr
) as Finalized_Data