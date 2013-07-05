//=============================================================================
// KarkianBabyCarcass.
//=============================================================================
class KarkianBabyCarcass extends DeusExCarcass;

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
     Mesh2=LodMesh'DeusExCharacters.KarkianCarcass'
     Mesh3=LodMesh'DeusExCharacters.KarkianCarcass'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.KarkianCarcass'
     DrawScale=0.500000
     CollisionRadius=36.279999
     CollisionHeight=9.880000
}
