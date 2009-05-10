//=============================================================================
// Vase1.
//=============================================================================
class Vase1 extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPvase1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     ItemName="Vase"
     Mesh=LodMesh'DeusExDeco.Vase1'
     CollisionRadius=6.700000
     CollisionHeight=14.810000
     Mass=20.000000
     Buoyancy=15.000000
}
