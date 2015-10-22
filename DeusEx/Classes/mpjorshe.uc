//=============================================================================
// MP Jordan Shea
//============================================================================
class MPJORSHE extends Human;

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
     CarcassType=Class'DeusEx.JordanSheaCarcass'
     JumpSound=Sound'DeusExSounds.Player.FemaleJump'
     bIsFemale=True
     HitSound1=Sound'DeusExSounds.Player.FemalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.FemalePainMedium'
     Land=Sound'DeusExSounds.Player.FemaleLand'
     Die=Sound'DeusExSounds.Player.FemaleDeath'
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.JordanSheaTex1'
     CollisionHeight=43.000000
}
