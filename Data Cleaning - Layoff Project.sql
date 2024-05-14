#Data Cleaning
Select *
from layoffs;
#remove duplicates, standardize data, check for null or blank values and remove any columns

#creating a copy to avoid altering the raw data
CREATE TABLE layoff_staging
like layoffs;

select *
from layoff_staging;

insert layoff_staging
select *
from layoffs;

#removing the duplicates
select *,
row_number() over(partition by 
company, industry, total_laid_off, percentage_laid_off,`date`) as row_num
from layoff_staging;

with duplicates_cte as
(select *,
row_number() over(partition by 
company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country,
funds_raised_millions) as row_num
from layoff_staging)
select *
from duplicates_cte
where row_num > 1;

select *
from layoff_staging
where company = 'Casper';

create table layoff_staging2
like layoff_staging;

insert layoff_staging2
select *
from layoff_staging;

select *
from layoff_staging2;


drop table layoff_staging2;

CREATE TABLE `layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
`row_num` INT
) ;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by 
company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country,
funds_raised_millions) as row_num
from layoff_staging;

select *
from layoffs_staging2
where row_num>1;

SET SQL_SAFE_UPDATES = 0;

delete
from layoffs_staging2
where row_num>1;

SET SQL_SAFE_UPDATES = 1;

select *
from layoffs_staging2;

#standardizing the data

select company, trim(company)
from layoffs_staging2;
SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set company = trim(company);
SET SQL_SAFE_UPDATES = 1;

select distinct industry
from layoffs_staging2
order by 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct location
from layoffs_staging2;


SELECT DISTINCT location
FROM layoffs_staging2
WHERE location LIKE 'Florian%' 
   OR location LIKE 'Malm%' 
   OR location LIKE 'D%';
   
   update layoffs_staging2
   set location = "Dusseldorf"
   where location = "DÃ¼sseldorf";

 update layoffs_staging2
   set location = 'Florianapolis'
   where location like 'Florian%';
   
    update layoffs_staging2
   set location = 'Malmo'
   where location like 'Malm%';
   
   select `date`, str_to_date(`date`, '%m/%d/%Y')
   from layoffs_staging2;
   
   update layoffs_staging2
   set `date` = str_to_date(`date`, '%m/%d/%Y');
   
   alter table layoffs_staging2
   modify column `date` date;

#checking for null and blank values
   
   select *
   from layoffs_staging2
   where total_laid_off is null
   and percentage_laid_off is null;
   
   select *
   from layoffs_staging2
   where industry is null
   or industry = ''
   order by 1;
   
   update layoffs_staging2
   set industry = null
   where industry = '';
   
   select *
   from layoffs_staging2
   where company = 'Juul'
   order by 1;
   
   select t1.industry, t2.industry
   from layoffs_staging2 t1
   join layoffs_staging2 t2
   on t1.company = t2.company
   where (t1.industry is null or t1.industry = '')
   and t2.industry is not null;
   
   update layoffs_staging2 t1
   join layoffs_staging2 t2
   on t1.industry = t2.industry
   set t1.industry = t2.industry
   where t1.industry is null 
   and t2.industry is not null;

#deleting unused columns
   
   select *
   from layoffs_staging2
   where total_laid_off is null
   and percentage_laid_off is null;
   
   delete 
	from layoffs_staging2
   where total_laid_off is null
   and percentage_laid_off is null;
   
   
   alter table layoffs_staging2
   drop column row_num;
   
 
