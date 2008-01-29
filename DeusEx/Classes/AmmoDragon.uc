//=============================================================================
// AmmoDragon
//=============================================================================
class AmmoDragon extends AmmoShell;

function Facelift(bool bOn)
{
	if(bOn)
		Skin = Texture(DynamicLoadObject("ShifterTextures.Ammo.AmmoDragon", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = Default.Skin;
}

defaultproperties
{
     bIsNonStandard=True
     AmmoAmount=6
     MaxAmmo=48
     ItemName="Dragon's Breath Shells"
     Description="Highly specialized shells containing a powdered mix of fuel and heat-sensitive igntion agent, exiting in the form of a large burst of flame when fired."
     beltDescription="DRAGON"
     DynamicLoadIcon="ShifterTextures.Icons.IconDragon"
}
