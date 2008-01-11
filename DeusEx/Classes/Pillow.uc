//=============================================================================
// Pillow.
//=============================================================================
class Pillow extends DeusExDecoration;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPillow", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     FragType=Class'DeusEx.PaperFragment'
     ItemName="Pillow"
     Mesh=LodMesh'DeusExDeco.Pillow'
     CollisionRadius=17.000000
     CollisionHeight=4.130000
     Mass=5.000000
     Buoyancy=6.000000
}
