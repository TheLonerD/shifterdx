//=============================================================================
// MP Junkie Female
//============================================================================
class MPJUNKFEM extends Human;

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
     CarcassType=Class'DeusEx.JunkieFemaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JunkieFemaleTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JunkieFemaleTex0'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JunkieFemaleTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.JunkieFemaleTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.JunkieFemaleTex1'
     CollisionHeight=43.000000
}
