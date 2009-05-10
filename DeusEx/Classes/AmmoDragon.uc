//=============================================================================
// AmmoDragon
//=============================================================================
class AmmoDragon extends AmmoShell;

function bool Facelift(bool bOn)
{
	if(Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("ShifterEX.Ammo.AmmoDragon", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = Default.Skin;

	return true;
}

defaultproperties
{
     bIsNonStandard=True
     DynamicLoadIcon="ShifterEX.Icons.BeltIconAmmoDragon"
     AmmoAmount=6
     MaxAmmo=48
     ItemName="Dragon's Breath Shells"
     Description="Highly specialized shells containing a powdered mix of fuel and heat-sensitive igntion agent, exiting in the form of a large burst of flame when fired."
     beltDescription="DRAGON"
}
