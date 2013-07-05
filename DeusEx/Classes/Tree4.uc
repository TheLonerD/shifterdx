//=============================================================================
// Tree4.
//=============================================================================
class Tree4 extends Tree;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree04", class'Mesh', True));
		Altmesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree04b", class'Mesh', True));
	}

	if(Mesh == None || Altmesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		HDTPtex[0] = None;
		HDTPtex[1] = None;
	}

	return true;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Tree4'
     CollisionRadius=40.000000
     CollisionHeight=188.600006
}
