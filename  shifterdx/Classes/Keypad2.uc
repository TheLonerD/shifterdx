//=============================================================================
// Keypad2.
//=============================================================================
class Keypad2 extends Keypad;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad2Tex1", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad2'
     CollisionRadius=4.440000
     CollisionHeight=7.410000
}
