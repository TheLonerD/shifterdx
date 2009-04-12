//=============================================================================
// Cushion.
//=============================================================================
class Cushion extends Furniture;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcushion", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PaperFragment'
     bCanBeBase=True
     ItemName="Floor Cushion"
     Mesh=LodMesh'DeusExDeco.Cushion'
     CollisionRadius=27.000000
     CollisionHeight=3.190000
     Mass=20.000000
     Buoyancy=25.000000
}
