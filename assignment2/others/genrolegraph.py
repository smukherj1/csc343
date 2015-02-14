import sys

try:
	base = int(sys.argv[1])
except:
	base = 0
try:
	movie_base = int(sys.argv[2])
except:
	movie_base = 20

for i in range(10):
	actor = i + base
	for j in range(movie_base + i, movie_base + i + 3):
		print "\t(%d, %d, 'role_id:a%dm%d'),"%(actor, j, actor, j)