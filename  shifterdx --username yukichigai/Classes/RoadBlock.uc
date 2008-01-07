//=============================================================================
// RoadBlock.
//=============================================================================
class RoadBlock extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTProadblock", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
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
