//=============================================================================
// BoxLarge.
//=============================================================================
class BoxLarge extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPboxlarge", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bRandomize=True
     FragType=Class'DeusEx.PaperFragment'
     ItemName="Cardboard Box"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.BoxLarge'
     CollisionRadius=42.000000
     CollisionHeight=50.000000
     Mass=80.000000
     Buoyancy=90.000000
}
