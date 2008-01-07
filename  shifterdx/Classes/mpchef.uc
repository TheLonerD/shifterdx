//=============================================================================
// MP Chef
//=============================================================================
class MPCHEF extends Human;

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
     CarcassType=Class'DeusEx.ChefCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ChefTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PantsTex10'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.ChefTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ChefTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.ChefTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.ChefTex3'
}
