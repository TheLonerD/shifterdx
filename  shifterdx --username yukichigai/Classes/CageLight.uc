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
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_1:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex1", class'Texture', True));
				Skin = Texture'CageLightTex1'; break;
		case SC_2:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex2", class'Texture', True));
				Skin = Texture'CageLightTex2'; break;
		case SC_3:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex3", class'Texture', True));
				Skin = Texture'CageLightTex3'; break;
		case SC_4:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex4", class'Texture', True));
				Skin = Texture'CageLightTex4'; break;
		case SC_5:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex5", class'Texture', True));
				Skin = Texture'CageLightTex5'; break;
		case SC_6:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCageLightTex6", class'Texture', True));
				Skin = Texture'CageLightTex6'; break;
	}

	MultiSkins[2] = MultiSkins[1];
	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCageLight", class'mesh', True));
	if(Mesh != None)
		Skin = None;
	else
		Mesh = Default.Mesh;
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
