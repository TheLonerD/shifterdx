//=============================================================================
// PaulDentonCarcass.
//=============================================================================
class PaulDentonCarcass extends DeusExCarcass;

var Texture PaulTex[5];
var Texture PaulHandTex[5];

function bool Facelift(bool bOn)
{
	local int i;
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGM_TrenchCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGM_TrenchCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGM_TrenchCarcassC", class'Mesh', True));
	}

	if(Mesh == None || Mesh2 == None || Mesh3 == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];

		for(i = 0; i < 5; ++i)
		{
			PaulTex[i] = Default.PaulTex[i];
			PaulHandTex[i] = Default.PaulHandTex[i];
		}
	}
	else
	{
		MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex1", class'Texture'));
		MultiSkins[2] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex2", class'Texture'));
		MultiSkins[4] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex4", class'Texture'));
		MultiSkins[5] = Texture'PinkMaskTex';
		MultiSkins[6] = Texture'PinkMaskTex';
		MultiSkins[7] = Texture'PinkMaskTex';

		PaulTex[0] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex0", class'Texture'));
		PaulHandTex[0] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCHandsTex0", class'Texture'));

		for(i = 1; i < 5; ++i)
		{
			PaulTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex"$ (i+1), class'Texture'));
			PaulHandTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCHandsTex"$ i, class'Texture'));
		}
	}

	return true;
} 

// ----------------------------------------------------------------------
// PostPostBeginPlay()
// ----------------------------------------------------------------------

function PostPostBeginPlay()
{
	local DeusExPlayer player;

	Super.PostPostBeginPlay();

	foreach AllActors(class'DeusExPlayer', player)
		break;

	SetSkin(player);
}

// ----------------------------------------------------------------------
// SetSkin()
// ----------------------------------------------------------------------

function SetSkin(DeusExPlayer player)
{
	if (player != None)
	{
		MultiSkins[0] = PaulTex[player.PlayerSkin];
		MultiSkins[3] = PaulHandTex[player.PlayerSkin];
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_Trench_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_Trench_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GM_Trench_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.PaulDentonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PaulDentonTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.PaulDentonTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.PaulDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.PaulDentonTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=40.000000
     PaulTex(0)=Texture'PaulDentonTex0'
     PaulTex(1)=Texture'PaulDentonTex4'
     PaulTex(2)=Texture'PaulDentonTex5'
     PaulTex(3)=Texture'PaulDentonTex6'
     PaulTex(4)=Texture'PaulDentonTex7'
     PaulHandTex(0)=Texture'PaulDentonTex0'
     PaulHandTex(1)=Texture'PaulDentonTex4'
     PaulHandTex(2)=Texture'PaulDentonTex5'
     PaulHandTex(3)=Texture'PaulDentonTex6'
     PaulHandTex(4)=Texture'PaulDentonTex7'
}
