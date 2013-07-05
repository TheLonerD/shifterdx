//=============================================================================
// AmmoDartFlare.
//=============================================================================

//Modified -- Y|yukichigai

class AmmoDartFlare extends AmmoDart;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		skin = Texture(DynamicLoadObject("HDTPItems.HDTPAmmoDartTex2", class'Texture', True));

	if(skin == None || !bOn)
		skin = Default.skin;

	return true;
}

defaultproperties
{
     ItemName="Flare Darts"
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoDartsFlare'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoDartsFlare'
     Description="Mini-crossbow flare darts use a slow-burning incendiary device, ignited on impact, to provide illumination of a targeted area."
     beltDescription="FLR DART"
     Skin=Texture'DeusExItems.Skins.AmmoDartTex2'
}
