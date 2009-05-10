//=============================================================================
// Pot1.
//=============================================================================
class Pot1 extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPot1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Clay Pot"
     Mesh=LodMesh'DeusExDeco.Pot1'
     CollisionRadius=11.090000
     CollisionHeight=7.400000
     Mass=20.000000
     Buoyancy=5.000000
}
