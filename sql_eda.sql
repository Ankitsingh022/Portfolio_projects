-- Exploatry data analysis

SELECT * 
from layoffs_staging2;

SELECT max(total_laid_off) ,max(percentage_laid_off)
from layoffs_staging2;

SELECT *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;

select company,SUM(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;


select min(`date`),max(`date`)
from layoffs_staging2;

select industry,SUM(total_laid_off)
FROM layoffs_staging2
group by industry
order by 2 desc;

SELECT * 
from layoffs_staging2;

select country,SUM(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc;



select YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
group by YEAR(`date`)
order by 1 desc;



select stage,SUM(total_laid_off)
FROM layoffs_staging2
group by stage
order by 2 desc;

select location,substring(`date`,1,7),SUM(total_laid_off)
FROM layoffs_staging2
group by location,substring(`date`,1,7)
order by 3 desc;

SELECT * 
from layoffs_staging2;

with Rolling_total AS(
SELECT substring(`date`,1,7) AS `MONTH` ,sum(total_laid_off) AS total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc
)

SELECT `MONTH`,total_off,sum(total_off) OVER (order by `MONTH`) AS rolling_table
FROM  Rolling_total;

select company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
group by company,YEAR(`date`)
order by 3 desc;

-- cte1 
with Company_year (company,years,total_laid_off) AS(
select company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
group by company,YEAR(`date`)
),
-- cte 2
company_year_rank AS(
select*, DENSE_RANK() OVER (partition by years ORDER by total_laid_off DESC) as rankings
FROM Company_year
WHERE years is not null
)
select*
FROM company_year_rank
where rankings<=5






