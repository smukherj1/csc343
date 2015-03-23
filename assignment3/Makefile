all: music.xml users.xml

music.xml : genmusic.py
	@echo Generating music.xml...
	@python genmusic.py
	@echo Formating the xml
	@xmllint --format music.xml > temp.txt
	@mv temp.txt music.xml
	@echo Checking for xml validity
	@xmllint --valid music.xml > /dev/null
	@echo music.xml generated successfully

users.xml: genusers.py
	@echo Generating users.xml...
	@python genusers.py
	@echo Formating the xml
	@xmllint --format users.xml > temp.txt
	@mv temp.txt users.xml
	@echo Checking for xml validity
	@xmllint --valid users.xml > /dev/null
	@echo users.xml generated successfully

clean:
	rm -f music.xml users.xml