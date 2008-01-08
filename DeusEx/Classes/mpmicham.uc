//=============================================================================
// MP Michael Hamner
//============================================================================
class MPMICHAM extends Human;

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
     CarcassType=Class'DeusEx.MichaelHamnerCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MichaelHamnerTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MichaelHamnerTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.MichaelHamnerTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MichaelHamnerTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MichaelHamnerTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex2'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
}
