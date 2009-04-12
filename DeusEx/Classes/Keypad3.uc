//=============================================================================
// Keypad3.
//=============================================================================
class Keypad3 extends Keypad;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad3Tex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad3'
     CollisionRadius=6.250000
     CollisionHeight=4.500000
}
