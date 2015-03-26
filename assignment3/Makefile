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

q2:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q2.xml
	@echo "<!DOCTYPE fewfollowers SYSTEM \"q2.dtd\">" >> q2.xml
	@galax-run q2.xq >> q2.xml
	@xmllint q2.xml --format > q2.xml1
	@mv q2.xml1 q2.xml
	@echo Xml generated for Q2.
	@xmllint q2.xml --valid > /dev/null
	@echo Passed

q3:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q3.xml
	@echo "<!DOCTYPE favourites SYSTEM \"q3.dtd\">" >> q3.xml
	@galax-run q3.xq >> q3.xml
	@xmllint q3.xml --format > q3.xml1
	@mv q3.xml1 q3.xml
	@echo Xml generated for Q3.
	@xmllint q3.xml --valid > /dev/null
	@echo Passed

q4:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q4.xml
	@echo "<!DOCTYPE pairs SYSTEM \"q4.dtd\">" >> q4.xml
	@galax-run q4.xq >> q4.xml
	@xmllint q4.xml --format > q4.xml1
	@mv q4.xml1 q4.xml
	@echo Xml generated for Q4.
	@xmllint q4.xml --valid > /dev/null
	@echo Passed

q5:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q5.xml
	@echo "<!DOCTYPE popularity SYSTEM \"q5.dtd\">" >> q5.xml
	@galax-run q5.xq >> q5.xml
	@xmllint q5.xml --format > q5.xml1
	@mv q5.xml1 q5.xml
	@echo Xml generated for Q5.
	@xmllint q5.xml --valid > /dev/null
	@echo Passed

q6:
	@echo "<?xml version=\"1.0\" standalone=\"no\" ?>" > q6.xml
	@echo "<!DOCTYPE songcounts SYSTEM \"q6.dtd\">" >> q6.xml
	@galax-run q6.xq >> q6.xml
	@xmllint q6.xml --format > q6.xml1
	@mv q6.xml1 q6.xml
	@echo Xml generated for Q6.
	@xmllint q6.xml --valid > /dev/null
	@echo Passed

clean:
	rm -f *.xml*