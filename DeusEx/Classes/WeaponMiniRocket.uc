//=============================================================================
// WeaponMiniRocket.
//=============================================================================
class WeaponMiniRocket expands WeaponLAW;

defaultproperties
{
     LowAmmoWaterMark=6
     ShotTime=0.500000
     reloadTime=2.000000
     HitDamage=91
     ProjectileDamage=91
     bCanHaveScope=True
     recoilStrength=0.300000
     bUnique=True
     mpHitDamage=80
     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     AmmoName=Class'DeusEx.AmmoRocketMini'
     ReloadCount=4
     PickupAmmoCount=10
     FireOffset=(X=-30.000000,Y=10.000000,Z=12.000000)
     ProjectileClass=Class'DeusEx.RocketMini2'
     FireSound=Sound'DeusExSounds.Robot.RobotFireRocket'
     AltFireSound=Sound'DeusExSounds.Weapons.LAWSelect'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultShotgunReload'
     InventoryGroup=85
     ItemName="Internal Light Anti-Personnel Weapon"
     ItemArticle="an"
     PlayerViewOffset=(Y=-10.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AssaultShotgun'
     PickupViewMesh=LodMesh'DeusExItems.AssaultShotgunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.AssaultShotgun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconAssaultShotgun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAssaultShotgun'
     largeIconWidth=99
     largeIconHeight=55
     invSlotsX=2
     invSlotsY=2
     Description="Prior to MJ12 adopting the technology, the ILAW was an abandoned attempt at creating a cybernetic rocket-based weapon.  This prototype has been fitted for external use for demonstration purposes."
     beltDescription="ILAW"
     Mesh=LodMesh'DeusExItems.AssaultShotgunPickup'
     Mass=20.000000
}
