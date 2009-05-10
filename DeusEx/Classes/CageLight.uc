//=============================================================================
// CageLight.
//=============================================================================
class CageLight extends DeusExDecoration;

enum ESkinColor
{
	SC_1,
	SC_2,
	SC_3,
	SC_4,
	SC_5,
	SC_6
};

var() ESkinColor SkinColor;
var() bool bOn;

function Trigger(Actor Other, Pawn Instigator)
{
	Super.Trigger(Other, Instigator);

	if (!bOn)
	{
		bOn = True;
		LightType = LT_Steady;
		bUnlit = True;
		ScaleGlow = 2.0;
	}
	else
	{
		bOn = False;
		LightType = LT_None;
		bUnlit = False;
		ScaleGlow = 1.0;
	}
}

function BeginPlay()
{
	local String texstr;

	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_1:	texstr = "CageLightTex1";
				break;
		case SC_2:	texstr = "CageLightTex2";
				break;
		case SC_3:	texstr = "CageLightTex3";
				break;
		case SC_4:	texstr = "CageLightTex4";
				break;
		case SC_5:	texstr = "CageLightTex5";
				break;
		case SC_6:	texstr = "CageLightTex6";
				break;
	}


	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCageLight", class'mesh', True));

	if(Mesh == None)
	{
		MultiSkins[1] = None;
		MultiSkins[2] = None;
		Mesh = Default.Mesh;
		Skin = Texture(DynamicLoadObject("DeusExDeco." $ texstr, class'Texture', True));
	}
	else
	{
		Skin = None;
		MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture', True));
		MultiSkins[2] = MultiSkins[1];
	}
}

function bool Facelift(bool bLiftOn)
{
	local String texstr;

	if(!Super.Facelift(bLiftOn))
		return false;

	switch (SkinColor)
	{
		case SC_1:	texstr = "CageLightTex1";
				break;
		case SC_2:	texstr = "CageLightTex2";
				break;
		case SC_3:	texstr = "CageLightTex3";
				break;
		case SC_4:	texstr = "CageLightTex4";
				break;
		case SC_5:	texstr = "CageLightTex5";
				break;
		case SC_6:	texstr = "CageLightTex6";
				break;
	}


	if(bLiftOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCageLight", class'mesh', True));

	if(Mesh == None || !bLiftOn)
	{
		MultiSkins[1] = None;
		MultiSkins[2] = None;
		Mesh = Default.Mesh;
		Skin = Texture(DynamicLoadObject("DeusExDeco." $ texstr, class'Texture', True));
	}
	else
	{
		Skin = None;
		MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture', True));
		MultiSkins[2] = MultiSkins[1];
	}

	return true;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (!bOn)
		LightType = LT_None;
}

defaultproperties
{
     bOn=True
     HitPoints=5
     bInvincible=True
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     bCanBeBase=True
     ItemName="Light Fixture"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.CageLight'
     ScaleGlow=2.000000
     CollisionRadius=17.139999
     CollisionHeight=17.139999
     LightType=LT_Steady
     LightBrightness=255
     LightHue=32
     LightSaturation=224
     LightRadius=8
     Mass=20.000000
     Buoyancy=10.000000
}
