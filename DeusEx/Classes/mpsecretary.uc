//=============================================================================
// MP Secretary
//============================================================================
class MPSECRETARY extends Human;

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
     CarcassType=Class'DeusEx.SecretaryCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SecretaryTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SecretaryTex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SecretaryTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.SecretaryTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.SecretaryTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
     CollisionHeight=43.000000
}
