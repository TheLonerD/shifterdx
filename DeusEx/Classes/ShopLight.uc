//=============================================================================
// ShopLight.
//=============================================================================
class ShopLight extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPShoplight", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     ItemName="Flourescent Light"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.ShopLight'
     CollisionRadius=42.500000
     CollisionHeight=4.000000
     Mass=30.000000
     Buoyancy=25.000000
}
