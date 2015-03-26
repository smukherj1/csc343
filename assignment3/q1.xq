<noplaylist>
{
let $playlist_songs := doc("music.xml")/music/playlists//track
let $all_songs := doc("music.xml")/music/songs/song[not(./@sid = $playlist_songs/@sid)]
for $song in $all_songs
	return 	<song sid="{$song/@sid}"/>
}
</noplaylist>
