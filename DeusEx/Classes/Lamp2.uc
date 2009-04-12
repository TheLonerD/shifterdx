//=============================================================================
// Lamp2.
//=============================================================================
class Lamp2 extends Lamp;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPlamp2", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Halogen Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=14.000000
     CollisionHeight=47.000000
     LightHue=140
     LightSaturation=192
     Mass=40.000000
     Buoyancy=10.000000
}
