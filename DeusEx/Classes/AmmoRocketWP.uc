//=============================================================================
// AmmoRocketWP.
//=============================================================================
class AmmoRocketWP extends AmmoRocket;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		skin = Texture(DynamicLoadObject("HDTPItems.HDTPGEPAmmoTex2", class'Texture', True));

	if(skin == None || !bOn)
		skin = Default.skin;

	Multiskins[1] = Skin;

	return true;
}

defaultproperties
{
     ItemName="WP Rockets"
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoWPRockets'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoWPRockets'
     largeIconWidth=45
     largeIconHeight=37
     Description="The white-phosphorus rocket, or 'wooly peter,' was designed to expand the mission profile of the GEP gun. While it does minimal damage upon detonation, the explosion will spread a cloud of particularized white phosphorus that ignites immediately upon contact with the air."
     beltDescription="WP ROCKET"
     Skin=Texture'DeusExItems.Skins.GEPAmmoTex2'
}
