//=============================================================================
// CeilingFan.
//=============================================================================
class CeilingFan extends DeusExDecoration;

enum ESkinColor
{
	SC_WoodBrass,
	SC_DarkWoodIron,
	SC_White,
	SC_WoodBrassFancy,
	SC_WoodPlastic
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	if(Mesh == None || Mesh == Default.Mesh)
	{
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_WoodBrass:		Skin = Texture'CeilingFanTex1'; break;
			case SC_DarkWoodIron:		Skin = Texture'CeilingFanTex2'; break;
			case SC_White:			Skin = Texture'CeilingFanTex3'; break;
			case SC_WoodBrassFancy:		Skin = Texture'CeilingFanTex4'; break;
			case SC_WoodPlastic:		Skin = Texture'CeilingFanTex5'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_WoodBrass:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex1", class'Texture')); break;
			case SC_DarkWoodIron:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex2", class'Texture')); break;
			case SC_White:			Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex3", class'Texture')); break;
			case SC_WoodBrassFancy:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex4", class'Texture')); break;
			case SC_WoodPlastic:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex5", class'Texture')); break;
		}
	}
}

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPceilingfan", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Multiskins[1] = None;
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_WoodBrass:		Skin = Texture'CeilingFanTex1'; break;
			case SC_DarkWoodIron:		Skin = Texture'CeilingFanTex2'; break;
			case SC_White:			Skin = Texture'CeilingFanTex3'; break;
			case SC_WoodBrassFancy:		Skin = Texture'CeilingFanTex4'; break;
			case SC_WoodPlastic:		Skin = Texture'CeilingFanTex5'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_WoodBrass:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex1", class'Texture')); break;
			case SC_DarkWoodIron:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex2", class'Texture')); break;
			case SC_White:			Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex3", class'Texture')); break;
			case SC_WoodBrassFancy:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex4", class'Texture')); break;
			case SC_WoodPlastic:		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCeilingFanTex5", class'Texture')); break;
		}
	}

	return true;
}

defaultproperties
{
     SkinColor=SC_DarkWoodIron
     FragType=Class'DeusEx.WoodFragment'
     bHighlight=False
     bCanBeBase=True
     ItemName="Ceiling Fan Blades"
     bPushable=False
     Physics=PHYS_Rotating
     RemoteRole=ROLE_SimulatedProxy
     Mesh=LodMesh'DeusExDeco.CeilingFan'
     CollisionRadius=45.750000
     CollisionHeight=3.300000
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=50.000000
     Buoyancy=30.000000
     RotationRate=(Yaw=16384)
}
