//=============================================================================
// Mission01.
//=============================================================================
class Mission01 expands MissionScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local PaulDenton Paul;
	local UNATCOTroop troop;
	local TerroristCommander cmdr;

	Super.FirstFrame();

	if (localURL == "01_NYC_UNATCOISLAND")
	{
		// delete Paul and company after final briefing
		if (flags.GetBool('M02Briefing_Played'))
		{
			foreach AllActors(class'PaulDenton', Paul)
				Paul.Destroy();
			foreach AllActors(class'UNATCOTroop', troop, 'custodytroop')
				troop.Destroy();
			foreach AllActors(class'TerroristCommander', cmdr, 'TerroristCommander')
				cmdr.Destroy();
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
	local Inventory item;
	local int c;
	local name tname;

	Super.PreTravel();

	if(localURL == "01_NYC_UNATCOHQ")
	{
		c = 0;
		foreach AllActors(class'Inventory', item)
		{
			//== Introducing JC's storage locker, AKA his office
			if(item.Location.X <= 104.0000 && item.Location.X >= -432.0000 && item.Location.Y <= 1424.0000 && item.Location.Y >= 1018.0000 && item.Location.Z >= 232.0000 && item.Location.Z <= 400.0000 && !item.IsA('NanoKeyRing') && ScriptedPawn(item.Owner) == None && DeusExPlayer(item.Owner) == None)
			{
				tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c);

				//== For whatever reason, we have to set the flag like this
				Player.flagBase.SetName(tname, item.Class.Name);
				Player.flagBase.SetExpiration(tname, FLAG_Name, 4);

				//== Check for heavy weapons left on the ground for snarky email purposes
				if(item.invSlotsX * item.invSlotsY > 4 && item.Location.Z <= 330.000000)
					Player.flagBase.SetBool('M01_JC_LeftHeavyItemOnFloor', True,, 6);

				if(item.IsA('DeusExWeapon'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_bHasLaser");
					Player.flagBase.SetBool(tname, True,, 4);
					if(!DeusExWeapon(item).bCanHaveLaser)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_bHasSilencer");
					Player.flagBase.SetBool(tname, True,, 4);
					if(!DeusExWeapon(item).bCanHaveSilencer)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_bHasScope");
					Player.flagBase.SetBool(tname, True,, 4);
					if(!DeusExWeapon(item).bCanHaveScope)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModBaseAccuracy");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModBaseAccuracy,, 4);
					if(!DeusExWeapon(item).bCanHaveModBaseAccuracy)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModReloadCount");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModReloadCount,, 4);
					if(!DeusExWeapon(item).bCanHaveModReloadCount)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModAccurateRange");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModAccurateRange,, 4);
					if(!DeusExWeapon(item).bCanHaveModAccurateRange)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModReloadTime");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModReloadTime,, 4);
					if(!DeusExWeapon(item).bCanHaveModReloadTime)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModRecoilStrength");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModRecoilStrength,, 4);
					if(!DeusExWeapon(item).bCanHaveModRecoilStrength)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_ModShotTime");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModShotTime,, 4);
					if(!DeusExWeapon(item).bCanHaveModShotTime)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

				}
				else if(item.IsA('AugmentationCannister'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_Aug1");
					Player.flagBase.SetName(tname, AugmentationCannister(item).AddAugs[0]);
					Player.flagBase.SetExpiration(tname, FLAG_Name, 4);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c $"_Aug2");
					Player.flagBase.SetName(tname, AugmentationCannister(item).AddAugs[1]);
					Player.flagBase.SetExpiration(tname, FLAG_Name, 4);
				}

				c++;
			}
			//== Make a deliniating endpoint, in case someone comes back and takes/adds stuff
			tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ c);
			Player.flagBase.SetName(tname, '');
			Player.flagBase.SetExpiration(tname, FLAG_Name, 4);
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
	local Terrorist T;
	local TerroristCarcass carc;
	local ScriptedPawn P;
	local SpawnPoint SP;
	local DeusExMover M;
	local PaulDenton Paul;
	local AutoTurret turret;
	local LaserTrigger laser;
	local SecurityCamera cam;
	local int count;
	local Inventory item, nextItem;
	local GuntherHermann gunther;

	Super.Timer();

	if (localURL == "01_NYC_UNATCOISLAND")
	{
		// count the number of dead terrorists
		if (!flags.GetBool('M01PlayerAggressive'))
		{
			count = 0;

			// count the living
			foreach AllActors(class'Terrorist', T)
				count++;

			// add the unconscious ones to the not dead count
			// there are 28 terrorists total on the island
			foreach AllActors(class'TerroristCarcass', carc)
			{
				if ((carc.KillerBindName == "JCDenton") && (carc.bNotDead || carc.itemName == "Unconscious"))
					count++;
				else if (carc.KillerBindName != "JCDenton")
					count++;
			}

			// if the player killed more than 5, set the flag
			if (count < 23)
				flags.SetBool('M01PlayerAggressive', True,, 6);		// don't expire until mission 6
		}

		if(flags.GetBool('GuntherRescued_Played'))
		{
			//== Gunther should always be equippable after we rescue him
			if(!flags.GetBool('M01_GuntherEquippable'))
			{
				foreach AllActors(class'GuntherHermann', gunther)
				{
					gunther.bCanGiveWeapon = True;
					flags.SetBool('M01_GuntherEquippable',True,,2);
				}
			}

			if(flags.GetBool('GuntherHermann_Equipped') && !flags.GetBool('GuntherRespectsPlayer') && !flags.GetBool('M01_GuntherGiveConvoReduxPlayed'))
			{
				//== Once we've given Gunther a gun (and if he hates us) play the "thanks" part of the rescue convo
				foreach AllActors(class'GuntherHermann', gunther)
				{
					if(Player.StartConversationByName('GuntherRescued', gunther, False, False, "GiveSpeech"))
						flags.SetBool('M01_GuntherGiveConvoReduxPlayed',True,,2);
				}
			}
		}

		// check for the leader being killed
		if (!flags.GetBool('MS_DL_Played'))
		{
			if (flags.GetBool('TerroristCommander_Dead'))
			{
				if (!flags.GetBool('DL_LeaderNotKilled_Played'))
					Player.StartDataLinkTransmission("DL_LeaderKilled");
				else
					Player.StartDataLinkTransmission("DL_LeaderKilledInSpite");

				flags.SetBool('MS_DL_Played', True,, 2);
			}
		}

		// check for player not killing leader
		if (!flags.GetBool('PlayerAttackedStatueTerrorist') &&
			flags.GetBool('MeetTerrorist_Played') &&
			!flags.GetBool('MS_DL2_Played'))
		{
			Player.StartDataLinkTransmission("DL_LeaderNotKilled");
			flags.SetBool('MS_DL2_Played', True,, 2);
		}

		// remove guys and move Paul
		if (!flags.GetBool('MS_MissionComplete'))
		{
			if (flags.GetBool('StatueMissionComplete'))
			{
				// open the HQ blast doors and unlock some other doors
				foreach AllActors(class'DeusExMover', M)
				{
					if (M.Tag == 'UN_maindoor')
					{
						M.bLocked = False;
						M.lockStrength = 0.0;
						M.Trigger(None, None);
					}
					else if ((M.Tag == 'StatueRuinDoors') || (M.Tag == 'temp_celldoor'))
					{
						M.bLocked = False;
						M.lockStrength = 0.0;
					}
				}

				// unhide the troop, delete the terrorists, Gunther, and teleport Paul
				foreach AllActors(class'ScriptedPawn', P)
				{
					if (P.IsA('UNATCOTroop') && (P.BindName == "custodytroop"))
						P.EnterWorld();
					else if (P.IsA('UNATCOTroop') && (P.BindName == "postmissiontroops"))
						P.EnterWorld();
					else if (P.IsA('ThugMale2') || P.IsA('SecurityBot3'))
						P.Destroy();
					else if (P.IsA('Terrorist') && (P.BindName != "TerroristCommander"))
					{
						// actually kill the terrorists instead of destroying them
						P.HealthTorso = 0;
						P.Health = 0;
						P.TakeDamage(1, P, P.Location, vect(0,0,0), 'Shot');

						// delete their inventories as well
						if (P.Inventory != None)
						{
							do
							{
								item = P.Inventory;
								nextItem = item.Inventory;
								P.DeleteInventory(item);
								item.Destroy();
								item = nextItem;
							}
							until (item == None);
						}
					}
					else if (P.BindName == "GuntherHermann")
						P.Destroy();
					else if (P.BindName == "PaulDenton")
					{
						SP = GetSpawnPoint('PaulTeleport');
						if (SP != None)
						{
							P.SetLocation(SP.Location);
							P.SetRotation(SP.Rotation);
							P.SetOrders('Standing',, True);
							P.SetHomeBase(SP.Location, SP.Rotation);
						}
					}
				}

				// delete all tagged turrets
				foreach AllActors(class'AutoTurret', turret)
					if ((turret.Tag == 'NSFTurret01') || (turret.Tag == 'NSFTurret02'))
						turret.Destroy();

				// delete all tagged lasertriggers
				foreach AllActors(class'LaserTrigger', laser, 'statue_lasertrap')
					laser.Destroy();

				// turn off all tagged cameras
				foreach AllActors(class'SecurityCamera', cam)
					if ((cam.Tag == 'NSFCam01') || (cam.Tag == 'NSFCam02') || (cam.Tag == 'NSFCam03'))
						cam.bNoAlarm = True;

				flags.SetBool('MS_MissionComplete', True,, 2);
			}
		}
	}
	else if (localURL == "01_NYC_UNATCOHQ")
	{
		// unhide Paul
		if (!flags.GetBool('MS_ReadyForBriefing'))
		{
			if (flags.GetBool('M01ReadyForBriefing'))
			{
				foreach AllActors(class'PaulDenton', Paul)
					Paul.EnterWorld();

				flags.SetBool('MS_ReadyForBriefing', True,, 2);
			}
		}

		//== If we come back to the map, we might take more stuff, so let's clear out the relevant "heavy" flag
		if(flags.GetBool('M01_JC_LeftHeavyItemOnFloor'))
			flags.SetBool('M01_JC_LeftHeavyItemOnFloor', False);
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
