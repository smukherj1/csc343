import random
import time

OUTFILE = 'music.xml'
NUM_SONGS = 150
NUM_PLAYLISTS = 20
NUM_USERS = 30

random.seed(0)
f_out = open(OUTFILE, 'w')
f_out.write('''<?xml version="1.0" standalone="no"?>
<!DOCTYPE music SYSTEM "music.dtd">
''')

def gen_song(i):
	f_out.write('<song')
	f_out.write(' sid="s%d"'%i)
	f_out.write(' time="%.0f"'%((time.time() * 100) % 100))
	f_out.write(' year="%d"'%random.randint(1980, 2015))
	f_out.write('>\n')
	f_out.write('<title>Song ' + str(i) + '</title>\n')
	f_out.write('<artist>Artist ' + str(random.randint(0, 100)) + '</artist>\n')
	f_out.write('<composers>\n')
	for i in range(random.randint(1, 5)):
		f_out.write('<composer>')
		f_out.write('Composer ' + str(i))
		f_out.write('</composer>\n')
	f_out.write('</composers>\n')
	if random.randint(0, 1) == 1:
		f_out.write('<album>Album ' + str(random.randint(0, 100)) + '</album>\n')
	f_out.write('</song>')
	return

def gen_playlist(i):
	f_out.write('<playlist')
	f_out.write(' pid="P%d"'%i)
	if random.randint(0, 1) == 1:
		f_out.write('   creator="u%d"'%(random.randint(0, NUM_USERS)))
	f_out.write('>\n')
	song_set = set()
	for i in range(random.randint(1, 10)):
		song_set.add(random.randint(0, NUM_SONGS))
	for sid in song_set:
		f_out.write('<track')
		f_out.write(' sid="s%d"'%(sid))
		f_out.write('/>\n')
	f_out.write('</playlist>\n')
	return

f_out.write('<music>\n')
f_out.write('<songs>\n')
for i in range(NUM_SONGS):
	gen_song(i)
f_out.write('</songs>')
f_out.write('<playlists>\n')
for i in range(NUM_PLAYLISTS):
	gen_playlist(i)
f_out.write('</playlists>\n')
f_out.write('</music>')

