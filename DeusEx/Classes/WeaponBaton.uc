//=============================================================================
// WeaponBaton.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponBaton extends DeusExWeapon;

function bool Facelift(bool bOn)
{
	local Name tName;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPWeaponBaton", class'mesh', True));

	if(PlayerViewMesh == None || !bOn)
		PlayerViewMesh = Default.PlayerViewMesh;

	if(tName != 'Pickup')
		Mesh = PlayerViewMesh;

	return true;
}

simulated function bool ClientAltFire( float Value )
{
		if(IsA('WeaponBlackjack'))
			return false;

        	bClientReadyToFire = False;
        	bInProcess = True;
        	GotoState('ClientFiring');
        	bPointing = True;
        	if ( PlayerPawn(Owner) != None )
	     	PlayerPawn(Owner).PlayFiring();
        	PlayFiringAltSound();
        	ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
		if(Level.NetMode == NM_Standalone)
			SwitchItem();
        	Destroy();
        	return true;		
}

function AltFire( float Value )
{
		if(IsA('WeaponBlackjack'))
			return;

        	GotoState('AltFiring');
        	bPointing = True;
        	if ( Owner.IsA('PlayerPawn') )
	     	PlayerPawn(Owner).PlayFiring();
        	PlayFiringAltSound();
        	ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
		if(Level.NetMode == NM_Standalone)
			SwitchItem();
        	Destroy();
}

function name WeaponDamageType()
{
	return 'KnockedOut';
}

function bool TestCycleable()
{
	return true;
}

//Increased damage from 7 to 8

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     reloadTime=0.000000
     HitDamage=8
     maxRange=80
     AccurateRange=80
     BaseAccuracy=1.000000
     FireSound2=Sound'DeusExSounds.Weapons.BatonFire'
     bHasAltFire=True
     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-24.000000,Y=14.000000,Z=17.000000)
     AltProjectileClass=Class'DeusEx.BatonThrown'
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.BatonFire'
     SelectSound=Sound'DeusExSounds.Weapons.BatonSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.BatonHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.BatonHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.BatonHitSoft'
     InventoryGroup=24
     ItemName="Baton"
     PlayerViewOffset=(X=24.000000,Y=-14.000000,Z=-17.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Baton'
     PickupViewMesh=LodMesh'DeusExItems.BatonPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Baton3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconBaton'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBaton'
     largeIconWidth=46
     largeIconHeight=47
     Description="A hefty looking baton, typically used by riot police and national security forces to discourage civilian resistance."
     beltDescription="BATON"
     Mesh=LodMesh'DeusExItems.BatonPickup'
     CollisionRadius=14.000000
     CollisionHeight=1.000000
}
