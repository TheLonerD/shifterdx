//=============================================================================
// Cushion.
//=============================================================================
class Cushion extends Furniture;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcushion", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
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
