//=============================================================================
// MP Nicolette DuClare
//============================================================================
class MPNICOLE extends Human;

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
     CarcassType=Class'DeusEx.NicoletteDuClareCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     bIsFemale=True
     BaseEyeHeight=38.000000
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_Dress'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     CollisionHeight=43.000000
}
