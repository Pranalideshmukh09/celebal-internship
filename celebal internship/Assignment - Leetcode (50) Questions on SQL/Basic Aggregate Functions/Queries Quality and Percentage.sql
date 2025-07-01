1211. Queries Quality and Percentage

SELECT DISTINCT query_name , round(avg(rating/position) over(partition by query_name) ,2) 
AS quality,
round(avg(case when rating<3 then 1 else 0 end) over(partition by query_name)*100,2) 
AS poor_query_percentage 
FROM queries
WHERE query_name IS NOT NULL