//=============================================================================
// WeaponCrowbar.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponCrowbar extends DeusExWeapon;

simulated function bool ClientAltFire( float Value )
{
        	bClientReadyToFire = False;
        	bInProcess = True;
        	GotoState('ClientFiring');
        	bPointing = True;
        	if ( PlayerPawn(Owner) != None )
	     	PlayerPawn(Owner).PlayFiring();
        	PlayFiringAltSound();
        	ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
        	Destroy();
        	return true;		
}

function AltFire( float Value )
{
        	GotoState('AltFiring');
        	bPointing = True;
        	if ( Owner.IsA('PlayerPawn') )
	     	PlayerPawn(Owner).PlayFiring();
        	PlayFiringAltSound();
        	ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
        	Destroy();
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

function Facelift(bool bOn)
{
	local Name tName;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPWeaponCrowbar", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPCrowbarPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPCrowbar3rd", class'mesh', True));
	}

	if(PlayerViewMesh == None || PickupViewMesh == None || ThirdPersonMesh == None || !bOn)
	{
		Texture = None;
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
	}
	else
	{
		Mesh = PickupViewMesh;
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPWeaponCrowbarTex2", class'Texture'));
	}

	if(tName == 'Pickup')
		Mesh = PickupViewMesh;
	else
		Mesh = PlayerViewMesh;

}

//Damage up to 12 from 10

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     reloadTime=0.000000
     HitDamage=12
     maxRange=80
     AccurateRange=80
     FireSound2=Sound'DeusExSounds.Weapons.CrowbarFire'
     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     mpHitDamage=12
     mpBaseAccuracy=1.000000
     mpAccurateRange=96
     mpMaxRange=96
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-40.000000,Y=15.000000,Z=8.000000)
     AltProjectileClass=Class'DeusEx.CrowbarThrown'
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.CrowbarFire'
     SelectSound=Sound'DeusExSounds.Weapons.CrowbarSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.CrowbarHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.CrowbarHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.CrowbarHitSoft'
     InventoryGroup=10
     ItemName="Crowbar"
     PlayerViewOffset=(X=40.000000,Y=-15.000000,Z=-8.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Crowbar'
     PickupViewMesh=LodMesh'DeusExItems.CrowbarPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Crowbar3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconCrowbar'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCrowbar'
     largeIconWidth=101
     largeIconHeight=43
     invSlotsX=2
     Description="A crowbar. Hit someone or something with it. Repeat.|n|n<UNATCO OPS FILE NOTE GH010-BLUE> Many crowbars we call 'murder of crowbars.'  Always have one for kombat. Ha. -- Gunther Hermann <END NOTE>"
     beltDescription="CROWBAR"
     Mesh=LodMesh'DeusExItems.CrowbarPickup'
     CollisionRadius=19.000000
     CollisionHeight=1.050000
     Mass=15.000000
     bHasAltFire=True
}
