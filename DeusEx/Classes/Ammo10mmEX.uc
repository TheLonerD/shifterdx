//=============================================================================
// Ammo10mmEX.
//=============================================================================
class Ammo10mmEX extends Ammo10mm;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("ShifterEX.Ammo.Ammo10mmEX",class'Texture', True));

	if(!bOn || Skin == None)
		Skin = Default.Skin;

	return true;
}

defaultproperties
{
     bIsNonStandard=True
     DynamicLoadIcon="ShifterEX.Icons.BeltIcon10mmEX"
     MaxAmmo=75
     ItemName="Explosive 10mm ammo"
     Description="By tipping standard 10mm rounds with a modest amount of magnesium, an average handgun can take down a wide range of targets, including bots.  The United Nations has banned the sale and use of explosive rounds for this reason."
     beltDescription="EXP AMMO"
}
