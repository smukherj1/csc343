set search_path to imdb;

-- Create a view with ids of movies where
-- Brad Pitt had some role
create view pitt_movies as
(
	select m.movie_id 
	from movies m, people p, roles r 
	where 
		(p.person_id = r.person_id)
		and 
		(m.movie_id = r.movie_id)
		and 
		(p.name = 'Pitt, Brad')
);

-- Get a list of people who worked along with Pitt
-- Select writers who worked with Pitt and union this with composers who worked with Pitt.
-- The list of (person_id, movie_id) for writers should be distict because it is a primary
-- key in writer. The same argument extends to composers. When we union this, duplicates are
-- removed. Hence the resulting view is a list of all writers and composers who have worked
-- with Pitt. A person will appear more than once if the movies are different
create view pitt_coworkers as
(
	(select person_id, p.movie_id from writers w, pitt_movies p where p.movie_id = w.movie_id) 
	union
	(select person_id, p.movie_id from composers c, pitt_movies p where p.movie_id = c.movie_id)
);

-- Group the above table by person_id and get the count per person to get the number of
-- different movies they worked with Pitt.
create view pitt_coworker_counts as
(
	select person_id, count(*) as bradtimes from pitt_coworkers group by person_id
);

-- Display the table after renaming the attributes appropriately and ordering by name
select name, bradtimes 
from pitt_coworker_counts pcc, people p 
where pcc.person_id = p.person_id 
order by name asc;
