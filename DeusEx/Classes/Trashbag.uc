//=============================================================================
// Trashbag.
//=============================================================================
class Trashbag extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPtrashbag1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bGenerateTrash=True
     HitPoints=10
     FragType=Class'DeusEx.PaperFragment'
     bGenerateFlies=True
     ItemName="Trashbag"
     Mesh=LodMesh'DeusExDeco.Trashbag'
     CollisionRadius=26.360001
     CollisionHeight=26.760000
     Mass=30.000000
     Buoyancy=40.000000
}
