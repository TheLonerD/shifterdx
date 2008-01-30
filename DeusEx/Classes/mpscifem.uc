//=============================================================================
// MP Scientist Female
//============================================================================
class MPSCIFEM extends Human;

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
     CarcassType=Class'DeusEx.ScientistFemaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.FemaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.FemalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.FemalePainMedium'
     Land=Sound'DeusExSounds.Player.FemaleLand'
     Die=Sound'DeusExSounds.Player.FemaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ScientistFemaleTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ScientistFemaleTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.ScientistFemaleTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ScientistFemaleTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TrenchShirtTex3'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.ScientistFemaleTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
     CollisionHeight=43.000000
}
