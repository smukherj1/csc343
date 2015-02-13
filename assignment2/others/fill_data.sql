-- Clear all tables
delete from roles;
delete from writers;
delete from composers;
delete from directors;
delete from cinematographers;
delete from movie_keywords;
delete from keywords;
delete from movies;
delete from people;

-- Fill 250 movies
\i others/fill_movies.sql

insert into people values
	(0, 'Pitt, Brad'),
	(1, 'Boluram, Raghu'),
	(2, 'Chandu, Jabber'),
	(3, 'Hariram, Koti'),
	(4, 'Bazaar, Randi'),
	(5, 'Tatti, Chola'),
	(6, 'Gholu, Raju'),
	(7, 'Jokati, Kala'),
	(8, 'Singh, Pagal')
;

insert into roles values
	(0, 0, 'Sam Roy Kan'), --person_id, movie_id, role
	(0, 0, 'Clown'),
	(1, 0, 'Raj'),
	(0, 1, 'Red Chaddi'),
	(2, 1, 'Blue Chaddi'),
	(1, 2, 'Jatin'),
	(2, 2, 'Vijay')
;

insert into writers values
	(0, 3), -- movie_id, person_id
	(1, 3),
	(1, 4),
	(2, 4),
	(2, 5)
;

insert into composers values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 8)
;

insert into directors values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 7)
;

insert into cinematographers values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 8)
;

insert into keywords values
(0, 'Word 0'),
(1, 'Word 1'),
(2, 'Word 2'),
(3, 'Word 3'),
(4, 'Word 4'),
(5, 'Word 5'),
(6, 'Word 6'),
(7, 'Word 7'),
(8, 'Word 8'),
(9, 'Word 9')
;

\i others/fill_movie_keywords.sql