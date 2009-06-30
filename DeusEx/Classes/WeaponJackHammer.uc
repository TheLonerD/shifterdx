//=============================================================================
// WeaponJackHammer.
//=============================================================================
class WeaponJackHammer expands WeaponAssaultShotgun;

function bool loadAmmo(int ammonum)
{
	local bool result;

	result = Super.loadAmmo(ammonum);

	//== If we don't set the sabot rounds to do more than 1 damage, they won't do any damage
	if(AmmoType.IsA('AmmoSabot'))
	{
		AreaOfEffect = AOE_Cone;
		HitDamage = Default.HitDamage * 3;
	}
	else
	{
		AreaOfEffect = Default.AreaOfEffect;
		HitDamage = Default.HitDamage;
	}

	return result;
}

//== Unlike the normal shotguns we want the Jackhammer to have absolutely no delay between simul-firing, since it's already automatic
simulated function DoTraceFire( float Accuracy )
{
	do
	{
		Super.DoTraceFire(Accuracy);
		ExtraAmmoLoaded--;
	}
	until(ExtraAmmoLoaded < 0);

	ExtraAmmoLoaded = 0;
}

defaultproperties
{
     ShotTime=0.080000
     HitDamage=1
     AreaOfEffect=AOE_Sphere
     recoilStrength=0.450000
     bUnique=True
     mpHitDamage=2
     bCanHaveModShotTime=False
     InventoryGroup=93
     ItemName="JackHammer"
     ItemArticle="the"
     Description="A product of Smuggler's extreme if not appropriate paranoia, the JackHammer is a fully automatic shotgun capable of exhausting a full clip in just under a second.  Unfortunately, Smuggler didn't have time to expand the clip capacity."
     beltDescription="JACKHAMMER"
}
