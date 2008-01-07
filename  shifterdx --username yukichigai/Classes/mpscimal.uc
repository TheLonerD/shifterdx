//=============================================================================
// MP Scientist Male
//============================================================================
class MPSCIMAL extends Human;

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
     CarcassType=Class'DeusEx.ScientistMaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     DrawScale=0.950000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ScientistMaleTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ScientistMaleTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TrenchShirtTex3'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
     CollisionRadius=19.000000
     CollisionHeight=45.130001
}
