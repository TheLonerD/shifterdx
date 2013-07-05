//=============================================================================
// Tree1.
//=============================================================================
class Tree1 extends Tree;

enum ESkinColor
{
	SC_Tree1,
	SC_Tree2,
	SC_Tree3
};

var() ESkinColor SkinColor;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree01", class'Mesh', True));
		Altmesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree01b", class'Mesh', True));
	}

	if(Mesh == None || Altmesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		HDTPtex[0] = None;
		HDTPtex[1] = None;
		switch (SkinColor)
		{
			case SC_Tree1:	Skin = Texture'Tree2Tex1'; break;
			case SC_Tree2:	Skin = Texture'Tree2Tex2'; break;
			case SC_Tree3:	Skin = Texture'Tree2Tex3'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_Tree1:	
			case SC_Tree2:	Skin = HDTPTex[0]; break;
			case SC_Tree3:	Skin = HDTPTex[1]; break;
		}
	}	

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

	if(Mesh == Default.Mesh)
	{
		switch (SkinColor)
		{
			case SC_Tree1:	Skin = Texture'Tree2Tex1'; break;
			case SC_Tree2:	Skin = Texture'Tree2Tex2'; break;
			case SC_Tree3:	Skin = Texture'Tree2Tex3'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_Tree1:	
			case SC_Tree2:	Skin = HDTPTex[0]; break;
			case SC_Tree3:	Skin = HDTPTex[1]; break;
		}
	}
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Tree1'
     CollisionRadius=10.000000
     CollisionHeight=125.000000
}
