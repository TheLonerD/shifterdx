//=============================================================================
// MP Lower Class Male 1
//============================================================================
class MPLCMALE extends Human;

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
     CarcassType=Class'DeusEx.LowerClassMaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_S'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex2'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.PantsTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.SkinTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LowerClassMaleTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
}
