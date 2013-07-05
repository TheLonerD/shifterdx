//=============================================================================
// CouchLeather.
//=============================================================================
class CouchLeather extends Seat;

enum ESkinColor
{
	SC_Black,
	SC_Blue,
	SC_Brown,
	SC_LitGray,
	SC_Tan
};

var() ESkinColor SkinColor;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPCouchLeather", class'Mesh', True));

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
			case SC_Black:		Skin = Texture'CouchLeatherTex1'; break;
			case SC_Blue:		Skin = Texture'CouchLeatherTex2'; break;
			case SC_Brown:		Skin = Texture'CouchLeatherTex3'; break;
			case SC_LitGray:	Skin = Texture'CouchLeatherTex4'; break;
			case SC_Tan:		Skin = Texture'CouchLeatherTex5'; break;
		}
	}
}

defaultproperties
{
     sitPoint(0)=(X=-18.000000,Y=-8.000000,Z=0.000000)
     sitPoint(1)=(X=18.000000,Y=-8.000000,Z=0.000000)
     ItemName="Leather Couch"
     Mesh=LodMesh'DeusExDeco.CouchLeather'
     CollisionRadius=47.880001
     CollisionHeight=23.250000
     Mass=100.000000
     Buoyancy=110.000000
}
