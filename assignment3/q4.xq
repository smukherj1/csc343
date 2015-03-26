<pairs>
{
let $users := doc("users.xml")//user
for $ui in $users
	for $uj in $users
		where ($ui/@uid ne $uj/@uid) and
		($ui/@uid lt $uj/@uid) and
		(
			every $pid in $ui/playlists/playlist/@pid 
			satisfies $pid = $uj/playlists/playlist/@pid
		) and
		(
			every $pid in $uj/playlists/playlist/@pid 
			satisfies $pid = $ui/playlists/playlist/@pid
		) and
		count($ui/playlists/playlist) >= 5
		return <pair uid1="{$ui/@uid}" uid2="{$uj/@uid}"/>
}
</pairs>