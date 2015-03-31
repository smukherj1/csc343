<fewfollowers>
{
let $user_followers :=
(: Create an xml mapping each user to their followers :)
for $u in doc("users.xml")//user
	let $followers :=
	for $ui in doc("users.xml")//user
		where $ui/follows/@who = $u/@uid
		return <follower uid="{$ui/@uid}"/>
	return
	<who uid="{$u/@uid}">
	{$followers}
	</who>

(: In the above generated xml, report the users with followers fewer than 4 :)
for $u in $user_followers
where count($u/follower) < 4
return $u

}
</fewfollowers>