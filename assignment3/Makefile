all: music.xml users.xml

music.xml:
	@echo Generating music.xml...
	@python genmusic.py
	@echo Formating the xml
	@xmllint --format music.xml > temp1.txt
	@cp temp1.txt music.xml
	@echo Checking for xml validity
	@xmllint --valid music.xml > /dev/null
	@echo music.xml generated successfully

users.xml:
	@echo Generating users.xml...
	@python genusers.py
	@echo Formating the xml
	@xmllint --format users.xml > temp.txt
	@cp temp.txt users.xml
	@echo Checking for xml validity
	@xmllint --valid users.xml > /dev/null
	@echo users.xml generated successfully

q1:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q1.xml
	@echo "<!DOCTYPE noplaylist SYSTEM \"q1.dtd\">" >> q1.xml
	@galax-run q1.xq >> q1.xml
	@xmllint q1.xml --format > q1.xml1
	@mv q1.xml1 q1.xml
	@echo Xml generated for Q1.
	@xmllint q1.xml --valid > /dev/null
	@echo Passed

clean:
	rm -f *.xml