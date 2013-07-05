//=============================================================================
// WeaponPistol.
//=============================================================================
class WeaponPistol extends DeusExWeapon;

var Texture HDTPLaserTex;

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPWeaponPistol", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPGlockPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPGlock3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Icon = Default.Icon;
		LargeIcon = Default.LargeIcon;
		HDTPLaserTex = None;
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		Mesh = PickupViewMesh;
		Icon = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPBeltIconPistol", class'Texture'));
		LargeIcon = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLargeIconPistol", class'Texture'));
		HDTPLaserTex = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPGlockTex4", class'Texture'));
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
		  multiskins[6] = none;
	   else
		  multiskins[6] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[5] = none;
	   else
		  multiskins[5] = texture'pinkmasktex';
	   if(bHasScope)
		  multiskins[4] = none;
	   else
		  multiskins[4] = texture'pinkmasktex';
	
		multiskins[2] = Getweaponhandtex();
	
	   super.renderoverlays(canvas);
	
		multiskins[2] = none;
	}
	else
		Super.RenderOverlays(canvas);

}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
	   if(bHasSilencer)
		  multiskins[6] = none;
	   else
		  multiskins[6] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[5] = none;
	   else
		  multiskins[5] = texture'pinkmasktex';
	   if(bHasScope)
		  multiskins[4] = none;
	   else
		  multiskins[4] = texture'pinkmasktex';
	}
}

simulated function SwapMuzzleFlashTexture()
{
	if(PickupViewMesh == Default.PickupViewMesh)
	{
		Super.SwapMuzzleFlashTexture();
		return;
	}

	if (!bHasMuzzleFlash || bHasSilencer)
	{
		if(bLasing)
		{
			MultiSkins[3] = HDTPLaserTex;
			setTimer(0.1, false);
		}
		return;
	}


	MultiSkins[3] = GetMuzzleTex();

	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function EraseMuzzleFlashTexture()
{
	if(PickupViewMesh == Default.PickupViewMesh)
		Super.EraseMuzzleFlashTexture();
	else if(!bLasing)
		MultiSkins[3] = none;
	else
		MultiSkins[3] = HDTPLaserTex;

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
     LowAmmoWaterMark=6
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_Visual
     ShotTime=0.600000
     reloadTime=2.000000
     HitDamage=14
     maxRange=4800
     AccurateRange=2400
     BaseAccuracy=0.700000
     bCanHaveScope=True
     ScopeFOV=25
     bCanHaveLaser=True
     AmmoNames(0)=Class'DeusEx.Ammo10mm'
     AmmoNames(1)=Class'DeusEx.Ammo10mmEX'
     recoilStrength=0.300000
     mpReloadTime=2.000000
     mpHitDamage=20
     mpBaseAccuracy=0.200000
     mpAccurateRange=1200
     mpMaxRange=1200
     mpReloadCount=9
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveModShotTime=True
     AmmoName=Class'DeusEx.Ammo10mm'
     ReloadCount=6
     PickupAmmoCount=6
     bInstantHit=True
     FireOffset=(X=-22.000000,Y=10.000000,Z=14.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.PistolFire'
     CockingSound=Sound'DeusExSounds.Weapons.PistolReload'
     SelectSound=Sound'DeusExSounds.Weapons.PistolSelect'
     InventoryGroup=2
     ItemName="Pistol"
     PlayerViewOffset=(X=22.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Glock'
     PickupViewMesh=LodMesh'DeusExItems.GlockPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Glock3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconPistol'
     largeIcon=Texture'DeusExUI.Icons.LargeIconPistol'
     largeIconWidth=46
     largeIconHeight=28
     Description="A standard 10mm pistol."
     beltDescription="PISTOL"
     Mesh=LodMesh'DeusExItems.GlockPickup'
     CollisionRadius=7.000000
     CollisionHeight=1.000000
}
