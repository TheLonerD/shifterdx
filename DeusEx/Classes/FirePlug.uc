//=============================================================================
// FirePlug.
//=============================================================================
class FirePlug expands OutdoorThings;

enum ESkinColor
{
	SC_Red,
	SC_Orange,
	SC_Blue,
	SC_Gray
};

var() ESkinColor SkinColor;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPFirePlug", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

	if(Mesh == Default.Mesh)
	{
		switch (SkinColor)
		{
			case SC_Red:	Skin = Texture'FirePlugTex1'; break;
			case SC_Orange:	Skin = Texture'FirePlugTex2'; break;
			case SC_Blue:	Skin = Texture'FirePlugTex3'; break;
			case SC_Gray:	Skin = Texture'FirePlugTex4'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_Red:	Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFirePlugTex1", class'Texture', True)); break;
			case SC_Orange:	Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFirePlugTex2", class'Texture', True)); break;
			case SC_Blue:	Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFirePlugTex3", class'Texture', True)); break;
			case SC_Gray:	Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFirePlugTex4", class'Texture', True)); break;
		}

	}
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.FirePlug'
     CollisionRadius=8.000000
     CollisionHeight=16.500000
     Mass=50.000000
     Buoyancy=30.000000
}
