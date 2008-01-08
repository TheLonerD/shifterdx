//=============================================================================
// MP Female 4
//============================================================================
class MPFEM4 extends Human;

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
     CarcassType=Class'DeusEx.Female4Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Female4Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.Female4Tex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Female4Tex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Female4Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.Female4Tex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
