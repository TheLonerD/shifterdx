//=============================================================================
// ShopLight.
//=============================================================================
class ShopLight extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPShoplight", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
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
