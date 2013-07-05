//=============================================================================
// BookClosed.
//=============================================================================
class BookClosed extends InformationDevices;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBookClosedtex", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = Default.Skin;

	return true;
} 

defaultproperties
{
     bCanBeBase=True
     ItemName="Book"
     Mesh=LodMesh'DeusExDeco.BookClosed'
     CollisionRadius=10.000000
     CollisionHeight=1.700000
     Mass=10.000000
     Buoyancy=11.000000
}
