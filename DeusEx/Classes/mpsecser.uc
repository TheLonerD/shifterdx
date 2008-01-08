//=============================================================================
// MP Secret Service Agent
//============================================================================
class MPSECSER extends Human;

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
     CarcassType=Class'DeusEx.SecretServiceCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SecretServiceTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SecretServiceTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SecretServiceTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SecretServiceTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.SecretServiceTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
}
