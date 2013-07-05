//=============================================================================
// WeaponAssaultGun.
//=============================================================================
class WeaponAssaultGun extends DeusExWeapon;

var float	mpRecoilStrength;
var int muznum; //loop through muzzleflashes
var texture muztex; //sigh

function bool Facelift(bool bOn)
{
	local Name tName;
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPAssaultGun", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPAssaultGunPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPAssaultGun3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		Texture = None;
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

//== HDTP Function to make sure the gun doesn't disappear
simulated function renderoverlays(Canvas canvas)
{
	//== Only use if HDTP is loaded
	if(PickupViewMesh != Default.PickupViewMesh)
	{
		if(bHasScope)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
		if(bHasSilencer)
			multiskins[4] = none;
		else
			multiskins[4] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[1] = none;
		else
			multiskins[1] = texture'pinkmasktex';
		if(bLasing)
			multiskins[5] = none;
		else
			multiskins[5] = texture'pinkmasktex';
		//assault gun uses so many differently assigned multiskins we need to keep flicking back between em or we get invisible gunz
		multiskins[0]=none;
		if(muztex != none && multiskins[2] != muztex) //don't overwrite the muzzleflash..this is fucking ugly, but I think we can spare some comp cycles for shit like this
			multiskins[2]=muztex;
		else
			multiskins[2]=none;
	
		multiskins[6]=none;
		multiskins[7]=Getweaponhandtex();
	
		super(weapon).renderoverlays(canvas);
	
		if(bHasScope)
			multiskins[6] = none;
		else
			multiskins[6] = texture'pinkmasktex';
		if(bHasSilencer)
			multiskins[2] = none;
		else
			multiskins[2] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[5] = none;
		else
			multiskins[5] = texture'pinkmasktex';
		if(bLasing)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
	
		multiskins[0]=none;
		multiskins[1]=none;
		if(muztex != none && multiskins[4] != muztex) //and here too! Ghaaa
			multiskins[4]=muztex;
		else
			multiskins[4]=none;
		multiskins[7]=none;
	}
	else
		Super.RenderOverlays(canvas);
}

function CheckWeaponSkins()
{
	if(PickupViewMesh != Default.PickupViewMesh)
	{
		if(bHasScope)
			multiskins[6] = none;
		else
			multiskins[6] = texture'pinkmasktex';
		if(bHasSilencer)
			multiskins[2] = none;
		else
			multiskins[2] = texture'pinkmasktex';
		if(bHasLaser)
			multiskins[5] = none;
		else
			multiskins[5] = texture'pinkmasktex';
		if(bLasing)
			multiskins[3] = none;
		else
			multiskins[3] = texture'pinkmasktex';
		multiskins[0]=none;
		multiskins[1]=none;
		multiskins[4]=none;
		multiskins[7]=none;
	}
}

//== This is automatically called by the Mesh's notifications.
//==  Need to override because multiskins varies for 1st/3rd meshes
simulated function SwapMuzzleFlashTexture()
{
	local int i;

	if (!bHasMuzzleFlash || bHasSilencer)
		return;

	if(playerpawn(owner) != none || PickupViewMesh == Default.Mesh)      //diff meshes, see
		i=2;
	else
		i=4;
	Muztex = GetMuzzleTex();
	Multiskins[i] = Muztex;
	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function EraseMuzzleFlashTexture()
{
	local int i;

	Muztex = none; //put this before the silencer check just in case we somehow add a silencer while mid shooting (it could happen!)
	if(!bHasMuzzleflash || bHasSilencer)
		return;

	if(playerpawn(owner) != none || PickupViewMesh == Default.Mesh)      //diff meshes, see
		i=2;
	else
		i=4;

	MultiSkins[i] = None;
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

		// Tuned for advanced -> master skill system (Monte & Ricardo's number) client-side
		recoilStrength = 0.75;
	}
}

defaultproperties
{
     LowAmmoWaterMark=30
     FireAnim(1)=None
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_Visual
     bAutomatic=True
     ShotTime=0.100000
     reloadTime=3.000000
     HitDamage=3
     BaseAccuracy=0.700000
     bCanHaveLaser=True
     bCanHaveSilencer=True
     FireSound2=Sound'DeusExSounds.Weapons.AssaultGunFire20mm'
     AmmoNames(0)=Class'DeusEx.Ammo762mm'
     AmmoNames(1)=Class'DeusEx.Ammo20mm'
     ProjectileNames(1)=Class'DeusEx.HECannister20mm'
     recoilStrength=0.500000
     MinWeaponAcc=0.200000
     mpReloadTime=0.500000
     mpHitDamage=9
     mpBaseAccuracy=1.000000
     mpAccurateRange=2400
     mpMaxRange=2400
     mpReloadCount=30
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveModShotTime=True
     AmmoName=Class'DeusEx.Ammo762mm'
     ReloadCount=30
     PickupAmmoCount=30
     bInstantHit=True
     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     shakemag=200.000000
     FireSound=Sound'DeusExSounds.Weapons.AssaultGunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.AssaultGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     InventoryGroup=4
     ItemName="Assault Rifle"
     ItemArticle="an"
     PlayerViewOffset=(X=16.000000,Y=-5.000000,Z=-11.500000)
     PlayerViewMesh=LodMesh'DeusExItems.AssaultGun'
     PickupViewMesh=LodMesh'DeusExItems.AssaultGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.AssaultGun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconAssaultGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAssaultGun'
     largeIconWidth=94
     largeIconHeight=65
     invSlotsX=2
     invSlotsY=2
     Description="The 7.62x51mm assault rifle is designed for close-quarters combat, utilizing a shortened barrel and 'bullpup' design for increased maneuverability. An additional underhand 20mm HE launcher increases the rifle's effectiveness against a variety of targets."
     beltDescription="ASSAULT"
     Mesh=LodMesh'DeusExItems.AssaultGunPickup'
     CollisionRadius=15.000000
     CollisionHeight=1.100000
     Mass=30.000000
}
