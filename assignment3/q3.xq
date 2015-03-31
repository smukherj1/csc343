<favourites>
{
let $users := doc("users.xml")//users/user

(: Get users and details about the playlist they played with max playcount :)
let $user_playcounts :=
for $u in $users
	for $p in $u/playlists/playlist
	where $p/@playcount = max($u/playlists/playlist/@playcount)
		return
		<user uid="{$u/@uid}" pid="{$p/@pid}" playcount="{$p/@playcount}"/>

(: Include users who have no playlists :)
let $user_no_playlists :=
for $u in $users
where count($u/playlists) = 0
	return
	<user uid="{$u/@uid}"/>

for $user in ($user_playcounts, $user_no_playlists)
order by $user/@uid
return $user
}
</favourites>