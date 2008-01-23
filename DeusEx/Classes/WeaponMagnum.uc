//=============================================================================
// WeaponMagnum.
//=============================================================================
class WeaponMagnum expands WeaponPistol;

function Facelift(bool bOn)
{
	local Texture temptex;

	if(bOn)
	{
		temptex = Texture(DynamicLoadObject("ShifterTextures.Icons.IconMagnum",class'Texture', True));
		if(temptex != None)
			largeIcon = temptex;

		temptex = Texture(DynamicLoadObject("ShifterTextures.Icons.BeltMagnum",class'Texture', True));
		if(temptex != None)
			Icon = temptex;

		temptex = Texture(DynamicLoadObject("ShifterTextures.Weapons.Magnum",class'Texture', True));
		if(temptex != None)
			MultiSkins[3] = temptex;

		temptex = Texture(DynamicLoadObject("ShifterTextures.Weapons.MagnumWorld",class'Texture', True));
		if(temptex != None)
			Skin = temptex;
	}
	else
	{
		MultiSkins[3] = Default.MultiSkins[3];
		largeIcon = Default.largeIcon;
		Icon = Default.Icon;
		Skin = Default.Skin;
	} 
}


defaultproperties
{
     HitDamage=17
     BaseAccuracy=0.650000
     recoilStrength=0.400000
     FireSound=Sound'DeusExSounds.Weapons.RifleFire'
     InventoryGroup=78
     ItemName="Magnum"
     Description="A variant of the 10mm pistol, modified to produce a higher bullet velocity.|n|n<UNATCO OPS FILE NOTE SC357-BLUE> Magnum handguns pack a helluva punch, but kick like a mule and are anything but quiet.  This isn't a gun for any would-be cowboy; it takes a steady hand and some good training to use this weapon effectively. -- Sam Carter"
     beltDescription="MAGNUM"
     bUnique=True
}
