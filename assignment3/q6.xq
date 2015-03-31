<songcounts>
{

(: Get the overall playcount of every playlist :)
let $playlist_counts :=
<playlists>
{
let $all_playlists := doc("music.xml")//playlist
let $all_user_playlists := doc("users.xml")//playlist
for $p in $all_playlists
	return
	<playlist pid="{$p/@pid}" count="{sum($all_user_playlists[./@pid = $p/@pid]/@playcount)}"/>
}
</playlists>

(: For each song, get the playlists it appears in :)
let $playlist_songs :=
<songs>
{
for $song in doc("music.xml")//song
	let $playlists :=
	for $playlist in doc("music.xml")//playlist
		for $track in $playlist/track
		where ($track/@sid = $song/@sid)
		return
		<playlist pid="{$playlist/@pid}"/>
	return
	<song sid="{$song/@sid}" title="{$song/title}">
	{$playlists}
	</song>
}
</songs>

(: For each song, sum up the overall playcount of each playlist it appears in :)
for $song in $playlist_songs//song
	let $count :=
	sum($playlist_counts//playlist[./@pid = $song/playlist/@pid]/@count)
	return
	<song sid="{$song/@sid}" title="{$song/@title}" playcount="{$count}"/>
}
</songcounts>
