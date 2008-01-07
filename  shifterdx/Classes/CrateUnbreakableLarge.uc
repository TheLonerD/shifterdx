//=============================================================================
// CrateUnbreakableLarge.
//=============================================================================
class CrateUnbreakableLarge extends Containers;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCrateUnbreakableLarge", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bInvincible=True
     bFlammable=False
     ItemName="Metal Crate"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateUnbreakableLarge'
     CollisionRadius=56.500000
     CollisionHeight=56.000000
     Mass=150.000000
     Buoyancy=160.000000
}
