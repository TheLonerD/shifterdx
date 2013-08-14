//=============================================================================
// DeusExCarcass.
//=============================================================================
class DeusExCarcass extends Carcass;

struct InventoryItemCarcass  {
	var() class<Inventory> Inventory;
	var() int              count;
};

var(Display) mesh Mesh2;		// mesh for secondary carcass
var(Display) mesh Mesh3;		// mesh for floating carcass
var(Inventory) InventoryItemCarcass InitialInventory[8];  // Initial inventory items held in the carcass
var() bool bHighlight;

var String			KillerBindName;		// what was the bind name of whoever killed me?
var Name			KillerAlliance;		// what alliance killed me?
var bool			bGenerateFlies;		// should we make flies?
var FlyGenerator		flyGen;
var Name			Alliance;			// this body's alliance
var Name			CarcassName;		// original name of carcass
var int				MaxDamage;			// maximum amount of cumulative damage
var bool			bNotDead;			// this body is just unconscious
var() bool			bEmitCarcass;		// make other NPCs aware of this body
var bool		    bQueuedDestroy;	// For multiplayer, semaphore so you can't doublefrob bodies (since destroy is latent)

var bool			bInit;

// Used for Received Items window
var bool bSearchMsgPrinted;

var localized string msgSearching;
var localized string msgEmpty;
var localized string msgNotDead;
var localized string msgAnimalCarcass;
var localized string msgCannotPickup;
var localized String msgRecharged;
var localized string itemName;			// human readable name

var() bool bInvincible;
var bool bAnimalCarcass;

var bool bOnFire;
var float burnTimer;
var float BurnPeriod;

var class<Inventory> FrobItems[4]; // Items to spawn on frob.  Used to give items to corpses after they are spawned

var localized string msgCombatDiscard;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	if(Level.NetMode == NM_Standalone)
		Facelift(true);
}

function bool Facelift(bool bOn)
{
	//== Only do this for DeusEx classes
	if(instr(String(Class.Name), ".") > -1 && bOn)
		if(instr(String(Class.Name), "DeusEx.") <= -1)
			return false;
	else
		if((Class != Class(DynamicLoadObject("DeusEx."$ String(Class.Name), class'Class', True))) && bOn)
			return false;

	return true;
}

// ----------------------------------------------------------------------
// InitFor()
// ----------------------------------------------------------------------

function InitFor(Actor Other)
{
	if (Other != None)
	{
		// set as unconscious or add the pawns name to the description
		//== and now use the FamiliarName field to store the full, descriptive name
//		if (!bAnimalCarcass)
//		{
			if (bNotDead)
			{
				itemName = msgNotDead;
				FamiliarName = msgNotDead $ " (" $ ScriptedPawn(Other).FamiliarName $ ")";
			}
			else if (Other.IsA('ScriptedPawn'))
			{
				itemName = itemName $ " (" $ ScriptedPawn(Other).FamiliarName $ ")";
				FamiliarName = itemName;
			}
//		}

		Mass           = Other.Mass;
		Buoyancy       = Mass * 1.2;
		MaxDamage      = 0.8*Mass;
//		if (ScriptedPawn(Other) != None)
//		{
//			if (ScriptedPawn(Other).bBurnedToDeath)
//			{
//				CumulativeDamage = MaxDamage-1;
//			}
//		}

		SetScaleGlow();

		// Will this carcass spawn flies?
		if (bAnimalCarcass && !bNotDead)
		{
			itemName = msgAnimalCarcass;
			FamiliarName = itemName $ " (" $ ScriptedPawn(Other).FamiliarName $ ")";
			if (FRand() < 0.2)
				bGenerateFlies = true;
		}
		else if (!Other.IsA('Robot') && !bNotDead)
		{
			if (FRand() < 0.1)
				bGenerateFlies = true;
			bEmitCarcass = true;
		}

		if (Other.AnimSequence == 'DeathFront')
			Mesh = Mesh2;

		// set the instigator and tag information
		if (Other.Instigator != None)
		{
			KillerBindName = Other.Instigator.BindName;
			KillerAlliance = Other.Instigator.Alliance;
		}
		else
		{
			KillerBindName = Other.BindName;
			KillerAlliance = '';
		}
		Tag = Other.Tag;
		Alliance = Pawn(Other).Alliance;
		CarcassName = Other.Name;
	}
}

// ----------------------------------------------------------------------
// PostBeginPlay()
// ----------------------------------------------------------------------

function PostBeginPlay()
{
	local int i, j;
	local Inventory inv;

	bCollideWorld = true;

	// Use the carcass name by default
	CarcassName = Name;

	// Add initial inventory items
	for (i=0; i<8; i++)
	{
		if ((InitialInventory[i].inventory != None) && (InitialInventory[i].count > 0))
		{
			for (j=0; j<InitialInventory[i].count; j++)
			{
				inv = spawn(InitialInventory[i].inventory, self);
				if (inv != None)
				{
					inv.bHidden = True;
					inv.SetPhysics(PHYS_None);
					AddInventory(inv);
				}
			}
		}
	}

	// use the correct mesh
	if (Region.Zone.bWaterZone)
	{
		Mesh = Mesh3;
		bNotDead = False;		// you will die in water every time
	}

	if (bAnimalCarcass && !bNotDead)
		itemName = msgAnimalCarcass;

	MaxDamage = 0.8*Mass;
	SetScaleGlow();

	SetTimer(30.0, False);

	Super.PostBeginPlay();
}

// ----------------------------------------------------------------------
// ZoneChange()
// ----------------------------------------------------------------------

function ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	// use the correct mesh for water
	if (NewZone.bWaterZone)
	{
		if(bOnFire)
			ExtinguishFire();

		Mesh = Mesh3;
	}
}

// ----------------------------------------------------------------------
// Destroyed()
// ----------------------------------------------------------------------

function Destroyed()
{
	if (flyGen != None)
	{
		flyGen.StopGenerator();
		flyGen = None;
	}

	Super.Destroyed();
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaSeconds)
{
	local Fire f;
	local ParticleGenerator p;
	local vector loc;

	if (!bInit)
	{
		bInit = true;
		if (bEmitCarcass)
			AIStartEvent('Carcass', EAITYPE_Visual);
	}
	if (bOnFire)
	{
		
		foreach BasedActors(class'Fire',f)
		{
			loc = f.Location;
			if(loc.Z > Location.Z + (CollisionHeight * 0.300000))
				loc.Z -= ( FMax(loc.Z - (Location.Z - CollisionHeight), 3.50) * deltaSeconds );
			else if(loc.Z < Location.Z - (CollisionHeight * 0.300000))
				loc.Z += ( FMax((Location.Z + CollisionHeight) - loc.Z, 3.50) * deltaSeconds );
			f.SetLocation(loc);

			if(f.smokeGen != None)
				f.smokeGen.SetLocation(loc);

			if(f.fireGen != None)
				f.fireGen.SetLocation(loc);
		}
		if(CumulativeDamage < MaxDamage)
		{
			burnTimer += deltaSeconds;
			UpdateFire(deltaSeconds);
			//== If there are no visible fire effects then we need to stop burning, lest this get very confusing
			if (burnTimer >= BurnPeriod || f == None)
				ExtinguishFire();
		}
	}
	Super.Tick(deltaSeconds);
}

// ----------------------------------------------------------------------
// Timer()
// ----------------------------------------------------------------------

function Timer()
{
	if (bGenerateFlies && !bOnFire)
	{
		flyGen = Spawn(Class'FlyGenerator', , , Location, Rotation);
		if (flyGen != None)
			flyGen.SetBase(self);
	}
}

// ----------------------------------------------------------------------
// ChunkUp()
// ----------------------------------------------------------------------

function ChunkUp(int Damage)
{
	local int i;
	local float size;
	local Vector loc;
	local FleshFragment chunk;

	// gib the carcass
	size = (CollisionRadius + CollisionHeight) / 2;
	if (size > 10.0)
	{
		for (i=0; i<size/4.0; i++)
		{
			loc.X = (1-2*FRand()) * CollisionRadius;
			loc.Y = (1-2*FRand()) * CollisionRadius;
			loc.Z = (1-2*FRand()) * CollisionHeight;
			loc += Location;
			chunk = spawn(class'FleshFragment', None,, loc);
			if (chunk != None)
			{
				chunk.DrawScale = size / 25;
				chunk.SetCollisionSize(chunk.CollisionRadius / chunk.DrawScale, chunk.CollisionHeight / chunk.DrawScale);
				chunk.bFixedRotationDir = True;
				chunk.RotationRate = RotRand(False);
			}
		}
	}

	Super.ChunkUp(Damage);
}

// ----------------------------------------------------------------------
// TakeDamage()
// ----------------------------------------------------------------------

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitLocation, Vector momentum, name damageType)
{
	local int i;

	if (bInvincible)
		return;

	// only take "gib" damage from these damage types
	if ((damageType == 'Shot') || (damageType == 'Sabot') || (damageType == 'Exploded') || (damageType == 'Munch') ||
	    (damageType == 'Tantalus') || (damageType == 'Shell'))
	{
		if ((damageType != 'Munch') && (damageType != 'Tantalus'))
		{
         if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
         {
         }
         else
         {
            spawn(class'BloodSpurt',,,HitLocation);
            spawn(class'BloodDrop',,, HitLocation);
            for (i=0; i<Damage; i+=10)
               spawn(class'BloodDrop',,, HitLocation);
         }
		}

		// this section copied from Carcass::TakeDamage() and modified a little
		if (!bDecorative)
		{
			bBobbing = false;
			SetPhysics(PHYS_Falling);
		}
		if ((Physics == PHYS_None) && (Momentum.Z < 0))
			Momentum.Z *= -1;
		Velocity += 3 * momentum/(Mass + 200);
		if (DamageType == 'Shot' || DamageType == 'Shell')
			Damage *= 0.4;
		CumulativeDamage += Damage;
		if (CumulativeDamage >= MaxDamage)
		{
			if(bOnFire)
				ExtinguishFire();
			ChunkUp(Damage);
		}
//		else if(CumulativeDamage * 2 >= MaxDamage)
//		{
//			if(bNotDead)
//			{
//				bNotDead = False;
//
//				//== Note to self: find way to just remove first part of names and replace
//				if(bAnimalCarcass)
//					itemName = "Animal Carcass";
//				else
//					itemName = "Dead Body";
//			}
//		}
		if (bDecorative)
			Velocity = vect(0,0,0);
	}

	SetScaleGlow();
}

// ----------------------------------------------------------------------
// SetScaleGlow()
//
// sets the scale glow for the carcass, based on damage
// ----------------------------------------------------------------------

function SetScaleGlow()
{
	local float pct;

	// scaleglow based on damage
	pct = FClamp(1.0-float(CumulativeDamage)/MaxDamage, 0.1, 1.0);
	ScaleGlow = pct;
}

// ----------------------------------------------------------------------
// Frob()
//
// search the body for inventory items and give them to the frobber
// ----------------------------------------------------------------------

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

//log("DeusExCarcass::Frob()--------------------------------");

	// Can we assume only the *PLAYER* would actually be frobbing carci?
	player = DeusExPlayer(Frobber);

	// No doublefrobbing in multiplayer.
	if (bQueuedDestroy)
		return;

	FIcount = 0;

	// if we've already been searched, let the player pick us up
	// don't pick up animal carcii
	if (!bAnimalCarcass)
	{
      // DEUS_EX AMSD Since we don't have animations for carrying corpses, and since it has no real use in multiplayer,
      // and since the PutInHand propagation doesn't just work, this is work we don't need to do.
      // Were you to do it, you'd need to check the respawning issue, destroy the POVcorpse it creates and point to the
      // one in inventory (like I did when giving the player starting inventory).
		if ((Inventory == None) && (player != None) && (player.inHand == None) && (Level.NetMode == NM_Standalone))
		{
			if (!bInvincible)
			{
				corpse = Spawn(class'POVCorpse');
				if (corpse != None)
				{
					// destroy the actual carcass and put the fake one
					// in the player's hands
					corpse.carcClassString = String(Class);
					corpse.KillerAlliance = KillerAlliance;
					corpse.KillerBindName = KillerBindName;
					corpse.Alliance = Alliance;
					corpse.bNotDead = bNotDead;
					corpse.bEmitCarcass = bEmitCarcass;
					corpse.CumulativeDamage = CumulativeDamage;
					corpse.MaxDamage = MaxDamage;
					corpse.CorpseItemName = itemName;
					corpse.CarcassName = CarcassName;
					corpse.FamiliarName = FamiliarName; //Make sure to track the nifty Familiar Name
					corpse.Frob(player, None);
					corpse.SetBase(player);
					player.PutInHand(corpse);
					bQueuedDestroy=True;
					Destroy();
					return;
				}
			}
		}
	}

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
//				log("===>DeusExCarcass:item="$item );

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
						item.Inventory = nextItem; //== Relink to the appropriate, un-player-owned item
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
						// EXCEPT for non-standard ammo -- Y|yukichigai
						if(DeusExAmmo(item).bIsNonStandard)
						{
							if(item.IsA('AmmoSabot') || item.IsA('Ammo10mmEX') || item.IsA('AmmoDragon'))
							{
								itemCount = 1 + Rand(12);
								if(Ammo(item).AmmoAmount >= 5 && Ammo(item).AmmoAmount <= 12)
									itemCount = Ammo(item).AmmoAmount;
							}
							else if(Ammo(item).AmmoAmount <= 4 && Ammo(item).AmmoAmount >= 1)
								itemCount = Ammo(item).AmmoAmount;
							else
								itemCount = 1 + Rand(4);
	
							Ammo(item).AmmoAmount = itemCount;
	
							if(player.FindInventoryType(item.Class) != None)
							{
		      						Ammo(player.FindInventoryType(item.Class)).AddAmmo(itemCount);
				                           	AddReceivedItem(player, item, itemCount);
	
								// Update the ammo display on the object belt
								player.UpdateAmmoBeltText(Ammo(item));
	
								P.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName @ "("$itemCount$")", 'Pickup');
								bPickedItemUp = True;
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
								player.UpdateAmmoBeltText(Ammo(tempitem));
								P.ClientMessage(tempitem.PickupMessage @ tempitem.itemArticle @ tempitem.itemName, 'Pickup');
								AddReceivedItem(player, tempitem, itemCount);
								bPickedItemUp = True;
							}
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
				       //== Except now, where the amount to dole out is randomly determined by the
				       //==  default PickupAmmoCount variable

			               // DEUS_EX AMSD In multiplayer, give everything away.
			               W = DeusExWeapon(item);
               
			               // Grenades and LAMs always pickup 1
			               if (W.IsA('WeaponGrenade') || W.IsA('WeaponCombatKnife') )
			                  W.PickupAmmoCount = 1;
			               else if (Level.NetMode == NM_Standalone)
			                  W.PickupAmmoCount = Rand(Max((W.Default.PickupAmmoCount/2),4)) + 1; //Rand(4) + 1;
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
									P.ClientMessage(msgCombatDiscard);
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

						if ((W != None) || ((W == None) && (!player.FindInventorySlot(item, True))) && !bPickedItemUp)
						{
							// Don't bother with this is there's no ammo
							if(Weapon(item) != None)
							{
								if ((Weapon(item).AmmoType != None || W.AmmoType != None))
								{
									if((Weapon(item).AmmoType.AmmoAmount > 0 || W.AmmoType.AmmoAmount > 0))
									{
										AmmoType = Ammo(player.FindInventoryType(Weapon(item).AmmoName));
		
										if(AmmoType == None)
											AmmoType = Ammo(Player.FindInventoryType(W.AmmoName));
		
		                        					if ((AmmoType != None))
										{
											if(AmmoType.AmmoAmount < AmmoType.MaxAmmo)
											{
												itemCount = Weapon(item).PickupAmmoCount;

												if(item.IsA('WeaponCombatKnife'))
													itemCount = 1;

				                           					AmmoType.AddAmmo(Weapon(item).PickupAmmoCount);
			
												if(item.IsA('WeaponShuriken') || item.IsA('WeaponCombatKnife'))
													AddReceivedItem(player, item, itemCount);
												else
									                           	AddReceivedItem(player, AmmoType, itemCount);
			                           
												// Update the ammo display on the object belt
												player.UpdateAmmoBeltText(AmmoType);
			
												// if this is an illegal ammo type, use the weapon name to print the message
												if (AmmoType.PickupViewMesh == Mesh'TestBox')
													P.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName @ "("$itemCount$")", 'Pickup');
												else
													P.ClientMessage(AmmoType.PickupMessage @ AmmoType.itemArticle @ AmmoType.itemName @ "("$itemCount$")", 'Pickup');
			
												// Mark it as 0 to prevent it from being added twice
												Weapon(item).AmmoType.AmmoAmount = 0;
											}
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
								P.ClientMessage(Sprintf(Player.InventoryFull, item.itemName));
								if(Level.NetMode == NM_Standalone)
								{
									tempitem = spawn(item.Class,self);
									DeleteInventory(item);
									item.Destroy();
								}
								item = None;
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
									P.ClientMessage(Sprintf(msgCannotPickup, invItem.itemName));
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
								if (DeusExPlayer(P).HandleItemPickup(Item) != False)
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
										//if(Weapon(item).PickupAmmoCount <= 0 && Weapon(item).Default.PickupAmmoCount > 0)
										//	Weapon(item).PickupAmmoCount = 1;

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

//log("  bFoundSomething = " $ bFoundSomething);

		if (!bFoundSomething)
			P.ClientMessage(msgEmpty);
	}

	//== Handle some special, script-given pickups if they are present
	while(FrobItems[FIcount] != None && FIcount <= 3)
	{
		item = spawn(FrobItems[FIcount],self);

		DeusExPlayer(P).FrobTarget = item;
		if (DeusExPlayer(P).HandleItemPickup(Item) != False)
		{

			// DEUS_EX AMSD Belt info isn't always getting cleaned up.  Clean it up.
			item.bInObjectBelt=False;
			item.BeltPos=-1;

			if(Weapon(item) != None)
			{
				if(Weapon(item).PickupAmmoCount == 0 && Weapon(item).Default.PickupAmmoCount > 0)
					Weapon(item).PickupAmmoCount = 1;
			}

			// Show the item received in the ReceivedItems window and also 
			// display a line in the Log
			AddReceivedItem(player, item, 1);
			
			PlaySound(Item.PickupSound);
			//Pepper Gun needs more ammo on pickup
			if(item.IsA('WeaponPepperGun'))
			{
				AmmoType = Ammo(player.FindInventoryType(Class'DeusEx.AmmoPepper'));
				AmmoType.AddAmmo(Rand(34) + 17);
			}

		}

		FIcount++;
	}

   if ((player != None) && (Level.Netmode != NM_Standalone))
   {
      player.ClientMessage(Sprintf(msgRecharged, 25));
      
      PlaySound(sound'BioElectricHiss', SLOT_None,,, 256);
      
      player.Energy += 25;
      if (player.Energy > player.EnergyMax)
         player.Energy = player.EnergyMax;
   }

	Super.Frob(Frobber, frobWith);

   if ((Level.Netmode != NM_Standalone) && (Player != None))   
   {
	   bQueuedDestroy = true;
	   Destroy();	  
   }
}

// ----------------------------------------------------------------------
// AddReceivedItem()
// ----------------------------------------------------------------------

function AddReceivedItem(DeusExPlayer player, Inventory item, int count)
{
	local DeusExWeapon w;
	local Inventory altAmmo;

	if (!bSearchMsgPrinted)
	{
		player.ClientMessage(msgSearching);
		bSearchMsgPrinted = True;
	}

	DeusExRootWindow(player.rootWindow).hud.receivedItems.AddItem(item, count);

	// Make sure the object belt is updated
	if (item.IsA('Ammo'))
		player.UpdateAmmoBeltText(Ammo(item));
	else
		player.UpdateBeltText(item);

	// Deny 20mm and WP rockets off of bodies in multiplayer
	if ( Level.NetMode != NM_Standalone )
	{
		if ( item.IsA('WeaponAssaultGun') || item.IsA('WeaponGEPGun') )
		{
			w = DeusExWeapon(player.FindInventoryType(item.Class));
			if (( Ammo20mm(w.AmmoType) != None ) || ( AmmoRocketWP(w.AmmoType) != None ))
			{
				altAmmo = Spawn( w.AmmoNames[0] );
				DeusExAmmo(altAmmo).AmmoAmount = w.PickupAmmoCount;
				altAmmo.Frob(player,None);
				altAmmo.Destroy();
				w.AmmoType.Destroy();
				w.LoadAmmo( 0 );
			}
		}
	}
}

// ----------------------------------------------------------------------
// GetItem()
//
// Does all the tedious steps of giving items to carcasses in one easy
// function.
// ----------------------------------------------------------------------

function GetItem(Inventory item)
{
	if(item != None)
	{
		if(Pawn(item.Owner) != None) //Remove from any other inventories
			Pawn(item.Owner).DeleteInventory(item);

		bCollideWorld = True;
		AddInventory(item);
		item.InitialState = 'Idle2';
		item.SetBase(Self);
		item.Instigator = None;
		item.BecomeItem();
		item.GoToState('Idle2');
		bCollideWorld = False;
	}
}


// ----------------------------------------------------------------------
// AddInventory()
//
// copied from Engine.Pawn
// Add Item to this carcasses inventory. 
// Returns true if successfully added, false if not.
// ----------------------------------------------------------------------

function bool AddInventory( inventory NewItem )
{
	// Skip if already in the inventory.
	local inventory Inv;

	for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
		if( Inv == NewItem )
			return false;

	// The item should not have been destroyed if we get here.
	assert(NewItem!=None);

	// Add to front of inventory chain.
	NewItem.SetOwner(Self);
	NewItem.Inventory = Inventory;
	NewItem.InitialState = 'Idle2';
	Inventory = NewItem;

	return true;
}

// ----------------------------------------------------------------------
// DeleteInventory()
// 
// copied from Engine.Pawn
// Remove Item from this pawn's inventory, if it exists.
// Returns true if it existed and was deleted, false if it did not exist.
// ----------------------------------------------------------------------

function bool DeleteInventory( inventory Item )
{
	// If this item is in our inventory chain, unlink it.
	local actor Link;

	for( Link = Self; Link!=None; Link=Link.Inventory )
	{
		if( Link.Inventory == Item )
		{
			Link.Inventory = Item.Inventory;
			break;
		}
	}
   Item.SetOwner(None);
}

//-----------------------------------------------------------------------
// I am Jack's Fire
//-----------------------------------------------------------------------

function CatchFire()
{
	local Fire f;
	local int i;
	local vector loc;

	if (bOnFire || Region.Zone.bWaterZone || BurnPeriod <= 0 || bInvincible)
		return;

	bOnFire = True;
	burnTimer = 0;

	for (i=0; i<8; i++)
	{
		loc.X = 0.5*CollisionRadius * (1.0-2.0*FRand());
		loc.Y = 0.5*CollisionRadius * (1.0-2.0*FRand());
		loc.Z = 0.300000*CollisionHeight * (1.000000-2.000000*FRand());
		loc += Location;
		f = Spawn(class'Fire', Self,, loc);
		if (f != None)
		{
			f.DrawScale = 0.5*FRand() + 1.0;

			// turn off the sound and lights for all but the first one
			if (i > 0)
			{
				f.AmbientSound = None;
				f.LightType = LT_None;
			}

			// turn on/off extra fire and smoke
			if (FRand() < 0.5)
				f.smokeGen.Destroy();
			if (FRand() < 0.5)
				f.AddFire();
		}
	}

}

function ExtinguishFire()
{
	local Fire f;

	bOnFire = False;
	burnTimer = 0;

	foreach BasedActors(class'Fire', f)
	{
		if(f.smokeGen != None)
			f.smokeGen.SetBase(f);
		if(f.fireGen != None)
			f.fireGen.SetBase(f);
		f.Destroy();
	}
}

function UpdateFire(float deltaSeconds)
{
	if(bOnFire)
	{
		// continually burn and do damage
		//  Munch damage will not make blood spurts
		TakeDamage(Int(6 * deltaSeconds),None,vect(0,0,0),vect(0,0,0),'Munch');
	}
}

// ----------------------------------------------------------------------
// auto state Dead
// ----------------------------------------------------------------------

auto state Dead
{
	function Timer()
	{
		// overrides goddamned lifespan crap
      // DEUS_EX AMSD In multiplayer, we want corpses to have lifespans.  
      if (Level.NetMode == NM_Standalone)		
         Global.Timer();
      else
         Super.Timer();
	}

	function HandleLanding()
	{
		local Vector HitLocation, HitNormal, EndTrace;
		local Actor hit;
		local BloodPool pool;

		if (!bNotDead)
		{
			// trace down about 20 feet if we're not in water
			if (!Region.Zone.bWaterZone)
			{
				EndTrace = Location - vect(0,0,320);
				hit = Trace(HitLocation, HitNormal, EndTrace, Location, False);
            if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
            {
               pool = None;
            }
            else
            {
               pool = spawn(class'BloodPool',,, HitLocation+HitNormal, Rotator(HitNormal));
            }
				if (pool != None)
				{
					pool.maxDrawScale = CollisionRadius / 40.0;

					if(pool.Texture != pool.Default.Texture) //== HDTP scale-down
						pool.maxDrawScale /= 16;
				}
			}

			// alert NPCs that I'm food
			AIStartEvent('Food', EAITYPE_Visual);
		}

		// by default, the collision radius is small so there won't be as
		// many problems spawning carcii
		// expand the collision radius back to where it's supposed to be
		// don't change animal carcass collisions
		if (!bAnimalCarcass)
			SetCollisionSize(40.0, Default.CollisionHeight);

		// alert NPCs that I'm really disgusting
		if (bEmitCarcass)
			AIStartEvent('Carcass', EAITYPE_Visual);
	}

Begin:
	while (Physics == PHYS_Falling)
	{
		Sleep(1.0);
	}
	HandleLanding();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     bHighlight=True
     msgSearching="You found:"
     msgEmpty="You don't find anything"
     msgNotDead="Unconscious"
     msgAnimalCarcass="Animal Carcass"
     msgCannotPickup="You cannot pickup the %s"
     msgRecharged="Recharged %d points"
     ItemName="Dead Body"
     BurnPeriod=10.000000
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=0.000000
     CollisionRadius=20.000000
     CollisionHeight=7.000000
     bCollideWorld=False
     Mass=150.000000
     Buoyancy=170.000000
     BindName="DeadBody"
     bVisionImportant=True
     msgCombatDiscard="You discarded a Combat Knife (You have a better melee weapon)"
}
