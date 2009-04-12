//=============================================================================
// Pan3.
//=============================================================================
class Pan3 extends DeusExDecoration;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPan3",class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Frying Pan"
     Mesh=LodMesh'DeusExDeco.Pan3'
     CollisionRadius=7.460000
     CollisionHeight=1.910000
     Mass=20.000000
     Buoyancy=5.000000
}
