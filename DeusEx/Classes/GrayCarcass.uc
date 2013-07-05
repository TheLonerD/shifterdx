//=============================================================================
// GrayCarcass.
//=============================================================================
class GrayCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGrayCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGrayCarcass2", class'Mesh', True));
	}

	if(Mesh == None || Mesh2 == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;
	}
	else
	{
		Mesh3 = Mesh2;
	}

	return true;
} 

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GrayCarcass2'
     Mesh3=LodMesh'DeusExCharacters.GrayCarcass2'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.GrayCarcass'
     AmbientGlow=12
     CollisionRadius=36.000000
     CollisionHeight=6.240000
     LightType=LT_Steady
     LightBrightness=10
     LightHue=96
     LightSaturation=128
     LightRadius=5
}
