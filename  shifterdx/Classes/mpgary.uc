//=============================================================================
// MP Gary Savage
//============================================================================
class MPGARY extends Human;

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
     CarcassType=Class'DeusEx.GarySavageCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.GarySavageTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.GarySavageTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.GarySavageTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex5'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex6'
}
