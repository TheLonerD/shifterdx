//=============================================================================
// GreaselCarcass.
//=============================================================================
class GreaselCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGreaselCarcass", class'Mesh', True));

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
     Mesh2=LodMesh'DeusExCharacters.GreaselCarcass'
     Mesh3=LodMesh'DeusExCharacters.GreaselCarcass'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.GreaselCarcass'
     CollisionRadius=36.000000
     CollisionHeight=6.650000
}
