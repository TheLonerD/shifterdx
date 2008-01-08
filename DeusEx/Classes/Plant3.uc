//=============================================================================
// Plant3.
//=============================================================================
class Plant3 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPlant3", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Houseplant"
     Mesh=LodMesh'DeusExDeco.Plant3'
     CollisionRadius=13.400000
     CollisionHeight=10.680000
     Mass=10.000000
     Buoyancy=15.000000
}
