//=============================================================================
// WeaponCatScratch.
//=============================================================================
class WeaponCatScratch extends WeaponNPCMelee;

function name WeaponDamageType()
{
	return 'ShotSoft';
}

defaultproperties
{
     ShotTime=0.500000
     HitDamage=3
     ProjectileDamage=3
     maxRange=50
     AccurateRange=80
     BaseAccuracy=0.000000
     bOwnerWillNotify=False
     FireSound=Sound'DeusExSounds.Animal.CatHiss'
     PlayerViewOffset=(X=5.000000,Y=-8.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.CombatKnife'
}
