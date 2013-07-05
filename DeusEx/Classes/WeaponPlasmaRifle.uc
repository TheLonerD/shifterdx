//=============================================================================
// WeaponPlasmaRifle.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponPlasmaRifle extends DeusExWeapon;

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPPlasmaRifle", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPPlasmaRiflePickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPPlasmaRifle3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		Mesh = PickupViewMesh;
		CheckWeaponSkins();
	}

	if(tName == 'Pickup')
		Mesh = PickupViewMesh;
	else
		Mesh = PlayerViewMesh;

	return true;
}

simulated function renderoverlays(Canvas canvas)
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
	   if(bHasScope)
	      multiskins[6] = none;
	   else
	      multiskins[6] = texture'pinkmasktex';
	   if(bHasLaser)
	      multiskins[4] = none;
	   else
	      multiskins[4] = texture'pinkmasktex';
	   if(bLasing)
	      multiskins[5] = none; 
	   else
	      multiskins[5] = texture'pinkmasktex';
	
	   //hah! Multiskins 3 wasn't autoresetting, of course, so you only got green when a laser was installed -_-
	   multiskins[3]=none;
	
	   super.renderoverlays(canvas);
	
	   if(bHasScope)
	      multiskins[5] = none;
	   else
	      multiskins[5] = texture'pinkmasktex';
	   if(bHasLaser)
	      multiskins[3] = none;
	   else
	      multiskins[3] = texture'pinkmasktex';
	   if(bLasing)
	      multiskins[4] = none;
	   else
	      multiskins[4] = texture'pinkmasktex';
	}
	else
		Super.RenderOverlays(canvas);

}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
		if(bHasScope)
			multiskins[5] = none;
		else
			multiskins[5] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
		if(bLasing)
			multiskins[4] = none;
		else
			multiskins[4] = texture'pinkmasktex';
	}
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		ReloadCount = mpReloadCount;
	}
}

defaultproperties
{
     LowAmmoWaterMark=12
     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     EnviroEffective=ENVEFF_AirVacuum
     reloadTime=2.000000
     HitDamage=35
     ProjectileDamage=35
     AltProjectileDamage=9
     maxRange=24000
     AccurateRange=14400
     BaseAccuracy=0.600000
     bCanHaveScope=True
     ScopeFOV=20
     bCanHaveLaser=True
     FireSound2=Sound'DeusExSounds.Weapons.PlasmaRifleFire'
     ProjectileString(0)="Standard Fire."
     ProjectileString(1)="Spread Fire."
     ProjectileNames(0)=Class'DeusEx.PlasmaBolt'
     ProjectileNames(1)=Class'DeusEx.PlasmaBolt'
     AreaOfEffect=AOE_Cone
     AltAreaOfEffect=AOE_Sphere
     bHasAltFire=True
     bPenetrating=False
     recoilStrength=0.300000
     MinAltProjSpreadAcc=0.350000
     mpReloadTime=0.500000
     mpHitDamage=20
     mpBaseAccuracy=0.500000
     mpAccurateRange=8000
     mpMaxRange=8000
     mpReloadCount=12
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveModShotTime=True
     AmmoName=Class'DeusEx.AmmoPlasma'
     ReloadCount=12
     PickupAmmoCount=12
     ProjectileClass=Class'DeusEx.PlasmaBolt'
     AltProjectileClass=Class'DeusEx.PlasmaBolt2'
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.PlasmaRifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.PlasmaRifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.PlasmaRifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.PlasmaRifleSelect'
     InventoryGroup=8
     ItemName="Plasma Rifle"
     PlayerViewOffset=(X=18.000000,Z=-7.000000)
     PlayerViewMesh=LodMesh'DeusExItems.PlasmaRifle'
     PickupViewMesh=LodMesh'DeusExItems.PlasmaRiflePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.PlasmaRifle3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconPlasmaRifle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconPlasmaRifle'
     largeIconWidth=203
     largeIconHeight=66
     invSlotsX=4
     invSlotsY=2
     Description="An experimental weapon that is currently being produced as a series of one-off prototypes, the plasma gun superheats slugs of magnetically-doped plastic and accelerates the resulting gas-liquid mix using an array of linear magnets. The resulting plasma stream is deadly when used against slow-moving targets."
     beltDescription="PLASMA"
     Mesh=LodMesh'DeusExItems.PlasmaRiflePickup'
     CollisionRadius=15.600000
     CollisionHeight=5.200000
     Mass=50.000000
}
