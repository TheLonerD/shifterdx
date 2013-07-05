//=============================================================================
// WeaponStealthPistol.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponStealthPistol extends DeusExWeapon;

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPStealthPistol", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPStealthPistolPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPStealthPistol3rd", class'mesh', True));
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
		Multiskins[0] = getweaponhandtex();
		Multiskins[1] = none;
	
		if(bHasScope)
			multiskins[4] = none;
		else
			multiskins[4] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[2] = none;
		else
			multiskins[2] = texture'pinkmasktex';
		if(bLasing)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
	
		super(weapon).renderoverlays(canvas);
	
		multiskins[0] = none;
	
		if(bHasScope)
			multiskins[1] = none;
		else
			multiskins[1] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[2] = none;
		else
			multiskins[2] = texture'pinkmasktex';
		if(bLasing)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
		multiskins[4]=none;
	}
	else
		Super.RenderOverlays(canvas);
}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
		multiskins[0]=none;
		if(bHasScope)
			multiskins[1] = none;
		else
			multiskins[1] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[2] = none;
		else
			multiskins[2] = texture'pinkmasktex';
	
		multiskins[3] = texture'pinkmasktex';
		multiskins[4]=none;
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

//Reload time is down considerably

defaultproperties
{
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     NoiseLevel=0.010000
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_All
     ShotTime=0.200000
     HitDamage=12
     maxRange=4800
     AccurateRange=2400
     BaseAccuracy=0.800000
     bCanHaveScope=True
     bCanHaveLaser=True
     AmmoNames(0)=Class'DeusEx.Ammo10mm'
     AmmoNames(1)=Class'DeusEx.Ammo10mmEX'
     recoilStrength=0.100000
     mpReloadTime=1.500000
     mpHitDamage=12
     mpBaseAccuracy=0.200000
     mpAccurateRange=1200
     mpMaxRange=1200
     mpReloadCount=12
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     AmmoName=Class'DeusEx.Ammo10mm'
     PickupAmmoCount=10
     bInstantHit=True
     FireOffset=(X=-24.000000,Y=10.000000,Z=14.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.StealthPistolFire'
     AltFireSound=Sound'DeusExSounds.Weapons.StealthPistolReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.StealthPistolReload'
     SelectSound=Sound'DeusExSounds.Weapons.StealthPistolSelect'
     InventoryGroup=3
     ItemName="Stealth Pistol"
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.StealthPistol'
     PickupViewMesh=LodMesh'DeusExItems.StealthPistolPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.StealthPistol3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconStealthPistol'
     largeIcon=Texture'DeusExUI.Icons.LargeIconStealthPistol'
     largeIconWidth=47
     largeIconHeight=37
     Description="The stealth pistol is a variant of the standard 10mm pistol with a larger clip and integrated silencer designed for wet work at very close ranges."
     beltDescription="STEALTH"
     Mesh=LodMesh'DeusExItems.StealthPistolPickup'
     CollisionRadius=8.000000
     CollisionHeight=0.800000
}
