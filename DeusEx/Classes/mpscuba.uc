//=============================================================================
// MP Scuba Diver
//============================================================================
class MPSCUBA extends Human;

function Bool HasTwoHandedWeapon()
{
	return False;
}

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
     CarcassType=Class'DeusEx.ScubaDiverCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Texture=Texture'DeusExCharacters.Skins.ScubasuitTex1'
     Mesh=LodMesh'DeusExCharacters.GM_Scubasuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ScubasuitTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ScubasuitTex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.ScubasuitTex1'
}
