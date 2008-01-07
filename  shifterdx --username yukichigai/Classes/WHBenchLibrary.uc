//=============================================================================
// WHBenchLibrary.
//=============================================================================
class WHBenchLibrary extends Seat;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPWHBenchLibrary", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     sitPoint(0)=(X=0.000000,Y=0.000000,Z=0.000000)
     ItemName="Bench"
     Mesh=LodMesh'DeusExDeco.WHBenchLibrary'
     CollisionRadius=56.000000
     CollisionHeight=34.000000
     Mass=25.000000
     Buoyancy=5.000000
}
