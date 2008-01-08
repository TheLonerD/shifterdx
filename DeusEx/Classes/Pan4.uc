//=============================================================================
// Pan4.
//=============================================================================
class Pan4 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPan4", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Pot"
     Mesh=LodMesh'DeusExDeco.Pan4'
     CollisionRadius=11.790000
     CollisionHeight=6.750000
     Mass=20.000000
     Buoyancy=5.000000
}
