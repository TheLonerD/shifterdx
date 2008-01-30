//=============================================================================
// MP Female 2
//============================================================================
class MPFEM2 extends Human;

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
     CarcassType=Class'DeusEx.Female2Carcass'
     JumpSound=Sound'DeusExSounds.Player.FemaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.FemalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.FemalePainMedium'
     Land=Sound'DeusExSounds.Player.FemaleLand'
     Die=Sound'DeusExSounds.Player.FemaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Female2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.Female2Tex0'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Female2Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Female2Tex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.Female2Tex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.Female2Tex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
}
