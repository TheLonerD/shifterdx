//=============================================================================
// Robot.
//=============================================================================
class Robot extends ScriptedPawn
	abstract;

var() int EMPHitPoints;
var ParticleGenerator sparkGen;
var float crazedTimer;
var Pawn CrazedInstigator;

var(Sounds) sound explosionSound;
var bool bSearchMsgPrinted;

function InitGenerator()
{
	local Vector loc;

	if ((sparkGen == None) || (sparkGen.bDeleteMe))
	{
		loc = Location;
		loc.z += CollisionHeight/2;
		sparkGen = Spawn(class'ParticleGenerator', Self,, loc, rot(16384,0,0));
		if (sparkGen != None)
			sparkGen.SetBase(Self);
	}
}

function DestroyGenerator()
{
	if (sparkGen != None)
	{
		sparkGen.DelayedDestroy();
		sparkGen = None;
	}
}

//
// Special tick for robots to show effects of EMP damage
//
function Tick(float deltaTime)
{
	local float pct, mod;

	Super.Tick(deltaTime);

   // DEUS_EX AMSD All the MP robots have massive numbers of EMP hitpoints, not equal to the default.  In multiplayer, at least, only do this if
   // they are DAMAGED.
	if ((Default.EMPHitPoints != EMPHitPoints) && (EMPHitPoints != 0) && ((Level.Netmode == NM_Standalone) || (EMPHitPoints < Default.EMPHitPoints)))
	{
		pct = (Default.EMPHitPoints - EMPHitPoints) / Default.EMPHitPoints;
		mod = pct * (1.0 - (2.0 * FRand()));
		DesiredSpeed = MaxDesiredSpeed + (mod * MaxDesiredSpeed * 0.5);
		SoundPitch = Default.SoundPitch + (mod * 8.0);
	}

	if (CrazedTimer > 0)
	{
		CrazedTimer -= deltaTime;
		if (CrazedTimer < 0)
			CrazedTimer = 0;
	}

	if (CrazedTimer > 0)
		bReverseAlliances = true;
	else
	{
		if(CrazedInstigator != None)
			CrazedInstigator = None;
		bReverseAlliances = false;
	}
}


function ImpartMomentum(Vector momentum, Pawn instigatedBy)
{
	// nil
}

function bool ShouldFlee()
{
	return (Health <= MinHealth);
}

function bool ShouldDropWeapon()
{
	return false;
}

//
// Called when the robot is destroyed
//
simulated event Destroyed()
{
	Super.Destroyed();

	DestroyGenerator();
}

function Carcass SpawnCarcass()
{
	Explode(Location);

	return None;
}

function bool IgnoreDamageType(Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Radiation'))
		return True;
	else if ((damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return True;
	else if (damageType == 'KnockedOut')
		return True;
	else
		return False;
}

function SetOrders(Name orderName, optional Name newOrderTag, optional bool bImmediate)
{
	if (EMPHitPoints > 0)  // ignore orders if disabled
		Super.SetOrders(orderName, newOrderTag, bImmediate);
}

// ----------------------------------------------------------------------
// TakeDamageBase()
// ----------------------------------------------------------------------

function TakeDamageBase(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType, bool bPlayAnim)
{
	local float actualDamage;
	local int oldEMPHitPoints;
	local int skillpt;

	// Robots are invincible to EMP in multiplayer as well
	if (( Level.NetMode != NM_Standalone ) && (damageType == 'EMP') && (Self.IsA('MedicalBot') || Self.IsA('RepairBot')) )
		return;

	if ( bInvincible )
		return;

	// robots aren't affected by gas or radiation
	if (IgnoreDamageType(damageType))
		return;

	// enough EMP damage shuts down the robot
	if (damageType == 'EMP')
	{
		oldEMPHitPoints = EMPHitPoints;
		EMPHitPoints   -= Damage;

		// make smoke!
		if (EMPHitPoints <= 0)
		{
			EMPHitPoints = 0;
			if (oldEMPHitPoints > 0)
			{
				PlaySound(sound'EMPZap', SLOT_None,,, (CollisionRadius+CollisionHeight)*8, 2.0);
				InitGenerator();
				if (sparkGen != None)
				{
					sparkGen.LifeSpan = 6;
					sparkGen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
					sparkGen.particleDrawScale = 0.3;
					sparkGen.bRandomEject = False;
					sparkGen.ejectSpeed = 10.0;
					sparkGen.bGravity = False;
					sparkGen.bParticlesUnlit = True;
					sparkGen.frequency = 0.3;
					sparkGen.riseRate = 3;
					sparkGen.spawnSound = Sound'Spark2';
				}

				//== Points for disabling a robot
				if(DeusExPlayer(instigatedBy) != None)
				{
					skillpt = FMax(Default.EMPHitPoints, oldEMPHitPoints);

					if(GetPawnAllianceType(DeusExPlayer(instigatedBy)) == ALLIANCE_Hostile)
						skillpt *= 5;
					else if(GetPawnAllianceType(DeusExPlayer(instigatedBy)) == ALLIANCE_Friendly && crazedTimer <= 0.0)
						skillpt *= -3;
					else
						skillpt = 0;

					if(oldEMPHitPoints >= Default.EMPHitPoints)
						skillpt *= 3;
					else if(oldEMPHitPoints >= Default.EMPHitPoints / 2)
						skillpt *= 2;

					skillpt /= 20;

					if(skillpt != 0)
						DeusExPlayer(instigatedBy).SkillPointsAdd(skillpt);
				}
			}
			AmbientSound = None;
			if (GetStateName() != 'Disabled')
				GotoState('Disabled');
		}

		// make sparks!
		else if (sparkGen == None)
		{
			InitGenerator();
			if (sparkGen != None)
			{
				sparkGen.particleTexture = Texture'Effects.Fire.SparkFX1';
				sparkGen.particleDrawScale = 0.2;
				sparkGen.bRandomEject = True;
				sparkGen.ejectSpeed = 100.0;
				sparkGen.bGravity = True;
				sparkGen.bParticlesUnlit = True;
				sparkGen.frequency = 0.2;
				sparkGen.riseRate = 10;
				sparkGen.spawnSound = Sound'Spark2';
			}
		}

		return;
	}
	else if (damageType == 'NanoVirus')
	{
		CrazedTimer += 0.5*Damage;
		if(instigatedBy != None)
			CrazedInstigator = instigatedBy;
		return;
	}

	// play a hit sound
	PlayTakeHitSound(Damage, damageType, 1);

	// increase the pitch of the ambient sound when damaged
	if (SoundPitch == Default.SoundPitch)
		SoundPitch += 16;

	actualDamage = Level.Game.ReduceDamage(Damage, DamageType, self, instigatedBy);

	// robots don't have soft, squishy bodies like humans do, so they're less
	// susceptible to gunshots...
	if (damageType == 'Shot' || damageType == 'Shell')
		actualDamage *= 0.25;  // quarter strength

	// hitting robots with a prod won't stun them, and will only do a limited
	// amount of damage...
	else if ((damageType == 'Stunned') || (damageType == 'KnockedOut'))
	{
		actualDamage *= 0.5;  // half strength
		damageType = 'Shot'; //== For the purposes of tricking PlayDying
	}

	// flame attacks don't really hurt robots much, either
	else if ((damageType == 'Flamed') || (damageType == 'Burned'))
		actualDamage *= 0.25;  // quarter strength

	if ((actualDamage > 0.01) && (actualDamage < 1))
		actualDamage = 1;
	actualDamage = int(actualDamage+0.5);

	if (ReducedDamageType == 'All') //God mode
		actualDamage = 0;
	else if (Inventory != None) //then check if carrying armor
		actualDamage = Inventory.ReduceDamage(int(actualDamage), DamageType, HitLocation);

	if (!bInvincible)
		Health -= int(actualDamage);

	if (Health <= 0)
	{
		ClearNextState();
		//PlayDeathHit(actualDamage, hitLocation, damageType);
		if ( actualDamage > mass )
			Health = -1 * actualDamage;
		Enemy = instigatedBy;
		Died(instigatedBy, damageType, HitLocation);
		SkillsForKills(instigatedBy, damageType, HitLocation);
	}
	MakeNoise(1.0);

	ReactToInjury(instigatedBy, damageType, HITLOC_None);
}

function ReactToInjury(Pawn instigatedBy, Name damageType, EHitLocation hitPos)
{
	local Pawn oldEnemy;

	if (IgnoreDamageType(damageType))
		return;

	if (EMPHitPoints > 0)
	{
		if (damageType == 'NanoVirus')
		{
			oldEnemy = Enemy;
			FindBestEnemy(false);
			if (oldEnemy != Enemy)
				PlayNewTargetSound();
			instigatedBy = Enemy;
		}
		Super.ReactToInjury(instigatedBy, damageType, hitPos);
	}
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if (!IgnoreDamageType(damageType) && CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}


function ComputeFallDirection(float totalTime, int numFrames,
                              out vector moveDir, out float stopTime)
{
}


function Explode(optional vector HitLocation)
{
	local int i, num;
	local float explosionRadius;
	local Vector loc;
	local DeusExFragment s;
	local ExplosionLight light;

	if(HitLocation == vect(0,0,0))
		HitLocation = Location;

	explosionRadius = (CollisionRadius + CollisionHeight) / 2;
	PlaySound(explosionSound, SLOT_None, 2.0,, explosionRadius*32);

	if (explosionRadius < 48.0)
		PlaySound(sound'LargeExplosion1', SLOT_None,,, explosionRadius*32);
	else
		PlaySound(sound'LargeExplosion2', SLOT_None,,, explosionRadius*32);

	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, HitLocation);
	for (i=0; i<explosionRadius/20+1; i++)
	{
		loc = Location + VRand() * CollisionRadius;
		if (explosionRadius < 16)
		{
			Spawn(class'ExplosionSmall',,, loc);
			light.size = 2;
		}
		else if (explosionRadius < 32)
		{
			Spawn(class'ExplosionMedium',,, loc);
			light.size = 4;
		}
		else
		{
			Spawn(class'ExplosionLarge',,, loc);
			light.size = 8;
		}
	}

	// spawn some metal fragments
	num = FMax(3, explosionRadius/6);
	for (i=0; i<num; i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, explosionRadius);
			s.DrawScale = explosionRadius*0.075*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	// cause the damage
	HurtRadius(0.5*explosionRadius, 8*explosionRadius, 'Exploded', 100*explosionRadius, Location);
}

function TweenToRunningAndFiring(float tweentime)
{
	bIsWalking = FALSE;
	TweenAnimPivot('Run', tweentime);
}

function PlayRunningAndFiring()
{
	bIsWalking = FALSE;
	LoopAnimPivot('Run');
}

function TweenToShoot(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayShoot()
{
	PlayAnimPivot('Still');
}

function TweenToAttack(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayAttack()
{
	PlayAnimPivot('Still');
}

function PlayTurning()
{
	LoopAnimPivot('Walk');
}

function PlayFalling()
{
}

function TweenToWalking(float tweentime)
{
	bIsWalking = True;
	TweenAnimPivot('Walk', tweentime);
}

function PlayWalking()
{
	bIsWalking = True;
	LoopAnimPivot('Walk');
}

function TweenToRunning(float tweentime)
{
	bIsWalking = False;
	PlayAnimPivot('Run',, tweentime);
}

function PlayRunning()
{
	bIsWalking = False;
	LoopAnimPivot('Run');
}

function TweenToWaiting(float tweentime)
{
	TweenAnimPivot('Idle', tweentime);
}

function PlayWaiting()
{
	PlayAnimPivot('Idle');
}

function PlaySwimming()
{
	LoopAnimPivot('Still');
}

function TweenToSwimming(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayLanded(float impactVel)
{
	bIsWalking = True;
}

function PlayDuck()
{
	TweenAnimPivot('Still', 0.25);
}

function PlayRising()
{
	PlayAnimPivot('Still');
}

function PlayCrawling()
{
	LoopAnimPivot('Still');
}

function PlayFiring()
{
	LoopAnimPivot('Still',,0.1);
}

function PlayReloadBegin()
{
	PlayAnimPivot('Still',, 0.1);
}

function PlayReload()
{
	PlayAnimPivot('Still');
}

function PlayReloadEnd()
{
	PlayAnimPivot('Still',, 0.1);
}

function PlayCowerBegin() {}
function PlayCowering() {}
function PlayCowerEnd() {}

function PlayDisabled()
{
	TweenAnimPivot('Still', 0.2);
}

function PlayWeaponSwitch(Weapon newWeapon)
{
}

function PlayIdleSound()
{
}

function PlayScanningSound()
{
	PlaySound(SearchingSound, SLOT_None,,, 2048);
	PlaySound(SpeechScanning, SLOT_None,,, 2048);
}

function PlaySearchingSound()
{
	PlaySound(SearchingSound, SLOT_None,,, 2048);
	PlaySound(SpeechScanning, SLOT_None,,, 2048);
}

function PlayTargetAcquiredSound()
{
	PlaySound(SpeechTargetAcquired, SLOT_None,,, 2048);
}

function PlayTargetLostSound()
{
	PlaySound(SpeechTargetLost, SLOT_None,,, 2048);
}

function PlayGoingForAlarmSound()
{
}

function PlayOutOfAmmoSound()
{
	PlaySound(SpeechOutOfAmmo, SLOT_None,,, 2048);
}

function PlayCriticalDamageSound()
{
	PlaySound(SpeechCriticalDamage, SLOT_None,,, 2048);
}

function PlayAreaSecureSound()
{
	PlaySound(SpeechAreaSecure, SLOT_None,,, 2048);
}


function AddReceivedItem(DeusExPlayer player, Inventory item, int count)
{
	if (!bSearchMsgPrinted)
	{
		player.ClientMessage(Sprintf((Class'DeusExCarcass').Default.msgSearching, "foo"));
		bSearchMsgPrinted = True;
	}

	DeusExRootWindow(player.rootWindow).hud.receivedItems.AddItem(item, count);

	// Make sure the object belt is updated
	if (item.IsA('Ammo'))
		player.UpdateAmmoBeltText(Ammo(item));
	else
		player.UpdateBeltText(item);
}


state Disabled
{
	ignores bump, reacttoinjury; //No longer ignores frob due to unrealistic
	function BeginState()
	{
		StandUp();
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

	function Frob(Actor Frobber, Inventory frobWith)
	{
		local Inventory item, nextItem, startItem, tempitem;
		local Pawn P;
		local DeusExWeapon W;
		local bool bFoundSomething;
		local DeusExPlayer player;
		local ammo AmmoType;
		local bool bPickedItemUp;
		local POVCorpse corpse;
		local DeusExPickup invItem;
		local int itemCount, FIcount;

		if(Level.NetMode != NM_Standalone) //== Let's not screw up multiplayer with this new code
			return;

		player = DeusExPlayer(Frobber);

		if(player == None) //== Players only
			return;

		if(player.combatDifficulty <= 4.0) //== Unrealistic only
			return;

		bFoundSomething = False;
		bSearchMsgPrinted = False;
		P = Pawn(Frobber);
		if (P != None)
		{
			// Make sure the "Received Items" display is cleared
			// DEUS_EX AMSD Don't bother displaying in multiplayer.  For propagation
			// reasons it is a lot more of a hassle than it is worth.
			if ( (player != None) && (Level.NetMode == NM_Standalone) )
	         		DeusExRootWindow(player.rootWindow).hud.receivedItems.RemoveItems();
	
			if (Inventory != None)
			{
	
				//== If by some chance we get items that belong to the player, skip them and move the Inventory
				//==  variable to something
				while(Inventory.Owner == Frobber)
				{
					Inventory = Inventory.Inventory;
					if(Inventory == None)
						break;
				}
	
				item = Inventory;
				startItem = item;
	
				do
				{
	
					if(item == None)
						break;
	
					while(item.Owner == Frobber)
					{
						item = item.Inventory;
						if(item == None)
							break;
					}
	
					if(item == None)
						break;
	
					nextItem = item.Inventory;
	
					if(nextItem != None)
					{
						while(nextItem.Owner == Frobber)
						{
							nextItem = nextItem.Inventory;
							item.Inventory = nextItem;
							if(nextItem == None)
								break;
						}
					}
	
					bPickedItemUp = False;
	
					if (item.IsA('Ammo'))
					{
						// Only let the player pick up ammo that's already in a weapon
	
						if(DeusExAmmo(item) != None && !item.IsA('AmmoCombatKnife') && !item.IsA('AmmoNone'))
						{
							if(item.IsA('AmmoSabot') || item.IsA('Ammo10mmEX') || item.IsA('AmmoDragon'))
								itemCount = 1 + Rand(12);
							else if(Ammo(item).AmmoAmount <= 4 && Ammo(item).AmmoAmount >= 1)
								itemCount = Ammo(item).AmmoAmount;
							else
								itemCount = 1 + Rand(4);
	
							// EXCEPT for non-standard ammo -- Y|yukichigai
							if(player.FindInventoryType(item.Class) != None)
							{
								if(DeusExAmmo(item).bIsNonStandard)
								{
			      						Ammo(player.FindInventoryType(item.Class)).AddAmmo(itemCount);
					                           	AddReceivedItem(player, item, itemCount);
		                         
									// Update the ammo display on the object belt
									player.UpdateAmmoBeltText(Ammo(item));
	
									P.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
									bPickedItemUp = True;
								}
							}
							//This is the code which would allow randomly-given ammo to be picked up by a player
							// regardless of if they have picked it up before.  This would (I feel) lead to
							// Shifter advancing the progress of the game prematurely, something which I am
							// endeavoring to avoid in the process of my coding -- Y|yukichigai
							else if(player.combatDifficulty > 4.0) //== But in unrealistic, who cares?
							{
								tempitem = spawn(item.Class, player);
								Ammo(tempitem).AmmoAmount = itemCount;
								tempitem.InitialState='Idle2';
								tempitem.GiveTo(player);
								tempitem.setBase(player);
								AddReceivedItem(player, tempitem, itemCount);
								bPickedItemUp = True;
							}
						}
	
						DeleteInventory(item);
						item.Destroy();
						item = None;
					}
					else if ( (item.IsA('DeusExWeapon')) )
					{
				               // Any weapons have their ammo set to a random number of rounds (1-4)
				               // unless it's a grenade, in which case we only want to dole out one.
					       // (Or assault rifle ammo, where it should be 1 - 14 rounds -- Y|yukichigai)
	
				               // DEUS_EX AMSD In multiplayer, give everything away.
				               W = DeusExWeapon(item);
	               
				               // Grenades and LAMs always pickup 1
				               if (W.IsA('WeaponGrenade') ||
						  W.IsA('WeaponHideAGun') ||
						  W.IsA('WeaponCombatKnife') )
				                  W.PickupAmmoCount = 1;
				               else if (Level.NetMode == NM_Standalone)
				                  W.PickupAmmoCount = Rand(W.Default.PickupAmmoCount) + 1;
					}
					
					if (item != None)
					{
						bFoundSomething = True;
	
						if (item.IsA('NanoKey'))
						{
							if (player != None)
							{
								player.PickupNanoKey(NanoKey(item));
								AddReceivedItem(player, item, 1);
								DeleteInventory(item);
								item.Destroy();
								item = None;
							}
							bPickedItemUp = True;
						}
						else if (item.IsA('Credits'))		// I hate special cases
						{
							if (player != None)
							{
								AddReceivedItem(player, item, Credits(item).numCredits);
								player.Credits += Credits(item).numCredits;
								P.ClientMessage(Sprintf(Credits(item).msgCreditsAdded, Credits(item).numCredits));
								DeleteInventory(item);
								item.Destroy();
								item = None;
							}
							bPickedItemUp = True;
						}
						else if (item.IsA('DeusExWeapon'))   // I *really* hate special cases
						{
							// Okay, check to see if the player already has this weapon.  If so,
							// then just give the ammo and not the weapon.  Otherwise give
							// the weapon normally. 
							W = DeusExWeapon(player.FindInventoryType(item.Class));
	
							//It's nice to know that EVERY F%$#ING NPC carries a combat knife,
							// but do we really need it f%$#ing filling our open slots?
							if(item.IsA('WeaponCombatKnife'))
							{
								if(player.FindInventoryType(Class'DeusEx.WeaponCombatKnife') == None)
								{
									//If we have a Sword, Crowbar or Dragon's Tooth just get rid of the damn thing
									if(player.FindInventoryType(Class'DeusEx.WeaponSword') != None ||
									 player.FindInventoryType(Class'DeusEx.WeaponCrowbar') != None ||
									 player.FindInventoryType(Class'DeusEx.WeaponToxinBlade') != None ||
									 player.FindInventoryType(Class'DeusEx.WeaponNanoSword') != None ||
									player.FindInventoryType(Class'WeaponPrototypeSwordA') != None ||
									player.FindInventoryType(Class'WeaponPrototypeSwordB') != None ||
									player.FindInventoryType(Class'WeaponPrototypeSwordC') != None)
									{
										DeleteInventory(item);
										item.Destroy();
										//Create a pickup in case they really want it
										spawn(Class'DeusEx.WeaponCombatKnife', self);
										item = None;
										W = None;
										P.ClientMessage("You discarded a Combat Knife (You have a better melee weapon)");
										bPickedItemUp = True;
									}
								}
							}
	
							// If the player already has this item in his inventory, piece of cake,
							// we just give him the ammo.  However, if the Weapon is *not* in the 
							// player's inventory, first check to see if there's room for it.  If so,
							// then we'll give it to him normally.  If there's *NO* room, then we 
							// want to give the player the AMMO only (as if the player already had 
							// the weapon).
	
							if (((W != None) || ((W == None) && (!player.FindInventorySlot(item, True))) && !bPickedItemUp) && Weapon(item) != None)
							{
								if ((Weapon(item).AmmoType != None || W.AmmoType != None))
								{
									if((Weapon(item).AmmoType.AmmoAmount > 0 || W.AmmoType.AmmoAmount > 0) && !DeusExWeapon(item).bNativeAttack)
									{
										AmmoType = Ammo(player.FindInventoryType(Weapon(item).AmmoName));
		
										if(AmmoType == None)
											AmmoType = Ammo(Player.FindInventoryType(W.AmmoName));
		
		                        					if ((AmmoType != None))
										{
											if(AmmoType.AmmoAmount < AmmoType.MaxAmmo)
											{
				                           					AmmoType.AddAmmo(Weapon(item).PickupAmmoCount);
			
												if(item.IsA('WeaponShuriken'))
													AddReceivedItem(player, item, Weapon(item).PickupAmmoCount);
												else if(item.IsA('WeaponCombatKnife'))
													AddReceivedItem(player, item, 1);
												else
									                           	AddReceivedItem(player, AmmoType, Weapon(item).PickupAmmoCount);
			                           
												// Update the ammo display on the object belt
												player.UpdateAmmoBeltText(AmmoType);
			
												// if this is an illegal ammo type, use the weapon name to print the message
												if (AmmoType.PickupViewMesh == Mesh'TestBox')
													P.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
												else
													P.ClientMessage(AmmoType.PickupMessage @ AmmoType.itemArticle @ AmmoType.itemName, 'Pickup');
			
												// Mark it as 0 to prevent it from being added twice
												Weapon(item).AmmoType.AmmoAmount = 0;
											}
										}
									}
								}
	
								// Print a message "Cannot pickup blah blah blah" if inventory is full
								// and the player can't pickup this weapon, so the player at least knows
								// if he empties some inventory he can get something potentially cooler
								// than he already has. 
								if ((W == None) && (!player.FindInventorySlot(item, True)))
								{
									if(!DeusExWeapon(item).bNativeAttack)
									{
										P.ClientMessage(Sprintf(Player.InventoryFull, item.itemName));
										if(Level.NetMode == NM_Standalone)
										{
											tempitem = spawn(item.Class,self);
											DeleteInventory(item);
											item.Destroy();
										}
									}
									else
									{
										if(DeusExWeapon(Item).AmmoType == None && DeusExWeapon(Item).AmmoName != None && DeusExWeapon(Item).AmmoName != Class'AmmoNone')
											DeusExWeapon(Item).AmmoType = Ammo(FindInventoryType(DeusExWeapon(Item).AmmoName));

										if(DeusExWeapon(Item).AmmoType != None)
										{
											AmmoType = Ammo(P.FindInventoryType(DeusExWeapon(Item).AmmoType.Class));
											if(AmmoType == None)
											{
												AmmoType = spawn(DeusExWeapon(Item).AmmoType.Class, P);
												if(AmmoType != None)
												{
													AmmoType.AmmoAmount = 2;
													AmmoType.InitialState='Idle2';
													AmmoType.GiveTo(P);
													AmmoType.SetBase(P);
												}
											}
											if(AmmoType != None && FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount) > 0 && AmmoType.AmmoAmount < AmmoType.MaxAmmo)
											{
												bFoundSomething = True;
												AmmoType.AmmoAmount += FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount);
												AddReceivedItem(player, DeusExWeapon(Item).AmmoType, FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount));
												DeusExWeapon(Item).AmmoType.AmmoAmount = 0;
												DeusExWeapon(Item).PickupAmmoCount = 0;
											}
										}
										DeleteInventory(Item);
										Item.Destroy();
									}
								}
	
								// Only destroy the weapon if the player already has it.
								if (W != None)
								{
									// Destroy the weapon, baby!
									if(!W.IsA('WeaponCombatKnife')) //Special case, since the Combat Knife is both ammo and weapon
									{
										tempitem = spawn(item.Class,self); //but leave behind a copy if we want it later 
										Weapon(tempitem).PickupAmmoCount = Weapon(item).AmmoType.AmmoAmount;
									}
									DeleteInventory(item);
									item.Destroy();
									item = None;
								}
	
								bPickedItemUp = True;
							}
						}
	
						else if (item.IsA('DeusExAmmo'))
						{
							if (DeusExAmmo(item).AmmoAmount == 0)
								bPickedItemUp = True;
						}
	
						if (!bPickedItemUp)
						{
							// Special case if this is a DeusExPickup(), it can have multiple copies
							// and the player already has it.
	
							if ((item.IsA('DeusExPickup')) && (DeusExPickup(item).bCanHaveMultipleCopies) && (player.FindInventoryType(item.class) != None))
							{
								invItem   = DeusExPickup(player.FindInventoryType(item.class));
								itemCount = DeusExPickup(item).numCopies;
	
								// Make sure the player doesn't have too many copies
								if ((invItem.MaxCopies > 0) && (DeusExPickup(item).numCopies + invItem.numCopies > invItem.MaxCopies))
								{	
									// Give the player the max #
									if ((invItem.MaxCopies - invItem.numCopies) > 0)
									{
										itemCount = (invItem.MaxCopies - invItem.numCopies);
										DeusExPickup(item).numCopies -= itemCount;
										invItem.numCopies = invItem.MaxCopies;
										invItem.TransferSkin(item);
										P.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
										AddReceivedItem(player, invItem, itemCount);
									}
									else
									{
										P.ClientMessage(Sprintf((class'DeusExCarcass').Default.msgCannotPickup, invItem.itemName));
										if(Level.NetMode == NM_Standalone)
										{
											invitem = DeusExPickup(spawn(item.Class,self));
											invitem.TransferSkin(item);
											DeleteInventory(item);
											item.Destroy();	
										}
									}
								}
								else
								{
									invItem.numCopies += itemCount;
									invItem.TransferSkin(item);
									DeleteInventory(item);
	
									P.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
									AddReceivedItem(player, invItem, itemCount);
								}
							}
							else
							{
								// check if the pawn is allowed to pick this up
								if ((P.Inventory == None) || (Level.Game.PickupQuery(P, item)))
								{
									DeusExPlayer(P).FrobTarget = item;
									if(DeusExWeapon(Item) != None && DeusExWeapon(Item).bNativeAttack) //Native weapons... bad
									{
										if(DeusExWeapon(Item).AmmoType == None && DeusExWeapon(Item).AmmoName != None && DeusExWeapon(Item).AmmoName != Class'AmmoNone')
											DeusExWeapon(Item).AmmoType = Ammo(FindInventoryType(DeusExWeapon(Item).AmmoName));

										if(DeusExWeapon(Item).AmmoType != None)
										{
											AmmoType = Ammo(P.FindInventoryType(DeusExWeapon(Item).AmmoType.Class));
											if(AmmoType == None)
											{
												AmmoType = spawn(DeusExWeapon(Item).AmmoType.Class, P);
												if(AmmoType != None)
												{
													AmmoType.AmmoAmount = 2;
													AmmoType.InitialState='Idle2';
													AmmoType.GiveTo(P);
													AmmoType.SetBase(P);
												}
											}
											if(AmmoType != None && FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount) > 0 && AmmoType.AmmoAmount < AmmoType.MaxAmmo)
											{
												bFoundSomething = True;
												AmmoType.AmmoAmount += FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount);
												AddReceivedItem(player, DeusExWeapon(Item).AmmoType, FMin(DeusExWeapon(Item).PickupAmmoCount, DeusExWeapon(Item).AmmoType.AmmoAmount));
												DeusExWeapon(Item).AmmoType.AmmoAmount = 0;
												DeusExWeapon(Item).PickupAmmoCount = 0;
											}
										}
										DeleteInventory(Item);
										Item.Destroy();
									}
									else if (DeusExPlayer(P).HandleItemPickup(Item) != False)
									{
	                           						DeleteInventory(item);
	
	                           						// DEUS_EX AMSD Belt info isn't always getting cleaned up.  Clean it up.
	                           						item.bInObjectBelt=False;
	                           						item.BeltPos=-1;
		
										item.SpawnCopy(P);
	
										// Show the item received in the ReceivedItems window and also 
										// display a line in the Log
										AddReceivedItem(player, item, 1);

										if(Weapon(item) != None)
										{
											if(Weapon(item).PickupAmmoCount <= 0 && Weapon(item).Default.PickupAmmoCount > 0)
												Weapon(item).PickupAmmoCount = 1;

											if(Weapon(item).AmmoType != None && Weapon(item).AmmoName != Class'AmmoNone')
											{
												if(Weapon(item).AmmoType.Icon != Weapon(item).Icon && Weapon(item).AmmoType.Icon != None)
													AddReceivedItem(player, Weapon(item).AmmoType, Weapon(item).PickupAmmoCount);
												else //== For weapons like the shuriken we just add to the weapon pickup count
													AddReceivedItem(player, Weapon(item), Weapon(item).PickupAmmoCount - 1);
											}
										}

										P.ClientMessage(Item.PickupMessage @ Item.itemArticle @ Item.itemName, 'Pickup');
										PlaySound(Item.PickupSound);
	
									}
									else if(Level.NetMode == NM_Standalone)
									{
										spawn(Item.Class,self);
										DeleteInventory(Item);
										Item.Destroy();
									}
								}
								else
								{
									DeleteInventory(item);
									item.Destroy();
									item = None;
								}
							}
						}
					}
	
					item = nextItem;
				}
				until ((item == None) || (item == startItem));
			}
	
			if (!bFoundSomething)
				P.ClientMessage( Sprintf( (Class'DeusExCarcass').Default.msgEmpty, "foo") );
		}
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayDisabled();

Disabled:
}

state Fleeing
{
	function PickDestination()
	{
		local int     iterations;
		local float   magnitude;
		local rotator rot1;

		iterations = 4;
		magnitude  = 400*(FRand()*0.4+0.8);  // 400, +/-20%
		rot1       = Rotator(Location-Enemy.Location);
		if (!AIPickRandomDestination(40, magnitude, rot1.Yaw, 0.6, rot1.Pitch, 0.6, iterations,
		                             FRand()*0.4+0.35, destLoc))
			destLoc = Location;  // we give up
	}
}

// ------------------------------------------------------------
// IsImmobile
// If the bots are immobile, then we can make them always relevant
// ------------------------------------------------------------
function bool IsImmobile()
{
   local bool bHasReactions;
   local bool bHasFears;
   local bool bHasHates;

   if (Orders != 'Standing')
      return false;

   bHasReactions = bReactFutz || bReactPresence || bReactLoudNoise || bReactAlarm || bReactShot || bReactCarcass || bReactDistress || bReactProjectiles;

   bHasFears = bFearHacking || bFearWeapon || bFearShot || bFearInjury || bFearIndirectInjury || bFearCarcass || bFearDistress || bFearAlarm || bFearProjectiles;

   bHasHates = bHateHacking || bHateWeapon || bHateShot || bHateInjury || bHateIndirectInjury || bHateCarcass || bHateDistress;

   return (!bHasReactions && !bHasFears && !bHasHates);
}

defaultproperties
{
     EMPHitPoints=50
     explosionSound=Sound'DeusExSounds.Robot.RobotExplode'
     maxRange=512.000000
     MinHealth=0.000000
     RandomWandering=0.150000
     bCanBleed=False
     bShowPain=False
     bCanSit=False
     bAvoidAim=False
     bAvoidHarm=False
     bHateShot=False
     bReactAlarm=True
     bReactProjectiles=False
     bEmitDistress=False
     RaiseAlarm=RAISEALARM_Never
     bMustFaceTarget=False
     FireAngle=60.000000
     MaxProvocations=0
     SurprisePeriod=0.000000
     EnemyTimeout=7.000000
     walkAnimMult=1.000000
     bCanStrafe=False
     bCanSwim=False
     bIsHuman=False
     JumpZ=0.000000
     MaxStepHeight=4.000000
     Health=50
     HitSound1=Sound'DeusExSounds.Generic.Spark1'
     HitSound2=Sound'DeusExSounds.Generic.Spark1'
     Die=Sound'DeusExSounds.Generic.Spark1'
     VisibilityThreshold=0.006000
     BindName="Robot"
}
