//=============================================================================
// BookOpen.
//=============================================================================
class BookOpen extends InformationDevices;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPBookOpen", class'Mesh', True));
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBookOpentex", class'Texture', True));
	}

	if(Mesh == None || Skin == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Default.Skin;
	}

	return true;
} 

defaultproperties
{
     bCanBeBase=True
     ItemName="Book"
     Mesh=LodMesh'DeusExDeco.BookOpen'
     CollisionRadius=15.000000
     CollisionHeight=1.420000
     Mass=10.000000
     Buoyancy=11.000000
}
