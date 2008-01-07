//=============================================================================
// MP Red Arrow
//============================================================================
class MPTRA extends Human;

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
     BaseEyeHeight=36.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.TriadRedArrowTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TriadRedArrowTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.TriadRedArrowTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.TriadRedArrowTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TriadRedArrowTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.TriadRedArrowTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=14.000000
}
