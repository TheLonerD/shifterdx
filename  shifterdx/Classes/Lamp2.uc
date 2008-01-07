//=============================================================================
// Lamp2.
//=============================================================================
class Lamp2 extends Lamp;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPlamp2", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Halogen Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=14.000000
     CollisionHeight=47.000000
     LightHue=140
     LightSaturation=192
     Mass=40.000000
     Buoyancy=10.000000
}
