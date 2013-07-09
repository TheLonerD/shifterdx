//=============================================================================
// Trashcan2.
//=============================================================================
class Trashcan2 extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPtrashcan2", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bLootable=True
     bRandomize=True
     bGenerateTrash=True
     ItemName="Trashcan"
     Mesh=LodMesh'DeusExDeco.Trashcan2'
     CollisionRadius=14.860000
     CollisionHeight=24.049999
     Mass=40.000000
     Buoyancy=50.000000
}
