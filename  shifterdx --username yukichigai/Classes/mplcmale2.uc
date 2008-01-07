//=============================================================================
// MP Lower Class Male 2
//============================================================================
class MPLCMALE2 extends Human;

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
     CarcassType=Class'DeusEx.LowerClassMale2Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
}
