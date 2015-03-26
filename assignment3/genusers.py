import random
from random import randint as rint
import time
from genmusic import NUM_USERS
from genmusic import NUM_SONGS
from genmusic import NUM_PLAYLISTS

OUTFILE = 'users.xml'

random.seed(0)
f_out = open(OUTFILE, 'w')
f_out.write('''<?xml version="1.0" standalone="no"?>
<!DOCTYPE users SYSTEM "users.dtd">
''')

def gen_playlist():
	f_out.write('<playlists>\n')
	pid_list = set()	
	for i in range(rint(1, 5)):
		pid_list.add(rint(0, NUM_PLAYLISTS - 1))
	for pid in pid_list:
		f_out.write('<playlist')
		f_out.write(' pid="P%d"'%pid)
		f_out.write(' created="%d"'%rint(2004, 2015))
		f_out.write(' playcount="%d"'%rint(0, 400))
		f_out.write('/>\n')
	f_out.write('</playlists>\n')
	return

def gen_user(i):
	f_out.write('<user')
	f_out.write(' uid="u%d"'%i)
	if rint(0, 1) == 1:
		f_out.write(' dob="%d"'%(rint(1950, 2005)))
	f_out.write(' email="user%d@example.com"'%i)
	f_out.write('>\n')
	f_out.write('<surname>UserTitle %d</surname>\n'%i)
	f_out.write('<givennames>User %d</givennames>\n'%i)
	f_out.write('<follows')
	follows = rint(0, NUM_USERS)
	if follows == i:
		if follows == 0:
			follows += 1
		else:
			follows -= 1

	f_out.write(' who="u%d"'%(follows))
	f_out.write('/>\n')
	if rint(0, 1) == 1:
		gen_playlist()
	f_out.write('</user>\n')
	return

f_out.write('<users>\n')
for i in range(NUM_USERS):
	gen_user(i)
f_out.write('</users>\n')