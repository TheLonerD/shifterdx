//=============================================================================
// TrashCan4.
//=============================================================================
class TrashCan4 extends Containers;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPtrashcan4", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bGenerateTrash=True
     bGenerateFlies=True
     ItemName="Trashcan"
     Mesh=LodMesh'DeusExDeco.TrashCan4'
     CollisionRadius=24.000000
     CollisionHeight=29.000000
     Mass=40.000000
     Buoyancy=50.000000
}
