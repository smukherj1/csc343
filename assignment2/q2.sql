set search_path to imdb;

-- Create a view that maps each movie to the number of different keywords it has and the
-- rating it got.
-- To get this, we will union two subqueries. The first subquery gets the movies that had some
-- keywords associated with them. The second subquery had no keywords associated with them.

create view movie_keyword_count as
(
	(
		select 
			m.movie_id, count(*) as keywords, 
			min(m.rating) as rating 
		from 
			movies m, 
			movie_keywords k 
		where 
			m.movie_id = k.movie_id 
		group by 
			m.movie_id
	)
	union
	(
		select 
			m.movie_id, 
			0 as keywords,
			m.rating
		from 
			movies m 
		where 
			not exists
			(
				select * from movie_keywords mk where m.movie_id = mk.movie_id
			)
	)
);


-- Group the movie_keyword_count view by keywords and display only the keyword count and
-- the average rating for movies that had those number of keywords. No need to select distict
-- because group by keywords will ensure each tuple has a unique keyword count
select 
	keywords, 
	avg(rating) as avgrating 
from 
	movie_keyword_count 
group by 
	keywords 
order by 
	keywords;
