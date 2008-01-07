//=============================================================================
// Keypad3.
//=============================================================================
class Keypad3 extends Keypad;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad3Tex1", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad3'
     CollisionRadius=6.250000
     CollisionHeight=4.500000
}
