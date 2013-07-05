//=============================================================================
// WeaponGEPGun.
//=============================================================================
class WeaponGEPGun extends DeusExWeapon;

var localized String shortName;

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPGEPGun", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPGEPGunPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPGEPGun3rd", class'mesh', True));
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
		if(ammotype.isA('AmmoRocketWP'))
		{
			multiskins[4] = texture'pinkmasktex';
			multiskins[5] = none;
			multiskins[6] = none;
		}
		else if(ammotype.isA('AmmoRocket'))
		{
			multiskins[4] = none;
			multiskins[5] = texture'pinkmasktex';
			multiskins[6] = texture'pinkmasktex';
		}
	//	else //bleh??
	//	{
	//		multiskins[4] = texture'pinkmasktex';
	//		multiskins[5] = texture'pinkmasktex';
	//		multiskins[6] = texture'pinkmasktex';
	//	}
	
	
	   super.renderoverlays(canvas);
	
	   if(bHasScope)
		  multiskins[3] = none;
	   else
		  multiskins[3] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[1] = none;
	   else
		  multiskins[1] = texture'pinkmasktex';
	   if(bLasing)
		  multiskins[2] = none;
	   else
		  multiskins[2] = texture'pinkmasktex';	
	}
	else
		Super.RenderOverlays(canvas);

}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{	
	   if(bHasScope)
		  multiskins[3] = none;
	   else
		  multiskins[3] = texture'pinkmasktex';
	   if(bHasLaser)
		  multiskins[1] = none;
	   else
		  multiskins[1] = texture'pinkmasktex';
	   if(bLasing)
		  multiskins[2] = none;
	   else
		  multiskins[2] = texture'pinkmasktex';
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
		bHasScope = True;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	// don't let NPC geps lock on to targets
	if ((Owner != None) && !Owner.IsA('DeusExPlayer'))
		bCanTrack = False;
}

function GiveTo(Pawn Other)
{
	//== Ensure that NPCs can't lock on to targets
	if(Other != None)
	{
		if(Other.IsA('DeusExPlayer'))
			bCanTrack = True;
		else
			bCanTrack = False;
	}

	Super.GiveTo(Other);
}

defaultproperties
{
     ShortName="GEP Gun"
     LowAmmoWaterMark=4
     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     NoiseLevel=2.000000
     EnviroEffective=ENVEFF_Air
     ShotTime=2.000000
     reloadTime=2.000000
     HitDamage=300
     maxRange=24000
     AccurateRange=14400
     bCanHaveScope=True
     bCanTrack=True
     LockTime=2.000000
     LockedSound=Sound'DeusExSounds.Weapons.GEPGunLock'
     TrackingSound=Sound'DeusExSounds.Weapons.GEPGunTrack'
     FireSound2=Sound'DeusExSounds.Weapons.GEPGunFireWP'
     AmmoNames(0)=Class'DeusEx.AmmoRocket'
     AmmoNames(1)=Class'DeusEx.AmmoRocketWP'
     ProjectileNames(0)=Class'DeusEx.Rocket'
     ProjectileNames(1)=Class'DeusEx.RocketWP'
     bHasMuzzleFlash=False
     recoilStrength=1.000000
     bUseWhileCrouched=False
     mpHitDamage=40
     mpAccurateRange=14400
     mpMaxRange=14400
     mpReloadCount=1
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     AmmoName=Class'DeusEx.AmmoRocket'
     ReloadCount=1
     PickupAmmoCount=4
     FireOffset=(X=-46.000000,Y=22.000000,Z=10.000000)
     ProjectileClass=Class'DeusEx.Rocket'
     shakemag=500.000000
     FireSound=Sound'DeusExSounds.Weapons.GEPGunFire'
     CockingSound=Sound'DeusExSounds.Weapons.GEPGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.GEPGunSelect'
     InventoryGroup=17
     ItemName="Guided Explosive Projectile (GEP) Gun"
     PlayerViewOffset=(X=46.000000,Y=-22.000000,Z=-10.000000)
     PlayerViewMesh=LodMesh'DeusExItems.GEPGun'
     PickupViewMesh=LodMesh'DeusExItems.GEPGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.GEPGun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconGEPGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconGEPGun'
     largeIconWidth=203
     largeIconHeight=77
     invSlotsX=4
     invSlotsY=2
     Description="The GEP gun is a relatively recent invention in the field of armaments: a portable, shoulder-mounted launcher that can fire rockets and laser guide them to their target with pinpoint accuracy. While suitable for high-threat combat situations, it can be bulky for those agents who have not grown familiar with it."
     beltDescription="GEP GUN"
     Mesh=LodMesh'DeusExItems.GEPGunPickup'
     CollisionRadius=27.000000
     CollisionHeight=6.600000
     Mass=50.000000
}
