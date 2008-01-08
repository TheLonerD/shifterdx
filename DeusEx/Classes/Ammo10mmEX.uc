//=============================================================================
// Ammo10mmEX.
//=============================================================================
class Ammo10mmEX extends Ammo10mm;

function Facelift(bool bOn)
{
	local Texture temptex;
	if(bOn)
	{
		temptex = Texture(DynamicLoadObject("ShifterTextures.Ammo.Ammo10mmEX",class'Texture', True));
		if(temptex != None)
			Skin = temptex;
	}
	else
		Skin = Default.Skin;
}

defaultproperties
{
     bIsNonStandard=True
     MaxAmmo=75
     ItemName="Explosive 10mm ammo"
     Description="By tipping standard 10mm rounds with a modest amount of magnesium, an average handgun can take down a wide range of targets, including bots.  The United Nations has banned the sale and use of explosive rounds for this reason."
     beltDescription="EXP AMMO"
     DynamicLoadIcon="ShifterTextures.Icons.Icon10mmEX"
}
