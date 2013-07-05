//=============================================================================
// JCDentonMale.
//=============================================================================
class JCDentonMale extends Human;

var Texture JCTex[5];
var Texture JCHandTex[5];

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGM_Trench", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];

		for(i = 0; i < 5; ++i)
		{
			JCTex[i] = Default.JCTex[i];
			JCHandTex[i] = None;
		}
	}
	else
	{
		MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex1", class'Texture'));
		MultiSkins[2] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex2", class'Texture'));
		MultiSkins[4] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex4", class'Texture'));
		MultiSkins[5] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex5", class'Texture'));
		MultiSkins[6] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex6", class'Texture'));
		MultiSkins[7] = Texture'BlackMaskTex';

		for(i = 0; i < 5; ++i)
		{
			JCTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCFaceTex"$ i, class'Texture'));
			JCHandTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCHandsTex"$ i, class'Texture'));
		}
	}

	SetSkin();

	return true;
}

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();

	SetSkin();
}

function SetSkin()
{
	MultiSkins[0] = JCTex[PlayerSkin];

	if(Mesh != Default.Mesh)
		MultiSkins[3] = JCHandTex[PlayerSkin];
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     CarcassType=Class'DeusEx.JCDentonMaleCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JCDentonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JCDentonTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JCDentonTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JCDentonTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JCDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JCDentonTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex5'
     JCTex(0)=Texture'JCDentonTex0'
     JCTex(1)=Texture'JCDentonTex4'
     JCTex(2)=Texture'JCDentonTex5'
     JCTex(3)=Texture'JCDentonTex6'
     JCTex(4)=Texture'JCDentonTex7'
}
