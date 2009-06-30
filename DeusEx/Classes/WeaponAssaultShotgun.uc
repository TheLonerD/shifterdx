//=============================================================================
// WeaponAssaultShotgun.
//=============================================================================
class WeaponAssaultShotgun extends DeusExWeapon;

var() travel int ExtraAmmoLoaded;
var string msgExtraShells;

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

state Packing
{
ignores Fire, AltFire, ClientAltFire, LoadAmmo;

Begin:

	if(DeusExPlayer(Owner) != None)
	{
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevel(GoverningSkill) )
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
		if(AmmoLeftInClip() > 1 && ExtraAmmoLoaded <= DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill) )
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
	do
	{
		Super.DoTraceFire(currentAccuracy);
		ExtraAmmoLoaded--;
		if(ExtraAmmoLoaded >= 0)
		{
			Sleep(0.2);
			PlayAnim('Shoot', ,0.1);
			if ( PlayerPawn(Owner) != None )		// shake us based on accuracy
				PlayerPawn(Owner).ShakeView(ShakeTime, currentAccuracy * ShakeMag + ShakeMag, currentAccuracy * ShakeVert);
		}
		else
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

//     ProjectileNames(2)=Class'DeusEx.Fireball'

defaultproperties
{
     msgExtraShells="%d rounds loaded into firing chamber"
     LowAmmoWaterMark=12
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     EnviroEffective=ENVEFF_Air
     bAutomatic=True
     ShotTime=0.700000
     reloadTime=4.500000
     HitDamage=4
     maxRange=2400
     AccurateRange=1200
     BaseAccuracy=0.800000
     FireSound2=Sound'DeusExSounds.Weapons.AssaultShotgunFire'
     AmmoNames(0)=Class'DeusEx.AmmoShell'
     AmmoNames(1)=Class'DeusEx.AmmoSabot'
     AmmoNames(2)=Class'DeusEx.AmmoDragon'
     ProjectileNames(2)=Class'DeusEx.FireballDragon'
     AreaOfEffect=AOE_Cone
     bHasAltFire=True
     recoilStrength=0.700000
     mpReloadTime=0.500000
     mpHitDamage=5
     mpBaseAccuracy=0.200000
     mpAccurateRange=1800
     mpMaxRange=1800
     mpReloadCount=12
     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveModShotTime=True
     AmmoName=Class'DeusEx.AmmoShell'
     ReloadCount=12
     PickupAmmoCount=12
     bInstantHit=True
     FireOffset=(X=-30.000000,Y=10.000000,Z=12.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.AssaultShotgunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.AssaultShotgunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultShotgunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultShotgunSelect'
     InventoryGroup=7
     ItemName="Assault Shotgun"
     ItemArticle="an"
     PlayerViewOffset=(Y=-10.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AssaultShotgun'
     PickupViewMesh=LodMesh'DeusExItems.AssaultShotgunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.AssaultShotgun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconAssaultShotgun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAssaultShotgun'
     largeIconWidth=99
     largeIconHeight=55
     invSlotsX=2
     invSlotsY=2
     Description="The assault shotgun (sometimes referred to as a 'street sweeper') combines the best traits of a normal shotgun with a fully automatic feed that can clear an area of hostiles in a matter of seconds. Particularly effective in urban combat, the assault shotgun accepts either buckshot or sabot shells."
     beltDescription="SHOTGUN"
     Mesh=LodMesh'DeusExItems.AssaultShotgunPickup'
     CollisionRadius=15.000000
     CollisionHeight=8.000000
     Mass=30.000000
}
