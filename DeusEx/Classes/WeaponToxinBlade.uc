//=============================================================================
// WeaponCombatKnife.
//=============================================================================
class WeaponToxinBlade expands WeaponCombatKnife;

function name WeaponDamageType()
{
	return 'Poison';
}

defaultproperties
{
     bLethal=True
     bHasAltFire=False
     StunDuration=3.000000
     bUnique=True
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     PickupAmmoCount=0
     InventoryGroup=79
     ItemName="Toxin Blade"
     Description="An example of the more deadly uses of nanotechnology, the Toxin Blade is a standard Combat Knife with a paralytic toxin coating.  Nanobots within the weapon ensure that the coating is always replenished, and that the blade remains its sharpest."
     beltDescription="TOXIN"
}
