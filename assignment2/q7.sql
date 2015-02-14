set search_path to imdb;

-- Get a view of all movies Night worked on
create view night_movies_view as
(
(select r.movie_id from roles r where 
	exists (select * from people p 
		where 
		(p.person_id = r.person_id) and
		(p.name = 'Shyamalan, M. Night')
	)
)
union
(select c.movie_id from composers c where 
	exists (select * from people p 
		where 
		(p.person_id = c.person_id) and
		(p.name = 'Shyamalan, M. Night')
	)
)
union
(select c.movie_id from cinematographers c where 
	exists (select * from people p 
		where 
		(p.person_id = c.person_id) and
		(p.name = 'Shyamalan, M. Night')
	)
)
union
(select w.movie_id from writers w where 
	exists (select * from people p 
		where 
		(p.person_id = w.person_id) and
		(p.name = 'Shyamalan, M. Night')
	)
)
union
(select d.movie_id from directors d where 
	exists (select * from people p 
		where 
		(p.person_id = d.person_id) and
		(p.name = 'Shyamalan, M. Night')
	)
)
);

create table night_movies
(
	movie_id integer primary key
);

insert into night_movies (select * from night_movies_view);

-- Get a view of all people night worked with
create view night_people_view as
(
(select r.person_id from roles r where 
	r.movie_id in (select * from night_movies)
)
union
(select c.person_id from composers c where 
	c.movie_id in (select * from night_movies)
)
union
(select c.person_id from cinematographers c where 
	c.movie_id in (select * from night_movies)
)
union
(select w.person_id from writers w where 
	w.movie_id in (select * from night_movies)
)
union
(select d.person_id from directors d where 
	d.movie_id in (select * from night_movies)
)
);

create table night_people
(
	person_id integer primary key
);
insert into night_people (select * from night_people_view);

-- Now delete all entries in tables that reference these movies.
-- Delete the movies last
delete from movie_keywords where movie_id in (select * from night_movies);
delete from movie_genres where movie_id in (select * from night_movies);
delete from roles where person_id in (select * from night_people);
delete from composers where person_id in (select * from night_people);
delete from cinematographers where person_id in (select * from night_people);
delete from writers where person_id in (select * from night_people);
delete from directors where person_id in (select * from night_people);
delete from people where person_id in (select * from night_people);
delete from movies where movie_id in (select * from night_movies);

drop view night_people_view;
drop view night_movies_view;
drop table night_movies;
drop table night_people;