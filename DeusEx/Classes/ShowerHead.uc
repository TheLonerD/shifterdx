//=============================================================================
// ShowerHead.
//=============================================================================
class ShowerHead extends DeusExDecoration;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPShowerHead", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
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
