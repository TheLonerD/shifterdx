//=============================================================================
// WeaponGreaselSpit.
//=============================================================================
class WeaponGreaselSpit extends WeaponNPCRanged;

//== Overridden so cheaters can cheat.  Reported by NotAVeryGoodName on the SVN
function BringUp()
{
	Super.BringUp();

	if ( Owner.IsA('DeusExPlayer') )
	{
		bHandtoHand=false;
	}
}

defaultproperties
{
     ShotTime=1.500000
     HitDamage=15
     maxRange=450
     AccurateRange=300
     bHandToHand=True
     AmmoName=Class'DeusEx.AmmoGreaselSpit'
     PickupAmmoCount=4
     ProjectileClass=Class'DeusEx.GreaselSpit'
}
