//=============================================================================
// MP Nathan Madison
//============================================================================
class MPNATMAD extends Human;

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
     CarcassType=Class'DeusEx.NathanMadisonCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NathanMadisonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NathanMadisonTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NathanMadisonTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.NathanMadisonTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NathanMadisonTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
}
