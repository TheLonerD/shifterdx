//=============================================================================
// Lamp1.
//=============================================================================
class Lamp1 extends Lamp;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPlamp1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     ItemName="Table Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp1'
     CollisionRadius=17.000000
     CollisionHeight=24.389999
     LightBrightness=192
     LightHue=44
     LightSaturation=128
     LightRadius=8
     Mass=40.000000
     Buoyancy=10.000000
}
