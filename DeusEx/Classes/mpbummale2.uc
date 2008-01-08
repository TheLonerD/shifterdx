//=============================================================================
// MP Bum Male 2
//============================================================================
class MPBUMMALE2 extends Human;

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
     CarcassType=Class'DeusEx.BumMale2Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.BumMale2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.BumMale2Tex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex4'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.BumMale2Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TrenchShirtTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.BumMale2Tex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
