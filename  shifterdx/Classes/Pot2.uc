//=============================================================================
// Pot2.
//=============================================================================
class Pot2 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPot2", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Clay Pot"
     Mesh=LodMesh'DeusExDeco.Pot2'
     CollisionRadius=7.980000
     CollisionHeight=13.000000
     Mass=20.000000
     Buoyancy=5.000000
}
