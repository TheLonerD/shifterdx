//=============================================================================
// MP Nurse
//============================================================================
class MPNURSE extends Human;

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
     CarcassType=Class'DeusEx.NurseCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NurseTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NurseTex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NurseTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NurseTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.NurseTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionHeight=43.000000
}
