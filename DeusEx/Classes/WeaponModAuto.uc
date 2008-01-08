//=============================================================================
// WeaponModLaser
//
// Adds a laser sight to a weapon
//=============================================================================
class WeaponModAuto extends WeaponMod;

// ----------------------------------------------------------------------
// ApplyMod()
// ----------------------------------------------------------------------

function ApplyMod(DeusExWeapon weapon)
{
	if (weapon != None)
	{
		weapon.ShotTime += (weapon.Default.ShotTime * WeaponModifier);
		if (weapon.ShotTime < 0.0)
			weapon.ShotTime = 0.0;
		weapon.ModShotTime += WeaponModifier;
	}
}

// ----------------------------------------------------------------------
// CanUpgradeWeapon()
// ----------------------------------------------------------------------

simulated function bool CanUpgradeWeapon(DeusExWeapon weapon)
{
	if (weapon != None)
		return (weapon.bCanHaveModShotTime && !weapon.HasMaxROFMod());
	else
		return False;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     WeaponModifier=-0.100000
     ItemName="Weapon Modification (Rate of Fire)"
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModSilencer'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModSilencer'
     Description="By lubricating key mechanisms many firearms can have their Rate of Fire increased."
     beltDescription="MOD ROF"
     Skin=Texture'DeusExItems.Skins.WeaponModTex4'
}
