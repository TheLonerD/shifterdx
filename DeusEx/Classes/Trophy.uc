//=============================================================================
// Trophy.
//=============================================================================
class Trophy extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPTrophy", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     ItemName="Trophy Cup"
     Mesh=LodMesh'DeusExDeco.Trophy'
     CollisionRadius=11.030000
     CollisionHeight=10.940000
     Mass=40.000000
     Buoyancy=10.000000
}
