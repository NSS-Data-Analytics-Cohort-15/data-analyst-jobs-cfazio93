--1. How many rows are in the data_analyst_jobs table?
select *
FROM data_analyst_jobs
--answer 1793

--2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--answer ExxonMobil

--3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT (location)
FROM data_analyst_jobs
WHERE location = 'TN';
--answer: 21
--How many are there in either Tennessee or Kentucky?
SELECT COUNT (location)
FROM data_analyst_jobs
WHERE location = 'TN' OR location='KY';
--answer: 27

--4. How many postings in Tennessee have a star rating above 4?
SELECT COUNT (location)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >'4'; 
--answer: 3

--5. How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT (*)
FROM data_analyst_jobs
WHERE review_count BETWEEN '500' AND '1000';
--answer: 151

--6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC
limit 1;
--answer: NE

--7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT(title) 
FROM data_analyst_jobs; 
--answer: 881

--ALTER TABLE FROM TEXT TO INTEGER
ALTER table data_analyst_jobs 
ALTER column review_count type integer USING review_count::integer,
ALTER column days_since_posting type integer USING days_since_posting::integer;

--8. How many unique job titles are there for California companies?
SELECT DISTINCT(title) 
FROM data_analyst_jobs
WHERE location = 'CA';
--answer: 230

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count >5000 AND company IS NOT NULL
GROUP BY company;
--answer: 40

--10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count >5000 AND company IS NOT NULL
GROUP BY company
ORDER BY AVG(star_rating) DESC
LIMIT 1; 
--answer: Microsoft, General Motors, American Express, Nike, Kaiser Permanente, Unilever (all same rating) -- if you do LIMIT 1, only 1 shows up (General Motors)

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT COUNT(DISTINCT (title))
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--answer: 774 different titles

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT (title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';
--answer: 4, "data"

SELECT DISTINCT (title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analy%';

--BONUS: 
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
--Disregard any postings where the domain is NULL.
--Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?

SELECT COUNT (title), domain, COUNT(*)
FROM data_analyst_jobs
WHERE days_since_posting > '21' AND skill LIKE '%SQL%'
AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(*) DESC;
--LIMIT 3;
--answers: internet and software (62), banks and financial services (61), consulting and business services (57)
