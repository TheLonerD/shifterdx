//=============================================================================
// MP Sandra Renton
//============================================================================
class MPSANREN extends Human;

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
     CarcassType=Class'DeusEx.SandraRentonCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=36.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SandraRentonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SandraRentonTex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SandraRentonTex0'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.SandraRentonTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.SandraRentonTex1'
     CollisionHeight=43.000000
}
