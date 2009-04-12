//=============================================================================
// CrateUnbreakableLarge.
//=============================================================================
class CrateUnbreakableLarge extends Containers;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCrateUnbreakableLarge", class'mesh', True));

	if(Mesh == None || !bOn)
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
