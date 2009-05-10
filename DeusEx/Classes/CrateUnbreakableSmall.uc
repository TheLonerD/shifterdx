//=============================================================================
// CrateUnbreakableSmall.
//=============================================================================
class CrateUnbreakableSmall extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcrateUnbreakableSmall", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bInvincible=True
     bFlammable=False
     ItemName="Metal Crate"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateUnbreakableSmall'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     Mass=40.000000
     Buoyancy=50.000000
}
