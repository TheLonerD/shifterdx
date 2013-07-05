//=============================================================================
// CatCarcass.
//=============================================================================
class CatCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPCatCarcass", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;
	}
	else
	{
		Mesh2 = Mesh;
		Mesh3 = Mesh;
	}

	return true;
} 

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.CatCarcass'
     Mesh3=LodMesh'DeusExCharacters.CatCarcass'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.CatCarcass'
     CollisionRadius=17.000000
     CollisionHeight=3.600000
}
