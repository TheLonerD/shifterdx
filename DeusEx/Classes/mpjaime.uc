//=============================================================================
// MP Jaime Reyes
//============================================================================
class MPJAIME extends Human;

function Bool HasTwoHandedWeapon()
{
	return False;
}

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
     CarcassType=Class'DeusEx.JaimeReyesCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     BaseEyeHeight=36.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench_F'
     DrawScale=0.900000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JaimeReyesTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JaimeReyesTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JaimeReyesTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionHeight=42.799999
}
