//=============================================================================
// MP Child
//=============================================================================
class MPCHILD extends Human;

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
     CarcassType=Class'DeusEx.ChildMaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     BaseEyeHeight=26.000000
     HitSound1=Sound'DeusExSounds.NPC.ChildPainMedium'
     HitSound2=Sound'DeusExSounds.NPC.ChildPainLarge'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.NPC.ChildDeath'
     Mesh=LodMesh'DeusExCharacters.GMK_DressShirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ChildMaleTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ChildMaleTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ChildMaleTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.ChildMaleTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=17.000000
     CollisionHeight=32.500000
}
