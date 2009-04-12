//=============================================================================
// Basket.
//=============================================================================
class Basket extends Containers;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPbasket", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PaperFragment'
     ItemName="Wicker Basket"
     Mesh=LodMesh'DeusExDeco.Basket'
     CollisionRadius=27.530001
     CollisionHeight=9.500000
     Mass=20.000000
     Buoyancy=25.000000
}
