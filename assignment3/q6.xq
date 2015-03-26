<songcounts>
{

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

for $song in $playlist_songs//song
	let $count :=
	sum($playlist_counts//playlist[./@pid = $song/playlist/@pid]/@count)
	return
	<song sid="{$song/@sid}" title="{$song/@title}" playcount="{$count}"/>
}
</songcounts>
