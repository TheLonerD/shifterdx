//=============================================================================
// Plant2.
//=============================================================================
class Plant2 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPlant2", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Houseplant"
     Mesh=LodMesh'DeusExDeco.Plant2'
     CollisionRadius=23.260000
     CollisionHeight=43.880001
     Mass=20.000000
     Buoyancy=20.000000
}
