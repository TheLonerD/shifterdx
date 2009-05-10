//=============================================================================
// RoadBlock.
//=============================================================================
class RoadBlock extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTProadblock", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     HitPoints=75
     minDamageThreshold=75
     FragType=Class'DeusEx.Rockchip'
     ItemName="Concrete Barricade"
     Mesh=LodMesh'DeusExDeco.RoadBlock'
     CollisionRadius=33.000000
     CollisionHeight=23.400000
     Mass=200.000000
     Buoyancy=50.000000
}
