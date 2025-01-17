# US Hosehold Income Project

select *
from ushouseholdincome
;

Select *
from ushouseholdincome_statistics
;

#rename column 
ALTER Table ushouseholdincome_statistics rename column `ï»¿id` to `id`;

# Identify Duplicates (no duplicates in ushouseholdincome_statistics 
Select id, count(id)
from ushouseholdincome
group by id
having count(id) > 1
;

#Delete Duplicates
Delete from ushouseholdincome
where row_id IN(
	Select row_id
	From (
		Select row_id, id, 
		row_number() over(partition by id order by id) as row_num
		from ushouseholdincome) as duplicates
where row_num > 1)
;

#checking state names for spelling
Select state_name, count(state_name)
from ushouseholdincome
group by state_name
;

# Replacing misspelled georgia
Update ushouseholdincome
set state_name = 'Georgia'
where state_name = 'georia'
;

#checking state abreviations 
Select Distinct State_ab
from ushouseholdincome
order by 1
;

#populating blank place
Select *
from ushouseholdincome
where County = 'Autauga County'
order by 1
;

Update ushouseholdincome
set place = 'Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont'
;


#checking type for discrpancies
Select Type, Count(type)
from ushouseholdincome
group by type
;

#changing boroughs to borough
Update ushouseholdincome
set type = 'Borough'
where type = 'Boroughs';



#Locating zero,blank or null values in land and water
select ALand, AWater
from ushouseholdincome
where AWater = 0 or AWater = '' or AWater IS NUll
where ALand = 0 or ALand = '' or ALand IS NUll
;


select ALand, AWater
from ushouseholdincome
where ALand = 0 or ALand = '' or ALand IS NUll
;





