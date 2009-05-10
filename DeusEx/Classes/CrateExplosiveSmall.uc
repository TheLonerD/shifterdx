//=============================================================================
// CrateExplosiveSmall.
//=============================================================================
class CrateExplosiveSmall extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcrateExplosive", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     HitPoints=4
     bExplosive=True
     explosionDamage=300
     explosionRadius=800.000000
     ItemName="TNT Crate"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateExplosiveSmall'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     Mass=30.000000
     Buoyancy=40.000000
}
