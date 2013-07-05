//=============================================================================
// HangingShopLight.
//=============================================================================
class HangingShopLight extends HangingDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPHangingShopLight", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bNoPitch=True
     bInvincible=True
     FragType=Class'DeusEx.GlassFragment'
     ItemName="Flourescent Light"
     Mesh=LodMesh'DeusExDeco.HangingShopLight'
     PrePivot=(Z=39.450001)
     CollisionRadius=42.500000
     CollisionHeight=39.450001
     Mass=30.000000
     Buoyancy=25.000000
}
