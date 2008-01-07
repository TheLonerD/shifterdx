//=============================================================================
// MP Max Chen
//============================================================================
class MPMAXCHE extends Human;

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
     CarcassType=Class'DeusEx.MaxChenCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench_F'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MaxChenTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MaxChenTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.MaxChenTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MaxChenTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaxChenTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MaxChenTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
