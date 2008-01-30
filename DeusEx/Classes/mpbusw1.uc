//=============================================================================
// MP Businesswoman
//============================================================================
class MPBUSW1 extends Human;

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
     CarcassType=Class'DeusEx.Businesswoman1Carcass'
     JumpSound=Sound'DeusExSounds.Player.FemaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.FemalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.FemalePainMedium'
     Land=Sound'DeusExSounds.Player.FemaleLand'
     Die=Sound'DeusExSounds.Player.FemaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt_F'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Businesswoman1Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.Businesswoman1Tex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Businesswoman1Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Businesswoman1Tex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.Businesswoman1Tex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.Businesswoman1Tex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
