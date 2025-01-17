# Life Expectancy Data Cleaning Project
# 1. Remove Duplicates
# 2. Standardize the Data
# 3. Null Values or blank values
# 4. Remove any columns 

select *
from worldlifeexpectancy
;

# 1. REMOVING DUPLICATES
#identify duplicates
Select country, year, concat(country, year), count(concat(country, year))
from worldlifeexpectancy
group by country, year, concat(country,year)
having count(concat(country,year)) > 1
;

#DELETE DUPLICATES
Delete from worldlifeexpectancy
WHERE 
	ROW_ID IN (
				select ROW_ID
				from(
					select row_id, 
					concat(country,year),
					row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
					from worldlifeexpectancy) as row_table
					where row_num > 1)
;

# 2. NO NEED TO STANDARDIZE DATA

# 3. NULL AND BLANK VALUES
#BLANK VALUES (STATUS)

#IDENTIFY BLANK STATUS 
 SELECT *
 FROM worldlifeexpectancy
 WHERE STATUS = ''
 ;
 


UPDATE worldlifeexpectancy AS T1
jOIN worldlifeexpectancy AS T2
	ON T1.COUNTRY = T2.COUNTRY
SET T1.STATUS = 'DEVELOPING'
WHERE T1.STATUS = ''
AND T2.STATUS <> ''
AND T2.STATUS = 'DEVELOPING'
;

UPDATE worldlifeexpectancy AS T1
jOIN worldlifeexpectancy AS T2
	ON T1.COUNTRY = T2.COUNTRY
SET T1.STATUS = 'DEVELOPED'
WHERE T1.STATUS = ''
AND T2.STATUS <> ''
AND T2.STATUS = 'DEVELOPED'
;


#BLANK VALUES (LIFE EXPECTANCY) USE AVERAGE OF SURROUNDING YEARS TO POPULATE MISSING VALUES

 SELECT *
 FROM worldlifeexpectancy
 WHERE `Life expectancy` = ''
 ;

#FINDING AVERAGE 
SELECT T1.COUNTRY, T1.YEAR, T1.`LIFE EXPECTANCY`,
T2.COUNTRY, T2.YEAR, T2.`LIFE EXPECTANCY`,
T3.COUNTRY, T3.YEAR, T3.`LIFE EXPECTANCY`,
ROUND((T2.`LIFE EXPECTANCY` + T3.`LIFE EXPECTANCY`)/2, 1)
FROM worldlifeexpectancy AS T1
JOIN worldlifeexpectancy AS T2
	ON T1.COUNTRY = T2.COUNTRY
    AND T1.YEAR = T2.YEAR - 1
JOIN worldlifeexpectancy AS T3
	ON T1.COUNTRY = T3.COUNTRY
    AND T1.YEAR = T3.YEAR + 1
 WHERE T1.`Life expectancy` = ''
 ;
 
#UPDATE TABLE
UPDATE worldlifeexpectancy AS T1
JOIN worldlifeexpectancy AS T2
	ON T1.COUNTRY = T2.COUNTRY
    AND T1.YEAR = T2.YEAR - 1
JOIN worldlifeexpectancy AS T3
	ON T1.COUNTRY = T3.COUNTRY
    AND T1.YEAR = T3.YEAR + 1
SET T1.`LIFE EXPECTANCY` = ROUND((T2.`LIFE EXPECTANCY` + T3.`LIFE EXPECTANCY`)/2, 1)
WHERE T1.`LIFE EXPECTANCY` = ''
;

# 4. NO COLUMNS TO REMOVE