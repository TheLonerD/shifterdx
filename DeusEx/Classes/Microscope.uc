//=============================================================================
// Microscope.
//=============================================================================
class Microscope extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPMicroscope",class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
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
