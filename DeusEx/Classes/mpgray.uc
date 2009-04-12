//=============================================================================
// MP Gray (Alien)
//=============================================================================
class MPGRAY extends Human;

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

function bool HasTwoHandedWeapon()
{
	return false;
}

event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     HitSound3=Sound'DeusExSounds.Animal.GrayPainSmall'
     CarcassType=Class'DeusEx.GrayCarcass'
     JumpSound=Sound'DeusExSounds.Animal.GrayIdle'
     BaseEyeHeight=25.000000
     HitSound1=Sound'DeusExSounds.Animal.GrayPainSmall'
     HitSound2=Sound'DeusExSounds.Animal.GrayPainLarge'
     Land=Sound'DeusExSounds.Animal.GrayIdle2'
     Die=Sound'DeusExSounds.Animal.GrayDeath'
     Mesh=LodMesh'DeusExCharacters.Gray'
     CollisionRadius=28.540001
     CollisionHeight=36.000000
}
