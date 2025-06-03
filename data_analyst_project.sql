-------------------------------------------------------------------------------------------------------
-----------------------------------Data-Analyst-Job-Project--------------------------------------------
-------------------------------------------------------------------------------------------------------
--1)How many rows are in the data_analyst_jobs table? 1793
-------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM data_analyst_jobs;
-------------------------------------------------------------------------------------------------------
--2)What company is associated with the job posting on the 10th row? Exon Mobile
-------------------------------------------------------------------------------------------------------
SELECT company
FROM data_analyst_jobs
LIMIT 10;
-------------------------------------------------------------------------------------------------------
--3)How many postings are in Tennessee? 21 How many are there in either Tennessee or Kentucky? 27
-------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';

--Option A
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' or location = 'KY';

--Option B
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN('TN', 'KY');

-------------------------------------------------------------------------------------------------------
--4)How many postings in Tennessee have a star rating above 4?
-------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN'
		AND star_rating > 4;
-------------------------------------------------------------------------------------------------------
--5)How many postings in the dataset have a review COUNT between 500 AND 1000?
------------------------------------------------------------------------------------------------------- 
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_COUNT BETWEEN 500 AND 1000;
-------------------------------------------------------------------------------------------------------
--6)Show the average star rating for companies in each state. 
--The output should show the state as `state` AND the average rating for the state as `avg_rating`. 
--Which state shows the highest average rating? NE
-------------------------------------------------------------------------------------------------------
SELECT location AS state, 
	   round(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;
-------------------------------------------------------------------------------------------------------
--7)SELECT unique job titles FROM the data_analyst_jobs table. How many are there? 881
-------------------------------------------------------------------------------------------------------
SELECT distinct title
FROM data_analyst_jobs;
-------------------------------------------------------------------------------------------------------
--8)How many unique job titles are there for California companies? 230
-------------------------------------------------------------------------------------------------------
SELECT COUNT(distinct title)
FROM data_analyst_jobs
WHERE location = 'CA';
-------------------------------------------------------------------------------------------------------
--9)Find the name of each company AND its average star rating for all companies that have more than 
--5000 reviews across all locations. How many companies are there with more that 5000 
--reviews across all locations? 42
-------------------------------------------------------------------------------------------------------
SELECT company, 
	   round(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL AND company IS NOT NULL
	AND review_COUNT > 5000
GROUP BY company;
-------------------------------------------------------------------------------------------------------
--10)Add the code to order the query in #9 FROM highest to lowest average star rating. 
--Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--What is that rating? Kaiser Permanente with a 4.2 however it is worth mentioning that there were 6 company in total 
--tied with the same avg_rating AND I used the review COUNT as tie breaker (8164)
-------------------------------------------------------------------------------------------------------
SELECT company,
	   review_COUNT,
	   round(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
	AND review_COUNT > 5000
GROUP BY 1, 2
ORDER BY 3 DESC, 2 DESC;

-------------------------------------------------------------------------------------------------------
--11)Find all the job titles that contain the word ‘Analyst’. 
--How many different job titles are there? 1669
-------------------------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
-------------------------------------------------------------------------------------------------------
--12)How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
--What word do these positions have in common?
-------------------------------------------------------------------------------------------------------
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%';
-------------------------------------------------------------------------------------------------------
--Bonus)
-------------------------------------------------------------------------------------------------------
SELECT domain AS industries, COUNT(*)
FROM(SELECT *
	 FROM data_analyst_jobs
	 WHERE skill ILIKE '%sql%'
		AND days_since_posting > 21
		AND domain IS NOT NULL
	 ORDER BY days_since_posting DESC)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 4

-------------------------------------------------------------------------------------------------------