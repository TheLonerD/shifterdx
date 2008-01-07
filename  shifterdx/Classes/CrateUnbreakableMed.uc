//=============================================================================
// CrateUnbreakableMed.
//=============================================================================
class CrateUnbreakableMed extends Containers;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcrateUnbreakableMed", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bInvincible=True
     bFlammable=False
     ItemName="Metal Crate"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateUnbreakableMed'
     CollisionRadius=45.200001
     CollisionHeight=32.000000
     Mass=80.000000
     Buoyancy=90.000000
}
