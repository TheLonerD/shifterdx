//=============================================================================
// Tumbleweed.
//=============================================================================
class Tumbleweed extends Trash;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPTumbleWeed", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Tumbleweed"
     Mesh=LodMesh'DeusExDeco.Tumbleweed'
     CollisionRadius=33.000000
     CollisionHeight=21.570000
}
