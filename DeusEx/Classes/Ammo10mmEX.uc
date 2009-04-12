//=============================================================================
// Ammo10mmEX.
//=============================================================================
class Ammo10mmEX extends Ammo10mm;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Skin = Texture(DynamicLoadObject("ShifterEX.Ammo.Ammo10mmEX",class'Texture', True));

	if(!bOn || Skin == None)
		Skin = Default.Skin;
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
