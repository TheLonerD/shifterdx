//=============================================================================
// RatCarcass.
//=============================================================================
class RatCarcass extends DeusExCarcass;

var mesh CarcassMesh[6];

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		CarcassMesh[0] = Mesh(DynamicLoadObject("HDTPCharacters.HDTPRatCarcass", class'Mesh', True));
	}

	if(CarcassMesh[0] == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;

		for(i = 0; i < 6; ++i)
			CarcassMesh[0] = None;
	}
	else
	{
		//== BEGIN COMPLICATION!  Preload all the meshes and then pick one randomly
		for(i = 2; i < 7; ++i)
		{
			CarcassMesh[i-1] = Mesh(DynamicLoadObject("HDTPCharacters.HDTPRatCarcass"$ i, class'Mesh', True));
			if(CarcassMesh[i-1] == None)
				CarcassMesh[i-1] = CarcassMesh[i-2];
		}

		//== Only pick a new mesh if we haven't already done so.  Otherwise rat carcasses shift on every load
		if(Mesh == Default.Mesh)
		{
			Mesh = CarcassMesh[rand(6)];
			Mesh2 = Mesh;
			Mesh3 = Mesh;
		}
	}

	return true;
} 

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.RatCarcass'
     Mesh3=LodMesh'DeusExCharacters.RatCarcass'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.RatCarcass'
     CollisionRadius=10.000000
     CollisionHeight=3.400000
}
