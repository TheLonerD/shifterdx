//=============================================================================
// TrashCan1.
//=============================================================================
class TrashCan1 extends Containers;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPtrashcan1", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bGenerateTrash=True
     ItemName="Trashcan"
     Mesh=LodMesh'DeusExDeco.TrashCan1'
     CollisionRadius=19.250000
     CollisionHeight=33.000000
     Mass=50.000000
     Buoyancy=60.000000
}
