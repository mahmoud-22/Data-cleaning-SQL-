SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging 
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging 
SELECT *
FROM layoffs;

select *
from layoffs_staging;



WITH duplicate_cte AS
 (
 SELECT * ,
 ROW_NUMBER() OVER ( PARTITION BY company , location , industry , total_laid_off, percentage_laid_off , `date`, stage ,country , funds_raised_millions ) AS row_num
 FROM layoffs_staging
 )
 SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company=' Included Health';

WITH duplicate_cte AS
 (
 SELECT * ,
 ROW_NUMBER() OVER ( PARTITION BY company , location , industry , total_laid_off, percentage_laid_off ,
 `date`, stage ,country , funds_raised_millions) AS row_num
 FROM layoffs_staging
 )
DELETE
    FROM duplicate_cte
    WHERE row_num > 1
;
 SET SQL_SAFE_UPDATES = 0;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL ,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
 FROM layoffs_staging2
 WHERE row_num >1 ;


 insert into layoffs_staging2
  SELECT * ,
 ROW_NUMBER() OVER ( PARTITION BY company , location , industry , total_laid_off, percentage_laid_off ,
 `date`, stage ,country , funds_raised_millions ) AS row_num
 FROM layoffs_staging;
 
Delete
 FROM layoffs_staging2
 WHERE row_num >1 ;
 
 SELECT *
FROM  layoffs_staging2;



SELECT company , trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = trim(company);

 SELECT *
FROM  layoffs_staging2;

SELECT distinct industry
FROM  layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET industry = "Crypto"
where industry like "Crypto%";


SELECT distinct industry
FROM  layoffs_staging2
order by 1;

select distinct country
FROM  layoffs_staging2
ORDER BY 1;

select *
FROM  layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

UPDATE layoffs_staging2
SET country = trim(TRAILING '.' from country)
WHERE country LIKE 'United States%';

select country
FROM  layoffs_staging2;

-- change type - date

select `date`
FROM  layoffs_staging2;

SELECT `date` ,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM  layoffs_staging2;

UPDATE  layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE ;

select `date`
FROM  layoffs_staging2;

select *
FROM  layoffs_staging2;

-- NULL , BLANK VALUE

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL  AND percentage_laid_off IS NULL;

update layoffs_staging2
set industry = null 
WHERE industry = '' ;

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL  ;

 SET SQL_SAFE_UPDATES = 0;
 
 
  UPDATE layoffs_staging2 t1
   JOIN layoffs_staging2  t2
    ON t1.company = t2.company 
  SET t1.industry = t2.industry
WHERE 
 t1.industry IS NULL
 AND
 t2.industry IS NOT NULL ;
 
 
SELECT t1.industry , t2.industry 'industry 2'
FROM layoffs_staging2  t1
JOIN layoffs_staging2  t2
  ON
  t1.company = t2.company 
  WHERE (t1.industry IS NULL OR t1.industry ='')
  AND t2.industry IS NOT NULL;
  
  SELECT *
  FROM layoffs_staging2;
  
  
  -- remove column 
  
  ALTER TABLE layoffs_staging2
  DROP COLUMN row_num;
  
  




 
















