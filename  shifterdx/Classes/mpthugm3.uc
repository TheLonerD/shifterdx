//=============================================================================
// MP Thug Male 3
//============================================================================
class MPTHUGM3 extends Human;

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
     CarcassType=Class'DeusEx.ThugMale3Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Texture=Texture'DeusExItems.Skins.BlackMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_B'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ThugMale3Tex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ThugMale3Tex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.ThugMale3Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ThugMale3Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.ThugMale3Tex3'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
