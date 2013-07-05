//=============================================================================
// AmmoDartPoison.
//=============================================================================
class AmmoDartPoison extends AmmoDart;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		skin = Texture(DynamicLoadObject("HDTPItems.HDTPAmmoDartTex3", class'Texture', True));

	if(skin == None || !bOn)
		skin = Default.skin;

	return true;
}

defaultproperties
{
     bIsNonStandard=False
     ItemName="Tranquilizer Darts"
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoDartsPoison'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoDartsPoison'
     Description="A mini-crossbow dart tipped with a succinylcholine-variant that causes complete skeletal muscle relaxation, effectively incapacitating a target in a non-lethal manner."
     beltDescription="TRQ DART"
     Skin=Texture'DeusExItems.Skins.AmmoDartTex3'
}
