//=============================================================================
// Keypad2.
//=============================================================================
class Keypad2 extends Keypad;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad2Tex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad2'
     CollisionRadius=4.440000
     CollisionHeight=7.410000
}
