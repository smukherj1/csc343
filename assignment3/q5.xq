<popularity>
{
let $playlists := doc("music.xml")//playlist
let $user_playlists := doc("users.xml")//playlist

for $p in $playlists
	let $lcount := count($user_playlists[./@playcount < 5][./@pid = $p/@pid])
	let $mcount := count($user_playlists[./@playcount >= 5][./@playcount <= 49][./@pid = $p/@pid])
	let $hcount := count($user_playlists[./@playcount >= 50][./@pid = $p/@pid])
	return
	<histogram pid="{$p/@pid}">
		<low count="{$lcount}" />
		<medium count="{$mcount}" />
		<high count="{$hcount}" />
	</histogram>
}
</popularity>