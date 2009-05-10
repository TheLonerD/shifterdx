//=============================================================================
// ShowerHead.
//=============================================================================
class ShowerHead extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPShowerHead", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bInvincible=True
     ItemName="Shower Head"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.ShowerHead'
     CollisionRadius=9.480000
     CollisionHeight=8.410000
     Mass=20.000000
     Buoyancy=10.000000
}
