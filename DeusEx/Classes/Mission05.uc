//=============================================================================
// Mission05.
//=============================================================================
class Mission05 extends MissionScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local PaulDentonCarcass carc;
	local PaulDenton Paul;
	local Terrorist T;
	local Inventory item, nextItem, inv;
	local SpawnPoint SP;
	local AnnaNavarre Anna;
	local DataCube dCube;
	local name tname;
	local int c;
	local Janitor dmatsuma;
	local float txPos, tyPos;
	local class<Actor> spawnclass;
	local vector loc;

	Super.FirstFrame();

	if (localURL == "05_NYC_UNATCOMJ12LAB")
	{
		// make sure this goal is completed
		Player.GoalCompleted('EscapeToBatteryPark');

		// delete Paul's carcass if he's still alive
		if (!flags.GetBool('PaulDenton_Dead'))
		{
			foreach AllActors(class'PaulDentonCarcass', carc)
			{
				carc.Destroy();
			}
		}
		else if(!flags.GetBool('M05_Blackjack_Placed'))
		{
			foreach AllActors(class'PaulDentonCarcass', carc)
			{
				//== We don't want to place a second one, do we?
				if(!flags.GetBool('M02_Blackjack_Placed'))
					carc.FrobItems[0] = Class'WeaponBlackjack';

				flags.SetBool('M05_Blackjack_Placed', true);
			}
		}

		// if the player has already talked to Paul, delete him
		if (flags.GetBool('M05PaulDentonDone') ||
			flags.GetBool('PlayerBailedOutWindow'))
		{
			foreach AllActors(class'PaulDenton', Paul)
				Paul.Destroy();
		}

		// if Miguel is not following the player, delete him
		if (flags.GetBool('MeetMiguel_Played') &&
			!flags.GetBool('MiguelFollowing'))
		{
			foreach AllActors(class'Terrorist', T)
				if (T.BindName == "Miguel")
					T.Destroy();
		}

		if(!flags.GetBool('Miguel_Equippable'))
		{
			foreach AllActors(class'Terrorist', T)
			{
				if (T.BindName == "Miguel")
				{
					T.bCanGiveWeapon = True;
					flags.SetBool('Miguel_Equippable', true);
				}
			}
		}

		//== There's a data cube that likes to fall through the level
		//==  let's spawn a new copy, only this time inside the level boundaries
		//==  Worst case scenario is there's a datacube on top of another
		if(!flags.GetBool('M05_Datacube_Replaced'))
		{
			dCube = spawn(class'DataCube', None,, vect(-279.169556,432.570007,-100.000000));
			dCube.textTag = '05_Datacube02';
			dCube.textPackage = "DeusExText";

			flags.SetBool('M05_Datacube_Replaced',True);
		}

		// remove the player's inventory and put it in a room
		// also, heal the player up to 50% of his total health
		if (!flags.GetBool('MS_InventoryRemoved'))
		{
			Player.HealthHead = Max(50, Player.HealthHead);
			Player.HealthTorso =  Max(50, Player.HealthTorso);
			Player.HealthLegLeft =  Max(50, Player.HealthLegLeft);
			Player.HealthLegRight =  Max(50, Player.HealthLegRight);
			Player.HealthArmLeft =  Max(50, Player.HealthArmLeft);
			Player.HealthArmRight =  Max(50, Player.HealthArmRight);
			Player.GenerateTotalHealth();

			//== There is an odd glitch with laser sights which can generate a "ghost" laser
			//==  so we need to force the laser off
			if(DeusExWeapon(Player.inHand) != None)
				DeusExWeapon(Player.inHand).LaserOff();

			if (Player.Inventory != None)
			{
				item      = Player.Inventory;
				nextItem  = None;

				foreach AllActors(class'SpawnPoint', SP, 'player_inv')
				{
					// Find the next item we can process.
					while((item != None) && (item.IsA('NanoKeyRing') || (!item.bDisplayableInv)))
						item = item.Inventory;

					if (item != None)
					{
						nextItem = item.Inventory;

						Player.DeleteInventory(item);

						item.DropFrom(SP.Location);

						// restore any ammo amounts for a weapon to default
						//  EXCEPT Grenades, etc. -- Y|yukichigai
						if (item.IsA('Weapon') && (Weapon(item).AmmoType != None) && !item.IsA('WeaponGrenade'))
							Weapon(item).PickupAmmoCount = Weapon(item).Default.PickupAmmoCount;
					}
					//== Finally, confiscate all the player's credits as well, then exit the loop.
					else
					{
						item = spawn(class'Credits',None,,SP.Location);
						Credits(item).numCredits = Player.Credits;
						Player.Credits = 0;

						break;
					}
					
					item = nextItem;
				}
			}
			
			flags.SetBool('MS_InventoryRemoved', True,, 6);
		}
	}
	else if (localURL == "05_NYC_UNATCOHQ")
	{
		if(!flags.GetBool('M05_AmmoDragon_Placed'))
		{
			if(spawn(class'AmmoDragon',None,, vect(836.209473,-1053.622070,-4.00)) != None)
				flags.SetBool('M05_AmmoDragon_Placed',True);
		}

		// if Miguel is following the player, unhide him
		if (flags.GetBool('MiguelFollowing'))
		{
			foreach AllActors(class'Terrorist', T)
			{
				if (T.BindName == "Miguel")
				{
					T.EnterWorld();
					T.bCanGiveWeapon = True;

					c = 0;

					do
					{
						tname = DeusExRootWindow(Player.rootWindow).StringToName("M05_Miguel_Item_"$ c);
						if(flags.GetName(tname) != '')
						{
							item = spawn(class<Inventory>(DynamicLoadObject("DeusEx."$ flags.GetName(tname), class'Class')),T);

							item.GiveTo(T);
							item.SetBase(T);

							if(DeusExWeapon(item) != None)
							{
					     			if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
					     			{
					     				Weapon(item).AmmoType = Ammo(T.FindInventoryType(Weapon(item).AmmoName));
					      				if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
					      				{
					      					Weapon(item).AmmoType = Ammo(T.FindInventoryType(Weapon(item).AmmoName));
					      					if (Weapon(item).AmmoType == None)
					      					{
											Weapon(item).AmmoType = spawn(Weapon(item).AmmoName,T);
					      					}
					      				}
									if(Weapon(item).AmmoType != None)
									{
										Weapon(item).AmmoType.InitialState='Idle2';
										Weapon(item).AmmoType.GiveTo(T);
										Weapon(item).AmmoType.SetBase(T);
									}
					     			}
								else if(Weapon(item).AmmoType != None && Weapon(item).AmmoType.AmmoAmount < 1)
									Weapon(item).AmmoType.AmmoAmount += (DeusExWeapon(item).AmmoName).default.AmmoAmount;
							}
							flags.DeleteFlag(tname, FLAG_Name);
						}
						else
							item = None;
					}
					until(item == None);
				}
			}
		}

		if(!flags.GetBool('M05_ModRoF_Placed'))
		{
			spawn(class'WeaponModAuto', None,, vect(1268.506104,-901.829224,63.520828));
			flags.SetBool('M05_ModRoF_Placed', True,, 6);
		}

		if(!flags.GetBool('M05_Janitor_Note_Placed'))
		{
			dCube = spawn(class'Datacube',None,, vect(-258.821838,1236.736450,287.50));
			if(dCube != None)
			{
				dCube.bAddToVault = False;
				flags.SetBool('M05_Janitor_Note_Placed',True,, 6);
			}
		}

		c = 0;
		if(flags.GetBool('M01_JC_LeftHeavyItemOnFloor'))
			c++;

		if(flags.GetBool('M03_JC_LeftHeavyItemOnFloor'))
			c++;

		//== Do not piss off the janitorial staff, or they will steal your stuff and kill you with it
		if(c >= 2 && flags.GetBool('M04_JC_LeftHeavyItemOnFloor') && !flags.GetBool('Beware_The_Angry_Janitor'))
		{
			dmatsuma = spawn(class'Janitor');
			if(dmatsuma != None)
			{
				dmatsuma.FamiliarName = "Daniel Matsuma";
				dmatsuma.BindName = "DanMatsuma";
				dmatsuma.setLocation(vect(-1478.937012, 712.059082, 575.173706));
				dmatsuma.SpeechTargetAcquired = Sound'DeusExSounds.Player.MaleLaugh';
				dmatsuma.ChangeAlly('Player', -1.0, true);

				//== The janitor fears NOTHING
				dmatsuma.bFearHacking = False;
				dmatsuma.bFearWeapon = False;
				dmatsuma.bFearShot = False;
				dmatsuma.bFearInjury = False;
				dmatsuma.bFearIndirectInjury = False;
				dmatsuma.bFearCarcass = False;
				dmatsuma.bFearDistress = False;
				dmatsuma.bFearAlarm = False;
				dmatsuma.bLookingForEnemy = True;
				dmatsuma.MinHealth = 20;

				//== The janitor is a skilled fighter
				dmatsuma.bCanStrafe = True;
				dmatsuma.bCanCrouch = True;
				dmatsuma.BaseAccuracy = 0.4;
				dmatsuma.RaiseAlarm = RAISEALARM_Never;
				dmatsuma.MaxRange = 1000.0000;
				dmatsuma.Health = 150;
				dmatsuma.HealthHead = 150;
				dmatsuma.HealthTorso = 150;
				dmatsuma.HealthLegLeft = 150;
				dmatsuma.HealthLegRight = 150;
				dmatsuma.HealthArmLeft = 150;
				dmatsuma.HealthArmRight = 150;

				item = Spawn(class'WeaponAssaultShotgun', dmatsuma);
				if(item != None)
				{
					item.InitialState='Idle2';
					item.SetBase(dmatsuma);
					item.GiveTo(dmatsuma);

					if(DeusExWeapon(item) != None)
					{
			     			if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
			     			{
			     				Weapon(item).AmmoType = Ammo(dmatsuma.FindInventoryType(Weapon(item).AmmoName));
			      				if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
			      				{
			      					Weapon(item).AmmoType = Ammo(dmatsuma.FindInventoryType(Weapon(item).AmmoName));
			      					if (Weapon(item).AmmoType == None)
			      					{
									Weapon(item).AmmoType = spawn(Weapon(item).AmmoName,dmatsuma);
			      					}
			      				}
							if(Weapon(item).AmmoType != None)
							{
								Weapon(item).AmmoType.InitialState='Idle2';
								Weapon(item).AmmoType.GiveTo(dmatsuma);
								Weapon(item).AmmoType.SetBase(dmatsuma);
								Weapon(item).AmmoType.AmmoAmount += 30;
							}
			     			}
						else if(Weapon(item).AmmoType != None && Weapon(item).AmmoType.AmmoAmount < 1)
							Weapon(item).AmmoType.AmmoAmount += 30;
					}
				}
				flags.SetBool('Beware_The_Angry_Janitor', True,, 6);
			}
		}

		if(dCube != None)
		{
			if(c >= 2 && flags.GetBool('M04_JC_LeftHeavyItemOnFloor'))
				dCube.SpecialText = emailString[3];
			else if(c >= 1)
				dCube.SpecialText = emailString[2];
			else
				dCube.SpecialText = emailString[1];		
		}

		//== Spawn all the stuff JC "stores" in his office
		c = 0;
		txPos = -394.0000;
		tyPos = 112.0000;
		do
		{
			tname = flags.GetName(DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c));

			if(tname != '')
			{
				spawnclass = class<Inventory>(DynamicLoadObject("DeusEx."$ tname, class'Class'));

				//== The positioning is a little different this time
				if(dmatsuma == None)
				{
					item = Inventory(spawn(spawnclass, None));
					if(item.invSlotsX * item.invSlotsY > 4)
					{
						loc.X = -360 + (16 - Rand(32));
						loc.Y = 208 - (item.CollisionRadius);
						loc.Z = 270 + (16 - Rand(24));
					}
					else
					{
						if(txPos + item.CollisionRadius >= -300.000)
						{
							txPos = -394.0000;
							tyPos += 20.0000;
						}
						if(tyPos >= 200.0000)
							tyPos = 112.00000;
		
						txPos += item.CollisionRadius;
		
						loc.X = txPos;
						loc.Y = tyPos;
						loc.Z = 270 + (16 - (frand() * 24));
					}

					item.SetLocation(loc);
				}
				else //== Like I said about the janitor: steal your stuff, kill you with it
				{
					if(dmatsuma.FindInventoryType(spawnclass) == None)
					{
						item = Inventory(spawn(spawnclass, dmatsuma));
						item.InitialState='Idle2';
						item.GiveTo(dmatsuma);
						item.SetBase(dmatsuma);
					}
					else
						item = dmatsuma.FindInventoryType(spawnclass);

					if(DeusExWeapon(item) != None)
					{
			     			if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
			     			{
			     				Weapon(item).AmmoType = Ammo(dmatsuma.FindInventoryType(Weapon(item).AmmoName));
			      				if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
			      				{
			      					Weapon(item).AmmoType = Ammo(dmatsuma.FindInventoryType(Weapon(item).AmmoName));
			      					if (Weapon(item).AmmoType == None)
			      					{
									Weapon(item).AmmoType = spawn(Weapon(item).AmmoName,dmatsuma);
			      					}
			      				}
							if(Weapon(item).AmmoType != None)
							{
								Weapon(item).AmmoType.InitialState='Idle2';
								Weapon(item).AmmoType.GiveTo(dmatsuma);
								Weapon(item).AmmoType.SetBase(dmatsuma);
							}
			     			}
						else if(Weapon(item).AmmoType != None && Weapon(item).AmmoType.AmmoAmount < 1)
							Weapon(item).AmmoType.AmmoAmount += (DeusExWeapon(item).AmmoName).default.AmmoAmount;
					}
				}

				flags.DeleteFlag(DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c), FLAG_Name);

				//== Now we need to handle all the weapon mods, if applicable
				if(item.IsA('DeusExWeapon'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_bHasLaser");
					if(DeusExWeapon(item).bCanHaveLaser)
						DeusExWeapon(item).bHasLaser = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_bHasSilencer");
					if(DeusExWeapon(item).bCanHaveSilencer)
						DeusExWeapon(item).bHasSilencer = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_bHasScope");
					if(DeusExWeapon(item).bCanHaveScope)
						DeusExWeapon(item).bHasScope = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModBaseAccuracy");
					if(DeusExWeapon(item).bCanHaveModBaseAccuracy)
					{
						DeusExWeapon(item).ModBaseAccuracy = flags.GetFloat(tname);
						if(DeusExWeapon(item).Default.BaseAccuracy == 0.0)
							DeusExWeapon(item).BaseAccuracy = 0.0 - DeusExWeapon(item).ModBaseAccuracy;
						else
							DeusExWeapon(item).BaseAccuracy = DeusExWeapon(item).Default.BaseAccuracy - (DeusExWeapon(item).Default.BaseAccuracy * DeusExWeapon(item).ModBaseAccuracy);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModReloadCount");
					if(DeusExWeapon(item).bCanHaveModReloadCount)
					{
						DeusExWeapon(item).ModReloadCount = flags.GetFloat(tname);
						DeusExWeapon(item).ReloadCount = DeusExWeapon(item).Default.ReloadCount + Int(FMax(Float(DeusExWeapon(item).Default.ReloadCount) * DeusExWeapon(item).ModReloadCount, 1.0));
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModAccurateRange");
					if(DeusExWeapon(item).bCanHaveModAccurateRange)
					{
						DeusExWeapon(item).ModAccurateRange = flags.GetFloat(tname);
						DeusExWeapon(item).AccurateRange = DeusExWeapon(item).Default.AccurateRange + (DeusExWeapon(item).Default.AccurateRange * DeusExWeapon(item).ModAccurateRange);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModReloadTime");
					if(DeusExWeapon(item).bCanHaveModReloadTime)
					{
						DeusExWeapon(item).ModReloadTime = flags.GetFloat(tname);
						DeusExWeapon(item).ReloadTime = FMax(DeusExWeapon(item).Default.ReloadTime + (DeusExWeapon(item).Default.ReloadTime * DeusExWeapon(item).ModReloadTime), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModRecoilStrength");
					if(DeusExWeapon(item).bCanHaveModRecoilStrength)
					{
						DeusExWeapon(item).ModRecoilStrength = flags.GetFloat(tname);
						DeusExWeapon(item).RecoilStrength = FMax(DeusExWeapon(item).Default.RecoilStrength + (DeusExWeapon(item).Default.RecoilStrength * DeusExWeapon(item).ModRecoilStrength), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_ModShotTime");
					if(DeusExWeapon(item).bCanHaveModShotTime)
					{
						DeusExWeapon(item).ModShotTime = flags.GetFloat(tname);
						DeusExWeapon(item).ShotTime = FMax(DeusExWeapon(item).Default.ShotTime + (DeusExWeapon(item).Default.ShotTime * DeusExWeapon(item).ModShotTime), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);
				}
				else if(item.IsA('AugmentationCannister'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_Aug1");
					AugmentationCannister(item).AddAugs[0] = flags.GetName(tname);
					flags.DeleteFlag(tname, FLAG_Name);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M04_JC_Item_"$ c $"_Aug2");
					AugmentationCannister(item).AddAugs[1] = flags.GetName(tname);
					flags.DeleteFlag(tname, FLAG_Name);
				}

				c++;
			}
			else
				item = None;

		}until(item == None);

		// make Anna not flee in this mission
		foreach AllActors(class'AnnaNavarre', Anna)
			Anna.MinHealth = 0;
	}
	else if (localURL == "05_NYC_UNATCOISLAND")
	{
		// if Miguel is following the player, unhide him
		if (flags.GetBool('MiguelFollowing'))
		{
			foreach AllActors(class'Terrorist', T)
			{
				if (T.BindName == "Miguel")
				{
					T.EnterWorld();
					T.bCanGiveWeapon = True;

					c = 0;

					do
					{
						tname = DeusExRootWindow(Player.rootWindow).StringToName("M05_Miguel_Item_"$ c);
						if(flags.GetName(tname) != '')
						{
							item = spawn(class<Inventory>(DynamicLoadObject("DeusEx."$ flags.GetName(tname), class'Class')),T);

							item.GiveTo(T);
							item.SetBase(T);

							if(DeusExWeapon(item) != None)
							{
					     			if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
					     			{
					     				Weapon(item).AmmoType = Ammo(T.FindInventoryType(Weapon(item).AmmoName));
					      				if ((Weapon(item).AmmoType == None) && (Weapon(item).AmmoName != None) && (Weapon(item).AmmoName != Class'AmmoNone'))
					      				{
					      					Weapon(item).AmmoType = Ammo(T.FindInventoryType(Weapon(item).AmmoName));
					      					if (Weapon(item).AmmoType == None)
					      					{
											Weapon(item).AmmoType = spawn(Weapon(item).AmmoName,T);
					      					}
					      				}
									if(Weapon(item).AmmoType != None)
									{
										Weapon(item).AmmoType.InitialState='Idle2';
										Weapon(item).AmmoType.GiveTo(T);
										Weapon(item).AmmoType.SetBase(T);
									}
					     			}
								else if(Weapon(item).AmmoType != None && Weapon(item).AmmoType.AmmoAmount < 1)
									Weapon(item).AmmoType.AmmoAmount += (DeusExWeapon(item).AmmoName).default.AmmoAmount;
							}
							flags.DeleteFlag(tname, FLAG_Name);
						}
						else
							item = None;
					}
					until(item == None);
				}
			}
		}
	}
}

// ----------------------------------------------------------------------
// PreTravel()
// 
// Set flags upon exit of a certain map
// ----------------------------------------------------------------------

function PreTravel()
{
	local Terrorist T;
	local Inventory item, nextItem;
	local name tname;
	local int c;

	Super.PreTravel();

	if (flags.GetBool('MiguelFollowing'))
	{
		foreach AllActors(class'Terrorist', T)
		{
			if (T.BindName == "Miguel")
			{
				item = T.Inventory;
				nextItem = None;
				c = 0;

				while(item != None)
				{
					nextItem = item.Inventory;
					if(item.IsA('DeusExWeapon') && !item.IsA('WeaponCombatKnife'))
					{
						tname = DeusExRootWindow(Player.rootWindow).StringToName("M05_Miguel_Item_"$ c);
						Player.flagBase.SetName(tname, item.Class.Name);
						Player.flagBase.SetExpiration(tname, FLAG_Name, 6);
						c++;

						T.DeleteInventory(item);
						item.Destroy();
					}
					item = nextItem;
				}
			}
		}
	}
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local AnnaNavarre Anna;
	local WaltonSimons Walton;
	local DeusExMover M;
	local VendingMachine V;
	local MIB mblack;
	local Inventory item;
	local Janitor dmatsuma;
	local AllianceTrigger altrig;

	Super.Timer();

	if (localURL == "05_NYC_UNATCOHQ")
	{
		// unlock a door
		if (flags.GetBool('CarterUnlock') &&
			!flags.GetBool('MS_DoorUnlocked'))
		{
			foreach AllActors(class'DeusExMover', M, 'supplydoor')
			{
				M.bLocked = False;
				M.lockStrength = 0.0;
			}

			flags.SetBool('MS_DoorUnlocked', True,, 6);
		}

		// kill Anna when a flag is set
		if (flags.GetBool('annadies') &&
			!flags.GetBool('MS_AnnaKilled'))
		{
			foreach AllActors(class'AnnaNavarre', Anna)
			{
				Anna.HealthTorso = 0;
				Anna.Health = 0;
				Anna.TakeDamage(1, Anna, Anna.Location, vect(0,0,0), 'Shot');
			}

			flags.SetBool('MS_AnnaKilled', True,, 6);
		}

		// make Anna attack the player after a convo is played
		if (flags.GetBool('M05AnnaAtExit_Played') &&
			!flags.GetBool('MS_AnnaAttacking'))
		{
			foreach AllActors(class'AnnaNavarre', Anna)
				Anna.SetOrders('Attacking', '', True);

			flags.SetBool('MS_AnnaAttacking', True,, 6);
		}

		// unhide Walton Simons
		if (flags.GetBool('simonsappears') &&
			!flags.GetBool('MS_SimonsUnhidden'))
		{
			foreach AllActors(class'WaltonSimons', Walton)
				Walton.EnterWorld();

			flags.SetBool('MS_SimonsUnhidden', True,, 6);
		}

		// hide Walton Simons
		if ((flags.GetBool('M05MeetManderley_Played') ||
			flags.GetBool('M05SimonsAlone_Played')) &&
			!flags.GetBool('MS_SimonsHidden'))
		{
			foreach AllActors(class'WaltonSimons', Walton)
				Walton.LeaveWorld();

			flags.SetBool('MS_SimonsHidden', True,, 6);
		}

		// mark a goal as completed
		if (flags.GetBool('KnowsAnnasKillphrase1') &&
			flags.GetBool('KnowsAnnasKillphrase2') &&
			!flags.GetBool('MS_KillphraseGoalCleared'))
		{
			Player.GoalCompleted('FindAnnasKillphrase');
			flags.SetBool('MS_KillphraseGoalCleared', True,, 6);
		}

		// clear a goal when anna is out of commision
		if (flags.GetBool('AnnaNavarre_Dead') &&
			!flags.GetBool('MS_EliminateAnna'))
		{
			Player.GoalCompleted('EliminateAnna');
			flags.SetBool('MS_EliminateAnna', True,, 6);
		}

		if(!flags.GetBool('VendingMachineSwapped')) //Add in the Skull Gun aug
		{
			foreach AllActors(class'VendingMachine',V)
			{
				if(V.Skin == Texture'VendingMachineTex1' || V.SkinColor == SC_Drink)
				{
					Spawn(class'VendingMachineSpec1', None,,V.Location,V.Rotation);
					V.Destroy();
					flags.SetBool('VendingMachineSwapped', True,, 6);
					break;
				}
			}
		}
	}
	else if (localURL == "05_NYC_UNATCOMJ12LAB")
	{
		// After the player talks to Paul, start a datalink
		if (!flags.GetBool('MS_DL_Played') &&
			flags.GetBool('PaulInMedLab_Played'))
		{
			Player.StartDataLinkTransmission("DL_Paul");
			flags.SetBool('MS_DL_Played', True,, 6);
		}
		if(!flags.GetBool('PaulDenton_Dead') && !flags.GetBool('SwordA_Placed'))
		{
			foreach AllActors(class'MIB',mblack)
			{
				item = spawn(Class'WeaponPrototypeSwordA', mblack);
				item.InitialState='Idle2';
				item.GiveTo(mblack);
				item.SetBase(mblack);
				flags.SetBool('SwordA_Placed', True,, 6);
				break;
			}
		}

		//== Once we modify the bot we don't want it to suddenly hate us if we break a window
		if(flags.GetBool('botmodified') && !flags.GetBool('M05_BotAlliance_Fixed'))
		{
			foreach AllActors(Class'AllianceTrigger', altrig, 'botorders')
			{
				altrig.Destroy();
				flags.SetBool('M05_BotAlliance_Fixed',True);
			}
		}
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     emailFrom(0)="JReyes"
     emailTo(0)="ghermann"
     emailSubject(0)="Augmentation shipment mixup"
     emailString(0)="Gunther,|n|n     Our latest supply shipment just came in, but your part of the shipment was missing.  Instead of an augmentation canister, the package contained a single can of lemon-lime soda.  I've already talked to the supply depot; they don't know what happened to the first shipment, but another is on the way.  It should be here in a few days.|n|n|nJaime"
     emailString(1)="Agent Denton,|n|n     My name is Dan Matsuma.  You don't know me, but I'm the head of Janitorial Services here.  (Was, anyway)  If you're reading this then my efforts weren't wasted.|n|n     You're a good man, Agent Denton, and I don't believe you're a traitor.  That the Coalition would brand you and your brother as such is the latest in a string of disturbing things I've seen.  Enough is enough.  Even janitors can make a stand for what's right.  I've managed to 're-direct' the stuff those goons confiscated from your office, and I've stashed it in the cleaning closet on this floor.  Hopefully some of it will be of help.|n|n     To set your mind at ease, Agent Denton, (and to anybody else reading this) I will be on my way out of the country by the time you read this note.  Consider this my official resignation.|n|n|nSincerely,|nDaniel Matsuma|n|nP.S. Manderley, if you're reading this, I was the one who blocked off your hidden safe.  I never bought that 'budget considerations' excuse, you prick."
     emailString(2)="Agent Denton,|n|n     Dan Matsuma here.  I know we've had our differences, but I write to you as a friend.  If you're reading this then my efforts weren't wasted.|n|n     Cleaning habits aside you're a good man, Agent Denton, and I don't believe you're a traitor.  That the Coalition would brand you and your brother as such is the latest in a string of disturbing things I've seen.  Enough is enough.  Even janitors can make a stand for what's right.  I've managed to 're-direct' the stuff those goons confiscated from your office, and I've stashed it in the cleaning closet on this floor.  Hopefully some of it will be of help.|n|n     To set your mind at ease, Agent Denton, (and to anybody else reading this) I will be on my way out of the country by the time you read this note.  Consider this my official resignation.|n|n|nSincerely,|nDaniel Matsuma|n|nP.S. Manderley, if you're reading this, I was the one who blocked off your hidden safe.  I never bought that 'budget considerations' excuse, you prick."
     emailString(3)="******* UNATCO INTERNAL MAIL AUTOMATED FORWARDING NOTICE|n|nTHIS PARCEL WAS RE-ROUTED TO THE MOST RECENT ADDRESS OF RECIPIENT 'JC Denton'.  IF YOU ARE NOT 'JC Denton' PLEASE CONTACT YOUR STATION POSTMASTER.|n|n******* END NOTICE|n|n|nDear Jackass,|n|n     Today Manderley told me my department is overbudget due to an increase in requisitions for cleaning bot drive motors.  'The money has to be made up somewhere', so now I'm working unpaid overtime for the next six months.  THANKS TO YOU.|n|n     As compensation I'm taking a few items from your office, and having this sent to your new office instead.  Maybe when this note arrives in Hong Kong instead of that giant whatever-it-is you'll think twice before tormenting the next janitorial staff unfortunate enough to be saddled with you.  If there were any justice in the world though, you'd be declared a traitor so I'd be legally allowed to shoot you.|n|n     Die in a fire.|n|n|nDaniel Matsuma,|nHead of Janitorial Services"
}
