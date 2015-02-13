set search_path to imdb;

-- Create a view with distinct actors per movie. ie if an actor had more than one role in a
-- movie, filter that out
create view distinct_actors as
(
	select distinct movie_id, person_id from roles
);

-- Create a view that lists every movie and people who worked on those movies. Use union to
-- ensure we get only distinct people
create view distinct_people as
(
	(
		select distinct movie_id, person_id from cinematographers
	)
	union
	(
		select distinct movie_id, person_id from composers
	)
	union
	(
		select distinct movie_id, person_id from directors
	)
	union
	(
		select distinct movie_id, person_id from writers
	)
	union
	(
		select distinct movie_id, person_id from distinct_actors
	)
);

-- Create a view of movie_id and the number of distinct people working per movie.
-- Also add movies that have no people working in them
create view movie_different_people as
(
	(
		select movie_id, count(*) as people
		from
		distinct_people
		group by
		movie_id
	)
	union
	(
		select movie_id, 0 as people
		from
		movies m
		where
		not exists(select * from distinct_people p where p.movie_id = m.movie_id)
	)
);

-- Create a view that lists all positions for every movie
create view all_positions as
(
	(
		select movie_id, person_id from cinematographers
	)
	union all
	(
		select movie_id, person_id from composers
	)
	union all
	(
		select movie_id, person_id from directors
	)
	union all
	(
		select movie_id, person_id from writers
	)
	union all
	(
		select distinct movie_id, person_id from distinct_actors
	)
);

-- Create a view of movie_id and the number of positions in that movie
-- Also add movies that have no positions in them
create view movie_positions as
(
	(
		select movie_id, count(*) as positions
		from
		all_positions
		group by
		movie_id
	)
	union
	(
		select movie_id, 0 as positions
		from
		movies m
		where
		not exists(select * from all_positions p where p.movie_id = m.movie_id)
	)
);

-- Join movie_positions and movie_different_people by movie_id and report relevant entries
-- after ordering them in the requested manner
select 
	mdp.movie_id, mp.positions, mdp.people 
from 
	movie_different_people mdp,
	movie_positions mp
where
	mdp.movie_id = mp.movie_id
order by
	mp.positions asc,
	mdp.people desc,
	mdp.movie_id asc
;