//=============================================================================
// WeaponRifle.
//=============================================================================
class WeaponRifle extends DeusExWeapon;

var float	mpNoScopeMult;

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPWeaponRifle", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPSniperPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPSniper3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Icon = Default.Icon;
		LargeIcon = Default.LargeIcon;
		Texture = Default.Texture;
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		Mesh = PickupViewMesh;
		Icon = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPBeltIconRifle", class'Texture'));
		LargeIcon = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLargeIconRifle", class'Texture'));
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPWeaponRifleShine", class'Texture'));
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
	   if(bHasSilencer)
		  multiskins[4] = none;
	   else
		  multiskins[4] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[3] = none;
	   else
		  multiskins[3] = texture'pinkmasktex';
	
		multiskins[6] = Getweaponhandtex();
	
	   super.renderoverlays(canvas);
	
	   if(bHasSilencer)
		  multiskins[3] = none;
	   else
		  multiskins[3] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[4] = none;
	   else
		  multiskins[4] = texture'pinkmasktex';
	
		multiskins[6] = none;
	}
	else
		Super.RenderOverlays(canvas);

}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
		if(bHasSilencer)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[4] = none;
		else
			multiskins[4] = texture'pinkmasktex';
	}
}

// Muzzle Flash Stuff
simulated function SwapMuzzleFlashTexture()
{
	if(PickupViewMesh == Default.PickupViewMesh)
	{
		Super.SwapMuzzleFlashTexture();
		return;
	}

	if (!bHasMuzzleFlash)
		return;

	MultiSkins[7] = GetMuzzleTex();

	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function texture GetMuzzleTex()
{
	return HDTPMuzzleTexLarge[rand(8)];
}

simulated function EraseMuzzleFlashTexture()
{
	if(PickupViewMesh != Default.PickupViewMesh)
		MultiSkins[7] = None;
	else
		Super.EraseMuzzleFlashTexture();
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
      bHasMuzzleFlash = True;
      ReloadCount = 1;
      ReloadTime = ShotTime;
	}
}

defaultproperties
{
     mpNoScopeMult=0.350000
     LowAmmoWaterMark=6
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     NoiseLevel=2.000000
     EnviroEffective=ENVEFF_Air
     ShotTime=1.500000
     reloadTime=2.000000
     HitDamage=25
     maxRange=48000
     AccurateRange=28800
     bCanHaveScope=True
     bHasScope=True
     bCanHaveLaser=True
     bCanHaveSilencer=True
     bHasMuzzleFlash=False
     recoilStrength=0.400000
     bUseWhileCrouched=False
     mpReloadTime=2.000000
     mpHitDamage=25
     mpAccurateRange=28800
     mpMaxRange=28800
     mpReloadCount=6
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveModShotTime=True
     AmmoName=Class'DeusEx.Ammo3006'
     ReloadCount=6
     PickupAmmoCount=6
     bInstantHit=True
     FireOffset=(X=-20.000000,Y=2.000000,Z=30.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.RifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.RifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.RifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.RifleSelect'
     InventoryGroup=5
     ItemName="Sniper Rifle"
     PlayerViewOffset=(X=20.000000,Y=-2.000000,Z=-30.000000)
     PlayerViewMesh=LodMesh'DeusExItems.SniperRifle'
     PickupViewMesh=LodMesh'DeusExItems.SniperRiflePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.SniperRifle3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconRifle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconRifle'
     largeIconWidth=159
     largeIconHeight=47
     invSlotsX=4
     Description="The military sniper rifle is the superior tool for the interdiction of long-range targets. When coupled with the proven 30.06 round, a marksman can achieve tight groupings at better than 1 MOA (minute of angle) depending on environmental conditions."
     beltDescription="SNIPER"
     Mesh=LodMesh'DeusExItems.SniperRiflePickup'
     CollisionRadius=26.000000
     CollisionHeight=2.000000
     Mass=30.000000
}
