set search_path to imdb;

-- Create a view that lists actors, the movies they worked in and the years
create view actor_movies as
(
	select distinct
		r.movie_id, 
		r.person_id,
		m.title,
		m.year 
	from 
		roles r, 
		movies m 
	where 
		r.movie_id = m.movie_id
);

-- For actors who worked on more than one movie on a particular year, only
-- keep the one who title is alphabetically the lowest
create view actor_movies_no_dupl_year as
(
	select
		*
	from 
		actor_movies oa
	where 
		not exists
		(
			select * from actor_movies ia
			where
			(ia.movie_id <> oa.movie_id)
			and
			(ia.person_id = oa.person_id)
			and
			(ia.year = oa.year)
			and
			(ia.title < oa.title)
		)
);