//=============================================================================
// MP Luminous Path 2
//============================================================================
class MPTLP2 extends Human;

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
     CarcassType=Class'DeusEx.TriadLumPath2Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     DrawScale=1.050000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.TriadLumPath2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PantsTex10'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.TriadLumPath2Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.TriadLumPathTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TriadLumPathTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.PonytailTex1'
     CollisionRadius=16.799999
     CollisionHeight=48.830002
}
