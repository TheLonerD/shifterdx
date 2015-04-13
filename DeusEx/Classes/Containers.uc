//=============================================================================
// Containers.
//=============================================================================
class Containers extends DeusExDecoration
	abstract;

var() int numThings;
var() bool bGenerateTrash;

//== Loot variables
var travel bool bLootable; //== Can be looted on frob
var() travel bool bLooted; //== If the item has already been looted so we can pick it up/etc.
var() travel bool bRandomize; //== If True, give some random inventory (if there's none already)
//var() bool bSearchMsgPrinted;

var localized string ContainerEmpty;
var localized string ContainerDiscard;
var localized string ContainerFound;

//== PostPostBeginPlay for randomizing inventory
function PostPostBeginPlay()
{
	local Class<Inventory> Consumables[6];
	local int i, testRandom;

	Super.PostPostBeginPlay();

	if(bRandomize)
	{
		bRandomize = False;

		testRandom = Rand(22);

		if(testRandom >= 15 && Contents == None)
		{
			Consumables[0] = class'SoyFood';
			Consumables[1] = class'Candybar';
			Consumables[2] = class'VialCrack';
			Consumables[3] = class'Cigarettes';
			Consumables[4] = class'Sodacan';
			Consumables[5] = class'Liquor40oz';
	
			//== Some substitutions for TNM
			if(GetPlayerPawn().IsA('trestkon'))
			{
				Consumables[0] = Class<Inventory>(DynamicLoadObject("TNMItems.Beans", class'Class', False)); //== Same as Soy Food, really
				Consumables[1] = Class<Inventory>(DynamicLoadObject("TNMItems.KetchupBar", class'Class', False)); //== Worse than Candy, but thematically appropriate
				Consumables[2] = Class<Inventory>(DynamicLoadObject("TNMItems.TNMVialCrack", class'Class', False)); //== Just a different name for Zyme.  Meh.
				Consumables[3] = Class<Inventory>(DynamicLoadObject("TNMItems.PlasticCoffee", class'Class', False)); //== Arguably more useful than smokes.  Probably an even tradeoff in Shifter
			}
	
			if(testRandom <= 15) //Credits
			{
				Contents = Class'Credits';
				//Contents.Count = 1 + rand(30);
			}
			i = Rand(7);
			switch(i)
			{
				case 2:
				case 3:
					Contents = Consumables[Rand(4)];
					break;
				case 4:
				case 5:
					Contents = Consumables[i];
					break;
			}
		}
	}

	

}


function Loot(Actor Frobber)
{
	local class<Inventory> tempClass;
	local Inventory tempItem;
	local DeusExPickup invItem;
	local DeusExPlayer player;
	local DeusExWeapon W;
	local bool bPickedItemUp;
	local ammo AmmoType;
	local int itemCount;

	player = DeusExPlayer(Frobber);

	if(player != None)
	{
		bLooted = True;

		if(Contents != None)
		{
			tempClass = Contents;
			if (Content2!=None && FRand()<0.3) tempClass = Content2;
			if (Content3!=None && FRand()<0.3) tempClass = Content3;

			//== Clear out the contents so we don't double-dip by opening and then destroying
			Contents = None;
			Content2 = None;
			Content3 = None;

			tempItem = spawn(tempClass, player);

			if(tempItem.IsA('Credits'))
			{
				itemCount = 1 + Rand(30);
				player.Credits += itemCount;
				player.ClientMessage(Sprintf(Credits(tempItem).msgCreditsAdded, itemCount));
				AddReceivedItem(player, tempItem, itemCount);
				tempItem.Destroy();
				bPickedItemUp = True;
			}
			else if (tempItem.IsA('DeusExWeapon'))   // I *really* hate special cases
			{
				// Okay, check to see if the player already has this weapon.  If so,
				// then just give the ammo and not the weapon.  Otherwise give
				// the weapon normally. 
				W = DeusExWeapon(player.FindInventoryType(tempItem.Class));

				// If the player already has this item in his inventory, piece of cake,
				// we just give him the ammo.  However, if the Weapon is *not* in the 
				// player's inventory, first check to see if there's room for it.  If so,
				// then we'll give it to him normally.  If there's *NO* room, then we 
				// want to give the player the AMMO only (as if the player already had 
				// the weapon).

				if ((W != None) || ((W == None) && (!player.FindInventorySlot(tempItem, True))) && !bPickedItemUp)
				{
					if(Weapon(tempItem) != None)
					{
						if ((Weapon(tempItem).AmmoType != None || W.AmmoType != None))
						{
							if((Weapon(tempItem).AmmoType.AmmoAmount > 0 || W.AmmoType.AmmoAmount > 0))
							{
								AmmoType = Ammo(player.FindInventoryType(Weapon(tempItem).AmmoName));

								if(AmmoType == None)
									AmmoType = Ammo(Player.FindInventoryType(W.AmmoName));

                        					if ((AmmoType != None))
								{
									if(AmmoType.AmmoAmount < AmmoType.MaxAmmo)
									{
		                           					AmmoType.AddAmmo(Weapon(tempItem).PickupAmmoCount);
	
										if(tempItem.IsA('WeaponShuriken'))
											AddReceivedItem(player, tempItem, Weapon(tempItem).PickupAmmoCount);
										else if(tempItem.IsA('WeaponCombatKnife'))
											AddReceivedItem(player, tempItem, 1);
										else
							                           	AddReceivedItem(player, AmmoType, Weapon(tempItem).PickupAmmoCount);
	                           
										// Update the ammo display on the object belt
										player.UpdateAmmoBeltText(AmmoType);
	
										// if this is an illegal ammo type, use the weapon name to print the message
										/*if (AmmoType.PickupViewMesh == Mesh'TestBox')
											player.ClientMessage(tempItem.PickupMessage @ tempItem.itemArticle @ tempItem.itemName, 'Pickup');
										else
											player.ClientMessage(AmmoType.PickupMessage @ AmmoType.itemArticle @ AmmoType.itemName, 'Pickup');*/
	
										// Mark it as 0 to prevent it from being added twice
										Weapon(tempItem).AmmoType.AmmoAmount = 0;
									}
								}
							}
						}
					}

					// Print a message "Cannot pickup blah blah blah" if inventory is full
					// and the player can't pickup this weapon, so the player at least knows
					// if he empties some inventory he can get something potentially cooler
					// than he already has. 
					if ((W == None) && (!player.FindInventorySlot(tempItem, True)))
					{
						player.ClientMessage(Sprintf(Player.InventoryFull, tempItem.itemName));
					}

					bPickedItemUp = True;
				}
			}
			else if(Ammo(tempItem) != None)
			{
				tempItem.InitialState='Idle2';
				tempItem.GiveTo(player);
				tempItem.setBase(player);
				player.UpdateAmmoBeltText(Ammo(tempItem));
				//player.ClientMessage(tempitem.PickupMessage @ tempitem.itemArticle @ tempitem.itemName, 'Pickup');
				AddReceivedItem(player, tempItem, Ammo(tempItem).AmmoAmount);
				bPickedItemUp = True;
			}

			if (!bPickedItemUp)
			{
				// Special case if this is a DeusExPickup(), it can have multiple copies
				// and the player already has it.

				if ((tempItem.IsA('DeusExPickup')) && (DeusExPickup(tempItem).bCanHaveMultipleCopies) && (player.FindInventoryType(tempItem.class) != None))
				{
					invItem   = DeusExPickup(player.FindInventoryType(tempItem.class));
					itemCount = DeusExPickup(tempItem).numCopies;

					// Make sure the player doesn't have too many copies
					if ((invItem.MaxCopies > 0) && (DeusExPickup(tempItem).numCopies + invItem.numCopies > invItem.MaxCopies))
					{	
						// Give the player the max #
						if ((invItem.MaxCopies - invItem.numCopies) > 0)
						{
							itemCount = (invItem.MaxCopies - invItem.numCopies);
							DeusExPickup(tempItem).numCopies -= itemCount;
							invItem.numCopies = invItem.MaxCopies;
							invItem.TransferSkin(tempItem);
							//player.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
							AddReceivedItem(player, invItem, itemCount);
						}
						else
						{
							player.ClientMessage(ContainerDiscard @ tempItem.itemArticle @ tempItem.itemName, 'Pickup');
						}
					}
					else
					{
						invItem.numCopies += itemCount;
						invItem.TransferSkin(tempItem);
						tempItem.Destroy();

						//player.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
						AddReceivedItem(player, invItem, itemCount);
					}
				}
				else
				{
					// check if the pawn is allowed to pick this up
					if ((Player.Inventory == None) || (Level.Game.PickupQuery(Player, tempItem)))
					{
						Player.FrobTarget = tempItem;
						if (Player.HandleItemPickup(tempItem) != False)
						{
           						//DeleteInventory(item);

							// Show the item received in the ReceivedItems window and also 
							// display a line in the Log
							AddReceivedItem(player, tempItem, 1);

							if(Weapon(tempItem) != None)
							{
								if(Weapon(tempItem).PickupAmmoCount <= 0 && Weapon(tempItem).Default.PickupAmmoCount > 0)
									Weapon(tempItem).PickupAmmoCount = 1;

								if(Weapon(tempItem).AmmoType != None && Weapon(tempItem).AmmoName != Class'AmmoNone')
								{
									if(Weapon(tempItem).AmmoType.Icon != Weapon(tempItem).Icon && Weapon(tempItem).AmmoType.Icon != None)
										AddReceivedItem(player, Weapon(tempItem).AmmoType, Weapon(tempItem).PickupAmmoCount);
									else //== For weapons like the shuriken we just add to the weapon pickup count
										AddReceivedItem(player, Weapon(tempItem), Weapon(tempItem).PickupAmmoCount - 1);
								}
							}
							
							//player.ClientMessage(tempItem.PickupMessage @ tempItem.itemArticle @ tempItem.itemName, 'Pickup');
							PlaySound(tempItem.PickupSound);

						}
					}
					else
					{
						player.ClientMessage(ContainerDiscard @ tempItem.itemArticle @ tempItem.itemName, 'Pickup');
					}
				}
			}
		}
		else
			player.ClientMessage(ContainerEmpty);
	}
}

function AddReceivedItem(DeusExPlayer player, Inventory item, int count)
{
	local DeusExWeapon w;
	local Inventory altAmmo;

	/*if (!bSearchMsgPrinted)
	{
		player.ClientMessage(ContainerFound);
		bSearchMsgPrinted = True;
	}*/

 	DeusExRootWindow(player.rootWindow).hud.receivedItems.AddItem(item, count);

	// Make sure the object belt is updated
	if (item.IsA('Ammo'))
		player.UpdateAmmoBeltText(Ammo(item));
	else
		player.UpdateBeltText(item);
}

//
// copied from Engine.Decoration
//
function Destroyed()
{
	local actor dropped;
	local class<actor> tempClass;
	local int i;
	local Rotator rot;
	local Vector loc;
	local TrashPaper trash;
	local Rat vermin;

	// trace down to see if we are sitting on the ground
	loc = vect(0,0,0);
	loc.Z -= CollisionHeight + 8.0;
	loc += Location;

	// only generate trash if we are on the ground
	if (!FastTrace(loc) && bGenerateTrash)
	{
		// maybe spawn some paper
		for (i=0; i<4; i++)
		{
			if (FRand() < 0.75)
			{
				loc = Location;
				loc.X += (CollisionRadius / 2) - FRand() * CollisionRadius;
				loc.Y += (CollisionRadius / 2) - FRand() * CollisionRadius;
				loc.Z += (CollisionHeight / 2) - FRand() * CollisionHeight;
				trash = Spawn(class'TrashPaper',,, loc);
				if (trash != None)
				{
					trash.SetPhysics(PHYS_Rolling);
					trash.rot = RotRand(True);
					trash.rot.Yaw = 0;
					trash.dir = VRand() * 20 + vect(20,20,0);
					trash.dir.Z = 0;
				}
			}
		}

		// maybe spawn a rat
		if (FRand() < 0.5)
		{
			loc = Location;
			loc.Z -= CollisionHeight;
			vermin = Spawn(class'Rat',,, loc);
			if (vermin != None)
				vermin.bTransient = true;
		}
	}

	if( (Pawn(Base) != None) && (Pawn(Base).CarriedDecoration == self) )
		Pawn(Base).DropDecoration();
	if( (Contents!=None) && !Level.bStartup )
	{
		tempClass = Contents;
		if (Content2!=None && FRand()<0.3) tempClass = Content2;
		if (Content3!=None && FRand()<0.3) tempClass = Content3;

		for (i=0; i<numThings; i++)
		{
			loc = Location+VRand()*CollisionRadius;
			loc.Z = Location.Z;
			rot = rot(0,0,0);
			rot.Yaw = FRand() * 65535;
			dropped = Spawn(tempClass,,, loc, rot);
			if (dropped != None)
			{
				if(dropped.IsA('Credits'))
					Credits(dropped).numCredits = 1 + Rand(30);

				dropped.RemoteRole = ROLE_DumbProxy;
				dropped.SetPhysics(PHYS_Falling);
				dropped.bCollideWorld = true;
				dropped.Velocity = VRand() * 50;
				if ( inventory(dropped) != None )
					inventory(dropped).GotoState('Pickup', 'Dropped');
			}
		}
	}

	Super.Destroyed();
}

defaultproperties
{
     numThings=1
     bFlammable=True
     bCanBeBase=True
     bLooted=False
     ContainerEmpty="You don't find anything"
     ContainerDiscard="You discarded"
     ContainerFound="You found:"
}
