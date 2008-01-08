//=============================================================================
// MP Doctor
//============================================================================
class MPDOC extends Human;

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
     CarcassType=Class'DeusEx.DoctorCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.DoctorTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.DoctorTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.DoctorTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
}
