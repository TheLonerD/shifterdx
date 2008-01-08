//=============================================================================
// Pot1.
//=============================================================================
class Pot1 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPot1", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Clay Pot"
     Mesh=LodMesh'DeusExDeco.Pot1'
     CollisionRadius=11.090000
     CollisionHeight=7.400000
     Mass=20.000000
     Buoyancy=5.000000
}
