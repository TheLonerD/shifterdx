//=============================================================================
// Keypad1.
//=============================================================================
class Keypad1 extends Keypad;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad1Tex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;

	return true;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad1'
     CollisionRadius=4.000000
     CollisionHeight=6.000000
}
