//=============================================================================
// Plant1.
//=============================================================================
class Plant1 extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPlant1", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Houseplant"
     Mesh=LodMesh'DeusExDeco.Plant1'
     CollisionRadius=11.000000
     CollisionHeight=34.500000
     Mass=10.000000
     Buoyancy=15.000000
}
