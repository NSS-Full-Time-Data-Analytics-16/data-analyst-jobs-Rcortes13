-------------------------------------------------------------------------------------------------------
-----------------------------------Data-Analyst-Job-Project--------------------------------------------
-------------------------------------------------------------------------------------------------------
--1)How many rows are in the data_analyst_jobs table? 1793
-------------------------------------------------------------------------------------------------------
select count(*)
from data_analyst_jobs;
-------------------------------------------------------------------------------------------------------
--2)What company is associated with the job posting on the 10th row? Exon Mobile
-------------------------------------------------------------------------------------------------------
select company
from data_analyst_jobs
limit 10;
-------------------------------------------------------------------------------------------------------
--3)How many postings are in Tennessee? 21 How many are there in either Tennessee or Kentucky? 27
-------------------------------------------------------------------------------------------------------
select count(*)
from data_analyst_jobs
where location = 'TN';

--Option A
select count(*)
from data_analyst_jobs
where location = 'TN' or location = 'KY';

--Option B
select count(*)
from data_analyst_jobs
where location IN('TN', 'KY');

-------------------------------------------------------------------------------------------------------
--4)How many postings in Tennessee have a star rating above 4?
-------------------------------------------------------------------------------------------------------
select count(*)
from data_analyst_jobs
where location = 'TN'
		and star_rating > 4;
-------------------------------------------------------------------------------------------------------
--5)How many postings in the dataset have a review count between 500 and 1000?
------------------------------------------------------------------------------------------------------- 
select count(*)
from data_analyst_jobs
where review_count between 500 and 1000;
-------------------------------------------------------------------------------------------------------
--6)Show the average star rating for companies in each state. 
--The output should show the state as `state` and the average rating for the state as `avg_rating`. 
--Which state shows the highest average rating? NE
-------------------------------------------------------------------------------------------------------
select location as state, 
	   round(avg(star_rating),1) as avg_rating
from data_analyst_jobs
where star_rating is not null
group by 1
order by 2 DESC;
-------------------------------------------------------------------------------------------------------
--7)Select unique job titles from the data_analyst_jobs table. How many are there? 881
-------------------------------------------------------------------------------------------------------
select distinct title
from data_analyst_jobs;
-------------------------------------------------------------------------------------------------------
--8)How many unique job titles are there for California companies? 230
-------------------------------------------------------------------------------------------------------
select count(distinct title)
from data_analyst_jobs
where location = 'CA';
-------------------------------------------------------------------------------------------------------
--9)Find the name of each company and its average star rating for all companies that have more than 
--5000 reviews across all locations. How many companies are there with more that 5000 
--reviews across all locations? 42
-------------------------------------------------------------------------------------------------------
select company, 
	   round(avg(star_rating),1) as avg_rating
from data_analyst_jobs
where star_rating is not null
	and review_count > 5000
group by 1;
-------------------------------------------------------------------------------------------------------
--10)Add the code to order the query in #9 from highest to lowest average star rating. 
--Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--What is that rating? Kaiser Permanente with a 4.2 however it is worth mentioning that there were 6 company in total 
--tied with the same avg_rating and I used the review count as tie breaker (8164)
-------------------------------------------------------------------------------------------------------
select company,
	   review_count,
	   round(avg(star_rating),1) as avg_rating
from data_analyst_jobs
where star_rating is not null
	and review_count > 5000
group by 1, 2
order by 3 DESC, 2 DESC;

-------------------------------------------------------------------------------------------------------
--11)Find all the job titles that contain the word ‘Analyst’. 
--How many different job titles are there? 1669
-------------------------------------------------------------------------------------------------------
select title
from data_analyst_jobs
where title ILIKE '%analyst%';
-------------------------------------------------------------------------------------------------------
--12)How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
--What word do these positions have in common?
-------------------------------------------------------------------------------------------------------
select title
from data_analyst_jobs
where title not ilike '%analyst%' AND title not ilike '%analytics%';
-------------------------------------------------------------------------------------------------------
--Bonus)
-------------------------------------------------------------------------------------------------------
select domain, count(*)
from(select *
	 from data_analyst_jobs
	 where skill ilike '%sql%'
		and days_since_posting > 21
		and domain is not null
	 order by days_since_posting DESC)
group by 1
order by 2 DESC
limit 4


-------------------------------------------------------------------------------------------------------


