//=============================================================================
// MP Hooker 2
//============================================================================
class MPHOOKER2 extends Human;

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
     CarcassType=Class'DeusEx.Hooker2Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_Dress'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Hooker2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.Hooker2Tex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Hooker2Tex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Hooker2Tex3'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.Hooker2Tex2'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.Hooker2Tex0'
     CollisionHeight=43.000000
}
