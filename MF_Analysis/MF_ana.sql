select * from m_data
select distinct(category) from mutual_fund_analysis.m_data
select * from mutual_fund_analysis.m_data where category='solution oriented'
select distinct(sub_category) from m_data where category = 'equity'
select distinct(sub_category) from m_data where category = 'hybrid'
select distinct(sub_category) from m_data where category = 'debt'
select distinct * from m_data where category = 'debt'
-- Analysing equity funds With Rating is higher
select * from m_data where rating >= 4 and category in ('equity')

-- we can see that risk_level is 6 for all equity funds

-- calculating avg sd
select avg(sd) from m_data where rating >= 4 and category in ('equity')

-- low volatile funds
select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity'))

-- higher alpha indicate funds perform better than benchmark of fund category

select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0

-- beta shows funds response to market volatility low beta ratio shows that funds totally not driven by market, beta should be less than 1

select * from m_data where rating >= 4 and category in ('equity') 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1

-- we need diversified fund not a sector specific because they are untrustable and carry high risk we look at large, mid, flexi, ELSS

select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds') and beta < 1

-- sharpe ratio shows return per unit of risk so for this should be high for given category of fund

select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds') and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('equity') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds'))

-- lets see past performance , order by funds with higher return in 5 yr , it automatically sort new funds at bottom

select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds') and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('equity') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds'))
order by returns_5yr desc

-- lets see funds with expense ratio less than 1 

select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds') and expense_ratio <= 1 and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('equity') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1
and sub_category in ('ELSS Mutual Funds','Large Cap Mutual Funds','Flexi Cap Funds','Large & Mid Cap Funds','Mid Cap Mutual Funds'))
order by returns_5yr desc

-- creating view for top midcap fund

create view Top_mid_fund as
select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('Mid Cap Mutual Funds') and expense_ratio <= 1 and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('equity') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1
and sub_category in ('Mid Cap Mutual Funds'))
order by returns_5yr desc

-- creating view for top small cap and sectoral fund

alter view Top_small_fund as
select * from m_data where rating >= 4 and category in ('equity')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 
and sub_category in ('small Cap Mutual Funds','Sectoral / Thematic Mutual Funds'
) and expense_ratio <= 1 and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('equity') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('equity') and risk_level > 1) and alpha > 0 and beta < 1
and sub_category in ('small Cap Mutual Funds','Sectoral / Thematic Mutual Funds'
))
order by returns_5yr desc

-- cerating view for top hybrid fund 

alter view Top_hybrid_fund as
select * from m_data where rating >= 4 and category in ('hybrid')
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('hybrid')) and alpha > 0 
and expense_ratio <= 1 and
sharpe >= (select avg(sharpe) from m_data where rating >= 4 and category in ('hybrid') and risk_level > 1 
and sd<(select avg(sd) from m_data where rating >= 4 and category in ('hybrid')) and alpha > 0 and beta < 1)
order by returns_5yr desc


select * from top_large_fund

-- seeing fund manager performance
create view top_manager as
select fund_manager,count(fund_manager) as c,avg(rating) as r,avg(returns_3yr) as re from m_data group by fund_manager having r>=4 and c>1 order by re desc limit 10









