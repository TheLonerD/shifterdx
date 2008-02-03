//=============================================================================
// DeusExWeapon.
//=============================================================================
class DeusExWeapon extends Weapon
	abstract;

//
// enums for weapons (duh)
//
enum EEnemyEffective
{
	ENMEFF_All,
	ENMEFF_Organic,
	ENMEFF_Robot
};

enum EEnviroEffective
{
	ENVEFF_All,
	ENVEFF_Air,
	ENVEFF_Water,
	ENVEFF_Vacuum,
	ENVEFF_AirWater,
	ENVEFF_AirVacuum,
	ENVEFF_WaterVacuum
};

enum EConcealability
{
	CONC_None,
	CONC_Visual,
	CONC_Metal,
	CONC_All
};

enum EAreaType
{
	AOE_Point,
	AOE_Cone,
	AOE_Sphere
};

enum ELockMode
{
	LOCK_None,
	LOCK_Invalid,
	LOCK_Range,
	LOCK_Acquire,
	LOCK_Locked
};

var() float 		FireRate;
var() float		AltFireRate;

var bool				bReadyToFire;			// true if our bullets are loaded, etc.
var() int				LowAmmoWaterMark;		// critical low ammo count
var travel int			ClipCount;				// number of bullets remaining in current clip

var() Name		FireAnim[2];

var() int				AmmoUseModifier;		// Modifies how much ammo is used per shot, e.g. modifier of 2
									//  means the weapon uses double ammo.
var() int				AltAmmoUseModifier;

var() class<Skill>		GoverningSkill;			// skill that affects this weapon
var() travel float		NoiseLevel;				// amount of noise that weapon makes when fired
var() EEnemyEffective	EnemyEffective;			// type of enemies that weapon is effective against
var() EEnviroEffective	EnviroEffective;		// type of environment that weapon is effective in
var() EConcealability	Concealability;			// concealability of weapon
var() travel bool		bAutomatic;				// is this an automatic weapon?
var() travel bool		bAltAutomatic;
var() travel float		ShotTime;				// number of seconds between shots
var() travel float		AltShotTime;
var() travel float		ReloadTime;				// number of seconds needed to reload the clip
var() int				HitDamage;				// damage done by a single shot (or for shotguns, a single slug)
var() int				AltHitDamage;
var() int				ProjectileDamage;				// damage done by a single shot (or for shotguns, a single slug)
var() int				AltProjectileDamage;
var() int				MaxRange;				// absolute maximum range in world units (feet * 16)
var() travel int		AccurateRange;			// maximum accurate range in world units (feet * 16)
var() travel float		BaseAccuracy;			// base accuracy (0.0 is dead on, 1.0 is far off)

var bool				bCanHaveScope;			// can this weapon have a scope?
var() travel bool		bHasScope;				// does this weapon have a scope?
var() int				ScopeFOV;				// FOV while using scope
var bool				bZoomed;				// are we currently zoomed?
var bool				bWasZoomed;				// were we zoomed? (used during reloading)

var bool				bCanHaveLaser;			// can this weapon have a laser sight?
var() travel bool		bHasLaser;				// does this weapon have a laser sight?
var bool				bLasing;				// is the laser sight currently on?
var LaserEmitter		Emitter;				// actual laser emitter - valid only when bLasing == True

var bool				bCanHaveSilencer;		// can this weapon have a silencer?
var() travel bool		bHasSilencer;			// does this weapon have a silencer?

var() bool				bCanTrack;				// can this weapon lock on to a target?
var() float				LockTime;				// how long the target must stay targetted to lock
var float				LockTimer;				// used for lock checking
var float            MaintainLockTimer;   // Used for maintaining a lock even after moving off target.
var Actor            LockTarget;          // Used for maintaining a lock even after moving off target.
var Actor				Target;					// actor currently targetted
var ELockMode			LockMode;				// is this target locked?
var string				TargetMessage;			// message to print during targetting
var float				TargetRange;			// range to current target
var() Sound				LockedSound;			// sound to play when locked
var() Sound				TrackingSound;			// sound to play while tracking a target
var() Sound				FireSound2;			// AltFire Sound
var float				SoundTimer;				// to time the sounds correctly

var() bool				bLethal;	//Does this weapon kill, regardless of damage type?
							//(Used for Toxin Blade)

var() class<Ammo>		AmmoNames[3];			// three possible types of ammo per weapon
var() string		ProjectileString[2];			// two possible alt-fire strings per weapon
var() class<Projectile> ProjectileNames[3];		// projectile classes for different ammo
var() EAreaType			AreaOfEffect;			// area of effect of the weapon
var() EAreaType			AltAreaOfEffect;
var bool				bHasAltFire;	// does the weapon have an alt-fire mode?
var bool				bSetAltFire;	// is the weapon set to alt-fire mode?
var() bool				bPenetrating;			// shot will penetrate and cause blood
var() float				StunDuration;			// how long the shot stuns the target
var() bool				bHasMuzzleFlash;		// does this weapon have a flash when fired?
var() bool				bHandToHand;			// is this weapon hand to hand (no ammo)?
var globalconfig vector SwingOffset;     // offsets for this weapon swing.
var() travel float		recoilStrength;			// amount that the weapon kicks back after firing (0.0 is none, 1.0 is large)
var bool				bFiring;				// True while firing, used for recoil
var bool				bOwnerWillNotify;		// True if firing hand-to-hand weapons is dependent on the owner's animations
var bool				bFallbackWeapon;		// If True, only use if no other weapons are available
var bool				bNativeAttack;			// True if weapon represents a native attack
var bool				bEmitWeaponDrawn;		// True if drawing this weapon should make NPCs react
var bool				bUseWhileCrouched;		// True if NPCs should crouch while using this weapon
var bool				bUseAsDrawnWeapon;		// True if this weapon should be carried by NPCs as a drawn weapon
var bool				bWasInFiring;

var() bool		bUnique;		// Is this a Unique Weapon? (Used for various things, e.g. NPCs picking up the weapon)

var bool bNearWall;								// used for prox. mine placement
var Vector placeLocation;						// used for prox. mine placement
var Vector placeNormal;							// used for prox. mine placement
var Mover placeMover;							// used for prox. mine placement

var float ShakeTimer;
var float ShakeYaw;
var float ShakePitch;

var float LaserYaw;							// Yaw of the Laser emitter, relative to the gun
var float LaserPitch;							// Pitch of the Laser emitter, relative to the gun

var float AIMinRange;							// minimum "best" range for AI; 0=default min range
var float AIMaxRange;							// maximum "best" range for AI; 0=default max range
var float AITimeLimit;							// maximum amount of time an NPC should hold the weapon; 0=no time limit
var float AIFireDelay;							// Once fired, use as fallback weapon until the timeout expires; 0=no time limit

var float standingTimer;						// how long we've been standing still (to increase accuracy)
var float currentAccuracy;						// what the currently calculated accuracy is (updated every tick)

var MuzzleFlash flash;							// muzzle flash actor

var float MinSpreadAcc;        // Minimum accuracy for multiple slug weapons (shotgun).  Affects only multiplayer,
                               // keeps shots from all going in same place (ruining shotgun effect)
var float MinAltSpreadAcc;

var float MinProjSpreadAcc;
var float MinAltProjSpreadAcc;

var float MinWeaponAcc;        // Minimum accuracy for a weapon at all.  Affects only multiplayer.
var bool bNeedToSetMPPickupAmmo;

var bool	bDestroyOnFinish;

var float	mpReloadTime;			
var int		mpHitDamage;
var float	mpBaseAccuracy;
var int		mpAccurateRange;
var int		mpMaxRange;
var int		mpReloadCount;
var int		mpPickupAmmoCount;

// Used to track weapon mods accurately.
var bool bCanHaveModBaseAccuracy;
var bool bCanHaveModReloadCount;
var bool bCanHaveModAccurateRange;
var bool bCanHaveModReloadTime;
var bool bCanHaveModRecoilStrength;

//Rate of Fire Mod -- Y|yukichigai
var bool bCanHaveModShotTime;

var travel float ModBaseAccuracy;
var travel float ModReloadCount;
var travel float ModAccurateRange;
var travel float ModReloadTime;
var travel float ModRecoilStrength;

//Rate of Fire Mod -- Y|yukichigai
var travel float ModShotTime;

var localized String msgCannotBeReloaded;
var localized String msgOutOf;
var localized String msgNowHas;
var localized String msgAlreadyHas;
var localized String msgNowSetMode; //added
var localized String ModeString; //added
var localized String msgNone;
var localized String msgLockInvalid;
var localized String msgLockRange;
var localized String msgLockAcquire;
var localized String msgLockLocked;
var localized String msgRangeUnit;
var localized String msgTimeUnit;
var localized String msgMassUnit;
var localized String msgNotWorking;
var localized String msgSwitchingTo;

//
// strings for info display
//
var localized String msgInfoAmmoLoaded;
var localized String msgInfoAmmo;
var localized String msgInfoDamage;
var localized String msgInfoClip;
var localized String msgInfoROF;
var localized String msgInfoReload;
var localized String msgInfoRecoil;
var localized String msgInfoAccuracy;
var localized String msgInfoAccRange;
var localized String msgInfoMaxRange;
var localized String msgInfoMass;
var localized String msgInfoLaser;
var localized String msgInfoScope;
var localized String msgInfoSilencer;
var localized String msgInfoNA;
var localized String msgInfoYes;
var localized String msgInfoNo;
var localized String msgInfoAuto;
var localized String msgInfoSingle;
var localized String msgInfoRounds;
var localized String msgInfoRoundsPerSec;
var localized String msgInfoSkill;
var localized String msgInfoWeaponStats;

var bool		bClientReadyToFire, bClientReady, bInProcess, bFlameOn, bLooping;
var int		SimClipCount, flameShotCount, SimAmmoAmount;
var float	TimeLockSet;

//
// network replication
//
replication
{
    // server to client
    reliable if ((Role == ROLE_Authority) && (bNetOwner))
        ClipCount, bZoomed, bHasSilencer, bHasLaser, ModBaseAccuracy, ModReloadCount, ModAccurateRange, ModReloadTime, ModRecoilStrength;

	// Things the client should send to the server
	//reliable if ( (Role<ROLE_Authority) )
		//LockTimer, Target, LockMode, TargetMessage, TargetRange, bCanTrack, LockTarget;

    // Functions client calls on server
    reliable if ( Role < ROLE_Authority )
        ReloadAmmo, LoadAmmo, CycleAmmo, LaserOn, LaserOff, LaserToggle, ScopeOn, ScopeOff, ScopeToggle, PropagateLockState, ServerForceFire, 
		  ServerGenerateBullet, ServerGotoFinishFire, ServerHandleNotify, StartFlame, StopFlame, ServerDoneReloading, DestroyOnFinish, SwitchItem, TestCycleable;

    // Functions Server calls in client
    reliable if ( Role == ROLE_Authority )
      RefreshScopeDisplay, ReadyClientToFire, SetClientAmmoParams, ClientDownWeapon, ClientActive, ClientReload;
}

// ---------------------------------------------------------------------
// PropagateLockState()
// ---------------------------------------------------------------------
simulated function PropagateLockState(ELockMode NewMode, Actor NewTarget)
{
   LockMode = NewMode;
   LockTarget = NewTarget;
}

// ---------------------------------------------------------------------
// SetLockMode()
// ---------------------------------------------------------------------
simulated function SetLockMode(ELockMode NewMode)
{
   if ((LockMode != NewMode) && (Role != ROLE_Authority))
   {
      if (NewMode != LOCK_Locked)
         PropagateLockState(NewMode, None);
      else
         PropagateLockState(NewMode, Target);
   }
	TimeLockSet = Level.Timeseconds;
   LockMode = NewMode;
}

// ---------------------------------------------------------------------
// PlayLockSound()
// Because playing a sound from a simulated function doesn't play it 
// server side.
// ---------------------------------------------------------------------
function PlayLockSound()
{
   if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
	   Owner.PlaySound(LockedSound, SLOT_None,,,, 0.5);
   else
	   Owner.PlaySound(LockedSound, SLOT_None);
}

function PlaySelect()
{
	PlayAnim('Select',1.0,0.0);
	if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
		Owner.PlaySound(SelectSound, SLOT_Misc, Pawn(Owner).SoundDampening,,, 0.5);	
	else
		Owner.PlaySound(SelectSound, SLOT_Misc, Pawn(Owner).SoundDampening);	
}

function RemoveObjectFromBelt(Inventory item)
{
   local DeusExPlayer player;
   player = DeusExPlayer(Owner);
   player.RemoveObjectFromBelt(item);
}

function AddObjectToBelt(Inventory item, int pos, bool bOverride)
{
   local DeusExPlayer player;
   player = DeusExPlayer(Owner);
   player.AddObjectToBelt(item, pos, bOverride);
}

//
// install the correct projectile info if needed
//
function TravelPostAccept()
{
	local int i;

	Super.TravelPostAccept();

	// make sure the AmmoName matches the currently loaded AmmoType
	if (AmmoType != None)
		AmmoName = AmmoType.Class;

	if (!bInstantHit)
	{
		if (ProjectileClass != None)
			ProjectileSpeed = ProjectileClass.Default.speed;

		// make sure the projectile info matches the actual AmmoType
		// since we can't "var travel class" (AmmoName and ProjectileClass)
		if (AmmoType != None)
		{
			FireSound = None;
			for (i=0; i<ArrayCount(AmmoNames); i++)
			{
				if (AmmoNames[i] == AmmoName)
				{
					ProjectileClass = ProjectileNames[i];
					break;
				}
			}
		}
	}
}


//
// PreBeginPlay
//

function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Default.mpPickupAmmoCount == 0 )
	{
		Default.mpPickupAmmoCount = Default.PickupAmmoCount;
	}
	if(Level.NetMode == NM_Standalone)
		Facelift(true);
}

function Facelift(bool bOn){}

//
// PostBeginPlay
//

function PostBeginPlay()
{
	Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
   {
      bWeaponStay = True;
      if (bNeedToSetMPPickupAmmo)
      {
         PickupAmmoCount = PickupAmmoCount * 3;
         bNeedToSetMPPickupAmmo = False;
      }
   }
}

singular function BaseChange()
{
	Super.BaseChange();

	// Make sure we fall if we don't have a base
	if ((base == None) && (Owner == None))
		SetPhysics(PHYS_Falling);
}

function bool HandlePickupQuery(Inventory Item)
{
	local DeusExWeapon W;
	local DeusExPlayer player;
	local bool bResult;
	local class<Ammo> defAmmoClass;
	local Ammo defAmmo;
	
	// make sure that if you pick up a modded weapon that you
	// already have, you get the mods
	W = DeusExWeapon(Item);
	if ((W != None) && (W.Class == Class))
	{
		if (W.ModBaseAccuracy > ModBaseAccuracy)
			ModBaseAccuracy = W.ModBaseAccuracy;
		if (W.ModReloadCount > ModReloadCount)
			ModReloadCount = W.ModReloadCount;
		if (W.ModAccurateRange > ModAccurateRange)
			ModAccurateRange = W.ModAccurateRange;

		// these are negative
		if (W.ModReloadTime < ModReloadTime)
			ModReloadTime = W.ModReloadTime;
		if (W.ModRecoilStrength < ModRecoilStrength)
			ModRecoilStrength = W.ModRecoilStrength;

		if (W.bHasLaser)
			bHasLaser = True;
		if (W.bHasSilencer)
			bHasSilencer = True;
		if (W.bHasScope)
			bHasScope = True;

		// copy the actual stats as well
		if (W.ReloadCount > ReloadCount)
			ReloadCount = W.ReloadCount;
		if (W.AccurateRange > AccurateRange)
			AccurateRange = W.AccurateRange;

		// these are negative
		if (W.BaseAccuracy < BaseAccuracy)
			BaseAccuracy = W.BaseAccuracy;
		if (W.ReloadTime < ReloadTime)
			ReloadTime = W.ReloadTime;
		if (W.RecoilStrength < RecoilStrength)
			RecoilStrength = W.RecoilStrength;

		// This is for the ROF mod
		if(W.ModShotTime < ModShotTime)
			ModShotTime = W.ModShotTime;
	}
	player = DeusExPlayer(Owner);

	if (Item.Class == Class)
	{
      if (!( (Weapon(item).bWeaponStay && (Level.NetMode == NM_Standalone)) && (!Weapon(item).bHeldItem || Weapon(item).bTossedOut)))
		{
			// Only add ammo of the default type
			// There was an easy way to get 32 20mm shells, buy picking up another assault rifle with 20mm ammo selected
			if ( AmmoType != None )
			{
				// Add to default ammo only
				if ( AmmoNames[0] == None )
					defAmmoClass = AmmoName;
				else
					defAmmoClass = AmmoNames[0];

				defAmmo = Ammo(player.FindInventoryType(defAmmoClass));
				defAmmo.AddAmmo( Weapon(Item).PickupAmmoCount );

				if ( Level.NetMode != NM_Standalone )
				{
					if (( player != None ) && ( player.InHand != None ))
					{
						if ( DeusExWeapon(item).class == DeusExWeapon(player.InHand).class )
							ReadyToFire();
					}
				}
			}
		}
	}

	bResult = Super.HandlePickupQuery(Item);

	// Notify the object belt of the new ammo
	if (player != None)
		player.UpdateBeltText(Self);

	return bResult;
}

function BringUp()
{
	if ( Level.NetMode != NM_Standalone )
		ReadyClientToFire( False );

	// alert NPCs that I'm whipping it out
	if (!bNativeAttack && bEmitWeaponDrawn)
		AIStartEvent('WeaponDrawn', EAITYPE_Visual);

	// Y|yukichigai
	// activate the laser on draw, if this weapon has one
	if (bHasLaser)
		LaserOn();

	// reset the standing still accuracy bonus
	standingTimer = 0;

	Super.BringUp();
}

function bool PutDown()
{
	if ( Level.NetMode != NM_Standalone )
		ReadyClientToFire( False );

	// alert NPCs that I'm putting away my gun
	AIEndEvent('WeaponDrawn', EAITYPE_Visual);

	// reset the standing still accuracy bonus
	standingTimer = 0;

	// Y|yukichigai
	// If it's not deactivated as the weapon goes down, it's possible to get a
	//  "ghost" laser that's not attached to anything if it's not finished before
	//  the level changes.
	if(bHasLaser)
		LaserOff();

	return Super.PutDown();
}

function ReloadAmmo()
{
	// single use or hand to hand weapon if ReloadCount == 0
	if (ReloadCount == 0)
	{
		Pawn(Owner).ClientMessage(msgCannotBeReloaded);
		return;
	}

	if (!IsInState('Reload'))
	{
		TweenAnim('Still', 0.1);
		GotoState('Reload');
	}
}

//
// Note we need to control what's calling this...but I'll get rid of the access nones for now
//
simulated function float GetWeaponSkill()
{
	local DeusExPlayer player;
	local float value;

	value = 0;

	if ( Owner != None )
	{
		player = DeusExPlayer(Owner);
		if (player != None)
		{
			if ((player.AugmentationSystem != None ) && ( player.SkillSystem != None ))
			{
				// get the target augmentation
				value = player.AugmentationSystem.GetAugLevelValue(class'AugTarget');
				if (value == -1.0)
					value = 0;

				// get the skill
				value += player.SkillSystem.GetSkillLevelValue(GoverningSkill);

				if(player.drugEffectTimer < 0) //(player.FindInventoryType(Class'DeusEx.ZymeCharged') != None)
				{
					value -= 0.15;
				}
			}
		}
	}
	return value;
}

// calculate the accuracy for this weapon and the owner's damage
simulated function float CalculateAccuracy()
{
	local float accuracy;	// 0 is dead on, 1 is pretty far off
	local float tempacc, div, diff;
   local float weapskill; // so we don't keep looking it up (slower).
	local int HealthArmRight, HealthArmLeft, HealthHead;
	local int BestArmRight, BestArmLeft, BestHead;
	local bool checkit;
	local DeusExPlayer player;

	accuracy = BaseAccuracy;		// start with the weapon's base accuracy
   weapskill = GetWeaponSkill();

	player = DeusExPlayer(Owner);

	diff = DeusExPlayer(GetPlayerPawn()).combatDifficulty;

	if (player != None)
	{
		// check the player's skill
		// 0.0 = dead on, 1.0 = way off
		accuracy += weapskill;

		// get the health values for the player
		HealthArmRight = player.HealthArmRight;
		HealthArmLeft  = player.HealthArmLeft;
		HealthHead     = player.HealthHead;
		BestArmRight   = player.Default.HealthArmRight;
		BestArmLeft    = player.Default.HealthArmLeft;
		BestHead       = player.Default.HealthHead;
		checkit = True;
	}
	else if (ScriptedPawn(Owner) != None)
	{
		// update the weapon's accuracy with the ScriptedPawn's BaseAccuracy
		// (BaseAccuracy uses higher values for less accuracy, hence we add)
		accuracy += ScriptedPawn(Owner).BaseAccuracy;

		// get the health values for the NPC
		HealthArmRight = ScriptedPawn(Owner).HealthArmRight;
		HealthArmLeft  = ScriptedPawn(Owner).HealthArmLeft;
		HealthHead     = ScriptedPawn(Owner).HealthHead;
		BestArmRight   = ScriptedPawn(Owner).Default.HealthArmRight;
		BestArmLeft    = ScriptedPawn(Owner).Default.HealthArmLeft;
		BestHead       = ScriptedPawn(Owner).Default.HealthHead;
		checkit = True;
	}
	else
		checkit = False;

	// Disabled accuracy mods based on health in multiplayer
	if ( Level.NetMode != NM_Standalone )
		checkit = False;

	if (checkit)
	{
		if (HealthArmRight < 1)
			accuracy += 0.5;
		else if (HealthArmRight < BestArmRight * 0.34)
			accuracy += 0.2;
		else if (HealthArmRight < BestArmRight * 0.67)
			accuracy += 0.1;

		if (HealthArmLeft < 1)
			accuracy += 0.5;
		else if (HealthArmLeft < BestArmLeft * 0.34)
			accuracy += 0.2;
		else if (HealthArmLeft < BestArmLeft * 0.67)
			accuracy += 0.1;

		if (HealthHead < BestHead * 0.67)
			accuracy += 0.1;
	}

	// increase accuracy (decrease value) if we haven't been moving for awhile
	// this only works for the player, because NPCs don't need any more aiming help!
	//  EXCEPT now they do because of my changes -- Y|yukichigai
	if (player != None || diff >= 1.0)
	{
		tempacc = accuracy;
		if (standingTimer > 0)
		{
			// higher skill makes standing bonus greater
			div = Max(15.0 + 29.0 * weapskill, 0.0);
			// NPCs get a decreased standing bonus on lower difficulty levels
			if(player == None)
				div *= 4.0/diff;
			accuracy -= FClamp(standingTimer/div, 0.0, 0.6);
	
			// don't go too low
			if ((accuracy < 0.1) && (tempacc > 0.1))
				accuracy = 0.1;
		}
	}

	// make sure we don't go negative
	if (accuracy < 0.0)
		accuracy = 0.0;

   if (Level.NetMode != NM_Standalone)
      if (accuracy < MinWeaponAcc)
         accuracy = MinWeaponAcc;

	// Let's do scope accuracy over here
	if(bHasScope && !bZoomed)
	{
		accuracy = FMax(accuracy, 0.05);
		if(Default.bHasScope)
			accuracy += 0.1;
	}

	return accuracy;
}

//
// functions to change ammo types
//
function bool LoadAmmo(int ammoNum)
{
	local class<Ammo> newAmmoClass;
	local Ammo newAmmo;
	local Pawn P;

	if ((ammoNum < 0) || (ammoNum > 2))
		return False;

	P = Pawn(Owner);

	// sorry, only pawns can have weapons
	if (P == None)
		return False;

	newAmmoClass = AmmoNames[ammoNum];

	if (newAmmoClass != None) 
	{
		if (newAmmoClass != AmmoName) 
		{
			newAmmo = Ammo(P.FindInventoryType(newAmmoClass));
			if (newAmmo == None)
			{
				//== Actually, let's not message them about the ammo if they've never picked it up before
				//P.ClientMessage(Sprintf(msgOutOf, newAmmoClass.Default.ItemName));
				return False;
			}
			
			// if we don't have a projectile for this ammo type, then set instant hit
			if (ProjectileNames[ammoNum] == None)
			{
				bInstantHit = True;
				bAutomatic = Default.bAutomatic;

				//New stuff -- ROF Mod
				if(HasROFMod())
					ShotTime = Default.ShotTime * (1.0+ModShotTime);
				else
					ShotTime = Default.ShotTime;

				if ( Level.NetMode != NM_Standalone )
				{
					if (HasReloadMod())
						ReloadTime = mpReloadTime * (1.0+ModReloadTime);
					else
						ReloadTime = mpReloadTime;
				}
				else
				{
					if (HasReloadMod())
						ReloadTime = Default.ReloadTime * (1.0+ModReloadTime);
					else
						ReloadTime = Default.ReloadTime;
				}
				FireSound = Default.FireSound;
				ProjectileClass = None;
			}
			else
			{
				// otherwise, set us to fire projectiles
				bInstantHit = False;
				bAutomatic = False;
				ShotTime = 1.0;
				if (HasReloadMod())
					ReloadTime = 2.0 * (1.0+ModReloadTime);
				else
					ReloadTime = 2.0;

				FireSound = None;		// handled by the projectile

				AltProjectileClass = ProjectileClass;
				ProjectileClass = ProjectileNames[ammoNum];
				AltProjectileSpeed = ProjectileSpeed;
				ProjectileSpeed = ProjectileClass.Default.Speed;
			}

			AmmoName = newAmmoClass;
			AmmoType = newAmmo;

			// AlexB had a new sound for 20mm but there's no mechanism for playing alternate sounds per ammo type
			// Same for WP rocket
//			if ( Ammo20mm(newAmmo) != None )
//				FireSound=Sound'AssaultGunFire20mm';
//			else if ( AmmoRocketWP(newAmmo) != None )
//				FireSound=Sound'GEPGunFireWP';
//			else if ( AmmoRocket(newAmmo) != None )
//				FireSound=Sound'GEPGunFire';
//			else if ( AmmoPlasma(newAmmo) != None )
//				FireSound=Sound'PlasmaRifleFire';

			if(ammoNum == 0)
			{
				FireSound=Default.FireSound;
				if(Default.FireSound2 != None)
					FireSound2=Default.FireSound2;
			}
			else if(Default.FireSound2 != None)
			{
				FireSound=Default.FireSound2;
				FireSound2=Default.FireSound;
			}

			if ( Level.NetMode != NM_Standalone )
				SetClientAmmoParams( bInstantHit, bAutomatic, ShotTime, FireSound, ProjectileClass, ProjectileSpeed );

			// Notify the object belt of the new ammo
			if (DeusExPlayer(P) != None)
				DeusExPlayer(P).UpdateBeltText(Self);

			ReloadAmmo();

			P.ClientMessage(Sprintf(msgNowHas, ItemName, newAmmoClass.Default.ItemName));
			return True;
		}
		else
		{
			P.ClientMessage(Sprintf(MsgAlreadyHas, ItemName, newAmmoClass.Default.ItemName));
		}
	}

	return False;
}

simulated function SwitchItem()
{
	local int i, j;
	local class<Weapon> SwitchList[12];
	local Pawn P;

	P = Pawn(Owner);

	if(P == None)
		return;

	i = 0;

	SwitchList[i++] = class'WeaponBaton';
	SwitchList[i++] = class'WeaponBlackjack';
	SwitchList[i++] = class'WeaponCombatKnife';
	SwitchList[i++] = class'WeaponCrowbar';
	SwitchList[i++] = class'WeaponNanoSword';
	SwitchList[i++] = class'WeaponPrototypeSword';
	SwitchList[i++] = class'WeaponPrototypeSwordA';
	SwitchList[i++] = class'WeaponPrototypeSwordB';
	SwitchList[i++] = class'WeaponPrototypeSwordC';
	SwitchList[i++] = class'WeaponSword';
	SwitchList[i++] = class'WeaponShuriken';
	SwitchList[i++] = class'WeaponToxinBlade';

	for(i = 0; i < ArrayCount(SwitchList); i++)
	{
		if(Class == SwitchList[i])
			break;
	}

	for(j = 0; j < ArrayCount(SwitchList); j++)
	{
		i++;
		if(i >= ArrayCount(SwitchList))
			i = 0;

		if(P.FindInventoryType(SwitchList[i]) != None && SwitchList[i] != Class)
		{
			if((P.FindInventoryType(SwitchList[i])).beltPos == -1)
			{
				AddObjectToBelt(P.FindInventoryType(SwitchList[i]), beltPos, false);
				DeusExPlayer(P).PutInHand(P.FindInventoryType(SwitchList[i]));
				P.ClientMessage(Sprintf(msgSwitchingTo, SwitchList[i].Default.ItemName));
				break;
			}
		}
	}
}

// ----------------------------------------------------------------------
//
// ----------------------------------------------------------------------

simulated function SetClientAmmoParams( bool bInstant, bool bAuto, float sTime, Sound FireSnd, class<projectile> pClass, float pSpeed )
{
	bInstantHit = bInstant;
	bAutomatic = bAuto;
	ShotTime = sTime;
	FireSound = FireSnd;
	ProjectileClass = pClass;
	ProjectileSpeed = pSpeed;
}

// ----------------------------------------------------------------------
// CanLoadAmmoType()
//
// Returns True if this ammo type can be used with this weapon
// ----------------------------------------------------------------------

simulated function bool CanLoadAmmoType(Ammo ammo)
{
	local int  ammoIndex;
	local bool bCanLoad;

	bCanLoad = False;

	if (ammo != None)
	{
		// First check "AmmoName"

		if (AmmoName == ammo.Class)
		{
			bCanLoad = True;
		}
		else
		{
			for (ammoIndex=0; ammoIndex<3; ammoIndex++)
			{
				if (AmmoNames[ammoIndex] == ammo.Class)
				{
					bCanLoad = True;
					break;
				}
			}
		}
	}

	return bCanLoad;
}

// ----------------------------------------------------------------------
// LoadAmmoType()
// 
// Load this ammo type given the actual object
// ----------------------------------------------------------------------

function LoadAmmoType(Ammo ammo)
{
	local int i;

	if (ammo != None)
		for (i=0; i<3; i++)
			if (AmmoNames[i] == ammo.Class)
				LoadAmmo(i);
}

// ----------------------------------------------------------------------
// LoadAmmoClass()
// 
// Load this ammo type given the class
// ----------------------------------------------------------------------

function LoadAmmoClass(Class<Ammo> ammoClass)
{
	local int i;

	if (ammoClass != None)
		for (i=0; i<3; i++)
			if (AmmoNames[i] == ammoClass)
				LoadAmmo(i);
}

// ----------------------------------------------------------------------
// CycleAmmo()
// ----------------------------------------------------------------------

function CycleAmmo()
{
	local int i, last;

	if(NumAmmoTypesAvailable() < 2)
	{
		//Call the item cycling option, if applicable
		if(TestCycleable())
			SwitchItem();

		return;
	}

	for (i=0; i<ArrayCount(AmmoNames); i++)
		if (AmmoNames[i] == AmmoName)
			break;

	last = i;

	do
	{
		if (++i >= 3)
			i = 0;

		if (LoadAmmo(i))
			break;
	} until (last == i);
}

simulated function bool CanReload()
{
	if ((ClipCount > 0) && (ReloadCount != 0) && (AmmoType != None) && (AmmoType.AmmoAmount > 0) &&
	    (AmmoType.AmmoAmount > (ReloadCount-ClipCount)))
		return true;
	else
		return false;
}

simulated function bool MustReload()
{
	if ((AmmoLeftInClip() == 0) && (AmmoType != None) && (AmmoType.AmmoAmount > 0))
		return true;
	else
		return false;
}

simulated function int AmmoLeftInClip()
{
	if (ReloadCount == 0)	// if this weapon is not reloadable
		return 1;
	else if (AmmoType == None)
		return 0;
	else if (AmmoType.AmmoAmount == 0)		// if we are out of ammo
		return 0;
	else if (ReloadCount - ClipCount > AmmoType.AmmoAmount)		// if we have no clips left
		return AmmoType.AmmoAmount;
	else
		return ReloadCount - ClipCount;
}

simulated function int NumClips()
{
	if (ReloadCount == 0)  // if this weapon is not reloadable
		return 0;
	else if (AmmoType == None)
		return 0;
	else if (AmmoType.AmmoAmount == 0)	// if we are out of ammo
		return 0;
	else  // compute remaining clips
		return ((AmmoType.AmmoAmount-AmmoLeftInClip()) + (ReloadCount-1)) / ReloadCount;
}

simulated function int AmmoAvailable(int ammoNum)
{
	local class<Ammo> newAmmoClass;
	local Ammo newAmmo;
	local Pawn P;

	P = Pawn(Owner);

	// sorry, only pawns can have weapons
	if (P == None)
		return 0;

	newAmmoClass = AmmoNames[ammoNum];

	if (newAmmoClass == None)
		return 0;

	newAmmo = Ammo(P.FindInventoryType(newAmmoClass));

	if (newAmmo == None)
		return 0;

	return newAmmo.AmmoAmount;
}

simulated function int NumAmmoTypesAvailable()
{
	local int i, j;
	local Pawn P;

	P = Pawn(Owner);

	j = 0;
	for (i=0; i<ArrayCount(AmmoNames); i++)
	{
		if (AmmoNames[i] == None)
			break;
		//=== modified to only indicate the number of ammo types that the player has found already
		if(DeusExPlayer(P) != None)
		{
			if(Ammo(P.FindInventoryType(AmmoNames[i])) == None)
				j++;
		}
	}

	i -= j;
	// to make Al fucking happy
	if (i <= 0)
		i = 1;

	return i;
}

function name WeaponDamageType()
{
	local name                    damageType;
	local Class<DeusExProjectile> projClass;

	projClass = Class<DeusExProjectile>(ProjectileClass);
	if (bInstantHit || bAltInstantHit)
	{
		if (StunDuration > 0)
			damageType = 'Stunned';
		else
			damageType = 'Shot';

		if (AmmoType != None)
		{
			if (AmmoType.IsA('AmmoSabot'))
				damageType = 'Sabot';
			else if(AmmoType.IsA('AmmoDragon'))
				damageType = 'Flamed';
			else if(AmmoType.IsA('AmmoShell'))
				damageType = 'Shell';
			else if(AmmoType.IsA('Ammo10mmEX'))
				damageType = 'Exploded';
		}
	}
	else if (projClass != None)
		damageType = projClass.Default.damageType;
	else
		damageType = 'None';

	return (damageType);
}


//
// target tracking info
//
simulated function Actor AcquireTarget()
{
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local Actor hit, retval;
	local Pawn p;

	p = Pawn(Owner);
	if (p == None)
		return None;

	StartTrace = p.Location;
	if (PlayerPawn(p) != None)
		EndTrace = p.Location + (10000 * Vector(p.ViewRotation));
	else
		EndTrace = p.Location + (10000 * Vector(p.Rotation));

	// adjust for eye height
	StartTrace.Z += p.BaseEyeHeight;
	EndTrace.Z += p.BaseEyeHeight;

	foreach TraceActors(class'Actor', hit, HitLocation, HitNormal, EndTrace, StartTrace)
		if (!hit.bHidden && (hit.IsA('Decoration') || hit.IsA('Pawn')))
			return hit;

	return None;
}

//
// Used to determine if we are near (and facing) a wall for placing LAMs, etc.
//
simulated function bool NearWallCheck()
{
	local Vector StartTrace, EndTrace, HitLocation, HitNormal;
	local Actor HitActor;

	// Scripted pawns can't place LAMs
	if (ScriptedPawn(Owner) != None)
		return False;

	// Don't let players place grenades when they have something highlighted
	if ( Level.NetMode != NM_Standalone )
	{
		if ( Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).frobTarget != None) )
		{
			if ( DeusExPlayer(Owner).IsFrobbable( DeusExPlayer(Owner).frobTarget ) )
				return False;
		}
	}

	// trace out one foot in front of the pawn
	StartTrace = Owner.Location;
	EndTrace = StartTrace + Vector(Pawn(Owner).ViewRotation) * 32;

	StartTrace.Z += Pawn(Owner).BaseEyeHeight;
	EndTrace.Z += Pawn(Owner).BaseEyeHeight;

	HitActor = Trace(HitLocation, HitNormal, EndTrace, StartTrace);
	if ((HitActor == Level) || ((HitActor != None) && HitActor.IsA('Mover')))
	{
		placeLocation = HitLocation;
		placeNormal = HitNormal;
		placeMover = Mover(HitActor);
		return True;
	}

	return False;
}

//
// used to place a grenade on the wall
//
function PlaceGrenade()
{
	local ThrownProjectile gren;
	local float dmgX, pitch;

	gren = ThrownProjectile(spawn(ProjectileClass, Owner,, placeLocation, Rotator(placeNormal)));
	if (gren != None)
	{
		pitch = 1.0;
		if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
			pitch = 0.5;

		AmmoType.UseAmmo(1);
		if ( AmmoType.AmmoAmount <= 0 )
			bDestroyOnFinish = True;

		gren.PlayAnim('Open');
		gren.PlaySound(gren.MiscSound, SLOT_None, 0.5+FRand()*0.5,, 512, (0.85+FRand()*0.3) * pitch);
		gren.SetPhysics(PHYS_None);
		gren.bBounce = False;
		gren.bProximityTriggered = True;
		gren.bStuck = True;
		if (placeMover != None)
			gren.SetBase(placeMover);

		// up the damage based on the skill
		// returned value from GetWeaponSkill is negative, so negate it to make it positive
		// dmgX value ranges from 1.0 to 2.4 (max demo skill and max target aug)
		dmgX = -2.0 * GetWeaponSkill() + 1.0;
		gren.Damage *= dmgX;

		// Update ammo count on object belt
		if (DeusExPlayer(Owner) != None)
			DeusExPlayer(Owner).UpdateBeltText(Self);
	}
}

//
// scope, laser, and targetting updates are done here
//
simulated function Tick(float deltaTime)
{
	local vector loc;
	local rotator rot;
	local float beepspeed, recoil;
	local DeusExPlayer player;
   local Actor RealTarget;
	local Pawn pawn;
	local bool bChange;

	local int accunit; //Multiplier to apply to the accuracy to get our effective spread

	player = DeusExPlayer(Owner);
	pawn = Pawn(Owner);

	Super.Tick(deltaTime);

	// don't do any of this if this weapon isn't currently in use
	if (pawn == None)
   {
      LockMode = LOCK_None;
      MaintainLockTimer = 0;
      LockTarget = None;
      LockTimer = 0;
		return;
   }

	if (pawn.Weapon != self)
   {
      LockMode = LOCK_None;
      MaintainLockTimer = 0;
      LockTarget = None;
      LockTimer = 0;
		return;
   }

	// all this should only happen IF you have ammo loaded
	if (ClipCount < ReloadCount)
	{
		// check for LAM or other placed mine placement
		if (bHandToHand && (ProjectileClass != None) && (!Self.IsA('WeaponShuriken')))
		{
			if (NearWallCheck())
			{
				if (( Level.NetMode != NM_Standalone ) && IsAnimating() && (AnimSequence == 'Select'))
				{
				}
				else
				{
					if (!bNearWall || (AnimSequence == 'Select'))
					{
						PlayAnim('PlaceBegin',, 0.1);
						bNearWall = True;
					}
				}
			}
			else
			{
				if (bNearWall)
				{
					PlayAnim('PlaceEnd',, 0.1);
					bNearWall = False;
				}
			}
		}


      SoundTimer += deltaTime;

      if ( (Level.Netmode == NM_Standalone) || ( (Player != None) && (Player.PlayerIsClient()) ) )
      {
         if (bCanTrack)
         {
            Target = AcquireTarget();
            RealTarget = Target;
            
            // calculate the range
            if (Target != None)
               TargetRange = Abs(VSize(Target.Location - Location));
            
            // update our timers
            //SoundTimer += deltaTime;
            MaintainLockTimer -= deltaTime;
            
            // check target and range info to see what our mode is
            if ((Target == None) || IsInState('Reload'))
            {
               if (MaintainLockTimer <= 0)
               {				
                  SetLockMode(LOCK_None);
                  MaintainLockTimer = 0;
                  LockTarget = None;
               }
               else if (LockMode == LOCK_Locked)
               {
                  Target = LockTarget;
               }
            }
            else if ((Target != LockTarget) && (Target.IsA('Pawn')) && (LockMode == LOCK_Locked))
            {
               SetLockMode(LOCK_None);
               LockTarget = None;
            }
            else if (!Target.IsA('Pawn'))
            {
               if (MaintainLockTimer <=0 )
               {
                  SetLockMode(LOCK_Invalid);
               }
            }
            else if ( (Target.IsA('DeusExPlayer')) && (Target.Style == STY_Translucent) )
            {
               //DEUS_EX AMSD Don't allow locks on cloaked targets.
               SetLockMode(LOCK_Invalid);
            }
            else if ( (Target.IsA('DeusExPlayer')) && (Player.DXGame.IsA('TeamDMGame')) && (TeamDMGame(Player.DXGame).ArePlayersAllied(Player,DeusExPlayer(Target))) )
            {
               //DEUS_EX AMSD Don't allow locks on allies.
               SetLockMode(LOCK_Invalid);
            }
            else
            {
               if (TargetRange > MaxRange)
               {
                  SetLockMode(LOCK_Range);
               }
               else
               {
                  // change LockTime based on skill
                  // -0.7 = max skill
                  // DEUS_EX AMSD Only do weaponskill check here when first checking.
                  if (LockTimer == 0)
                  {
                     LockTime = FMax(Default.LockTime + 3.0 * GetWeaponSkill(), 0.0);
                     if ((Level.Netmode != NM_Standalone) && (LockTime < 0.25))
                        LockTime = 0.25;
                  }
                  
                  LockTimer += deltaTime;
                  if (LockTimer >= LockTime)
                  {
                     SetLockMode(LOCK_Locked);
                  }
                  else
                  {
                     SetLockMode(LOCK_Acquire);
                  }
               }
            }
            
            // act on the lock mode
            switch (LockMode)
            {
            case LOCK_None:
               TargetMessage = msgNone;
               LockTimer -= deltaTime;
               break;
               
            case LOCK_Invalid:
               TargetMessage = msgLockInvalid;
               LockTimer -= deltaTime;
               break;
               
            case LOCK_Range:
               TargetMessage = msgLockRange @ Int(TargetRange/16) @ msgRangeUnit;
               LockTimer -= deltaTime;
               break;
               
            case LOCK_Acquire:
               TargetMessage = msgLockAcquire @ Left(String(LockTime-LockTimer), 4) @ msgTimeUnit;
               beepspeed = FClamp((LockTime - LockTimer) / Default.LockTime, 0.2, 1.0);
               if (SoundTimer > beepspeed)
               {
		  if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
	                  Owner.PlaySound(TrackingSound, SLOT_None,,,, 0.5);
		  else
	                  Owner.PlaySound(TrackingSound, SLOT_None);
                  SoundTimer = 0;
               }
               break;
               
            case LOCK_Locked:
               // If maintaining a lock, or getting a new one, increment maintainlocktimer
               if ((RealTarget != None) && ((RealTarget == LockTarget) || (LockTarget == None)))
               {
                  if (Level.NetMode != NM_Standalone)
                     MaintainLockTimer = default.MaintainLockTimer;
                  else
                     MaintainLockTimer = 0;
                  LockTarget = Target;
               }
               TargetMessage = msgLockLocked @ Int(TargetRange/16) @ msgRangeUnit;
               // DEUS_EX AMSD Moved out so server can play it so that client knows for sure when locked.
               /*if (SoundTimer > 0.1)
               {
                  Owner.PlaySound(LockedSound, SLOT_None);
                  SoundTimer = 0;
               }*/
               break;
            }
         }
	 else if(bLasing)
	 {
	    if(Emitter.Spot[0] != None)
	    {
		TargetRange = Abs(VSize(Owner.Location - Emitter.Spot[0].Location));
		TargetMessage = Int(TargetRange/16) @ msgRangeUnit;
	    }
	    else
	    {
		TargetRange = Float(MaxRange) + 2.000000;
		TargetMessage = "Out of Range";
	    }

	    if(Int(TargetRange) <= AccurateRange)
	    {
		LockMode = LOCK_None;
	    }
	    else if(Int(TargetRange) <= MaxRange)
	    {
		LockMode = LOCK_Acquire;
	    }
	    else
	    {
		LockMode = LOCK_Locked;
	    }

            LockTimer = 0;
            MaintainLockTimer = 0;
            LockTarget = None;
         }
         else
         {
            LockMode = LOCK_None;
            TargetMessage = msgNone;
            LockTimer = 0;
            MaintainLockTimer = 0;
            LockTarget = None;
         }
         
         if (LockTimer < 0)
            LockTimer = 0;
      }
   }
   else
   {
      LockMode = LOCK_None;
	  TargetMessage=msgNone;
      MaintainLockTimer = 0;
      LockTarget = None;
      LockTimer = 0;
   }

   if ((LockMode == LOCK_Locked) && (SoundTimer > 0.1) && (Role == ROLE_Authority))
   {
      PlayLockSound();
      SoundTimer = 0;
   }

	currentAccuracy = CalculateAccuracy();

	if (player != None)
	{
		// reduce the recoil based on skill
		recoil = recoilStrength + GetWeaponSkill() * 2.0;
		if (recoil < 0.0)
			recoil = 0.0;

		// simulate recoil while firing
		if (bFiring && IsAnimating() && (AnimSequence == 'Shoot') && (recoil > 0.0))
		{
			player.ViewRotation.Yaw += deltaTime * (Rand(4096) - 2048) * recoil;
			player.ViewRotation.Pitch += deltaTime * (Rand(4096) + 4096) * recoil;
			if ((player.ViewRotation.Pitch > 16384) && (player.ViewRotation.Pitch < 32768))
				player.ViewRotation.Pitch = 16384;
		}
	}

	// if were standing still, increase the timer
	if (VSize(Owner.Velocity) < 10)
		standingTimer += deltaTime;
	else	// otherwise, decrease it slowly based on velocity
		standingTimer = FMax(0, standingTimer - 0.03*deltaTime*VSize(Owner.Velocity));

	if (bLasing || bZoomed)
	{
		//== Though it uses the same code, the laser shake is different than the zoom shake
		if(bZoomed)
			accunit = 2048;
		else if (bLasing)
			accunit = 1536;

		// shake our view to simulate poor aiming
		if (ShakeTimer > 0.25)
		{
			ShakeYaw = currentAccuracy * (Rand(accunit * 2) - accunit);
			ShakePitch = currentAccuracy * (Rand(accunit * 2) - accunit);
			ShakeTimer -= 0.25;
		}

		ShakeTimer += deltaTime;

		if (bLasing && (Emitter != None))
		{
			loc = Owner.Location;
			loc.Z += Pawn(Owner).BaseEyeHeight;

			// add a little random jitter - looks cool!
			rot = Pawn(Owner).ViewRotation;
			rot.Yaw += Rand(5) - 2;
			rot.Pitch += Rand(5) - 2;

			if(!bZoomed)
			{
				LaserYaw += ShakeYaw * deltaTime;
				if(LaserYaw > currentAccuracy * accunit)
				{
					LaserYaw = currentAccuracy * accunit;
					ShakeYaw *= -1;
				}
				if(LaserYaw < currentAccuracy * accunit * -1)
				{
					LaserYaw = currentAccuracy * accunit * -1;
					ShakeYaw *= -1;
				}
	
				LaserPitch += ShakePitch * deltaTime;
				if(LaserPitch > currentAccuracy * accunit)
				{
					LaserPitch = currentAccuracy * accunit;
					ShakePitch *= -1;
				}
				if(LaserPitch < currentAccuracy * accunit * -1)
				{
					LaserPitch = currentAccuracy * accunit * -1;
					ShakePitch *= -1;
				}

				rot.Yaw += LaserYaw;
				rot.Pitch += LaserPitch;
			}

			Emitter.SetLocation(loc);
			Emitter.SetRotation(rot);
		}

		if ((player != None) && bZoomed)
		{
			player.ViewRotation.Yaw += deltaTime * ShakeYaw;
			player.ViewRotation.Pitch += deltaTime * ShakePitch;
		}
	}
}

//
// scope functions for weapons which have them
//

function ScopeOn()
{
	if (!bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		if(bHasScope || DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugTarget') > -1)
		{
			// Show the Scope View
			bZoomed = True;
			RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
		}
	}
}

function ScopeOff()
{
	if (bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bZoomed = False;
		//== If we disable the scope in the middle of a reload, don't go back
		if(bWasZoomed)
			bWasZoomed = False;
		// Hide the Scope View
		RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
		//DeusExRootWindow(DeusExPlayer(Owner).rootWindow).scopeView.DeactivateView();
	}
}

simulated function ScopeToggle()
{
//	if (IsInState('Idle'))
//	{
		if ((Owner != None) && Owner.IsA('DeusExPlayer'))
		{
			if(bHasScope || DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugTarget') > -1 || bZoomed)
			{
				if (bZoomed)
					ScopeOff();
				else
					ScopeOn();
			}
		}
//	}
}

// ----------------------------------------------------------------------
// RefreshScopeDisplay()
// ----------------------------------------------------------------------

simulated function RefreshScopeDisplay(DeusExPlayer player, bool bInstant, bool bScopeOn)
{
	local int temp;
	if (bScopeOn && (player != None))
	{
		temp = Int(30.000000 + (100.000000 * player.AugmentationSystem.GetAugLevelValue(class'AugTarget')));
		if(ScopeFOV < temp || temp <= 0)
			temp = ScopeFOV;

		// Show the Scope View
		DeusExRootWindow(player.rootWindow).scopeView.ActivateView(temp, False, bInstant);
	}
   else if (!bScopeOn)
   {
      DeusExrootWindow(player.rootWindow).scopeView.DeactivateView();
   }
}

//
// laser functions for weapons which have them
//

function LaserOn()
{
	if (bHasLaser && !bLasing)
	{
		// if we don't have an emitter, then spawn one
		// otherwise, just turn it on
		if (Emitter == None)
		{
			Emitter = Spawn(class'LaserEmitter', Self, , Location, Pawn(Owner).ViewRotation);
			if (Emitter != None)
			{
				Emitter.SetHiddenBeam(True);
				Emitter.AmbientSound = None;
				Emitter.TurnOn();
			}
		}
		else
			Emitter.TurnOn();

		bLasing = True;
	}
}

function LaserOff()
{
	if (bHasLaser && bLasing)
	{
		if (Emitter != None)
			Emitter.TurnOff();

		bLasing = False;
	}
}

function LaserToggle()
{
	if (IsInState('Idle'))
	{
		if (bHasLaser)
		{
			if (bLasing)
				LaserOff();
			else
				LaserOn();
		}
	}
}

simulated function SawedOffCockSound()
{
	if ((AmmoType.AmmoAmount > 0) && (WeaponSawedOffShotgun(Self) != None))
	{
		if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
			Owner.PlaySound(SelectSound, SLOT_None,,, 1024, 0.5);
		else
			Owner.PlaySound(SelectSound, SLOT_None,,, 1024);
	}
}

//
// called from the MESH NOTIFY
//
simulated function SwapMuzzleFlashTexture()
{
   if (!bHasMuzzleFlash)
      return;
	if (FRand() < 0.5)
		MultiSkins[2] = Texture'FlatFXTex34';
	else
		MultiSkins[2] = Texture'FlatFXTex37';

	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function EraseMuzzleFlashTexture()
{
	MultiSkins[2] = None;
}

simulated function Timer()
{
	EraseMuzzleFlashTexture();
}

simulated function MuzzleFlashLight()
{
	local Vector offset, X, Y, Z;

 	if (!bHasMuzzleFlash)
		return;

	if ((flash != None) && !flash.bDeleteMe)
		flash.LifeSpan = flash.Default.LifeSpan;
	else
	{
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);
		offset = Owner.Location;
		offset += X * Owner.CollisionRadius * 2;
		flash = spawn(class'MuzzleFlash',,, offset);
		if (flash != None)
			flash.SetBase(Owner);
	}
}

function ServerHandleNotify( bool bInstantHit, class<projectile> ProjClass, float ProjSpeed, bool bWarn )
{
	if (bInstantHit)
		TraceFire(0.0);
	else
		ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);
}

//
// HandToHandAttack
// called by the MESH NOTIFY for the H2H weapons
//
simulated function HandToHandAttack()
{
	local bool bOwnerIsPlayerPawn;

	if (bOwnerWillNotify)
		return;

	// The controlling animator should be the one to do the tracefire and projfire
	if ( Level.NetMode != NM_Standalone )
	{
		bOwnerIsPlayerPawn = (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn()));

		if (( Role < ROLE_Authority ) && bOwnerIsPlayerPawn )
			ServerHandleNotify( bInstantHit, ProjectileClass, ProjectileSpeed, bWarnTarget );
		else if ( !bOwnerIsPlayerPawn )
			return;
	}

	if (ScriptedPawn(Owner) != None)
		ScriptedPawn(Owner).SetAttackAngle();

	if (bInstantHit)
		TraceFire(0.0);
	else
		ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);

	// if we are a thrown weapon and we run out of ammo, destroy the weapon
	if ( bHandToHand && (ReloadCount > 0) && (SimAmmoAmount <= 0))
	{
		DestroyOnFinish();
		if(AmmoType.AmmoAmount <= 0)
			SwitchItem(); //Replace a lost grenade in the belt slot with a new one if we can
		if ( Role < ROLE_Authority )
		{
			ServerGotoFinishFire();
			GotoState('SimQuickFinish');
		}
	}
}

//
// OwnerHandToHandAttack
// called by the MESH NOTIFY for this weapon's owner
//
simulated function OwnerHandToHandAttack()
{
	local bool bOwnerIsPlayerPawn;

	if (!bOwnerWillNotify)
		return;

	// The controlling animator should be the one to do the tracefire and projfire
	if ( Level.NetMode != NM_Standalone )
	{
		bOwnerIsPlayerPawn = (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn()));

		if (( Role < ROLE_Authority ) && bOwnerIsPlayerPawn )
			ServerHandleNotify( bInstantHit, ProjectileClass, ProjectileSpeed, bWarnTarget );
		else if ( !bOwnerIsPlayerPawn )
			return;
	}

	if (ScriptedPawn(Owner) != None)
		ScriptedPawn(Owner).SetAttackAngle();

	if (bInstantHit)
		TraceFire(0.0);
	else
		ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);
}

function ForceFire()
{
	Fire(0);
}

function ForceAltFire()
{
	AltFire(0);
}

//
// ReadyClientToFire is called by the server telling the client it's ok to fire now
//

simulated function ReadyClientToFire( bool bReady )
{
	bClientReadyToFire = bReady;
}

//
// ClientReFire is called when the client is holding down the fire button, loop firing
//

simulated function ClientReFire( float value )
{
	bClientReadyToFire = True;
	bLooping = True;
	bInProcess = False;
	ClientFire(0);
}

simulated function ClientAltReFire( float value )
{
	bClientReadyToFire = True;
	bLooping = True;
	bInProcess = False;
	ClientAltFire(0);
}

function StartFlame()
{
	flameShotCount = 0;
	bFlameOn = True;
	GotoState('FlameThrowerOn');
}

function StopFlame()
{
	bFlameOn = False;
}

//
// ServerForceFire is called from the client when loop firing
//
function ServerForceFire()
{
	bClientReady = True;
	Fire(0);
}

function ServerForceAltFire()
{
      if ( (Owner != None) && !Owner.IsA('DeusExPlayer') )
            return;
	bClientReady = True;
	AltFire(0);
}

simulated function int PlaySimSound( Sound snd, ESoundSlot Slot, float Volume, float Radius )
{
	if ( Owner != None )
	{
		if ( Level.NetMode == NM_Standalone )
		{
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				return ( Owner.PlaySound( snd, Slot, Volume, , Radius, 0.5 ) );
			return ( Owner.PlaySound( snd, Slot, Volume, , Radius ) );
		}
		else
		{
			Owner.PlayOwnedSound( snd, Slot, Volume, , Radius );
			return 1;
		}
	}
	return 0;
}

//
// ClientFire - Attempts to play the firing anim, sounds, and trace fire hits for instant weapons immediately
//				on the client.  The server may have a different interpretation of what actually happen, but this at least
//				cuts down on preceived lag.
//
simulated function bool ClientFire( float value )
{
	local bool bWaitOnAnim;
	local vector shake;
	local int i;

	// check for surrounding environment
	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );
			}
			return false;
		}
	}

	if ( !bLooping ) // Wait on animations when not looping
	{
		bWaitOnAnim = ( IsAnimating() && ((AnimSequence == 'Select') || (AnimSequence == FireAnim[0]) || (AnimSequence == FireAnim[1]) || (AnimSequence == 'ReloadBegin') || (AnimSequence == 'Reload') || (AnimSequence == 'ReloadEnd') || (AnimSequence == 'Down')));
	}
	else
	{
		bWaitOnAnim = False;
		bLooping = False;
	}

	if ( (Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).NintendoImmunityTimeLeft > 0.01)) ||
		  (!bClientReadyToFire) || bInProcess || bWaitOnAnim )
	{
		DeusExPlayer(Owner).bJustFired = False;
		bPointing = False;
		bFiring = False;
		return false;
	}

	if ( !Self.IsA('WeaponFlamethrower') )
		ServerForceFire();

	if (bHandToHand)
	{
		SimAmmoAmount = AmmoType.AmmoAmount - 1;

		bClientReadyToFire = False;
		bInProcess = True;
		GotoState('ClientFiring');
		bPointing = True;
		if ( PlayerPawn(Owner) != None )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveFiring();
		PlayFiringSound();
	}
	else if ((ClipCount < ReloadCount) || (ReloadCount == 0))
	{
		if ((ReloadCount == 0) || ((AmmoType.AmmoAmount > 0 && AmmoUseModifier <= 1) || AmmoType.AmmoAmount >= AmmoUseModifier))
		{
			SimClipCount = ClipCount + 1;

			if ( AmmoType != None )
			{
				AmmoType.SimUseAmmo();

				if(AmmoUseModifier > 1)
				{
					for(i = 1; i < AmmoUseModifier; i++)
					{
						AmmoType.SimUseAmmo();
					}
				}
			}

			bFiring = True;
			bPointing = True;
			bClientReadyToFire = False;
			bInProcess = True;
			GotoState('ClientFiring');
			if ( PlayerPawn(Owner) != None )
			{
				shake.X = 0.0;
				shake.Y = 100.0 * (ShakeTime*0.5);
				shake.Z = 100.0 * -(currentAccuracy * ShakeVert);
				PlayerPawn(Owner).ClientShake( shake );
				PlayerPawn(Owner).PlayFiring();
			}
			// Don't play firing anim for 20mm
			if ( Ammo20mm(AmmoType) == None )
				PlaySelectiveFiring();

			if( (Ammo20mm(AmmoType) == None && Self.IsA('WeaponAssaultGun') && !bHasSilencer) || Self.IsA('WeaponFlameThrower') || Self.IsA('WeaponPepperGun'))
				PlayFiringSound();

			if ( bInstantHit &&  ( Ammo20mm(AmmoType) == None ))
				TraceFire(currentAccuracy);
			else
			{
				if ( !bFlameOn && Self.IsA('WeaponFlamethrower'))
				{
					bFlameOn = True;
					StartFlame();
				}
				ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);
			}
		}
		else
		{
			if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
			{
				if ( MustReload() && CanReload() )
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();

					ReloadAmmo();
				}
			}
			PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );		// play dry fire sound
		}
	}
	else
	{
		if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
		{
			if ( MustReload() && CanReload() )
			{
				bClientReadyToFire = False;
				bInProcess = False;
				if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
					CycleAmmo();
				ReloadAmmo();
			}
		}
		PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );		// play dry fire sound
	}
	return true;
}

//
// from Weapon.uc - modified so we can have the accuracy in TraceFire
//
function Fire(float Value)
{
	local float sndVolume;
	local bool bListenClient;
	local int ammouse;

	bListenClient = (Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient());

	sndVolume = TransientSoundVolume;

	if ( Level.NetMode != NM_Standalone )  // Turn up the sounds a bit in mulitplayer
	{
		sndVolume = TransientSoundVolume * 2.0;
		if ( Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).NintendoImmunityTimeLeft > 0.01) || (!bClientReady && (!bListenClient)) )
		{
			DeusExPlayer(Owner).bJustFired = False;
			bReadyToFire = True;
			bPointing = False;
			bFiring = False;
			return;
		}
	}
	// check for surrounding environment
	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound
			}
			GotoState('Idle');
			return;
		}
	}


	if (bHandToHand)
	{
		if (ReloadCount > 0)
			AmmoType.UseAmmo(1);

		if (( Level.NetMode != NM_Standalone ) && !bListenClient )
			bClientReady = False;
		bReadyToFire = False;
		GotoState('NormalFire');
		bPointing=True;
		if ( Owner.IsA('PlayerPawn') )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveFiring();
		PlayFiringSound();
	}
	// if we are a single-use weapon, then our ReloadCount is 0 and we don't use ammo
	else if ((ClipCount < ReloadCount) || (ReloadCount == 0))
	{
		ammouse = AmmoUseModifier;
		if(ammouse < 1) ammouse = 1;

		if ((ReloadCount == 0) || AmmoType.UseAmmo(ammouse))
		{
			if (( Level.NetMode != NM_Standalone ) && !bListenClient )
				bClientReady = False;

			ClipCount++;
			bFiring = True;
			bReadyToFire = False;
			GotoState('NormalFire');
			if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
			{
				if ( PlayerPawn(Owner) != None )		// shake us based on accuracy
					PlayerPawn(Owner).ShakeView(ShakeTime, currentAccuracy * ShakeMag + ShakeMag, currentAccuracy * ShakeVert);
			}
			bPointing=True;
			if ( bInstantHit )
				TraceFire(currentAccuracy);
			else
				ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);

			if ( Owner.IsA('PlayerPawn') )
				PlayerPawn(Owner).PlayFiring();
			// Don't play firing anim for 20mm
			PlaySelectiveFiring();
			if ( Ammo20mm(AmmoType) == None )
			{
//				PlaySelectiveFiring();
				if((Self.IsA('WeaponAssaultGun') && !bHasSilencer) || Self.IsA('WeaponFlameThrower') || Self.IsA('WeaponPepperGun'))
					PlayFiringSound();
			}
			if ( Owner.bHidden )
				CheckVisibility();
		}
		else
			PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound
	}
	else
		PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound

	// Update ammo count on object belt
	if (DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).UpdateBeltText(Self);
}

simulated function bool ClientAltFire( float value )
{
	local bool bWaitOnAnim;
	local vector shake;

	if(!bHasAltFire && !IsA('TnagWeapon'))
	{
		ScopeToggle();
		return false;
	}

	// check for surrounding environment
	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );
			}
			return false;
		}
	}

	if ( !bLooping ) // Wait on animations when not looping
	{
		bWaitOnAnim = ( IsAnimating() && ((AnimSequence == 'Select') || (AnimSequence == FireAnim[0]) || (AnimSequence == FireAnim[1]) || (AnimSequence == 'ReloadBegin') || (AnimSequence == 'Reload') || (AnimSequence == 'ReloadEnd') || (AnimSequence == 'Down')));
	}
	else
	{
		bWaitOnAnim = False;
		bLooping = False;
	}	

      if ( !bClientReadyToFire || bInProcess || ((DeusExPlayer(Owner) != None) && bWaitOnAnim) )
	{
//            if (Owner.IsA('DeusExPlayer'))
//		    DeusExPlayer(Owner).bJustAltFired = False;
		bPointing = False;
		bFiring = False;
		return false;
	}

      ServerForceAltFire();
	
	if (bHandToHand)
	{
		SimAmmoAmount = AmmoType.AmmoAmount - 1;

		bClientReadyToFire = False;
		bInProcess = True;
		GotoState('ClientAltFiring');
		bPointing = True;
		if ( PlayerPawn(Owner) != None )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveAltFiring();
		PlayFiringAltSound();
	}
	else if (((ReloadCount - ClipCount) >= AltAmmoUseModifier) || (ReloadCount == 0))
	{
		if ((ReloadCount == 0) || (AmmoType.AmmoAmount > 0))
		{

			if ( AmmoType != None )
				AmmoType.SimUseAmmo();

			bFiring = True;
			bPointing = True;
			bClientReadyToFire = False;
			bInProcess = True;
			GotoState('ClientAltFiring');
			if ( PlayerPawn(Owner) != None )
			{
				shake.X = 0.0;
				shake.Y = 100.0 * (ShakeTime*0.5);
				shake.Z = 100.0 * -(currentAccuracy * ShakeVert);
				PlayerPawn(Owner).ClientShake( shake );
				PlayerPawn(Owner).PlayFiring();
			}
			PlaySelectiveAltFiring();
			PlayFiringAltSound();

			if ( bAltInstantHit )
				TraceAltFire(currentAccuracy);
			else
				ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
		}
		else
		{
			if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
			{
				if ( MustReload() && CanReload() )
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if (AmmoType.AmmoAmount == 0)
						CycleAmmo();
					ReloadAmmo();
				}
			}
                  		else if ( ScriptedPawn(Owner) != None )
			{
				bClientReadyToFire = False;
				bInProcess = False;
				ReloadAmmo();
			}

			PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );		// play dry fire sound
		}
	}
	else
	{
		if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
		{
			if ( MustReload() && CanReload() )
			{
				bClientReadyToFire = False;
				bInProcess = False;
				if (AmmoType.AmmoAmount == 0) 
					CycleAmmo();
				ReloadAmmo();
			}
		}
            		else if ( ScriptedPawn(Owner) != None )
		{
			bClientReadyToFire = False;
			bInProcess = False;
			ReloadAmmo();
		}

		PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );		// play dry fire sound
	}
	return true;
}

function AltFire(float Value)
{
	local float sndVolume;
	local bool bListenClient;

	if(!bHasAltFire && !IsA('TnagWeapon'))
	{
		ScopeToggle();
		return;
	}

	bListenClient = (Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient());

	sndVolume = TransientSoundVolume;

	if (Level.Game.bDeathMatch)
           sndVolume = TransientSoundVolume * 2.0;

	if ( Level.NetMode != NM_Standalone )  
	{
		if ( !bClientReady && !bListenClient && Owner.IsA('DeusExPlayer'))
		{
//                  if ( Owner.IsA('DeusExPlayer')) 
//			     DeusExPlayer(Owner).bJustAltFired = False;
			bReadyToFire = True;
			bPointing = False;
			bFiring = False;
			return;
		}
	}

	// check for surrounding environment
	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound
			}
			GotoState('Idle');
			return;
		}
	}

	if (bHandToHand)
	{
		if (ReloadCount > 0)
			AmmoType.UseAmmo(1);

		if (( Level.NetMode != NM_Standalone ) && (!bListenClient || !Owner.IsA('DeusExPlayer'))  )
			bClientReady = False;
		bReadyToFire = False;
            if (( Level.NetMode != NM_Standalone ) && ((Owner != None) && !Owner.IsA('DeusExPlayer')))
                  ClientAltFire(Value);
          	GotoState('AltFiring');
		bPointing=True;
            if ( Owner.IsA('PlayerPawn') )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveAltFiring();
		PlayFiringAltSound();
	}
	// if we are a single-use weapon, then our ReloadCount is 0 and we don't use ammo
	else if (((ReloadCount - ClipCount) >= AltAmmoUseModifier) || (ReloadCount == 0))
	{
		if ((ReloadCount == 0) || AmmoType.UseAmmo(AltAmmoUseModifier))
		{
			ClipCount += AltAmmoUseModifier;

			if (( Level.NetMode != NM_Standalone ) && (!bListenClient || !Owner.IsA('DeusExPlayer'))  )
				bClientReady = False;
			bFiring = True;
			bReadyToFire = False;
                        		if (( Level.NetMode != NM_Standalone ) && ((Owner != None) && !Owner.IsA('DeusExPlayer')))
                             			ClientAltFire(Value);
                        		GotoState('AltFiring');
			if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
			{
				if ( PlayerPawn(Owner) != None )		// shake us based on accuracy
					PlayerPawn(Owner).ShakeView(ShakeTime, currentAccuracy * ShakeMag + ShakeMag, currentAccuracy * ShakeVert);
			}
			bPointing=True;
                  		if ( bAltInstantHit )
				TraceAltFire(currentAccuracy);
			else
				ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);

			if ( Owner.IsA('PlayerPawn') )
				PlayerPawn(Owner).PlayFiring();
			PlaySelectiveAltFiring();   
			PlayFiringAltSound();
			if ( Owner.bHidden )
				CheckVisibility();
		}
		else
			PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound
	}
	else
		PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );		// play dry fire sound

	// Update ammo count on object belt
	if (DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).UpdateBeltText(Self);
}

function ReadyToFire()
{
	if (!bReadyToFire)
	{
		// BOOGER!
		//if (ScriptedPawn(Owner) != None)
		//	ScriptedPawn(Owner).ReadyToFire();
		bReadyToFire = True;
		if ( Level.NetMode != NM_Standalone )
			ReadyClientToFire( True );
	}
}

function PlayPostSelect()
{
	// let's not zero the ammo count anymore - you must always reload
//	ClipCount = 0;		
}

simulated function PlaySelectiveFiring()
{
	local Pawn aPawn;
	local float rnd;
	local Name anim;
	local int animNum;
	local float mod;

	animNum = 0;

	if(AmmoNames[1] != None)
	{
		for(animNum = 0; animNum < 2; animNum++)
		{
			if(ProjectileClass == ProjectileNames[animNum])
				break;
		}
		if(animNum >= 2)
			animNum = 0;
	}

	anim = FireAnim[animNum];

//	if(anim == '\'')
//		anim = 'Shoot';

	if (bHandToHand)
	{
		rnd = FRand();
		if (rnd < 0.33)
			anim = 'Attack';
		else if (rnd < 0.66)
			anim = 'Attack2';
		else
			anim = 'Attack3';
	}

	if(anim == '')
		return;

	if (( Level.NetMode == NM_Standalone ) || ( DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
	{
		//== Speed up the firing animation if we have the ROF mod
		mod = 1.000000 - ModShotTime;
		if (bAutomatic)
			LoopAnim(anim,FireRate * mod, 0.1);
		else
			PlayAnim(anim,FireRate * mod,0.1);
	}
	else if ( Role == ROLE_Authority )
	{
		for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
		{
			if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(Owner) != DeusExPlayer(aPawn) ) )
			{
				// If they can't see the weapon, don't bother
				if ( DeusExPlayer(aPawn).FastTrace( DeusExPlayer(aPawn).Location, Location ))
					DeusExPlayer(aPawn).ClientPlayAnimation( Self, anim, 0.1, bAutomatic );
			}
		}
	}
}

simulated function PlaySelectiveAltFiring()
{
	local Pawn aPawn;
	local float rnd;
	local Name anim;
	local float mod;

	anim = FireAnim[1];

	if (bHandToHand)
	{
		rnd = FRand();
		if (rnd < 0.33)
			anim = 'Attack';
		else if (rnd < 0.66)
			anim = 'Attack2';
		else
			anim = 'Attack3';
	}

	if(anim == '')
		return;

	if (( Level.NetMode == NM_Standalone ) || ( DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
	{
		mod = 1.0 - ModShotTime;
		if (bAltAutomatic) // || bFireOnRelease)
			LoopAnim(anim,AltFireRate * mod,0.1); //AltFireRate, TimeBetweenAltFire);
		else
			PlayAnim(anim,AltFireRate * mod,0.1); //AltFireRate, TimeBetweenAltFire);
	}
	else if ( Role == ROLE_Authority )
	{
		for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
		{
			if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(Owner) != DeusExPlayer(aPawn) ) )
			{
				if ( DeusExPlayer(aPawn).FastTrace( DeusExPlayer(aPawn).Location, Location ))
					DeusExPlayer(aPawn).ClientPlayAnimation( Self, anim, 0.1, bAltAutomatic );
			}
		}
	}
}

simulated function PlayFiringSound()
{
	if (bHasSilencer)
		PlaySimSound( Sound'StealthPistolFire', SLOT_None, TransientSoundVolume, 2048 );
	else
	{
		// The sniper rifle sound is heard to it's range in multiplayer
		if ( ( Level.NetMode != NM_Standalone ) &&  Self.IsA('WeaponRifle') )	
			PlaySimSound( FireSound, SLOT_None, TransientSoundVolume, class'WeaponRifle'.Default.mpMaxRange );
		else
			PlaySimSound( FireSound, SLOT_None, TransientSoundVolume, 2048 );
	}
}

simulated function PlayFiringAltSound()
{
	if (bHasSilencer)
		PlaySimSound( Sound'StealthPistolFire', SLOT_None, TransientSoundVolume, 2048 );
	else	
		PlaySimSound( FireSound2, SLOT_None, TransientSoundVolume, 2048 );
}

simulated function PlayIdleAnim()
{
	local float rnd;

	if (bZoomed || bNearWall)
		return;

	rnd = FRand();

	if (rnd < 0.1)
		PlayAnim('Idle1',,0.1);
	else if (rnd < 0.2)
		PlayAnim('Idle2',,0.1);
	else if (rnd < 0.3)
		PlayAnim('Idle3',,0.1);
}

//
// SpawnBlood
//

function SpawnBlood(Vector HitLocation, Vector HitNormal)
{
   if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      return;

   spawn(class'BloodSpurt',,,HitLocation+HitNormal);
	spawn(class'BloodDrop',,,HitLocation+HitNormal);
	if (FRand() < 0.5)
		spawn(class'BloodDrop',,,HitLocation+HitNormal);
}

//
// SelectiveSpawnEffects - Continues the simulated chain for the owner, and spawns the effects for other players that can see them
//			No actually spawning occurs on the server itself.
//
simulated function SelectiveSpawnEffects( Vector HitLocation, Vector HitNormal, Actor Other, float Damage)
{
	local DeusExPlayer fxOwner;
	local Pawn aPawn;

	// The normal path before there was multiplayer
	if ( Level.NetMode == NM_Standalone )
	{
		SpawnEffects(HitLocation, HitNormal, Other, Damage);
		return;
	}

	fxOwner = DeusExPlayer(Owner);

	if ( Role == ROLE_Authority )
	{
		SpawnEffectSounds(HitLocation, HitNormal, Other, Damage );

		for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
		{
			if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(aPawn) != fxOwner ) )
			{
				if ( DeusExPlayer(aPawn).FastTrace( DeusExPlayer(aPawn).Location, HitLocation ))
					DeusExPlayer(aPawn).ClientSpawnHits( bPenetrating, bHandToHand, HitLocation, HitNormal, Other, Damage );
			}
		}
	}
	if ( fxOwner == DeusExPlayer(GetPlayerPawn()) )
	{
			fxOwner.ClientSpawnHits( bPenetrating, bHandToHand, HitLocation, HitNormal, Other, Damage );
			SpawnEffectSounds( HitLocation, HitNormal, Other, Damage );
	}
}

//
//	 SpawnEffectSounds - Plays the sound for the effect owner immediately, the server will play them for the other players
//	
simulated function SpawnEffectSounds( Vector HitLocation, Vector HitNormal, Actor Other, float Damage )
{
	if (bHandToHand)
	{
		// if we are hand to hand, play an appropriate sound
		if (Other.IsA('DeusExDecoration'))
			Owner.PlayOwnedSound(Misc3Sound, SLOT_None,,, 1024);
		else if (Other.IsA('Pawn'))
			Owner.PlayOwnedSound(Misc1Sound, SLOT_None,,, 1024);
		else if (Other.IsA('BreakableGlass'))
			Owner.PlayOwnedSound(sound'GlassHit1', SLOT_None,,, 1024);
		else if (GetWallMaterial(HitLocation, HitNormal) == 'Glass')
			Owner.PlayOwnedSound(sound'BulletProofHit', SLOT_None,,, 1024);
		else
			Owner.PlayOwnedSound(Misc2Sound, SLOT_None,,, 1024);
	}
}

//
//	SpawnEffects - Spawns the effects like it did in single player
//
function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other, float Damage)
{
   local TraceHitSpawner hitspawner;
	local Name damageType;
	local float pitch;

	damageType = WeaponDamageType();

	pitch = 1.0;
	if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
		pitch = 0.5;

   if (bPenetrating)
   {
      if (bHandToHand)
      {
         hitspawner = Spawn(class'TraceHitHandSpawner',Other,,HitLocation,Rotator(HitNormal));
      }
      else
      {
         hitspawner = Spawn(class'TraceHitSpawner',Other,,HitLocation,Rotator(HitNormal));
      }
   }
   else
   {
      if (bHandToHand)
      {
         hitspawner = Spawn(class'TraceHitHandNonPenSpawner',Other,,HitLocation,Rotator(HitNormal));
      }
      else
      {
         hitspawner = Spawn(class'TraceHitNonPenSpawner',Other,,HitLocation,Rotator(HitNormal));
      }
   }
   if (hitSpawner != None)
	{
      hitspawner.HitDamage = Damage;
		hitSpawner.damageType = damageType;
	}
	if (bHandToHand)
	{
		// if we are hand to hand, play an appropriate sound
		if (Other.IsA('DeusExDecoration'))
			Owner.PlaySound(Misc3Sound, SLOT_None,,, 1024, pitch);
		else if (Other.IsA('Pawn'))
			Owner.PlaySound(Misc1Sound, SLOT_None,,, 1024, pitch);
		else if (Other.IsA('BreakableGlass'))
			Owner.PlaySound(sound'GlassHit1', SLOT_None,,, 1024, pitch);
		else if (GetWallMaterial(HitLocation, HitNormal) == 'Glass')
			Owner.PlaySound(sound'BulletProofHit', SLOT_None,,, 1024, pitch);
		else
			Owner.PlaySound(Misc2Sound, SLOT_None,,, 1024, pitch);
	}
}


function name GetWallMaterial(vector HitLocation, vector HitNormal)
{
	local vector EndTrace, StartTrace;
	local actor target;
	local int texFlags;
	local name texName, texGroup;

	StartTrace = HitLocation + HitNormal*16;		// make sure we start far enough out
	EndTrace = HitLocation - HitNormal;

	foreach TraceTexture(class'Actor', target, texName, texGroup, texFlags, StartTrace, HitNormal, EndTrace)
		if ((target == Level) || target.IsA('Mover'))
			break;

	return texGroup;
}

simulated function SimGenerateBullet()
{
	if ( Role < ROLE_Authority )
	{
		if ((ClipCount < ReloadCount) && (ReloadCount != 0))
		{
			if ( AmmoType != None )
				AmmoType.SimUseAmmo();

			if ( bInstantHit )
				TraceFire(currentAccuracy);
			else
				ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);

			SimClipCount++;

			if ( !Self.IsA('WeaponFlamethrower') )
				ServerGenerateBullet();
		}
		else
			GotoState('SimFinishFire');
	}
}

simulated function SimAltGenerateBullet()
{
	if ( Role < ROLE_Authority )
	{
		if ((ClipCount < ReloadCount) && (ReloadCount != 0))
		{
			if ( AmmoType != None )
				AmmoType.SimUseAmmo();

			if ( bAltInstantHit )
				TraceAltFire(currentAccuracy);
			else
				ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);

			SimClipCount++;

			if ( !Self.IsA('WeaponFlamethrower') )
				ServerAltGenerateBullet();
		}
		else
			GotoState('SimFinishFire');
	}
}

function ServerAltGenerateBullet()
{
      	if ( (Owner != None) && !Owner.IsA('DeusExPlayer') )
            		return;
	if ( ClipCount < ReloadCount )
		AltGenerateBullet();
}

function AltGenerateBullet()
{
	if (AmmoType.UseAmmo(1))
	{
		if ( bAltInstantHit) 
			TraceAltFire(currentAccuracy);
		else
			ProjectileAltFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);
	}           
	else
		GotoState('FinishFire');
}

function DestroyOnFinish()
{
	bDestroyOnFinish = True;
}

function ServerGotoFinishFire()
{
	GotoState('FinishFire');
}

function ServerDoneReloading()
{
	ClipCount = 0;
}

function ServerGenerateBullet()
{
	if ( ClipCount < ReloadCount )
		GenerateBullet();
}

function GenerateBullet()
{
	if (AmmoType.UseAmmo(1))
	{
		if ( bInstantHit )
			TraceFire(currentAccuracy);
		else
			ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);

		ClipCount++;
	}
	else
		GotoState('FinishFire');
}


function PlayLandingSound()
{
	if (LandSound != None)
	{
		if (Velocity.Z <= -200)
		{
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768, 0.5);
			else
				PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768);
			AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 768);
		}
	}
}


function GetWeaponRanges(out float wMinRange,
                         out float wMaxAccurateRange,
                         out float wMaxRange)
{
	local Class<DeusExProjectile> dxProjectileClass;

	dxProjectileClass = Class<DeusExProjectile>(ProjectileClass);
	if (dxProjectileClass != None)
	{
		wMinRange         = dxProjectileClass.Default.blastRadius;
		wMaxAccurateRange = dxProjectileClass.Default.AccurateRange;
		wMaxRange         = dxProjectileClass.Default.MaxRange;
	}
	else
	{
		wMinRange         = 0;
		wMaxAccurateRange = AccurateRange;
		wMaxRange         = MaxRange;
	}
}

//
// computes the start position of a projectile/trace
//
simulated function Vector ComputeProjectileStart(Vector X, Vector Y, Vector Z)
{
	local Vector Start;

	// if we are instant-hit, non-projectile, then don't offset our starting point by PlayerViewOffset
	if (bInstantHit)
		Start = Owner.Location + Pawn(Owner).BaseEyeHeight * vect(0,0,1);// - Vector(Pawn(Owner).ViewRotation)*(0.9*Pawn(Owner).CollisionRadius);
	else
		Start = Owner.Location + CalcDrawOffset() + FireOffset.X * X + FireOffset.Y * Y + FireOffset.Z * Z;

	return Start;
}

simulated function Vector ComputeAltProjectileStart(Vector X, Vector Y, Vector Z)
{
	local Vector Start;
	
	if ( bAltInstantHit )
		Start = Owner.Location + Pawn(Owner).BaseEyeHeight * vect(0,0,1);// - Vector(Pawn(Owner).ViewRotation)*(0.9*Pawn(Owner).CollisionRadius);
	else
		Start = Owner.Location + CalcDrawOffset() + FireOffset.X * X + FireOffset.Y * Y + FireOffset.Z * Z;

	return Start;
}

//
// Modified to work better with scripted pawns
//
simulated function vector CalcDrawOffset()
{
	local vector		DrawOffset, WeaponBob;
	local ScriptedPawn	SPOwner;
	local Pawn			PawnOwner;

	SPOwner = ScriptedPawn(Owner);
	if (SPOwner != None)
	{
		DrawOffset = ((0.9/SPOwner.FOVAngle * PlayerViewOffset) >> SPOwner.ViewRotation);
		DrawOffset += (SPOwner.BaseEyeHeight * vect(0,0,1));
	}
	else
	{
		// copied from Engine.Inventory to not be FOVAngle dependent
		PawnOwner = Pawn(Owner);
		DrawOffset = ((0.9/PawnOwner.Default.FOVAngle * PlayerViewOffset) >> PawnOwner.ViewRotation);

		DrawOffset += (PawnOwner.EyeHeight * vect(0,0,1));
		WeaponBob = BobDamping * PawnOwner.WalkBob;
		WeaponBob.Z = (0.45 + 0.55 * BobDamping) * PawnOwner.WalkBob.Z;
		DrawOffset += WeaponBob;
	}

	return DrawOffset;
}

function GetAIVolume(out float volume, out float radius)
{
	volume = 0;
	radius = 0;

	if (!bHasSilencer && !bHandToHand)
	{
		volume = NoiseLevel*Pawn(Owner).SoundDampening;
		radius = volume * 800.0;
	}
}


//
// copied from Weapon.uc
//
simulated function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Vector Start, X, Y, Z;
	local DeusExProjectile proj, proj2, proj3;
	local float mult;
	local float EMPDam;
	local float volume, radius;
	local int i, numProj, EMPlev;
	local Pawn aPawn;

	// AugCombat increases our speed (distance) if hand to hand
	mult = 1.0;
	if (bHandToHand && (DeusExPlayer(Owner) != None))
	{
		mult = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
		if (mult == -1.0)
			mult = 1.0;
		ProjSpeed *= mult;
	}

	// skill also affects our damage
	// GetWeaponSkill returns 0.0 to -0.7 (max skill/aug)
	mult += -2.0 * GetWeaponSkill();

	// make noise if we are not silenced
	if (!bHasSilencer && !bHandToHand)
	{
		GetAIVolume(volume, radius);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);
	}

	// should we shoot multiple projectiles in a spread?
	if (AreaOfEffect == AOE_Cone)
		numProj = 3;
	else if (AreaOfEffect == AOE_Sphere)
		numProj = 7;
	else
		numProj = 1;

	//== Play the sound here.
	if((!Self.IsA('WeaponAssaultGun') || bHasSilencer || Ammo20mm(AmmoType) != None) && !bHandtoHand && !Self.IsA('WeaponFlameThrower') && !Self.IsA('WeaponPepperGun'))
		PlayFiringSound();

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start = ComputeProjectileStart(X, Y, Z);

	for (i=0; i<numProj; i++)
	{
      // If we have multiple slugs, then lower our accuracy a bit after the first slug so the slugs DON'T all go to the same place
      if ((i > 0) && (Level.NetMode != NM_Standalone))
         if (currentAccuracy < MinProjSpreadAcc)
            currentAccuracy = MinProjSpreadAcc;
         
		AdjustedAim = pawn(owner).AdjustAim(ProjSpeed, Start, AimError, True, bWarn);
		AdjustedAim.Yaw += currentAccuracy * (Rand(1024) - 512);
		AdjustedAim.Pitch += currentAccuracy * (Rand(1024) - 512);


		if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
		{
			proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
			if (proj != None)
			{
				// Change the projectile damage if it is specified in the weapon
				if(ProjectileDamage > 0)
					proj.Damage = ProjectileDamage;

				// AugCombat increases our damage as well -- Now AugMuscle
				proj.Damage *= mult;

				// send the targetting information to the projectile
				if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
				{
					proj.Target = LockTarget;
					proj.bTracking = True;
				}

			}
		}
		else
		{
			if (( Role == ROLE_Authority ) || (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
			{
				// Do it the old fashioned way if it can track, or if we are a projectile that we could pick up again
				if ( bCanTrack || Self.IsA('WeaponShuriken') || Self.IsA('WeaponMiniCrossbow') || Self.IsA('WeaponGrenade'))
				{
					if ( Role == ROLE_Authority )
					{
						proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
						if (proj != None)
						{
							// Change the projectile damage if it is specified in the weapon
							if(ProjectileDamage > 0)
								proj.Damage = ProjectileDamage;
							// AugCombat increases our damage as well
								proj.Damage *= mult;
							// send the targetting information to the projectile
							if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
							{
								proj.Target = LockTarget;
								proj.bTracking = True;
							}
						}
					}
				}
				else
				{
					proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
					if (proj != None)
					{
						proj.RemoteRole = ROLE_None;
						// Change the projectile damage if it is specified in the weapon
						if(ProjectileDamage > 0)
							proj.Damage = ProjectileDamage;
						// AugCombat increases our damage as well
						if ( Role == ROLE_Authority )
							proj.Damage *= mult;
						else
							proj.Damage = 0;
					}
					if ( Role == ROLE_Authority )
					{
						for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
						{
							if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(aPawn) != DeusExPlayer(Owner) ))
								DeusExPlayer(aPawn).ClientSpawnProjectile( ProjClass, Owner, Start, AdjustedAim );
						}
					}
				}
			}
		}

	}
	return proj;
}

simulated function Projectile ProjectileAltFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Vector Start, X, Y, Z;
	local DeusExProjectile proj, proj2, proj3;
	local float mult;
	local float EMPDam;
	local float volume, radius;
	local int i, numProj, EMPlev;
	local Pawn aPawn;

	// AugCombat increases our speed (distance) if hand to hand
	mult = 1.0;
	if (bHandToHand && (DeusExPlayer(Owner) != None))
	{
		mult = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
		if (mult == -1.0)
			mult = 1.0;
		ProjSpeed *= mult;
	}

	// skill also affects our damage
	// GetWeaponSkill returns 0.0 to -0.7 (max skill/aug)
	mult += -2.0 * GetWeaponSkill();

	// make noise if we are not silenced
	if (!bHasSilencer && !bHandToHand)
	{
		GetAIVolume(volume, radius);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);
	}

	// should we shoot multiple projectiles in a spread?
	if (AltAreaOfEffect == AOE_Cone)
		numProj = 3;
	else if (AltAreaOfEffect == AOE_Sphere)
		numProj = 7;
	else
		numProj = 1;

	//== Play the sound here.
	if((!Self.IsA('WeaponAssaultGun') || bHasSilencer || Ammo20mm(AmmoType) != None) && !bHandtoHand)
		PlayFiringAltSound();

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start = ComputeAltProjectileStart(X, Y, Z);

	for (i=0; i<numProj; i++)
	{
      // If we have multiple slugs, then lower our accuracy a bit after the first slug so the slugs DON'T all go to the same place
      if ((i > 0)) // && (Level.NetMode != NM_Standalone))
         if (currentAccuracy < MinAltProjSpreadAcc)
            currentAccuracy = MinAltProjSpreadAcc;
         
		AdjustedAim = pawn(owner).AdjustAim(ProjSpeed, Start, AimError, True, bWarn);
		AdjustedAim.Yaw += currentAccuracy * (Rand(1024) - 512);
		AdjustedAim.Pitch += currentAccuracy * (Rand(1024) - 512);


		if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
		{
			proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
			if (proj != None)
			{
				// Change the projectile damage if it is specified in the weapon
				if(AltProjectileDamage > 0)
					proj.Damage = AltProjectileDamage;

				// AugCombat increases our damage as well -- Now AugMuscle
				proj.Damage *= mult;

				// send the targetting information to the projectile
				if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
				{
					proj.Target = LockTarget;
					proj.bTracking = True;
				}

			}
		}
		else
		{
			if (( Role == ROLE_Authority ) || (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
			{
				// Do it the old fashioned way if it can track, or if we are a projectile that we could pick up again
				if ( bCanTrack || Self.IsA('WeaponShuriken') || Self.IsA('WeaponMiniCrossbow') || Self.IsA('WeaponGrenade'))
				{
					if ( Role == ROLE_Authority )
					{
						proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
						if (proj != None)
						{
							// Change the projectile damage if it is specified in the weapon
							if(AltProjectileDamage > 0)
								proj.Damage = AltProjectileDamage;
							// AugCombat increases our damage as well
								proj.Damage *= mult;
							// send the targetting information to the projectile
							if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
							{
								proj.Target = LockTarget;
								proj.bTracking = True;
							}
						}
					}
				}
				else
				{
					proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
					if (proj != None)
					{
						proj.RemoteRole = ROLE_None;
						// Change the projectile damage if it is specified in the weapon
						if(AltProjectileDamage > 0)
							proj.Damage = AltProjectileDamage;
						// AugCombat increases our damage as well
						if ( Role == ROLE_Authority )
							proj.Damage *= mult;
						else
							proj.Damage = 0;
					}
					if ( Role == ROLE_Authority )
					{
						for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
						{
							if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(aPawn) != DeusExPlayer(Owner) ))
								DeusExPlayer(aPawn).ClientSpawnProjectile( ProjClass, Owner, Start, AdjustedAim );
						}
					}
				}
			}
		}

	}
	return proj;
}

//
// copied from Weapon.uc so we can add range information
//
simulated function TraceFire( float Accuracy )
{
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z;
	local Rotator rot;
	local actor Other;
	local float dist, alpha, degrade;
	local int i, numSlugs;
	local float volume, radius;
	local actor splash;
	local ParticleGenerator waterGen;
	local ZoneInfo TestZone;
	local string detLevel;

	// make noise if we are not silenced
	if (!bHasSilencer && !bHandToHand)
	{
		GetAIVolume(volume, radius);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);
	}

	if((!Self.IsA('WeaponAssaultGun') || bHasSilencer || Ammo20mm(AmmoType) != None) && !bHandtoHand)
		PlayFiringSound();

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace = ComputeProjectileStart(X, Y, Z);
	AdjustedAim = pawn(owner).AdjustAim(1000000, StartTrace, 2.75*AimError, False, False);

	// check to see if we are a shotgun-type weapon
	if (AreaOfEffect == AOE_Cone)
		numSlugs = 5;
	else if (AreaOfEffect == AOE_Sphere)
		numSlugs = 15;
	else
		numSlugs = 1;

	// if there is a scope, but the player isn't using it, decrease the accuracy
	// so there is an advantage to using the scope
	// BUT ONLY WHEN THEY DON'T HAVE A LASER SIGHT -- Y|yukichigai
	//if (bHasScope && !bZoomed && !bLasing)
	//	Accuracy += 0.2; //now handled in CalculateAccuracy
	// if the laser sight is on, make this shot dead on
	// also, if the scope is on, zero the accuracy so the shake makes the shot inaccurate
	//else 
	if (bLasing || bZoomed)
		Accuracy = 0.0;

	if(DeusExPlayer(GetPlayerPawn()) != None)
		detLevel = DeusExPlayer(GetPlayerPawn()).ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetail");

	for (i=0; i<numSlugs; i++)
	{
	      // If we have multiple slugs, then lower our accuracy a bit after the first slug so the slugs DON'T all go to the same place
	      if ((i > 0) && (Level.NetMode != NM_Standalone) && !(bHandToHand))
	         if (Accuracy < MinSpreadAcc)
	            Accuracy = MinSpreadAcc;
	
	      // Let handtohand weapons have a better swing
	      if ((bHandToHand) && (NumSlugs > 1) && (Level.NetMode != NM_Standalone))
	      {
	         StartTrace = ComputeProjectileStart(X,Y,Z);
	         StartTrace = StartTrace + (numSlugs/2 - i) * SwingOffset;
	      }
	
	      if(bLasing && Emitter != None)
		EndTrace = StartTrace + ( FMax(1024.0, MaxRange) * vector(Emitter.Rotation) );
	      else if(Owner.IsA('PlayerPawn') && !bHandToHand)
	      {
		//== Use a new, consistent method for calculating aim offsets.  Works just like the laser sight
		rot = AdjustedAim;
		if(Accuracy != 0.0)
		{
			rot.Yaw += Accuracy * (Rand(3072) - 1536);
			rot.Pitch += Accuracy * (Rand(3072) - 1536);
		}
		EndTrace = StartTrace + ( FMax(1024.0, MaxRange) * vector(rot) );
	      }
	      else
	      {

		//== This is the old method.  It works in theory, but the spread is different than what the reticle shows.
		//==  We need to use it for hand to hand weapons and NPC weapons (otherwise NPCs suck)
		EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;
		EndTrace += (FMax(1024.0, MaxRange) * vector(AdjustedAim));
	      }
	      
	      Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);


		rot = Rotator(EndTrace - StartTrace);

		// randomly draw a tracer for relevant ammo types
		// don't draw tracers if we're zoomed in with a scope - looks stupid
      		// DEUS_EX AMSD In multiplayer, draw tracers all the time.
		if ( ((Level.NetMode == NM_Standalone) && (!bZoomed && (numSlugs == 1) && (FRand() < 0.5))) ||
           ((Level.NetMode != NM_Standalone) && (Role == ROLE_Authority) && (numSlugs == 1)) )
		{
			if ((AmmoName == Class'Ammo10mm') || (AmmoName == Class'Ammo3006') ||
				(AmmoName == Class'Ammo762mm'))
			{
				if (VSize(HitLocation - StartTrace) > 250)
				{
//               				if ((Level.NetMode != NM_Standalone) && (Self.IsA('WeaponRifle')))
               				Spawn(class'SniperTracer',,, StartTrace + 96 * Vector(rot), rot);
//               				else
//                  				Spawn(class'Tracer',,, StartTrace + 96 * Vector(rot), rot);
				}
			}
		}

		if(detLevel != "Low" && !bHandToHand)
			splash = Spawn(class'LaserSpot',,, HitLocation, rot);

		//== Draw a pretty pretty splash effect
		if(splash != None)
		{
			TestZone = splash.Region.Zone;
			splash.Destroy();

			if(TestZone.bWaterZone != Region.Zone.bWaterZone && i < 6)
			{
				if(TestZone.bWaterZone)
				{
					if(!WaterZone(TestZone).bSurfaceLevelKnown && i < 1)
					{
						Spawn(class'Tracer',,, StartTrace, rot);
					}
					else if(WaterZone(TestZone).bSurfaceLevelKnown && TestZone.EntryActor != None)
					{
						EndTrace.Z = WaterZone(TestZone).SurfaceLevel;
						EndTrace.X = StartTrace.X + (Vector(rot).X * Abs( (EndTrace.Z - StartTrace.Z)/Vector(rot).Z ) );
						EndTrace.Y = StartTrace.Y + (Vector(rot).Y * Abs( (EndTrace.Z - StartTrace.Z)/Vector(rot).Z ) );
	
						splash = Spawn(TestZone.EntryActor,,, EndTrace); 
						if ( splash != None )
						{
							splash.DrawScale = 0.00001;
							splash.LifeSpan = 0.60;
							if(WaterRing(splash) != None)
								WaterRing(splash).bNoExtraRings = True;

							if(detLevel == "High")
							{
								waterGen = Spawn(class'ParticleGenerator', splash,, splash.Location, rot(16384,0,0));
								if (waterGen != None)
								{
									waterGen.bHighDetail = True; //Only render on high detail level
									waterGen.particleDrawScale = 0.2;
									waterGen.checkTime = 0.05;
									waterGen.frequency = 1.0;
									waterGen.bGravity = True;
									waterGen.bScale = False;
									waterGen.bFade = True;
									waterGen.ejectSpeed = 75.0;
									waterGen.particleLifeSpan = 0.60;
									waterGen.numPerSpawn = 15;
									waterGen.bRandomEject = True;
									waterGen.particleTexture = Texture'Effects.Generated.WtrDrpSmall';
									waterGen.bTriggered = True;
									waterGen.bInitiallyOn = True;
									waterGen.LifeSpan = 1.1;
									waterGen.SetBase(splash);
								}
							}
						}
					}
	
				}
	
				else if(Region.Zone.bWaterZone)
				{
					if(!WaterZone(Region.Zone).bSurfaceLevelKnown && i < 1)
					{
						Spawn(class'Tracer',,, StartTrace, rot);
					}
					else if(WaterZone(Region.Zone).bSurfaceLevelKnown && Region.Zone.ExitActor != None)
					{
						EndTrace.Z = WaterZone(Region.Zone).SurfaceLevel;
						EndTrace.X = StartTrace.X + (Vector(rot).X * Abs( (EndTrace.Z - StartTrace.Z)/Vector(rot).Z ) );
						EndTrace.Y = StartTrace.Y + (Vector(rot).Y * Abs( (EndTrace.Z - StartTrace.Z)/Vector(rot).Z ) );
	
						splash = Spawn(Region.Zone.ExitActor,,, EndTrace); 
						if ( splash != None )
						{
							splash.DrawScale = 0.00001;
							splash.LifeSpan = 0.60;
							if(WaterRing(splash) != None)
								WaterRing(splash).bNoExtraRings = True;

							if(detLevel == "High")
							{
								waterGen = Spawn(class'ParticleGenerator', splash,, splash.Location, rot(16384,0,0));
								if (waterGen != None)
								{
									waterGen.particleDrawScale = 0.2;
									waterGen.checkTime = 0.05;
									waterGen.frequency = 1.0;
									waterGen.bGravity = True;
									waterGen.bScale = False;
									waterGen.bFade = True;
									waterGen.ejectSpeed = 75.0;
									waterGen.particleLifeSpan = 0.60;
									waterGen.numPerSpawn = 15;
									waterGen.bRandomEject = True;
									waterGen.particleTexture = Texture'Effects.Generated.WtrDrpSmall';
									waterGen.bTriggered = True;
									waterGen.bInitiallyOn = True;
									waterGen.LifeSpan = 1.1;
									waterGen.SetBase(splash);
								}
							}
						}	
					}
				}
			}
		}

		// check our range
		dist = Abs(VSize(HitLocation - Owner.Location));

		if ((dist <= AccurateRange && AmmoName != Class'Ammo10mmEX') || dist <= AccurateRange*2/3)		// we hit just fine
			ProcessTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		else if ((dist <= MaxRange && AmmoName != Class'Ammo10mmEX') || dist <= MaxRange*2/3)
		{
			// simulate gravity by lowering the bullet's hit point
			// based on the owner's distance from the ground
			alpha = (dist - AccurateRange) / (MaxRange - AccurateRange);
			degrade = 0.5 * Square(alpha);
			HitLocation.Z += degrade * (Owner.Location.Z - Owner.CollisionHeight);
			ProcessTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		}
	}

	//== Make the laser sight jump a little so it moves from a different location
	if(bLasing && !bZoomed)
	{
		LaserYaw = currentAccuracy * (Rand(3072) - 1536);
		LaserPitch = currentAccuracy * (Rand(3072) - 1536);
	}

	//== Reset the shake timer so the laser/scope moves to a different location after the shot
	shakeTimer = 0.35;

	// otherwise we don't hit the target at all
}

simulated function TraceAltFire( float Accuracy )
{
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z;
	local Rotator rot;
	local actor Other;
	local float dist, alpha, degrade;
	local int i, numSlugs;
	local float volume, radius;

	// make noise if we are not silenced
	if (!bHasSilencer && !bHandToHand)
	{
		GetAIVolume(volume, radius);
            		Owner.MakeNoise(Pawn(Owner).SoundDampening);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);
	}

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace = ComputeProjectileStart(X, Y, Z);
	AdjustedAim = pawn(owner).AdjustAim(1000000, StartTrace, 2*AimError, False, False);

	// check to see if we are a shotgun-type weapon
	if (AltAreaOfEffect == AOE_Sphere)
		numSlugs = 15;
      	else if (AltAreaOfEffect == AOE_Cone)
		numSlugs = 5;
	else
		numSlugs = 1;

	// if there is a scope, but the player isn't using it, decrease the accuracy
	// so there is an advantage to using the scope
	// BUT ONLY WHEN THERE ISN'T A LASER SIGHT
	//if (bHasScope && !bZoomed && !bLasing)
	//	Accuracy += 0.2; // handled in CalculateAccuracy
	// if the laser sight is on, make this shot dead on
	// also, if the scope is on, zero the accuracy so the shake makes the shot inaccurate
	//else
	if ((bLasing || bZoomed)) // && (AltAccuracy == 0.0))
		Accuracy = 0.0;

	for (i=0; i<numSlugs; i++)
	{
      		// If we have multiple slugs, then lower our accuracy a bit after the first slug so the slugs DON'T all go to the same place
      		if ((i > 0) && !(bHandToHand))
         			if (Accuracy < MinAltSpreadAcc)
            				Accuracy = MinAltSpreadAcc;

      		// Let handtohand weapons have a better swing
      		if ((bHandToHand) && (NumSlugs > 1) && (Level.Game.bDeathMatch || (Level.NetMode != NM_Standalone)))
      		{
         			StartTrace = ComputeProjectileStart(X,Y,Z);
         			StartTrace = StartTrace + (numSlugs/2 - i) * SwingOffset;
      		}

		if(bLasing && Emitter != None)
			EndTrace = StartTrace + ( FMax(1024.0, MaxRange) * vector(Emitter.Rotation) );
		else
		{
			//== Use a new, consistent method for calculating aim offsets
			rot = AdjustedAim;
			rot.Yaw += currentAccuracy * (Rand(4096) - 2048);
			rot.Pitch += currentAccuracy * (Rand(4096) - 2048);
			EndTrace = StartTrace + ( FMax(1024.0, MaxRange) * vector(rot) );

			//== This is the old method.  It works in theory, but the spread is different than what the reticle shows
//			EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;
//			EndTrace += (FMax(1024.0, MaxRange) * vector(AdjustedAim));
		}
      
      		Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
		
		if ((!bZoomed) && (Role == ROLE_Authority) && (numSlugs == 1)) 
		{
			if ( (AmmoName == Class'Ammo10mm') || (AmmoName == Class'Ammo762mm') )
			{
				if (VSize(HitLocation - StartTrace) > 200)
				{
					rot = Rotator(EndTrace - StartTrace);
                              				if (!Self.IsA('WeaponStealthPistol'))
                                   				Spawn(class'SniperTracer',,, Owner.Location + CalcDrawOffset() + (FireOffset.X)* X + (FireOffset.Y ) * Y + (FireOffset.Z) * Z * Vector(rot), rot);
				}
			}
		}

		// check our range
		dist = Abs(VSize(HitLocation - Owner.Location));

		if (dist <= AccurateRange)		// we hit just fine
			ProcessAltTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		else if (dist <= MaxRange)
		{
			// simulate gravity by lowering the bullet's hit point
			// based on the owner's distance from the ground
			alpha = (dist - AccurateRange) / (MaxRange - AccurateRange);
			degrade = 0.5 * Square(alpha);
			HitLocation.Z += degrade * (Owner.Location.Z - Owner.CollisionHeight);
			ProcessAltTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		}
	}
	// otherwise we don't hit the target at all
}

simulated function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local int	   EMPlev;
	local float	   EMPDam;
	local DeusExPlayer dxPlayer;
	local LaserTrigger lastrig; //For electrostatic discharge
	local Spark        thespark; //For determining radius from the hit loc, plus a pretty effect

	//== If we're using 10mm explosive rounds (or if we're in unrealistic mode and we're an NPC) spawn a bullet explosion instead
	if( (AmmoName == Class'Ammo10mmEX' || (DeusExPlayer(Owner) == None && DeusExPlayer(GetPlayerPawn()).combatDifficulty > 4.0 && Abs(VSize(HitLocation - Owner.Location)) > FMin(HitDamage * 1.78, 25 * 1.78) ) ) && Other != None)
		ProcessTraceHitExplosive(Other, HitLocation, HitNormal, X, Y, Z);
	else if (Other != None)
	{
		// AugCombat increases our damage if hand to hand
		mult = 1.0;
		EMPDam = -1.0;
		EMPlev = 0;
		if (bHandToHand && (DeusExPlayer(Owner) != None))
		{
			mult = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
			if (mult == -1.0)
				mult = 1.0;

			EMPDam = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugCombat');
			EMPlev = DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugCombat');
		}

		// skill also affects our damage
		// GetWeaponSkill returns 0.0 to -0.7 (max skill/aug)
		mult += -2.0 * GetWeaponSkill();

		// Determine damage type
		damageType = WeaponDamageType();

		if (Other != None)
		{
			if (Other.bOwned)
			{
				dxPlayer = DeusExPlayer(Owner);
				if (dxPlayer != None)
					dxPlayer.AISendEvent('Futz', EAITYPE_Visual);
			}
		}
		if ((Other == Level) || (Other.IsA('Mover')))
		{
			if ( Role == ROLE_Authority )
			{
				if(!Other.IsA('SecurityCamera') || Level.NetMode == NM_Standalone || EMPDam <= 0.0)
					Other.TakeDamage(HitDamage * mult, Pawn(Owner), HitLocation, 1000.0*X, damageType);
			}

			//=== Electrostatic Discharge
			if (EMPDam > 0.0)
			{
				Other.TakeDamage(HitDamage * mult * EMPDam, Pawn(Owner), HitLocation, 1000.0*X, 'EMP');
				//=== Scramble damage is only done under certain conditions
				if((Pawn(Other).Default.Health <= (EMPlev * 100) + 50 || Pawn(Other).Default.Health <= HitDamage * mult * EMPDam * 5 || EMPlev >= 3) && Level.NetMode == NM_Standalone)
					Other.TakeDamage(HitDamage * mult * EMPDam * 5, Pawn(Owner), HitLocation, 1000.0*X, 'NanoVirus');

				thespark = Spawn(class'Spark',Owner,, HitLocation);
				foreach thespark.RadiusActors(class'LaserTrigger', lastrig, 1.25)
					lastrig.TakeDamage(HitDamage * mult * EMPDam, Pawn(Owner), HitLocation, 1000.0*X, 'EMP');
			}

			SelectiveSpawnEffects( HitLocation, HitNormal, Other, HitDamage * mult);

			if(damageType == 'Flamed')
			{
				theSpark = spawn(class'Spark',,, HitLocation);
				if(theSpark != None)
				{
					theSpark.drawScale *= 0.90 + FRand();
					theSpark.Skin = FireTexture'Effects.Fire.Fireball1';

					//== Underwater hits create air bubbles
					if(theSpark.Region.Zone.bWaterZone)
						spawn(class'AirBubble',,, theSpark.Location);
				}
			}
		}
		else if ((Other != self) && (Other != Owner))
		{
			if(Other.IsA('ScriptedPawn'))
			{
				//== Lethal weapons kill on the last shot
				if(bLethal)
				{
					ScriptedPawn(Other).bUnStunnable = true;
				}
				if(bHandtoHand)
				{
					ScriptedPawn(Other).bTookHandtoHand = true;
				}
			}
			if ( Role == ROLE_Authority )
			{
				//=== This prevents the "Cameras can only be damaged by EMP" messages in DXMP when the Electrostatic Discharge aug is on
				if(!Other.IsA('SecurityCamera') || Level.NetMode == NM_Standalone || EMPDam <= 0.0)
					Other.TakeDamage(HitDamage * mult, Pawn(Owner), HitLocation, 1000.0*X, damageType);
			}
			if (bHandToHand)
				SelectiveSpawnEffects( HitLocation, HitNormal, Other, HitDamage * mult);


			//=== Electrostatic Discharge
			if (EMPDam > 0.0)
			{
				Other.TakeDamage(HitDamage * mult * EMPDam, Pawn(Owner), HitLocation, 1000.0*X, 'EMP');
				//=== Scramble damage is only done under certain conditions
				if((Pawn(Other).Default.Health <= (EMPlev * 100) + 50 || Pawn(Other).Default.Health <= HitDamage * mult * EMPDam * 5 || EMPlev >= 3) && Level.NetMode == NM_Standalone)
					Other.TakeDamage(HitDamage * mult * EMPDam * 5, Pawn(Owner), HitLocation, 1000.0*X, 'NanoVirus');

				Spawn(class'Spark',Owner,, HitLocation);
			}

			if (bPenetrating && Other.IsA('Pawn') && !Other.IsA('Robot'))
				SpawnBlood(HitLocation, HitNormal);

			if(damageType == 'Flamed')
			{
				theSpark = spawn(class'Spark',,, HitLocation);
				if(theSpark != None)
				{
					theSpark.drawScale *= 0.90 + FRand();
					theSpark.Skin = FireTexture'Effects.Fire.Fireball1';

					//== Underwater hits create air bubbles
					if(theSpark.Region.Zone.bWaterZone)
						spawn(class'AirBubble',,, theSpark.Location);
				}
			}

			//=== This amazingly simple line of code makes it so weapons can do non-stunned damage and still
			//===  stun NPCs.  Later this will put the player into a "stunned" state.
			if (StunDuration > 0 && Other.IsA('Pawn') && !Other.IsA('Robot') && !Other.IsA('PlayerPawn') && Other.GetStateName() != 'Dying')
				Other.GoToState('Stunned');

			if(Other.IsA('ScriptedPawn'))
			{
				ScriptedPawn(Other).bUnStunnable = false;
				ScriptedPawn(Other).bTookHandtoHand = false;
			}
		}
	}
   if (DeusExMPGame(Level.Game) != None)
   {
      if (DeusExPlayer(Other) != None)
         DeusExMPGame(Level.Game).TrackWeapon(self,HitDamage * mult);
      else
         DeusExMPGame(Level.Game).TrackWeapon(self,0);
   }
}

//== Default is to just call ProcessTraceHit.  This can be overridden for individual weapons if necessary
simulated function ProcessAltTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	ProcessTraceHit(Other, HitLocation, HitNormal, X, Y, Z);
}

//=== Explosive bullet simulation
simulated function ProcessTraceHitExplosive(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local SphereEffect sphere;
	local ExplosionLight light;
	local FireComet comet;
	local int i;
	local vector HitLoc;
	local bool bWasInvincible;

	if (Other != None)
	{
		//== We used to offset the location, but that's unnecessary now
		HitLoc = HitLocation; //+ (HitNormal * 0.03);

		// AugCombat increases our damage if hand to hand
		mult = 1.0;

		// skill also affects our damage
		// GetWeaponSkill returns 0.0 to -0.7 (max skill/aug)
		mult += -2.0 * GetWeaponSkill();

		if (Other != None)
		{
			damageType = 'Exploded';
//			if (Other.bOwned)
//			{
				dxPlayer = DeusExPlayer(Owner);
				if (dxPlayer != None)
					dxPlayer.AISendEvent('Futz', EAITYPE_Visual);
//			}
			//Spawn(class'ExplosionSmall',,, HitLoc);
			for(i = 0; i < 5; i++)
			{
				comet = Spawn(class'FireComet',,, HitLoc);
				if(comet != None)
				{
					comet.Velocity.X /= 2;
					comet.Velocity.Y /= 2;
					comet.Velocity.Z /= 2;
				}
			}

			sphere = Spawn(class'SphereEffect',,, HitLoc);
			if (sphere != None)
				sphere.size = FMin(HitDamage * mult * 1.75, 25 * mult * 1.75) / 32.0;

			light = Spawn(class'ExplosionLight',,, HitLoc);
			if(light != None)
				light.size = FMin(HitDamage * mult * 1.75, 25 * mult * 1.75) / 32.0;

			//== Make sure the NPC/player we hit takes damage
			if(Pawn(Other) != None)
			{
				for(i = 0; i < 5; i++)
				{
					if(Pawn(Owner) != None)
						Other.TakeDamage(HitDamage * mult, Pawn(Owner), HitLocation, 3000.0*X, damageType);
					//== Only do one direct explosive hit on the player (since the only time that will happen
					//==  is in Unrealistic) or 3 on Robots
					if((DeusExPlayer(Other) != None && !AmmoType.IsA('Ammo10mmEX')) || (i >= 2 && Robot(Other) != None) )
						break;
				}

				if(ScriptedPawn(Other) != None)
				{
					bWasInvincible = ScriptedPawn(Other).bInvincible;
					ScriptedPawn(Other).bInvincible = True;
				}
			}

			HurtRadius(HitDamage * mult * 5.0, FMin(HitDamage * mult * 1.75, 25 * mult * 1.75), damageType, HitDamage*mult*1000.0, HitLoc);

			if(ScriptedPawn(Other) != None && !bWasInvincible)
				ScriptedPawn(Other).bInvincible = False;
		}
	}
}

simulated function IdleFunction()
{
	PlayIdleAnim();
	bInProcess = False;
	if ( bFlameOn )
	{
		StopFlame();
		bFlameOn = False;
	}
}

simulated function SimAltFinish();

simulated function SimFinish()
{
	ServerGotoFinishFire();

	bInProcess = False;
	bFiring = False;

	if ( bFlameOn )
	{
		StopFlame();
		bFlameOn = False;
	}

	if (bHasMuzzleFlash)
		EraseMuzzleFlashTexture();

	if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
	{
		if ( (SimClipCount >= ReloadCount) && CanReload() )
		{
			SimClipCount = 0;
			bClientReadyToFire = False;
			bInProcess = False;
			if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
				CycleAmmo();
			ReloadAmmo();
		}
	}

	if (Pawn(Owner) == None)
	{
		GotoState('SimIdle');
		return;
	}
	if ( PlayerPawn(Owner) == None )
	{
		if ( (Pawn(Owner).bFire != 0) && (FRand() < RefireRate) )
			ClientReFire(0);
		else
			GotoState('SimIdle');
		return;
	}
	if ( Pawn(Owner).bFire != 0 )
		ClientReFire(0);
	else
		GotoState('SimIdle');
}

// Finish a firing sequence (ripped off and modified from Engine\Weapon.uc)
function Finish()
{
	if ( Level.NetMode != NM_Standalone )
		ReadyClientToFire( True );
	
	if (bHasMuzzleFlash)
		EraseMuzzleFlashTexture();

	if ( bChangeWeapon )
	{
		GotoState('DownWeapon');
		return;
	}

	if (( Level.NetMode != NM_Standalone ) && IsInState('Active'))
	{
		GotoState('Idle');
		return;
	}

	if (Pawn(Owner) == None)
	{
		GotoState('Idle');
		return;
	}
	if ( PlayerPawn(Owner) == None )
	{
		//bFireMem = false;
		//bAltFireMem = false;
		if ( ((AmmoType==None) || (AmmoType.AmmoAmount<=0)) && ReloadCount!=0 )
		{
			Pawn(Owner).StopFiring();
			Pawn(Owner).SwitchToBestWeapon();
		}
		else if ( (Pawn(Owner).bFire != 0) && (FRand() < RefireRate) )
			Global.Fire(0);
		else if ( (Pawn(Owner).bAltFire != 0) && (FRand() < AltRefireRate) )
			Global.AltFire(0);	
		else 
		{
			Pawn(Owner).StopFiring();
			GotoState('Idle');
		}
		return;
	}

	if (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))
	{
		GotoState('Idle');
		return;
	}

	if ( ((AmmoType==None) || (AmmoType.AmmoAmount<=0)) || (Pawn(Owner).Weapon != self) )
		GotoState('Idle');
	else if ( /*bFireMem ||*/ Pawn(Owner).bFire!=0 )
		Global.Fire(0);
	else if ( /*bAltFireMem ||*/ Pawn(Owner).bAltFire!=0 )
		Global.AltFire(0);
	else 
		GotoState('Idle');
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInventoryInfoWindow winInfo;
	local string str;
	local int i, dmg;
	local float mod;
	local bool bHasAmmo;
	local bool bAmmoAvailable;
	local class<DeusExAmmo> ammoClass;
	local Pawn P;
	local Ammo weaponAmmo;
	local int  ammoAmount;

	P = Pawn(Owner);
	if (P == None)
		return False;

	winInfo = PersonaInventoryInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(msgInfoWeaponStats);
	winInfo.AddLine();

	// Create the ammo buttons.  Start with the AmmoNames[] array,
	// which is used for weapons that can use more than one 
	// type of ammo.

	if (AmmoNames[0] != None)
	{
		for (i=0; i<ArrayCount(AmmoNames); i++)
		{
			if (AmmoNames[i] != None) 
			{
				// Check to make sure the player has this ammo type
				// *and* that the ammo isn't empty
				weaponAmmo = Ammo(P.FindInventoryType(AmmoNames[i]));

				if (weaponAmmo != None)
				{
					ammoAmount = weaponAmmo.AmmoAmount;
					bHasAmmo = (weaponAmmo.AmmoAmount > 0);
				}
				else
				{
					ammoAmount = 0;
					bHasAmmo = False;
				}

				//== Only draw a new ammo button if we've ever picked up the ammo before
				if(weaponAmmo != None)
				{
					winInfo.AddAmmo(AmmoNames[i], bHasAmmo, ammoAmount);
					bAmmoAvailable = True;

					if (AmmoNames[i] == AmmoName)
					{
						winInfo.SetLoaded(AmmoName);
						ammoClass = class<DeusExAmmo>(AmmoName);
					}
				}
			}
		}
	}
	else
	{
		// Now peer at the AmmoName variable, but only if the AmmoNames[] 
		// array is empty
		if ((AmmoName != class'AmmoNone') && (!bHandToHand) && (ReloadCount != 0))
		{	
			weaponAmmo = Ammo(P.FindInventoryType(AmmoName));

			if (weaponAmmo != None)
			{
				ammoAmount = weaponAmmo.AmmoAmount;
				bHasAmmo = (weaponAmmo.AmmoAmount > 0);
			}
			else
			{
				ammoAmount = 0;
				bHasAmmo = False;
			}

			winInfo.AddAmmo(AmmoName, bHasAmmo, ammoAmount);
			winInfo.SetLoaded(AmmoName);
			ammoClass = class<DeusExAmmo>(AmmoName);
			bAmmoAvailable = True;
		}
	}

	// Only draw another line if we actually displayed ammo.
	if (bAmmoAvailable)
		winInfo.AddLine();	

	// Ammo loaded
	if ((AmmoName != class'AmmoNone') && (!bHandToHand) && (ReloadCount != 0))
		winInfo.AddAmmoLoadedItem(msgInfoAmmoLoaded, AmmoType.itemName);

	// ammo info
	if ((AmmoName == class'AmmoNone') || bHandToHand || (ReloadCount == 0))
		str = msgInfoNA;
	else
		str = AmmoName.Default.ItemName;
	for (i=0; i<ArrayCount(AmmoNames); i++)
		if ((AmmoNames[i] != None) && (AmmoNames[i] != AmmoName))
			if(Ammo(P.FindInventoryType(AmmoNames[i])) != None) //Only list ammo the player has picked up previously
				str = str $ "|n" $ AmmoNames[i].Default.ItemName;

	winInfo.AddAmmoTypesItem(msgInfoAmmo, str);

	if(Level.NetMode != NM_Standalone)
		dmg = Default.mpHitDamage;
	else
		dmg = HitDamage;

	//== For explosive, instant-hit weapons the damage is lowballed by default
	if(bInstantHit && WeaponDamageType() == 'Exploded')
		dmg *= 5;

	// base damage
	if (AreaOfEffect == AOE_Cone)
	{
		if (bInstantHit)
		{
			str = String(dmg) $" (x5)";
			dmg *= 5;
		}
		else
		{
			str = String(dmg) $" (x3)";
			dmg *= 3;
		}
	}
	else if(AreaOfEffect == AOE_Sphere)
	{
		if (bInstantHit)
		{
			str = String(dmg) $" (x15)";
			dmg *= 15;
		}
		else
		{
			str = String(dmg) $" (x7)";
			dmg *= 7;
		}
	}
	else
		str = String(dmg);

	//str = String(dmg);
	mod = 1.0 - GetWeaponSkill();
	if (mod != 1.0)
	{
		str = str @ BuildPercentString(mod - 1.0);
		str = str @ "=" @ FormatFloatString(dmg * mod, 1.0);
	}
	else if(str != String(dmg))
	{
		str = str $" = "$ String(dmg);
	}

	winInfo.AddInfoItem(msgInfoDamage, str, (mod != 1.0));

	// clip size
	if ((Default.ReloadCount == 0) || bHandToHand)
		str = msgInfoNA;
	else
	{
		if ( Level.NetMode != NM_Standalone )
			str = Default.mpReloadCount @ msgInfoRounds;
		else
			str = Default.ReloadCount @ msgInfoRounds;
	}

	if (HasClipMod())
	{
		str = str @ BuildPercentString(ModReloadCount);
		str = str @ "=" @ ReloadCount @ msgInfoRounds;
	}

	winInfo.AddInfoItem(msgInfoClip, str, HasClipMod());

	// rate of fire
	if ((Default.ReloadCount == 0) || bHandToHand)
	{
		str = msgInfoNA;
	}
	else
	{
		if (bAutomatic)
			str = msgInfoAuto;
		else
			str = msgInfoSingle;

		str = str $ "," @ FormatFloatString(1.0/Default.ShotTime, 0.1) @ msgInfoRoundsPerSec;

		if(HasROFMod())
		{
			str = str @ BuildPercentString(ModShotTime);
			str = str @ "=" @ FormatFloatString(1.0/ShotTime, 0.1) @ msgInfoRoundsPerSec;
		}
	}
	winInfo.AddInfoItem(msgInfoROF, str, HasROFMod());

	// reload time
	if ((Default.ReloadCount == 0) || bHandToHand)
		str = msgInfoNA;
	else
	{
		if (Level.NetMode != NM_Standalone )
			str = FormatFloatString(Default.mpReloadTime, 0.1) @ msgTimeUnit;
		else
			str = FormatFloatString(Default.ReloadTime, 0.1) @ msgTimeUnit;
	}

	if (HasReloadMod() || (GetWeaponSkill() < 0.0 && str != msgInfoNA))
	{
		str = str @ BuildPercentString(ModReloadTime + (GetWeaponSkill() * ReloadTime/Default.ReloadTime));
		str = str @ "=" @ FormatFloatString(ReloadTime * (1.0 + GetWeaponSkill()), 0.1) @ msgTimeUnit;
	}

	winInfo.AddInfoItem(msgInfoReload, str, (HasReloadMod() || (GetWeaponSkill() < 0.0 && (Default.ReloadCount > 0 && !bHandToHand))));

	// recoil
	str = FormatFloatString(Default.recoilStrength, 0.01);
	if (HasRecoilMod() || (GetWeaponSkill() < 0.0 && Default.recoilStrength > 0.0))
	{
		str = str @ BuildPercentString(ModRecoilStrength + (GetWeaponSkill() * 2.0 * recoilStrength/Default.recoilStrength));
		str = str @ "=" @ FormatFloatString(recoilStrength * (1.0 + (GetWeaponSkill() * 2.0)), 0.01);
	}

	winInfo.AddInfoItem(msgInfoRecoil, str, (HasRecoilMod() || (GetWeaponSkill() < 0.0 && Default.recoilStrength > 0.0)));

	// base accuracy (2.0 = 0%, 0.0 = 100%)
	if ( Level.NetMode != NM_Standalone )
	{
		str = Int((2.0 - Default.mpBaseAccuracy)*50.0) $ "%";
		mod = (Default.mpBaseAccuracy - (BaseAccuracy + GetWeaponSkill())) * 0.5;
		if (mod != 0.0)
		{
			str = str @ BuildPercentString(mod);
			str = str @ "=" @ Min(100, Int(100.0*mod+(2.0 - Default.mpBaseAccuracy)*50.0)) $ "%";
		}
	}
	else
	{
		str = Int((2.0 - Default.BaseAccuracy)*50.0) $ "%";
		mod = (Default.BaseAccuracy - (BaseAccuracy + GetWeaponSkill())) * 0.5;
		if (mod != 0.0)
		{
			str = str @ BuildPercentString(mod);
			str = str @ "=" @ Min(100, Int(100.0*mod+(2.0 - Default.BaseAccuracy)*50.0)) $ "%";
		}
	}
	winInfo.AddInfoItem(msgInfoAccuracy, str, (mod != 0.0));

	// accurate range
	if (bHandToHand)
		str = msgInfoNA;
	else
	{
		if ( Level.NetMode != NM_Standalone )
			str = FormatFloatString(Default.mpAccurateRange/16.0, 1.0) @ msgRangeUnit;
		else
			str = FormatFloatString(Default.AccurateRange/16.0, 1.0) @ msgRangeUnit;
	}

	if (HasRangeMod())
	{
		str = str @ BuildPercentString(ModAccurateRange);
		str = str @ "=" @ FormatFloatString(AccurateRange/16.0, 1.0) @ msgRangeUnit;
	}
	winInfo.AddInfoItem(msgInfoAccRange, str, HasRangeMod());

	// max range
	if (bHandToHand)
		str = msgInfoNA;
	else
	{
		if ( Level.NetMode != NM_Standalone )
			str = FormatFloatString(Default.mpMaxRange/16.0, 1.0) @ msgRangeUnit;
		else
			str = FormatFloatString(Default.MaxRange/16.0, 1.0) @ msgRangeUnit;
	}
	winInfo.AddInfoItem(msgInfoMaxRange, str);

	// mass
	winInfo.AddInfoItem(msgInfoMass, FormatFloatString(Default.Mass, 1.0) @ msgMassUnit);

	// laser mod
	if (bCanHaveLaser)
	{
		if (bHasLaser)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	winInfo.AddInfoItem(msgInfoLaser, str, bCanHaveLaser && bHasLaser && (Default.bHasLaser != bHasLaser));

	// scope mod
	if (bCanHaveScope)
	{
		if (bHasScope)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	winInfo.AddInfoItem(msgInfoScope, str, bCanHaveScope && bHasScope && (Default.bHasScope != bHasScope));

	// silencer mod
	if (bCanHaveSilencer)
	{
		if (bHasSilencer)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	winInfo.AddInfoItem(msgInfoSilencer, str, bCanHaveSilencer && bHasSilencer && (Default.bHasSilencer != bHasSilencer));

	// Governing Skill
	winInfo.AddInfoItem(msgInfoSkill, GoverningSkill.default.SkillName);

	winInfo.AddLine();
	winInfo.SetText(Description);

	// If this weapon has ammo info, display it here
	if (ammoClass != None)
	{
		winInfo.AddLine();
		winInfo.AddAmmoDescription(ammoClass.Default.ItemName $ "|n" $ ammoClass.Default.description);
	}

	return True;
}

// ----------------------------------------------------------------------
// UpdateAmmoInfo()
// ----------------------------------------------------------------------

simulated function UpdateAmmoInfo(Object winObject, Class<DeusExAmmo> ammoClass)
{
	local PersonaInventoryInfoWindow winInfo;
	local string str;
	local int i;

	winInfo = PersonaInventoryInfoWindow(winObject);
	if (winInfo == None)
		return;

	// Ammo loaded
	if ((AmmoName != class'AmmoNone') && (!bHandToHand) && (ReloadCount != 0))
		winInfo.UpdateAmmoLoaded(AmmoType.itemName);

	// ammo info
	if ((AmmoName == class'AmmoNone') || bHandToHand || (ReloadCount == 0))
		str = msgInfoNA;
	else
		str = AmmoName.Default.ItemName;
	for (i=0; i<ArrayCount(AmmoNames); i++)
		if ((AmmoNames[i] != None) && (AmmoNames[i] != AmmoName))
			str = str $ "|n" $ AmmoNames[i].Default.ItemName;

	winInfo.UpdateAmmoTypes(str);

	// If this weapon has ammo info, display it here
	if (ammoClass != None)
		winInfo.UpdateAmmoDescription(ammoClass.Default.ItemName $ "|n" $ ammoClass.Default.description);
}

// ----------------------------------------------------------------------
// BuildPercentString()
// ----------------------------------------------------------------------

simulated final function String BuildPercentString(Float value)
{
	local string str;

	str = String(Int(Abs(value * 100.0)));
	if (value < 0.0)
		str = "-" $ str;
	else
		str = "+" $ str;

	return ("(" $ str $ "%)");
}

// ----------------------------------------------------------------------
// FormatFloatString()
// ----------------------------------------------------------------------

simulated function String FormatFloatString(float value, float precision)
{
	local string str;

	if (precision == 0.0)
		return "ERR";

	// build integer part
	str = String(Int(value));

	// build decimal part
	if (precision < 1.0)
	{
		value -= Int(value);
		str = str $ "." $ String(Int((0.5 * precision) + value * (1.0 / precision)));
	}

	return str;
}

// ----------------------------------------------------------------------
// CR()
// ----------------------------------------------------------------------

simulated function String CR()
{
	return Chr(13) $ Chr(10);
}

// ----------------------------------------------------------------------
// HasReloadMod()
// ----------------------------------------------------------------------

simulated function bool HasReloadMod()
{
	return (ModReloadTime != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxReloadMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxReloadMod()
{
	return (ModReloadTime == -0.5);
}

// ----------------------------------------------------------------------
// HasClipMod()
// ----------------------------------------------------------------------

simulated function bool HasClipMod()
{
	return (ModReloadCount != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxClipMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxClipMod()
{
	return (ModReloadCount == 0.5);
}

// ----------------------------------------------------------------------
// HasRangeMod()
// ----------------------------------------------------------------------

simulated function bool HasRangeMod()
{
	return (ModAccurateRange != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxRangeMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxRangeMod()
{
	return (ModAccurateRange == 0.5);
}

// ----------------------------------------------------------------------
// HasAccuracyMod()
// ----------------------------------------------------------------------

simulated function bool HasAccuracyMod()
{
	return (ModBaseAccuracy != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxAccuracyMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxAccuracyMod()
{
	return (ModBaseAccuracy == 0.5);
}

// ----------------------------------------------------------------------
// HasRecoilMod()
// ----------------------------------------------------------------------

simulated function bool HasRecoilMod()
{
	return (ModRecoilStrength != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxRecoilMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxRecoilMod()
{
	return (ModRecoilStrength == -0.5);
}

// ----------------------------------------------------------------------
// HasROFMod()
// ----------------------------------------------------------------------

simulated function bool HasROFMod()
{
	return (ModShotTime != 0.0);
}

// ----------------------------------------------------------------------
// HasMaxROFMod()
// ----------------------------------------------------------------------

simulated function bool HasMaxROFMod()
{
	return (ModShotTime == -0.5);
}

// ----------------------------------------------------------------------
// ClientDownWeapon()
// ----------------------------------------------------------------------

simulated function ClientDownWeapon()
{
	bWasInFiring = IsInState('ClientFiring') || IsInState('ClientAltFiring') || IsInState('SimFinishFire');
	bClientReadyToFire = False;
	GotoState('SimDownWeapon');
}

simulated function ClientActive()
{
	bWasInFiring = IsInState('ClientFiring') || IsInState('ClientAltFiring') || IsInState('SimFinishFire');
	bClientReadyToFire = False;
	GotoState('SimActive');
}

simulated function ClientReload()
{
	bWasInFiring = IsInState('ClientFiring') || IsInState('ClientAltFiring') || IsInState('SimFinishFire');
	bClientReadyToFire = False;
	GotoState('SimReload');
}

//
// weapon states
//

state NormalFire
{
	function AnimEnd()
	{
		if (bAutomatic)
		{
			if ((Pawn(Owner).bFire != 0) && (AmmoType.AmmoAmount > 0))
			{
				if (PlayerPawn(Owner) != None)
					Global.Fire(0);
				else 
					GotoState('FinishFire');
			}
			else 
				GotoState('FinishFire');
		}
		else
		{
			// if we are a thrown weapon and we run out of ammo, destroy the weapon
			if (bHandToHand && (ReloadCount > 0) && (AmmoType.AmmoAmount <= 0))
				Destroy();
		}
	}
	function float GetShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		else
		{
			// AugCombat decreases shot time
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}

Begin:
	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (!bAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}

		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;

				// should we autoreload?
				if (DeusExPlayer(Owner).bAutoReload)
				{
					// auto switch ammo if we're out of ammo and
					// we're not using the primary ammo
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					GotoState('Idle');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
				ReloadAmmo();
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();
			GotoState('Idle');
		}
	}
	if ( bAutomatic && (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient())))
		GotoState('Idle');

	Sleep(GetShotTime());
	if (bAutomatic)
	{
		GenerateBullet();	// In multiplayer bullets are generated by the client which will let the server know when
		Goto('Begin');
	}
	bFiring = False;
	FinishAnim();

	// if ReloadCount is 0 and we're not hand to hand, then this is a
	// single-use weapon so destroy it after firing once
	if ((ReloadCount == 0) && !bHandToHand)
	{
		if (DeusExPlayer(Owner) != None)
			DeusExPlayer(Owner).RemoveItemFromSlot(Self);   // remove it from the inventory grid
		Destroy();
	}
	ReadyToFire();
Done:
	bFiring = False;
	Finish();
}

state FinishFire
{
Begin:
	bFiring = False;
	if ( bDestroyOnFinish )
		Destroy();
	else
		Finish();
}

state Pickup
{
	function BeginState()
	{
		// alert NPCs that I'm putting away my gun
		AIEndEvent('WeaponDrawn', EAITYPE_Visual);

		Super.BeginState();
	}
}

state Reload
{
ignores Fire, AltFire;

	function float GetReloadTime()
	{
		local float val;

		val = ReloadTime;

		if (ScriptedPawn(Owner) != None)
		{
			val = ReloadTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		}
		else if (DeusExPlayer(Owner) != None)
		{
			// check for skill use if we are the player
			val = GetWeaponSkill();
			val = ReloadTime + (val*ReloadTime);
		}

		return val;
	}

	function NotifyOwner(bool bStart)
	{
		local DeusExPlayer player;
		local ScriptedPawn pawn;

		player = DeusExPlayer(Owner);
		pawn   = ScriptedPawn(Owner);

		if (player != None)
		{
			if (bStart)
				player.Reloading(self, GetReloadTime()+(1.0/AnimRate));
			else
			{
				player.DoneReloading(self);
			}
		}
		else if (pawn != None)
		{
			if (bStart)
				pawn.Reloading(self, GetReloadTime()+(1.0/AnimRate));
			else
				pawn.DoneReloading(self);
		}
	}

Begin:
	FinishAnim();

	// only reload if we have ammo left
	if (AmmoType.AmmoAmount > 0)
	{
		if (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))
		{
			ClientReload();
			Sleep(GetReloadTime());
			ReadyClientToFire( True );
		}
		else
		{
			bWasZoomed = False;
			if (bZoomed)
			{
				ScopeOff();
				bWasZoomed = True;
			}

			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024, 0.5);		// CockingSound is reloadbegin
			else
				Owner.PlaySound(CockingSound, SLOT_None,,, 1024);		// CockingSound is reloadbegin
			PlayAnim('ReloadBegin');
			NotifyOwner(True);
			FinishAnim();
			LoopAnim('Reload');
			Sleep(GetReloadTime());
			if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024, 0.5);		// AltFireSound is reloadend
			else
				Owner.PlaySound(AltFireSound, SLOT_None,,, 1024);		// AltFireSound is reloadend
			PlayAnim('ReloadEnd');
			FinishAnim();
			NotifyOwner(False);

			if (bWasZoomed)
				ScopeOn();

			ClipCount = 0;
		}
	}
	GotoState('Idle');
}

simulated state ClientFiring
{
	simulated function AnimEnd()
	{
		bInProcess = False;

		if (bAutomatic)
		{
			if ((Pawn(Owner).bFire != 0) && (AmmoType.AmmoAmount > 0))
			{
				if (PlayerPawn(Owner) != None)
					ClientReFire(0);
				else
					GotoState('SimFinishFire');
			}
			else 
				GotoState('SimFinishFire');
		}
	}
	simulated function float GetSimShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		else
		{
			// AugCombat decreases shot time
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}
Begin:
	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (!bAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}
		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;
				if (DeusExPlayer(Owner).bAutoReload)
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
					GotoState('SimQuickFinish');
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					IdleFunction();
					GotoState('SimQuickFinish');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();
			IdleFunction();
			GotoState('SimQuickFinish');
		}
	}
	Sleep(GetSimShotTime());
	if (bAutomatic)
	{
		SimGenerateBullet();
		Goto('Begin');
	}
	bFiring = False;
	FinishAnim();
	bInProcess = False;
Done:
	bInProcess = False;
	bFiring = False;
	SimFinish();
}

simulated state ClientAltFiring
{
	simulated function AnimEnd()
	{
		bInProcess = False;

		if (bAutomatic)
		{
			if ((Pawn(Owner).bAltFire != 0) && (AmmoType.AmmoAmount > 0))
			{
				if (PlayerPawn(Owner) != None)
					ClientAltReFire(0);
				else
					GotoState('SimFinishFire');
			}
			else 
				GotoState('SimFinishFire');
		}
	}
	simulated function float GetSimShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		else
		{
			// AugCombat decreases shot time
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}
Begin:
	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (!bAltAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}
		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;
				if (DeusExPlayer(Owner).bAutoReload)
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
					GotoState('SimQuickFinish');
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					IdleFunction();
					GotoState('SimQuickFinish');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();
			IdleFunction();
			GotoState('SimQuickFinish');
		}
	}
	Sleep(GetSimShotTime());
	if (bAltAutomatic)
	{
		SimAltGenerateBullet();
		Goto('Begin');
	}
	bFiring = False;
	FinishAnim();
	bInProcess = False;
Done:
	bInProcess = False;
	bFiring = False;
	SimFinish();
}

simulated state SimQuickFinish
{
Begin:
	if ( IsAnimating() && (AnimSequence == FireAnim[0] || AnimSequence == FireAnim[1]) )
		FinishAnim();

	if (bHasMuzzleFlash)
		EraseMuzzleFlashTexture();

	bInProcess = False;
	bFiring=False;
}

simulated state SimIdle
{
	function Timer()
	{
		PlayIdleAnim();
	}
Begin:
	bInProcess = False;
	bFiring = False;
	if (!bNearWall)
		PlayAnim('Idle1',,0.1);
	SetTimer(3.0, True);
}


simulated state SimFinishFire
{
Begin:
	FinishAnim();

	if ( PlayerPawn(Owner) != None )
		PlayerPawn(Owner).FinishAnim();

	if (bHasMuzzleFlash)
		EraseMuzzleFlashTexture();

	bInProcess = False;
	bFiring=False;
	SimFinish();
}

simulated state SimDownweapon
{
ignores Fire, AltFire, ClientFire, ClientReFire;

Begin:
	if ( bWasInFiring )
	{
		if (bHasMuzzleFlash)
			EraseMuzzleFlashTexture();
		FinishAnim();
	}
	bInProcess = False;
	bFiring=False;
	TweenDown();
	FinishAnim();
}

simulated state SimActive
{
Begin:
	if ( bWasInFiring )
	{
		if (bHasMuzzleFlash)
			EraseMuzzleFlashTexture();
		FinishAnim();
	}
	bInProcess = False;
	bFiring=False;
	PlayAnim('Select',1.0,0.0);
	FinishAnim();
	SimFinish();
}

simulated state SimReload
{
ignores Fire, AltFire, ClientFire, ClientReFire;

	simulated function float GetSimReloadTime()
	{
		local float val;

		val = ReloadTime;

		if (ScriptedPawn(Owner) != None)
		{
			val = ReloadTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		}
		else if (DeusExPlayer(Owner) != None)
		{
			// check for skill use if we are the player
			val = GetWeaponSkill();
			val = ReloadTime + (val*ReloadTime);
		}
		return val;
	}
Begin:
	if ( bWasInFiring )
	{
		if (bHasMuzzleFlash)
			EraseMuzzleFlashTexture();
		FinishAnim();
	}
	bInProcess = False;
	bFiring=False;

	bWasZoomed = False;
	if (bZoomed)
	{
		ScopeOff();
		bWasZoomed = True;
	}

	if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
		Owner.PlaySound(CockingSound, SLOT_None,,, 1024, 0.5);		// CockingSound is reloadbegin
	else
		Owner.PlaySound(CockingSound, SLOT_None,,, 1024);		// CockingSound is reloadbegin
	PlayAnim('ReloadBegin');
	FinishAnim();
	LoopAnim('Reload');
	Sleep(GetSimReloadTime());
	if(DeusExPlayer(GetPlayerPawn()).DrugEffectTimer < 0)
		Owner.PlaySound(AltFireSound, SLOT_None,,, 1024, 0.5);		// AltFireSound is reloadend
	else
		Owner.PlaySound(AltFireSound, SLOT_None,,, 1024);		// AltFireSound is reloadend
	ServerDoneReloading();
	PlayAnim('ReloadEnd');
	FinishAnim();

	if (bWasZoomed)
		ScopeOn();

	GotoState('SimIdle');
}


state Idle
{
	function bool PutDown()
	{
		// alert NPCs that I'm putting away my gun
		AIEndEvent('WeaponDrawn', EAITYPE_Visual);

		return Super.PutDown();
	}

	function AnimEnd()
	{
	}

	function Timer()
	{
		PlayIdleAnim();
	}

Begin:
	bFiring = False;
	ReadyToFire();

	if (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))
	{
	}
	else
	{
		if (!bNearWall)
			PlayAnim('Idle1',,0.1);
		SetTimer(3.0, True);
	}
}

state FlameThrowerOn
{
	function float GetShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		else
		{
			// AugCombat decreases shot time
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');//(class'AugCombat');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}
Begin:
	if ( (DeusExPlayer(Owner).Health > 0) && bFlameOn && (ClipCount < ReloadCount))
	{
		if (( flameShotCount == 0 ) && (Owner != None))
		{
			PlayerPawn(Owner).PlayFiring();
			PlaySelectiveFiring();
			PlayFiringSound();
			flameShotCount = 6;
		}
		else
			flameShotCount--;

		Sleep( GetShotTime() );
		GenerateBullet();
		goto('Begin');
	}
Done:
	bFlameOn = False;
	GotoState('FinishFire');
}

state Active
{
	function bool PutDown()
	{
		// alert NPCs that I'm putting away my gun
		AIEndEvent('WeaponDrawn', EAITYPE_Visual);
		return Super.PutDown();
	}

Begin:
	// Rely on client to fire if we are a multiplayer client

	if ( (Level.NetMode==NM_Standalone) || (Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
		bClientReady = True;
	if (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))
	{
		ClientActive();
		bClientReady = False;
	}

	if (!Owner.IsA('ScriptedPawn'))
		FinishAnim();
	if ( bChangeWeapon )
		GotoState('DownWeapon');

	bWeaponUp = True;
	PlayPostSelect();
	if (!Owner.IsA('ScriptedPawn'))
		FinishAnim();
	// reload the weapon if it's empty and autoreload is true
	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (Owner.IsA('ScriptedPawn') || ((DeusExPlayer(Owner) != None) && DeusExPlayer(Owner).bAutoReload))
			ReloadAmmo();
	}
	Finish();
}


state DownWeapon
{
ignores Fire, AltFire;

	function bool PutDown()
	{
		// alert NPCs that I'm putting away my gun
		AIEndEvent('WeaponDrawn', EAITYPE_Visual);
		return Super.PutDown();
	}

Begin:
   ScopeOff();
	LaserOff();

	if (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))
		ClientDownWeapon();

	TweenDown();
	FinishAnim();

	if ( Level.NetMode != NM_Standalone )
	{
		ClipCount = 0;	// Auto-reload in multiplayer (when putting away)
	}
	bOnlyOwnerSee = false;
	if (Pawn(Owner) != None)
		Pawn(Owner).ChangedWeapon();
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
//   return ((BeltSpot <= 3) && (BeltSpot >= 1));
   //=== Modified by Y|yukichigai to make Deus Ex MP not suck.
   return ((BeltSpot <= 6) && (BeltSpot >= 1));
}

// ----------------------------------------------------------------------
// TestCycleable()
// Determines whether or not the weapon is part of a "cycle" group.
// ----------------------------------------------------------------------
simulated function bool TestCycleable()
{
   return (bHandToHand && AmmoType == None);
}

defaultproperties
{
     fireRate=1.000000
     AltFireRate=1.000000
     bReadyToFire=True
     LowAmmoWaterMark=10
     FireAnim(0)=Shoot
     FireAnim(1)=Shoot
     AmmoUseModifier=1
     AltAmmoUseModifier=1
     NoiseLevel=1.000000
     ShotTime=0.500000
     reloadTime=1.000000
     HitDamage=10
     maxRange=9600
     AccurateRange=4800
     BaseAccuracy=0.500000
     ScopeFOV=10
     MaintainLockTimer=1.000000
     bPenetrating=True
     bHasMuzzleFlash=True
     bEmitWeaponDrawn=True
     bUseWhileCrouched=True
     bUseAsDrawnWeapon=True
     MinSpreadAcc=0.250000
     MinProjSpreadAcc=1.000000
     bNeedToSetMPPickupAmmo=True
     msgCannotBeReloaded="This weapon can't be reloaded"
     msgOutOf="Out of %s"
     msgNowHas="%s now has %s loaded"
     msgAlreadyHas="%s already has %s loaded"
     msgNowSetMode="%s is now set to %s"
     msgNone="NONE"
     msgLockInvalid="INVALID"
     msgLockRange="RANGE"
     msgLockAcquire="ACQUIRE"
     msgLockLocked="LOCKED"
     msgRangeUnit="FT"
     msgTimeUnit="SEC"
     msgMassUnit="LBS"
     msgNotWorking="This weapon doesn't work underwater"
     msgSwitchingTo="Switching to %s"
     msgInfoAmmoLoaded="Ammo loaded:"
     msgInfoAmmo="Ammo type(s):"
     msgInfoDamage="Base damage:"
     msgInfoClip="Clip size:"
     msgInfoROF="Rate of fire:"
     msgInfoReload="Reload time:"
     msgInfoRecoil="Recoil:"
     msgInfoAccuracy="Base Accuracy:"
     msgInfoAccRange="Acc. range:"
     msgInfoMaxRange="Max. range:"
     msgInfoMass="Mass:"
     msgInfoLaser="Laser sight:"
     msgInfoScope="Scope:"
     msgInfoSilencer="Silencer:"
     msgInfoNA="N/A"
     msgInfoYes="YES"
     msgInfoNo="NO"
     msgInfoAuto="AUTO"
     msgInfoSingle="SINGLE"
     msgInfoRounds="RDS"
     msgInfoRoundsPerSec="RDS/SEC"
     msgInfoSkill="Skill:"
     msgInfoWeaponStats="Weapon Stats:"
     ReloadCount=10
     shakevert=10.000000
     Misc1Sound=Sound'DeusExSounds.Generic.DryFire'
     AutoSwitchPriority=0
     bRotatingPickup=False
     PickupMessage="You found"
     ItemName="DEFAULT WEAPON NAME - REPORT THIS AS A BUG"
     LandSound=Sound'DeusExSounds.Generic.DropSmallWeapon'
     bNoSmooth=False
     Mass=10.000000
     Buoyancy=5.000000
     bUnique=False
}
