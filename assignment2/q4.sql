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