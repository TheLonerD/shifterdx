//=============================================================================
// Lamp3.
//=============================================================================
class Lamp3 extends Lamp;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPlamp3", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Desk Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp3'
     CollisionRadius=16.389999
     CollisionHeight=10.610000
     LightBrightness=192
     LightHue=96
     LightSaturation=128
     LightRadius=4
     Mass=30.000000
     Buoyancy=10.000000
}
