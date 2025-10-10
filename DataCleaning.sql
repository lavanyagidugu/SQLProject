##Data Cleaning
use World_data;
SELECT *
FROM layoffs;
##Remove duplicates
##Standardize the data
##Null values and blank values
##Remove Any colums

CREATE Table layoffs_staging
Like layoffs;
select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;

select *,ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date') as row_num
from layoffs_staging;


WITH duplicate_cte AS
(
select *,ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date',location,stage,country,funds_raised_millions) as row_num
from layoffs_staging
) 
SELECT * from duplicate_cte
WHERE row_num>1;

WITH duplicate_cte AS
(
select *,ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date',location,stage,country,funds_raised_millions) as row_num
from layoffs_staging
) 
SELECT * from duplicate_cte
WHERE company='Oyster';

WITH duplicate_cte AS
(
select *,ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date',location,stage,country,funds_raised_millions) as row_num
from layoffs_staging
) 
DELETE from duplicate_cte
WHERE row_num>1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

INSERT INTO layoffs_staging2
select *,ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date',location,stage,country,funds_raised_millions) as row_num
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;

DELETE from layoffs_staging2 where row_num>1;


##Standarizing data
select company,Trim(company) from layoffs_staging2 ;

UPDATE layoffs_staging2 
SET company=Trim(company);

select DISTINCT(industry) from layoffs_staging2 order by 1;

UPDATE layoffs_staging2
SET industry='Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

select date,STR_TO_DATE(date,'%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
SET date=STR_TO_DATE(date,'%m/%d/%Y');

ALTER Table layoffs_staging2
MODIFY COLUMN date DATE;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL;


SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete Useless data we can't really use
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM world_layoffs.layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT * 
FROM world_layoffs.layoffs_staging2;
