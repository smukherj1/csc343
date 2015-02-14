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

\i others/drop_views.sql;

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
	(8, 'Singh, Pagal'),
	(9, 'Shyamalan, M. Night'),
	(10, 'Actor 10'),
	(11, 'Actor 11'),
	(12, 'Actor 12'),
	(13, 'Actor 13'),
	(14, 'Actor 14'),
	(15, 'Actor 15'),
	(16, 'Actor 16'),
	(17, 'Actor 17'),
	(18, 'Actor 18'),
	(19, 'Actor 19'),
	(20, 'Actor 20'),
	(21, 'Actor 21'),
	(22, 'Actor 22'),
	(23, 'Actor 23'),
	(24, 'Actor 24'),
	(25, 'Actor 25'),
	(26, 'Actor 26'),
	(27, 'Actor 27'),
	(28, 'Actor 28'),
	(29, 'Actor 29')
;

insert into roles values
	(0, 0, 'Sam Roy Kan'), --person_id, movie_id, role
	(0, 0, 'Clown'),
	(1, 0, 'Raj'),
	(0, 1, 'Red Chaddi'),
	(2, 1, 'Blue Chaddi'),
	(1, 2, 'Jatin'),
	(2, 2, 'Vijay'),

	(2, 3, 'Vijay'),
	(2, 4, 'Manoj'),
	(2, 5, 'Arjun'),
	(2, 6, 'Abhay'),

	(4, 6, 'Vijay'),
	(4, 7, 'Manoj'),
	(4, 8, 'Arjun'),
	(4, 9, 'Abhay'),
	(4, 10, 'Zandu'),
	(4, 11, 'Nichimura'),
	(9, 10, 'Day'),

	-- For Kevin Bacon. Create two disconnected trees
	(10, 20, 'role_id:a10m20'),
	(10, 21, 'role_id:a10m21'),
	(10, 22, 'role_id:a10m22'),
	(11, 21, 'role_id:a11m21'),
	(11, 22, 'role_id:a11m22'),
	(11, 23, 'role_id:a11m23'),
	(12, 22, 'role_id:a12m22'),
	(12, 23, 'role_id:a12m23'),
	(12, 24, 'role_id:a12m24'),
	(13, 23, 'role_id:a13m23'),
	(13, 24, 'role_id:a13m24'),
	(13, 25, 'role_id:a13m25'),
	(14, 24, 'role_id:a14m24'),
	(14, 25, 'role_id:a14m25'),
	(14, 26, 'role_id:a14m26'),
	(15, 25, 'role_id:a15m25'),
	(15, 26, 'role_id:a15m26'),
	(15, 27, 'role_id:a15m27'),
	(16, 26, 'role_id:a16m26'),
	(16, 27, 'role_id:a16m27'),
	(16, 28, 'role_id:a16m28'),
	(17, 27, 'role_id:a17m27'),
	(17, 28, 'role_id:a17m28'),
	(17, 29, 'role_id:a17m29'),
	(18, 28, 'role_id:a18m28'),
	(18, 29, 'role_id:a18m29'),
	(18, 30, 'role_id:a18m30'),
	(19, 29, 'role_id:a19m29'),
	(19, 30, 'role_id:a19m30'),
	(19, 31, 'role_id:a19m31'),

	(20, 32, 'role_id:a20m32'),
	(20, 33, 'role_id:a20m33'),
	(20, 34, 'role_id:a20m34'),
	(21, 33, 'role_id:a21m33'),
	(21, 34, 'role_id:a21m34'),
	(21, 35, 'role_id:a21m35'),
	(22, 34, 'role_id:a22m34'),
	(22, 35, 'role_id:a22m35'),
	(22, 36, 'role_id:a22m36'),
	(23, 35, 'role_id:a23m35'),
	(23, 36, 'role_id:a23m36'),
	(23, 37, 'role_id:a23m37'),
	(24, 36, 'role_id:a24m36'),
	(24, 37, 'role_id:a24m37'),
	(24, 38, 'role_id:a24m38'),
	(25, 37, 'role_id:a25m37'),
	(25, 38, 'role_id:a25m38'),
	(25, 39, 'role_id:a25m39'),
	(26, 38, 'role_id:a26m38'),
	(26, 39, 'role_id:a26m39'),
	(26, 40, 'role_id:a26m40'),
	(27, 39, 'role_id:a27m39'),
	(27, 40, 'role_id:a27m40'),
	(27, 41, 'role_id:a27m41'),
	(28, 40, 'role_id:a28m40'),
	(28, 41, 'role_id:a28m41'),
	(28, 42, 'role_id:a28m42'),
	(29, 41, 'role_id:a29m41'),
	(29, 42, 'role_id:a29m42'),
	(29, 43, 'role_id:a29m43'),
	(29, 32, 'role_id:a29m43') -- Create a cycle


;

insert into writers values
	(0, 3), -- movie_id, person_id
	(1, 3),
	(1, 4),
	(2, 4),
	(2, 5),
	(2, 9)
;

insert into composers values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 8),
	(1, 9)
;

insert into directors values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 7),
	(11, 9)
;

insert into cinematographers values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 8),
	(9, 9)
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