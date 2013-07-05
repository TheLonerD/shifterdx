//=============================================================================
// JCDouble.
//=============================================================================
class JCDouble extends HumanMilitary;

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

	SetSkin(DeusExPlayer(GetPlayerPawn()));

	return true;
}

//
// JC's cinematic stunt double!
//
function SetSkin(DeusExPlayer player)
{
	if (player != None)
	{
		MultiSkins[0] = JCTex[player.PlayerSkin];
	
		if(Mesh != Default.Mesh)
			MultiSkins[3] = JCHandTex[player.PlayerSkin];
	}
}

function ImpartMomentum(Vector momentum, Pawn instigatedBy)
{
	// to ensure JC's understudy doesn't get impact momentum from damage...
}

function AddVelocity( vector NewVelocity)
{
}


// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     WalkingSpeed=0.120000
     bInvincible=True
     BaseAssHeight=-23.000000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JCDentonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JCDentonTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JCDentonTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JCDentonTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JCDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JCDentonTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex5'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="JCDouble"
     FamiliarName="JC Denton"
     UnfamiliarName="JC Denton"
     JCTex(0)=Texture'JCDentonTex0'
     JCTex(1)=Texture'JCDentonTex4'
     JCTex(2)=Texture'JCDentonTex5'
     JCTex(3)=Texture'JCDentonTex6'
     JCTex(4)=Texture'JCDentonTex7'
}
