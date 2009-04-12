//=============================================================================
// Flowers.
//=============================================================================
class Flowers extends DeusExDecoration;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFlowers", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Flowers"
     Mesh=LodMesh'DeusExDeco.Flowers'
     CollisionRadius=11.880000
     CollisionHeight=9.630000
     Mass=20.000000
     Buoyancy=10.000000
}
