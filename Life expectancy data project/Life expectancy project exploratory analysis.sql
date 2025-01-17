#data cleaning project 1 life expectancy - exploritory analysis 

#min vs max by country
select country, min(`life expectancy`), max(`life expectancy`),
round(max(`life expectancy`) - min(`life expectancy`), 1) as life_increase
from worldlifeexpectancy
group by country
having min(`life expectancy`) <> 0
and max(`life expectancy`) <> 0
order by life_increase asc
;


# life expectancy by year (world as a whole)
select year, round(avg(`life expectancy`),2)
from worldlifeexpectancy
where `life expectancy`<> 0
group by year
order by year
;


# Life exp vs GDP
select Country, ROUND(AVG(`life expectancy`), 1) as Life_exp, Round(AVG(GDP), 2) as GDP
from worldlifeexpectancy
group by Country
having Life_exp > 0
and GDP > 0
order by GDP desc
;





# Life exp vs GDP
select 
sum(Case when GDP >= 1500 then 1 else 0 end) as high_gdp_count,
Avg(case when  GDP >= 1500 then `life expectancy` Else NULL End) High_GDP_Life_expectancy,
sum(Case when GDP <= 1500 then 1 else 0 end) as low_gdp_count,
Avg(case when  GDP <= 1500 then `life expectancy` Else NULL End) low_GDP_Life_expectancy
from worldlifeexpectancy
;



# Life exp vs country status

select status, ROUND(AVG(`life expectancy`), 1)
from worldlifeexpectancy
group by status
;



select status, count(distinct country), ROUND(AVG(`life expectancy`), 1)
from worldlifeexpectancy
group by status
;



# BMI by country

select Country, ROUND(AVG(`life expectancy`), 1) as Life_exp, Round(AVG(BMI), 2) as BMI
from worldlifeexpectancy
group by Country
having Life_exp > 0
and BMI > 0
order by BMI asc
;



# Adult Mortality (rolling total)

Select country, year, `life expectancy`, `Adult Mortality`,
Sum(`adult mortality`) over(partition by country order by year) as rolling_total
from worldlifeexpectancy
;



