<favourites>
{
let $users := doc("users.xml")//users/user
for $u in $users
	for $p in $u/playlists/playlist
	where $p/@playcount = max($u/playlists/playlist/@playcount)
		return
		<user uid="{$u/@uid}" pid="{$p/@pid}" playcount="$p/@playcount"/>
}
</favourites>