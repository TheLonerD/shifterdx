//=============================================================================
// Keypad2.
//=============================================================================
class Keypad2 extends Keypad;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad2Tex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;

	return true;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad2'
     CollisionRadius=4.440000
     CollisionHeight=7.410000
}
