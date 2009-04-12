//=============================================================================
// Tumbleweed.
//=============================================================================
class Tumbleweed extends Trash;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPTumbleWeed", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Tumbleweed"
     Mesh=LodMesh'DeusExDeco.Tumbleweed'
     CollisionRadius=33.000000
     CollisionHeight=21.570000
}
