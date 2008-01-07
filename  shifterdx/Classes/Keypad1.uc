//=============================================================================
// Keypad1.
//=============================================================================
class Keypad1 extends Keypad;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPKeypad1Tex1", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Keypad1'
     CollisionRadius=4.000000
     CollisionHeight=6.000000
}
