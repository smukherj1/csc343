<noplaylist>
{
(: Get a list of all songs which are in some playlist :)
let $playlist_songs := doc("music.xml")/music/playlists//track

(: For every song in the song list, add songs to the sequence that don't appear
   in any playlist :)
let $all_songs := doc("music.xml")/music/songs/song[not(./@sid = $playlist_songs/@sid)]
for $song in $all_songs
	return 	<song sid="{$song/@sid}"/>
}
</noplaylist>
