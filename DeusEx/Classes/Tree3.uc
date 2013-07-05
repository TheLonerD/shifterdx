//=============================================================================
// Tree3.
//=============================================================================
class Tree3 extends Tree;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree03", class'Mesh', True));
		Altmesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTree03b", class'Mesh', True));
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
     Mesh=LodMesh'DeusExDeco.Tree3'
     CollisionRadius=30.000000
     CollisionHeight=124.339996
}
