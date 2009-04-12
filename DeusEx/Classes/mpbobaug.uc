//=============================================================================
// MP Bob Page (augmented)
//============================================================================
class MPBOBAUG extends Human;

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();
}

function Carcass SpawnCarcass()
{
	local Carcass aCorpse;

	aCorpse = Super.SpawnCarcass();

	if(aCorpse != None)
	{
		aCorpse.Multiskins[0] = Texture'DeusExDeco.Skins.BobPageAugmentedTex2';
		aCorpse.Multiskins[2] = Texture'DeusExDeco.Skins.BobPageAugmentedTex2';
	}

	return aCorpse;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     CarcassType=Class'DeusEx.BobPageCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExDeco.Skins.BobPageAugmentedTex2'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.BobPageTex2'
     MultiSkins(2)=Texture'DeusExDeco.Skins.BobPageAugmentedTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.BobPageTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.BobPageTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
}
