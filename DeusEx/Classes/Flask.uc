//=============================================================================
// Flask.
//=============================================================================
class Flask extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPFlask", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     ItemName="Lab Flask"
     Mesh=LodMesh'DeusExDeco.Flask'
     CollisionRadius=4.300000
     CollisionHeight=7.470000
     Mass=5.000000
     Buoyancy=3.000000
}
