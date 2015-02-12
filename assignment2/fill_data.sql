-- Clear all tables
delete from roles;
delete from writers;
delete from composers;
delete from movies;
delete from people;

insert into movies values
(0, 'Dilwale Dulhaniya Le Jayenge Returns', 2014, 7.3),
(1, 'Chaddi Buddies', 2013, 9.6),
(2, 'Jatin Pagal Ho Gaya', 2006, 5.5)
;

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
	(2, 5)
;

insert into composers values
	(0, 6), -- movie_id, person_id
	(1, 4),
	(1, 7),
	(2, 8)
;