//=============================================================================
// MP Gray (Alien)
//=============================================================================
class MPGRAY extends Human;

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     CarcassType=Class'DeusEx.GrayCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     BaseEyeHeight=25.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.Gray'
     CollisionRadius=28.540001
     CollisionHeight=36.000000
}
