//=============================================================================
// MP Child 2
//=============================================================================
class MPCHILD2 extends Human;

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
     CarcassType=Class'DeusEx.ChildMale2Carcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     BaseEyeHeight=26.000000
     HitSound1=Sound'DeusExSounds.NPC.ChildPainMedium'
     HitSound2=Sound'DeusExSounds.NPC.ChildPainLarge'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.NPC.ChildDeath'
     Mesh=LodMesh'DeusExCharacters.GMK_DressShirt_F'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ChildMale2Tex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.ChildMale2Tex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=17.000000
     CollisionHeight=32.500000
}
