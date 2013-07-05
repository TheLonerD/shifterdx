//=============================================================================
// WeaponEMPGrenade.
//=============================================================================
class WeaponEMPGrenade extends WeaponGrenade;

function bool Facelift(bool bOn)
{
	local Name tName;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPEMPGrenade", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPEMPGrenadePickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPEMPGrenade3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
	}
	else
		Mesh = PickupViewMesh;

	if(tName == 'Pickup')
		Mesh = PickupViewMesh;
	else
		Mesh = PlayerViewMesh;

	return true;
}

simulated function renderoverlays(Canvas canvas)
{
	if(PickupViewMesh != Default.PickupViewMesh)
		multiskins[0] = Getweaponhandtex();

	super.renderoverlays(canvas);

	if(PickupViewMesh != Default.PickupViewMesh)
		multiskins[0] = none; 
}

//== Minty's Mod needs this to work, because specified super(WeaponEMPGrenade).  DON'T DO THAT.
function Fire(float Value)
{
	Super.Fire(Value);
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 7);
}

defaultproperties
{
     LowAmmoWaterMark=2
     GoverningSkill=Class'DeusEx.SkillDemolition'
     EnemyEffective=ENMEFF_Robot
     Concealability=CONC_Visual
     ShotTime=0.300000
     reloadTime=0.100000
     HitDamage=0
     maxRange=4800
     AccurateRange=2400
     BaseAccuracy=1.000000
     bPenetrating=False
     StunDuration=60.000000
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     AITimeLimit=3.500000
     AIFireDelay=5.000000
     bNeedToSetMPPickupAmmo=False
     mpReloadTime=0.100000
     mpBaseAccuracy=1.000000
     mpAccurateRange=2400
     mpMaxRange=2400
     AmmoName=Class'DeusEx.AmmoEMPGrenade'
     ReloadCount=1
     PickupAmmoCount=1
     FireOffset=(Y=10.000000,Z=20.000000)
     ProjectileClass=Class'DeusEx.EMPGrenade'
     shakemag=50.000000
     SelectSound=Sound'DeusExSounds.Weapons.EMPGrenadeSelect'
     InventoryGroup=22
     ItemName="Electromagnetic Pulse (EMP) Grenade"
     ItemArticle="an"
     PlayerViewOffset=(X=24.000000,Y=-15.000000,Z=-19.000000)
     PlayerViewMesh=LodMesh'DeusExItems.EMPGrenade'
     PickupViewMesh=LodMesh'DeusExItems.EMPGrenadePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.EMPGrenade3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconEMPGrenade'
     largeIcon=Texture'DeusExUI.Icons.LargeIconEMPGrenade'
     largeIconWidth=31
     largeIconHeight=49
     Description="The EMP grenade creates a localized pulse that will temporarily disable all electronics within its area of effect, including cameras and security grids.|n|n<UNATCO OPS FILE NOTE JR134-VIOLET> While nanotech augmentations are largely unaffected by EMP, experiments have shown that it WILL cause the spontaneous dissipation of stored bioelectric energy. -- Jaime Reyes <END NOTE>"
     beltDescription="EMP GREN"
     Mesh=LodMesh'DeusExItems.EMPGrenadePickup'
     CollisionRadius=3.000000
     CollisionHeight=2.430000
     Mass=5.000000
     Buoyancy=2.000000
}
