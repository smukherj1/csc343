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

-- Create a view that lists all actors and any three consecutive movies they have
-- done
create view actor_three_movies as
(
	select 
		a1.person_id,
		a1.year as year1,
		a1.title as movie1,
		a2.year as year2,
		a2.title as movie2,
		a3.year as year3,
		a3.title as movie3
	from
		actor_movies_no_dupl_year a1,
		actor_movies_no_dupl_year a2,
		actor_movies_no_dupl_year a3
	where
		-- Make sure we are checking movies for the same actor
		(a1.person_id = a2.person_id) and
		(a2.person_id = a3.person_id) and
		-- Make sure the movies occured in consecutive years
		(a1.year = (a2.year - 1)) and
		(a2.year = (a3.year - 1))
);

-- To get the final answers, we need to remove tuples from the above view for actors who had
-- more than one 3 year consecutive movie runs
select distinct
	*
from 
	actor_three_movies a1
where
	not exists
	(
		select 
			*
		from 
			actor_three_movies a2
		where 
			(a2.person_id = a1.person_id) and 
			(a2.year1 > a1.year1)
	)
order by
	person_id asc;
;