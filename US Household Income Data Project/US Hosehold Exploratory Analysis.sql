# us household income exploratroy anaysis 

# total land/water by state
Select State_name, Sum(ALand), Sum(AWater)
from ushouseholdincome
group by state_name
order by 3 desc
Limit 10
;


#joining income and statistics tables
Select *
from ushouseholdincome as u
Right join ushouseholdincome_statistics as us
	on u.id = us.id
;


#avg mean/median by state
Select u.State_Name, round(avg(mean),1), round(avg(median),1)
from ushouseholdincome as u
Right join ushouseholdincome_statistics as us
	on u.id = us.id
where mean <> 0
group by u.State_Name
order by 3 asc
Limit 10
;



# mean/median by type
Select Type, count(type),round(avg(mean),1), round(avg(median),1)
from ushouseholdincome as u
Right join ushouseholdincome_statistics as us
	on u.id = us.id
where mean <> 0
group by Type
order by 4 desc
;




Select u.State_Name, city, Round(avg(mean),1), round(avg(median),1), count(city)
from ushouseholdincome as u
Right join ushouseholdincome_statistics as us
	on u.id = us.id
where mean <> 0
group by u.state_name, city
order by 5 desc
;


