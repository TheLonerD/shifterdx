//=============================================================================
// Microscope.
//=============================================================================
class Microscope extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPMicroscope",class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     ItemName="Microscope"
     Mesh=LodMesh'DeusExDeco.Microscope'
     CollisionRadius=6.420000
     CollisionHeight=10.660000
     Mass=20.000000
     Buoyancy=10.000000
}
