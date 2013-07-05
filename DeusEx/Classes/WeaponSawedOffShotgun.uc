//=============================================================================
// WeaponSawedOffShotgun.
//=============================================================================
class WeaponSawedOffShotgun extends DeusExWeapon;

var() travel int ExtraAmmoLoaded;
var string msgExtraShells;

function bool Facelift(bool bOn)
{
	local Name tName;

	if(!Super.Facelift(bOn))
		return false;

	tName = GetStateName();

	if(bOn)
	{
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPShotgun", class'mesh', True));
		PickupViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPSawedoffPickup", class'mesh', True));
		ThirdPersonMesh = mesh(DynamicLoadObject("HDTPItems.HDTPSawedoff3rd", class'mesh', True));
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
      PickupAmmoCount = 12; //to match assaultshotgun
	}
}

state Packing
{
ignores Fire, AltFire, ClientAltFire, LoadAmmo;

Begin:

	if(DeusExPlayer(Owner) != None)
	{
		//== Only load up if a) we have ammo in the clip, and b) if our skill level permits it
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill) )
		{
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024, 0.5);		// CockingSound is reloadbegin
			else
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024);		// CockingSound is reloadbegin
			PlayAnim('ReloadBegin', , 0.1);
			FinishAnim();
			AmmoType.UseAmmo(1);
			ClipCount++;
		
			if(ExtraAmmoLoaded < 0)
				ExtraAmmoLoaded = 0;
		
			ExtraAmmoLoaded++;
	
			Pawn(Owner).ClientMessage(Sprintf(msgExtraShells,ExtraAmmoLoaded + 1));
	
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024, 0.5);		// AltFireSound is reloadend
			else
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024);		// AltFireSound is reloadend
			PlayAnim('ReloadEnd');
			FinishAnim();
		}
	}
	GotoState('Idle');

}

state ClientPacking
{
ignores ClientFire, ClientAltFire, AltFire, LoadAmmo;

Begin:

	if(DeusExPlayer(Owner) != None)
	{
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill))
		{
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024, 0.5);		// CockingSound is reloadbegin
			else
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024);		// CockingSound is reloadbegin
			PlayAnim('ReloadBegin', , 0.1);
			FinishAnim();
			AmmoType.SimUseAmmo();
		
			if(ExtraAmmoLoaded < 0)
				ExtraAmmoLoaded = 0;
			ExtraAmmoLoaded++;

			Pawn(Owner).ClientMessage(Sprintf(msgExtraShells,ExtraAmmoLoaded + 1));

			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024, 0.5);		// AltFireSound is reloadend
			else
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024);		// AltFireSound is reloadend
			PlayAnim('ReloadEnd');
			FinishAnim();
		}
	}

	GotoState('Idle');
}

state ReFiring
{
ignores ClientFire, ClientAltFire, AltFire, LoadAmmo;

Begin:
	//=== Do a number of TraceFires for each extra round in the chamber
	do
	{
		Super.DoTraceFire(currentAccuracy);
		ExtraAmmoLoaded--;
		if(ExtraAmmoLoaded >= 0)
		{
			//== Wait a little bit before playing the next animation
			Sleep(0.2);
			PlayAnim('Shoot', ,0.1);
			if ( PlayerPawn(Owner) != None )		// shake us based on accuracy
				PlayerPawn(Owner).ShakeView(ShakeTime, currentAccuracy * ShakeMag + ShakeMag, currentAccuracy * ShakeVert);
		}
		else //== If we're done, wait for the animation to finish so we don't get a permanent muzzleflash
			FinishAnim();
	}
	until(ExtraAmmoLoaded < 0);
	GotoState('Idle');

}

function AltFire(float Value)
{
	if(DeusExPlayer(Owner) != None)
	{
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill))
		{
			GotoState('Packing');
		}
	}
	return;
}

simulated function bool ClientAltFire(float Value)
{
	if(DeusExPlayer(Owner) != None)
	{
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill))
		{
			GotoState('ClientPacking');
		}
		else
			return false;
	}
	return true;
}

simulated function DoTraceFire( float Accuracy )
{

	if(ExtraAmmoLoaded > 0)
		GotoState('ReFiring');
	else
		Super.DoTraceFire(Accuracy);
}

function bool LoadAmmo(int ammonum)
{
	if(ExtraAmmoLoaded > 0)
		AmmoType.AddAmmo(ExtraAmmoLoaded);

	ExtraAmmoLoaded = 0;

	return Super.LoadAmmo(ammonum);
}

function ReloadAmmo()
{
	if(ExtraAmmoLoaded > 0)
		AmmoType.AddAmmo(ExtraAmmoLoaded);

	ExtraAmmoLoaded = 0;

	Super.ReloadAmmo();	
}

defaultproperties
{
     msgExtraShells="%d rounds loaded into firing chamber"
     LowAmmoWaterMark=4
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_Visual
     ShotTime=0.300000
     reloadTime=3.000000
     HitDamage=5
     maxRange=2400
     AccurateRange=1200
     BaseAccuracy=0.600000
     FireSound2=Sound'DeusExSounds.Weapons.SawedOffShotgunFire'
     AmmoNames(0)=Class'DeusEx.AmmoShell'
     AmmoNames(1)=Class'DeusEx.AmmoSabot'
     AmmoNames(2)=Class'DeusEx.AmmoDragon'
     ProjectileNames(2)=Class'DeusEx.FireballDragon'
     AreaOfEffect=AOE_Cone
     bHasAltFire=True
     recoilStrength=0.500000
     mpReloadTime=0.500000
     mpHitDamage=9
     mpBaseAccuracy=0.200000
     mpAccurateRange=1200
     mpMaxRange=1200
     mpReloadCount=6
     mpPickupAmmoCount=12
     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     AmmoName=Class'DeusEx.AmmoShell'
     ReloadCount=4
     PickupAmmoCount=4
     bInstantHit=True
     FireOffset=(X=-11.000000,Y=4.000000,Z=13.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.SawedOffShotgunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.SawedOffShotgunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.SawedOffShotgunReload'
     SelectSound=Sound'DeusExSounds.Weapons.SawedOffShotgunSelect'
     InventoryGroup=6
     ItemName="Sawed-off Shotgun"
     PlayerViewOffset=(X=11.000000,Y=-4.000000,Z=-13.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Shotgun'
     PickupViewMesh=LodMesh'DeusExItems.ShotgunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Shotgun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconShotgun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconShotgun'
     largeIconWidth=131
     largeIconHeight=45
     invSlotsX=3
     Description="The sawed-off, pump-action shotgun features a truncated barrel resulting in a wide spread at close range and will accept either buckshot or sabot shells."
     beltDescription="SAWED-OFF"
     Mesh=LodMesh'DeusExItems.ShotgunPickup'
     CollisionRadius=12.000000
     CollisionHeight=0.900000
     Mass=15.000000
}
