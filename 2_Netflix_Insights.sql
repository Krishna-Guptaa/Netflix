create database Netflix_db;
use netflix_db;

-- 1) What is the Distribution of Movies and TV shows on Netflix.
select type, count(*) as total_count from netflix 
group by type;

-- 2) Who are the Top 10 Director with the most of title on Netflix. 
select director, count(*) as total_titles from netflix
where director is not null 
group by director
order by total_titles desc
limit 10;

-- 3) Which Country have highest number of Netflix title. 
select country, count(*) as Highest_Titles from netflix 
where country is not null or country = ''
group by country
order by Highest_Titles desc
limit 10;

-- 4) How has Netflix content grown over years. 
select release_year, count(*) as Total_Content from Netflix 
group by release_year
order by Total_Content desc
limit 5;

-- 5) What are the most common Content Rating on Netflix. 
select Rating, count(*) as Most_Common_Content from netflix 
group by Rating
order by Most_Common_Content desc
limit 5;

-- 6) Which country produce more Movies than TV shows. 
select Country,
sum(case when type = 'Movie' then 1 else 0 end) as Movies,
sum(case when type = 'TV show' then 1 else 0 end) as TV_Shows
from netflix
where country != ''
group by country
limit 3;

-- 7) Name the Top 5 countries produce Movies. 
select Country, count(*) as Total_Movies from netflix 
where type = "Movie" and country !=''
group by Country
order by Total_Movies desc
limit 5; 

-- 8) Which Genre(Category) has highest number of TV shows. 
select Listed_In, count(*) as Total_TV_Shows from netflix
where type = 'TV show'
group by listed_in
order by Total_TV_Shows desc
limit 1;

-- 9) Which Genre(Catgory) has highest number of Movies.
select Listed_in, count(*) as Total_Movies from netflix
where type = 'Movie' 
group by listed_in
order by Total_Movies desc
limit 1;

-- 10) What is the Average Duration of Netflix Movies. 
select Type, avg(Duration) as Avg_Duration from netflix 
where type = 'Movie'
group by type 
order by avg_duration desc;

select version();

-- 11) What is the longest movie on Netflix. 
select Title, Duration from netflix 
where type = "Movie"
order by duration desc
limit 1;

-- 12) Which is the shortest movie on netflix. 
select Title, Duration from netflix
where type = 'Movie'
order by duration asc
limit 1;

-- 13) How many Titles were release after 2020. 
select count(*) as Release_After_2020 from netflix
where release_year > 2020;

-- 14) How many Titles were release before 2020. 
select count(*) as Release_Before_2020 from netflix 
where release_year < 2020;

-- 15) How many title are rated TV_MA. 
select count(*) as Total_TV_MA from netflix 
where rating = 'TV-MA';

     
														-- Advance SQL Question with CTE and WINDOW ()

 

-- 16) Using CTE, Find all genres that have more than 250 title. 
with category as ( select listed_in as genre, count(*) as total_title from netflix 
group by listed_in)
select * from category
where total_title > 250;

-- 17) For each country, Find its highest Rated title using ROW_NUMBER. 
with ranked_titles as ( select
country, title, rating,
row_number() over ( 
partition by country
order by rating desc ) as rn
from netflix 
where country != '' and rating != '')
select Country, Title, Rating from ranked_titles
where rn = 1;

-- 18) Which column have missing value. 
select
sum(show_id = '') as Missing_Show_ID,
sum(type = '') as Missing_Type,
sum(title = '') as Missing_Title,
sum(director = '') as Missing_Director,
sum('cast' = '') as Missing_Cast,
sum(country = '') as Missing_Country,
sum(date_added = '') as Missing_Date_Added,
sum(release_year = '') as Missing_Release_Year,
sum(rating = '') as Misssing_Rating,
sum(duration = '') as Missing_Duration,
sum(listed_in = '') as Missing_Listed_In,
sum(description = '') as Missing_Description
from netflix;