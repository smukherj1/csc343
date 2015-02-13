set search_path to imdb;

-- Create a view with the movie year changed to decade
create view movie_decade as
(
	select 
		movie_id, 
		title, 
		CAST(year as CHAR(3))||'0s' as decade, 
		rating 
	from 
		movies
);

-- Generate a list of the maximum rating given to movies in each decade
create view decade_super_movie as
(
	select decade, max(rating) as max_rating from movie_decade group by decade
);

-- Use the above view to get movies that were the super movies in each decade
create view super_movies as
(
	select
		md.movie_id,
		md.title,
		md.decade,
		md.rating
	from 
		movie_decade md, 
		decade_super_movie dsm
	where
		(dsm.decade = md.decade)
		and
		(dsm.max_rating = md.rating)
);

-- Create a view of writers who worked on atleast on super movie
create view super_writers as
(
	select 
		m.movie_id, 
		w.person_id 
	from 
		writers w, 
		super_movies m 
	where 
		w.movie_id = m.movie_id
);

-- Create of view that has regular movies only
create view regular_movies as
(
	select
		md.movie_id,
		md.title,
		md.decade,
		md.rating
	from 
		movie_decade md, 
		decade_super_movie dsm
	where
		(dsm.decade = md.decade)
		and
		-- For a regular movie, the rating is lower than the highest rating for that
		-- decade
		(dsm.max_rating > md.rating)
);

-- Create a view of writers who worked on atleast one regular movie
create view regular_writers as
(
	select 
		m.movie_id, 
		w.person_id 
	from 
		writers w, 
		regular_movies m 
	where 
		w.movie_id = m.movie_id
);

-- Create a view of writers who only ever worked on super movies.
-- And while we are at it, also get the names of these people
create view exclusive_super_writers as
(
	select distinct
		sw.movie_id,
		p.name as writer
	from
		super_writers sw, people p
	where
		not exists
		(
			select * from regular_writers rw where rw.person_id = sw.person_id
		)
		and
		(sw.person_id = p.person_id)
);

-- Join this list of exclusive_super_writers with super_movies and display the
-- relevant information
select distinct
	ew.writer,
	m.title as supermovie,
	m.rating,
	m.decade
from
	exclusive_super_writers ew, super_movies m
where
	(ew.movie_id = m.movie_id)
order by
	ew.writer asc,
	m.decade desc,
	m.title asc
; 