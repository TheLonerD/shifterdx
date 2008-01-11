//=============================================================================
// BoxMedium.
//=============================================================================
class BoxMedium extends Containers;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPboxmedium", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     HitPoints=10
     FragType=Class'DeusEx.PaperFragment'
     ItemName="Cardboard Box"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.BoxMedium'
     CollisionRadius=42.000000
     CollisionHeight=30.000000
     Mass=50.000000
     Buoyancy=60.000000
}
