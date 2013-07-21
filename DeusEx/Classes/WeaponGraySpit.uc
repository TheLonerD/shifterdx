//=============================================================================
// WeaponGraySpit.
//=============================================================================
class WeaponGraySpit extends WeaponNPCRanged;

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
     HitDamage=8
     maxRange=450
     AccurateRange=300
     AreaOfEffect=AOE_Cone
     bHandToHand=True
     AmmoName=Class'DeusEx.AmmoGraySpit'
     PickupAmmoCount=4
     ProjectileClass=Class'DeusEx.GraySpit'
}
