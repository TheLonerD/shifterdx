//=============================================================================
// WeaponCombatKnife.
//=============================================================================
class WeaponCombatKnife extends DeusExWeapon;

function bool Facelift(bool bOn)
{
	local Name tName;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPCombatKnife", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPCombatKnifePickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPCombatKnife3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		Texture = None;
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
	}
}

simulated function renderoverlays(Canvas canvas)
{
	multiskins[1] = Getweaponhandtex();

	super.renderoverlays(canvas);

	multiskins[1] = none; 
}

function BringUp()
{
	if(AmmoType != Class'DeusEx.AmmoNone')
		if(AmmoType.AmmoAmount <= 0)
			AmmoType.AmmoAmount = 1;

	Super.BringUp();
}

function AltFire(float Value)
{
	if(Class != class'WeaponCombatKnife')
	{
		Super.AltFire(Value);
		return;
	}
	
	AmmoType.UseAmmo(1);


	if (( Level.NetMode != NM_Standalone ) )// && !bListenClient )
		bClientReady = False;
	bReadyToFire = False;
//	GotoState('AltFiring');
	ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
//	PlaySelectiveAltFiring();
	PlayFiringAltSound();
	bPointing=True;
	if ( Owner.IsA('PlayerPawn') )
		PlayerPawn(Owner).PlayFiring();

	if(AmmoType.AmmoAmount <= 0)
	{
		if(Level.NetMode == NM_Standalone)
			SwitchItem();
		Destroy();
	}
	else
		PlaySelect();

	// Update ammo count on object belt
	if (DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).UpdateBeltText(Self);
}

function Fire(float Value)
{
	if(Class != class'WeaponCombatKnife')
	{
		Super.Fire(Value);
		return;
	}

	if (( Level.NetMode != NM_Standalone ) )// && !bListenClient )
		bClientReady = False;
	bReadyToFire = False;
	GotoState('NormalFire');
	bPointing=True;
	if ( Owner.IsA('PlayerPawn') )
		PlayerPawn(Owner).PlayFiring();
	PlaySelectiveFiring();
	PlayFiringSound();


	// Update ammo count on object belt
	if (DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).UpdateBeltText(Self);
}

simulated function bool ClientAltFire( float value)
{
	if(Class != class'WeaponCombatKnife')
	{
		return Super.ClientAltFire(value);
	}

	SimAmmoAmount = AmmoType.AmmoAmount - 1;
	if ( (Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).NintendoImmunityTimeLeft > 0.01)) ||
		  (!bClientReadyToFire) || bInProcess )
	{
		DeusExPlayer(Owner).bJustFired = False;
		bPointing = False;
		bFiring = False;
		return false;
	}

	ServerForceAltFire();

	bClientReadyToFire = False;
	bInProcess = True;
	GotoState('ClientAltFiring');
	bPointing = True;
	if ( PlayerPawn(Owner) != None )
		PlayerPawn(Owner).PlayFiring();
//	PlaySelectiveAltFiring();
	PlayFiringAltSound();
	return true;
}

simulated function bool ClientFire( float value )
{
	if(Class != class'WeaponCombatKnife')
	{
		return Super.ClientFire(value);
	}

	if ( (Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).NintendoImmunityTimeLeft > 0.01)) ||
		  (!bClientReadyToFire) || bInProcess )
	{
		DeusExPlayer(Owner).bJustFired = False;
		bPointing = False;
		bFiring = False;
		return false;
	}

	ServerForceFire();

	bClientReadyToFire = False;
	bInProcess = True;
	GotoState('ClientFiring');
	bPointing = True;
	if ( PlayerPawn(Owner) != None )
		PlayerPawn(Owner).PlayFiring();
	PlaySelectiveFiring();
	PlayFiringSound();
	return true;
}

function bool TestCycleable()
{
	return true;
}

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     EnemyEffective=ENMEFF_Organic
     Concealability=CONC_Visual
     reloadTime=0.000000
     HitDamage=5
     AltProjectileDamage=8
     maxRange=80
     AccurateRange=80
     BaseAccuracy=0.000000
     FireSound2=Sound'DeusExSounds.Weapons.CombatKnifeFire'
     bHasAltFire=True
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     mpHitDamage=20
     mpBaseAccuracy=1.000000
     mpAccurateRange=96
     mpMaxRange=96
     AmmoName=Class'DeusEx.AmmoCombatKnife'
     ReloadCount=1
     PickupAmmoCount=1
     bInstantHit=True
     FireOffset=(X=-5.000000,Y=8.000000,Z=14.000000)
     AltProjectileClass=Class'DeusEx.CombatKnifeThrown'
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.CombatKnifeFire'
     SelectSound=Sound'DeusExSounds.Weapons.CombatKnifeSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitSoft'
     InventoryGroup=11
     ItemName="Combat Knife"
     PlayerViewOffset=(X=5.000000,Y=-8.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.CombatKnife'
     PickupViewMesh=LodMesh'DeusExItems.CombatKnifePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.CombatKnife3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconCombatKnife'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCombatKnife'
     largeIconWidth=49
     largeIconHeight=45
     Description="An ultra-high carbon stainless steel knife."
     beltDescription="KNIFE"
     Mesh=LodMesh'DeusExItems.CombatKnifePickup'
     CollisionRadius=12.650000
     CollisionHeight=0.800000
}
