//=============================================================================
// Pan1.
//=============================================================================
class Pan1 extends DeusExDecoration;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPan1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Frying Pan"
     Mesh=LodMesh'DeusExDeco.Pan1'
     CollisionRadius=14.500000
     CollisionHeight=1.600000
     Mass=20.000000
     Buoyancy=5.000000
}
