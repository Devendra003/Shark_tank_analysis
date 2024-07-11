create database sharktank_analysis

use sharktank_analysis

select * from sharktank_analysis




---how many pitches have done there?

select count(Brand)total_pitches from sharktank_analysis



---total no. of episodes?

select count(distinct Ep_No )total_episodes from sharktank_analysis




---how many pitches converted into a deal?


select count([Amount Invested lakhs])converted_into_deal from sharktank_analysis
where [Amount Invested lakhs] >'0'



---total no. of pitches and how many pitches converted in a deal?


select count(*)total_pitches,sum(deal_converted)convert_into_deal from
(select [Amount Invested lakhs],case when [Amount Invested lakhs]>0 then 1 
else 0 end deal_converted from sharktank_analysis)a



---success percentage of the converted pitches out of the total pitches? 

select convert_into_deal*100/total_pitches as success_percentage from
(select count(*)total_pitches,sum(deal_converted)convert_into_deal from
(select [Amount Invested lakhs],case when [Amount Invested lakhs]>0 then 1 
else 0 end deal_converted from sharktank_analysis)a)b



---total no. of male and female participants?


select sum(male)total_male,sum(female)total_female from sharktank_analysis


---ratio of male to female?

select sum(male)/sum(female)Ratio from sharktank_analysis



---total invested ammount?



select sum([Amount Invested lakhs])total_investment_in_lakhs from sharktank_analysis


---avg equity taken by the sharks?


select avg(a.[Equity Taken %])from
(select * from sharktank_analysis
where [Equity Taken %]>'0')a



---highest deal of the shark tank?


select max([Amount Invested lakhs])max_amnt_in_lakhs from sharktank_analysis



---highest equity taken by the shark


select max([Equity Taken %]) from sharktank_analysis




---among all of the pitches at least 1 woman should be there so count the women?


select sum(a.female)cnt_of_women from
(select * from sharktank_analysis
where Female>=1)a


---pitches which have converted into deal having atleast one woman


select sum(a.Female)cnt_feamle from
(select * from sharktank_analysis
where deal !='no deal' and female>=1)a


---avg ammount invested per deal

select avg(a.[Amount Invested lakhs])avg_amnt_in_lakhs from
(select * from sharktank_analysis
where deal !='no deal')a


---total no. of members according to their age group


select [Avg age], sum(male+female) total_members from sharktank_analysis
where [Avg age] !='null'
group by [Avg age] 



---total no. of male and female according to their age group



select sum(male)male,sum(female)female,[Avg age] from sharktank_analysis
where [Avg age] is not null
group by [Avg age] 


---which age group people frequently come


select [Avg age],count([Avg age])cnt from sharktank_analysis
group by [Avg age]
order by cnt desc


---most famous location from where most of the pitchers come


select Location,count(Location)cnt_pitchers from sharktank_analysis
group by [Location]
order by cnt_pitchers desc


---from which sector most of the startups coming from?


select sector,count(sector)cnt_startup from sharktank_analysis
group by Sector
order by cnt_startup desc


---count of deals sharks having



select Partners,count(Partners)cnt_partnership from sharktank_analysis
where Partners != '-'
group by Partners
order by cnt_partnership desc


---which shark have most no. of deals? 



select a.value,count(a.value)cnt_of_deal from 
(select Partners,value from sharktank_analysis
cross apply string_split(Partners,'-')
where Partners ! ='-')a group by a.value
order by cnt_of_deal desc




---making the matrix

select * from sharktank_analysis


---no. of days ashneer present

select count([Ep_No])present_days from sharktank_analysis 
where [Ashneer Amount Invested] is not null




---no. of days ashneer absent


select count([Ep_No])absent_days from sharktank_analysis 
where [Ashneer Amount Invested] is null




---no. of deals ashneer have


select count([Ep_No])no_of_deals_ashneer_have from sharktank_analysis 
where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested] !=0




---total amount invested by ashneer and avg equity taken by ashneer?


select sum([Ashneer Amount Invested])total_sum, avg([Ashneer Equity Taken %])avg_equit_taken 
from sharktank_analysis
where [Ashneer Equity Taken %] !=0 and [Ashneer Equity Taken %] is not null



---join the data of no. of days ashneer present,ashneer have deals,avg equity taken and total 
---sum invested



select a.shark_name,a.present_days,b.no_of_deals_ashneer_have,c.avg_equit_taken,c.total_sum_invested from

(select 'ashneer' as shark_name, count([Ep_No])present_days from sharktank_analysis 
where [Ashneer Amount Invested] is not null)a
join 

(select 'ashneer' as shark_name, count([Ep_No])no_of_deals_ashneer_have from sharktank_analysis 
where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested] !=0)b

on a.shark_name=b.shark_name
join


(select 'ashneer' as shark_name, sum([Ashneer Amount Invested])total_sum_invested, 
avg([Ashneer Equity Taken %])avg_equit_taken from sharktank_analysis
where [Ashneer Equity Taken %] !=0 and [Ashneer Equity Taken %] is not null)c

on b.shark_name=c.shark_name



---join the data of no. of days aman present,aman have deals,avg equity taken and total 
---sum invested


select a.shark_name,a.present_days,b.no_of_deals_aman_have,c.avg_equit_taken,c.total_sum_invested from

(select 'aman' as shark_name, count([Ep_No])present_days from sharktank_analysis 
where [Aman Amount Invested] is not null)a
join 

(select 'aman' as shark_name, count([Ep_No])no_of_deals_aman_have from sharktank_analysis 
where [Aman Amount Invested] is not null and [Aman Amount Invested] !=0)b

on a.shark_name=b.shark_name
join


(select 'aman' as shark_name, sum([Aman Amount Invested])total_sum_invested, 
avg([Aman Equity Taken %])avg_equit_taken from sharktank_analysis
where [Aman Equity Taken %] !=0 and [Aman Equity Taken %] is not null)c

on b.shark_name=c.shark_name




---join the total data of ashneer and aman


select a.shark_name,a.present_days,b.no_of_deals_ashneer_have,c.avg_equit_taken,c.total_sum_invested from

(select 'ashneer' as shark_name, count([Ep_No])present_days from sharktank_analysis 
where [Ashneer Amount Invested] is not null)a
join 

(select 'ashneer' as shark_name, count([Ep_No])no_of_deals_ashneer_have from sharktank_analysis 
where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested] !=0)b

on a.shark_name=b.shark_name
join


(select 'ashneer' as shark_name, sum([Ashneer Amount Invested])total_sum_invested, 
avg([Ashneer Equity Taken %])avg_equit_taken from sharktank_analysis
where [Ashneer Equity Taken %] !=0 and [Ashneer Equity Taken %] is not null)c

on b.shark_name=c.shark_name


union all


select a.shark_name,a.present_days,b.no_of_deals_aman_have,c.avg_equit_taken,c.total_sum_invested from

(select 'aman' as shark_name, count([Ep_No])present_days from sharktank_analysis 
where [Aman Amount Invested] is not null)a
join 

(select 'aman' as shark_name, count([Ep_No])no_of_deals_aman_have from sharktank_analysis 
where [Aman Amount Invested] is not null and [Aman Amount Invested] !=0)b

on a.shark_name=b.shark_name
join


(select 'aman' as shark_name, sum([Aman Amount Invested])total_sum_invested, 
avg([Aman Equity Taken %])avg_equit_taken from sharktank_analysis
where [Aman Equity Taken %] !=0 and [Aman Equity Taken %] is not null)c

on b.shark_name=c.shark_name



---which is the startup in which the highest amount has been invested in each domain/sector


select * from
(select brand,sector,[Amount Invested lakhs],DENSE_RANK() over
(partition by sector order by [Amount Invested lakhs] desc)rnk
from sharktank_analysis)a where rnk=1 and sector is not null
order by [Amount Invested lakhs] desc
