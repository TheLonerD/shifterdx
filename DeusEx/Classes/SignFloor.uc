//=============================================================================
// SignFloor.
//=============================================================================
class SignFloor extends DeusExDecoration;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPSignfloor", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Caution Sign"
     Mesh=LodMesh'DeusExDeco.SignFloor'
     CollisionRadius=12.500000
     CollisionHeight=15.380000
     Mass=10.000000
     Buoyancy=12.000000
}
