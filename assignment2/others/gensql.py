import random

num_keywords = 10


def asciifilter(s): 
	newstr = ''
	for c in s:
		if c == "'":
			pass
		elif ord(c) >= 128:
			pass
		else:
			newstr += c
	return newstr

class Movie:
	movies = {}
	def __init__(self, movie_id, title, year, rating):
		self._id = int(movie_id)
		self._title = asciifilter(title)
		self._year = int(year)
		self._rating = float(rating)

		if self._id in Movie.movies:
			raise RuntimeError('Duplicate movie_id : %d'%self._id)
		else:
			Movie.movies[self._id] = self

	def display(self):
		print "(%d, '%s', %d, %.1f),"%(self._id,
								self._title,
								self._year,
								self._rating)
	def id(self):
		return self.__id

random.seed(0)
movie_id = 0
for line in open('others/formatted_movies.txt'):
	line = line.split('-')
	m = None
	if len(line) == 3:
		m = Movie(movie_id, line[0], line[1], line[2])
	else:
		m = Movie(movie_id, line[0], line[2], line[3])
	#m.display()
	movie_id += 1

# Display keywords table
print '''
insert into keywords values'''
for i in range(num_keywords):
	if i < (num_keywords - 1):
		print "(%d, 'Word %d'),"%(i, i)
	else:
		print "(%d, 'Word %d')"%(i, i)
print ';'

f_out = open('fill_movie_keywords.sql', 'w')
f_out.write('''
insert into movie_keywords values
''')
for movie_id in Movie.movies.keys():
	n = random.randint(0, num_keywords)
	for i in range(n):
		f_out.write('\t(%d, %d),\n'%(movie_id, i))
f_out.write(';\n')