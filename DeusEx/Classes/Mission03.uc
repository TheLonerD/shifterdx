//=============================================================================
// Mission03.
//=============================================================================
class Mission03 expands MissionScript;

var localized String VoIPText, VoIPTText, VoIPNText, VoIPJoin;
var String VoIPNumber;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local Terrorist T;
	local BlackHelicopter chopper;
	local SecurityBot3 bot;
	local PaulDenton Paul;
	local SecurityCamera cam;
	local AutoTurret turret;
	local GuntherHermann Gunther;
	local UNATCOTroop troop;
	local ComputerPersonal comp;
	local int count;
	local Inventory item;
	local float txPos;
	local vector loc;
	local Class<Actor> spawnclass;
	local name tname;
	local Phone aPhone;

	Super.FirstFrame();

	if (localURL == "03_NYC_AIRFIELDHELIBASE")
	{
		// delete terrorists and unhide reinforcements
		if (flags.GetBool('MeetLebedev_Played') ||
			flags.GetBool('JuanLebedev_Dead'))
		{
			foreach AllActors(class'Terrorist', T)
				T.Destroy();

			foreach AllActors(class'SecurityBot3', bot)
				bot.Destroy();

			foreach AllActors(class'UNATCOTroop', troop, 'UNATCOTroop')
				troop.EnterWorld();

			//== All the phones should now play the "locked" message
			foreach AllActors(class'Phone', aPhone)
				aPhone.AnswerSound = AS_Locked;

			//== clear the VoIP conversation if we didn't hear it already
			if(flags.GetBool('M03ConversationAdded'))
			{
				foreach AllActors(class'ComputerPersonal', comp)
				{
					for(count = 0; count < 4; count++)
					{
						if(comp.specialOptions[count].Text == VoIPText)
						{
							comp.specialOptions[count].Text = "";
							comp.specialOptions[count].TriggerEvent = '';
							if(count < 3)
							{
								if(comp.specialOptions[count + 1].Text != "")
								{
									comp.specialOptions[count].bAlreadyTriggered = True;
									comp.specialOptions[count].Text = VoIPNText;
								}
							}
						}
					}
				}
			}
		}
		else if(!flags.GetBool('M03_Helibase_Phones_Active'))
		{
			count = 0;
			foreach AllActors(class'Phone', aPhone)
			{
				//== There's a phone in a rather secure part of the helibase we can use for the lebedev convo
				if(count == 1)
				{
					aPhone.AnswerSound = AS_Dialtone;
					aPhone.DialEvent = 'LebVoIP';
					aPhone.validNumber = "658????"; // The question marks indicate random-gen numbers
					aPhone.CleanValidNumber(); // Clean the code (and randomly generate the last four digits)
					VoIPNumber = aPhone.validNumber; // So the status message can track the new valid code
					aPhone.bEventOnlyOnce = True;
				}
				else
					aPhone.AnswerSound = AS_Unrecognized;

				count++;

				flags.SetBool('M03_Helibase_Phones_Active', True);
			}
		}
	}
	else if (localURL == "03_NYC_AIRFIELD")
	{
		// delete terrorists and unhide reinforcements and unhide the helicopter
		// also, turn off all security cameras
		if (flags.GetBool('MeetLebedev_Played') ||
			flags.GetBool('JuanLebedev_Dead'))
		{
			foreach AllActors(class'Terrorist', T)
				T.Destroy();

			foreach AllActors(class'SecurityBot3', bot)
				bot.Destroy();

			foreach AllActors(class'UNATCOTroop', troop, 'UNATCOTroop')
				troop.EnterWorld();

			foreach AllActors(class'BlackHelicopter', chopper)
				chopper.EnterWorld();

			foreach AllActors(class'SecurityCamera', cam)
				cam.UnTrigger(None, None);

			foreach AllActors(class'AutoTurret', turret)
				turret.UnTrigger(None, None);

			foreach AllActors(class'GuntherHermann', Gunther)
				Gunther.EnterWorld();
		}
	}
	else if (localURL == "03_NYC_HANGAR")
	{
		// delete terrorists and unhide reinforcements
		if (flags.GetBool('MeetLebedev_Played') ||
			flags.GetBool('JuanLebedev_Dead'))
		{
			foreach AllActors(class'Terrorist', T)
				T.Destroy();

			foreach AllActors(class'SecurityBot3', bot)
				bot.Destroy();

			foreach AllActors(class'PaulDenton', Paul)
				Paul.Destroy();

			foreach AllActors(class'UNATCOTroop', troop, 'UNATCOTroop')
				troop.EnterWorld();
		}
	}
	else if (localURL == "03_NYC_747")
	{
		// delete terrorists
		if (flags.GetBool('MeetLebedev_Played') ||
			flags.GetBool('JuanLebedev_Dead'))
		{
			foreach AllActors(class'Terrorist', T)
				T.Destroy();

			foreach AllActors(class'SecurityBot3', bot)
				bot.Destroy();
		}
	}
	else if (localURL == "03_NYC_UNATCOHQ")
	{
		count = 0;
		txPos = -384.0000;
		do
		{
			tname = flags.GetName(DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count));

			if(tname != '')
			{
				spawnclass = class<Inventory>(DynamicLoadObject("DeusEx."$ tname, class'Class'));

				item = Inventory(spawn(spawnclass, None));

				if(item.invSlotsX * item.invSlotsY > 4)
				{
					loc.X = -360 + (16 - Rand(32));
					loc.Y = 1074 + (item.CollisionRadius);
					loc.Z = 324 + (16 - Rand(24));
				}
				else
				{
					if(txPos + item.CollisionRadius >= -310.000)
						txPos = -384.0000;
	
					txPos += item.CollisionRadius;
	
					loc.X = txPos;
					loc.Y = 1062;
					loc.Z = 324 + (16 - (frand() * 24));
				}

				item.SetLocation(loc);

				flags.DeleteFlag(DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count), FLAG_Name);

				//== Now we need to handle all the weapon mods, if applicable
				if(item.IsA('DeusExWeapon'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_bHasLaser");
					if(DeusExWeapon(item).bCanHaveLaser)
						DeusExWeapon(item).bHasLaser = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_bHasSilencer");
					if(DeusExWeapon(item).bCanHaveSilencer)
						DeusExWeapon(item).bHasSilencer = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_bHasScope");
					if(DeusExWeapon(item).bCanHaveScope)
						DeusExWeapon(item).bHasScope = flags.GetBool(tname);
					flags.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModBaseAccuracy");
					if(DeusExWeapon(item).bCanHaveModBaseAccuracy)
					{
						DeusExWeapon(item).ModBaseAccuracy = flags.GetFloat(tname);
						if(DeusExWeapon(item).Default.BaseAccuracy == 0.0)
							DeusExWeapon(item).BaseAccuracy = 0.0 - DeusExWeapon(item).ModBaseAccuracy;
						else
							DeusExWeapon(item).BaseAccuracy = DeusExWeapon(item).Default.BaseAccuracy - (DeusExWeapon(item).Default.BaseAccuracy * DeusExWeapon(item).ModBaseAccuracy);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModReloadCount");
					if(DeusExWeapon(item).bCanHaveModReloadCount)
					{
						DeusExWeapon(item).ModReloadCount = flags.GetFloat(tname);
						DeusExWeapon(item).ReloadCount = DeusExWeapon(item).Default.ReloadCount + Int(FMax(Float(DeusExWeapon(item).Default.ReloadCount) * DeusExWeapon(item).ModReloadCount, 1.0));
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModAccurateRange");
					if(DeusExWeapon(item).bCanHaveModAccurateRange)
					{
						DeusExWeapon(item).ModAccurateRange = flags.GetFloat(tname);
						DeusExWeapon(item).AccurateRange = DeusExWeapon(item).Default.AccurateRange + (DeusExWeapon(item).Default.AccurateRange * DeusExWeapon(item).ModAccurateRange);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModReloadTime");
					if(DeusExWeapon(item).bCanHaveModReloadTime)
					{
						DeusExWeapon(item).ModReloadTime = flags.GetFloat(tname);
						DeusExWeapon(item).ReloadTime = FMax(DeusExWeapon(item).Default.ReloadTime + (DeusExWeapon(item).Default.ReloadTime * DeusExWeapon(item).ModReloadTime), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModRecoilStrength");
					if(DeusExWeapon(item).bCanHaveModRecoilStrength)
					{
						DeusExWeapon(item).ModRecoilStrength = flags.GetFloat(tname);
						DeusExWeapon(item).RecoilStrength = FMax(DeusExWeapon(item).Default.RecoilStrength + (DeusExWeapon(item).Default.RecoilStrength * DeusExWeapon(item).ModRecoilStrength), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_ModShotTime");
					if(DeusExWeapon(item).bCanHaveModShotTime)
					{
						DeusExWeapon(item).ModShotTime = flags.GetFloat(tname);
						DeusExWeapon(item).ShotTime = FMax(DeusExWeapon(item).Default.ShotTime + (DeusExWeapon(item).Default.ShotTime * DeusExWeapon(item).ModShotTime), 0.0);
					}
					flags.DeleteFlag(tname, FLAG_Float);
				}
				else if(item.IsA('AugmentationCannister'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_Aug1");
					AugmentationCannister(item).AddAugs[0] = flags.GetName(tname);
					flags.DeleteFlag(tname, FLAG_Name);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M01_JC_Item_"$ count $"_Aug2");
					AugmentationCannister(item).AddAugs[1] = flags.GetName(tname);
					flags.DeleteFlag(tname, FLAG_Name);
				}

				count++;
			}
			else
				item = None;

		}until(item == None);

		//== Clear out the snarky email if JC didn't leave anything heavy on the floor
		if(!flags.GetBool('M01_JC_LeftHeavyItemOnFloor'))
		{
			for(count = 0; count < 25; count++)
			{
				if(dxInfo.emailFrom[count] == "JanitDept")
				{
					dxInfo.emailFrom[count] = "";
					dxInfo.emailTo[count] = "";
					dxInfo.emailSubject[count] = "";
					dxInfo.emailCC[count] = "";
					dxInfo.emailString[count] = "";
				}

				if(emailFrom[count] == "JanitDept")
				{
					emailFrom[count] = "";
					emailTo[count] = "";
					emailSubject[count] = "";
					emailCC[count] = "";
					emailString[count] = "";
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
	local Inventory item;
	local int c;
	local name tname;

	Super.PreTravel();

	if(localURL == "03_NYC_UNATCOHQ")
	{
		c = 0;
		foreach AllActors(class'Inventory', item)
		{
			//== Introducing JC's storage locker, AKA his office
			if(item.Location.X <= 104.0000 && item.Location.X >= -432.0000 && item.Location.Y <= 1424.0000 && item.Location.Y >= 1018.0000 && item.Location.Z >= 232.0000 && item.Location.Z <= 400.0000 && !item.IsA('NanoKeyRing') && ScriptedPawn(item.Owner) == None && DeusExPlayer(item.Owner) == None)
			{
				tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c);

				//== For whatever reason, we have to set the flag like this
				Player.flagBase.SetName(tname, item.Class.Name);
				Player.flagBase.SetExpiration(tname, FLAG_Name, 5);

				if(item.invSlotsX * item.invSlotsY > 4 && item.Location.Z <= 270.000000 && item.Base == Level)
					Player.flagBase.SetBool('M03_JC_LeftHeavyItemOnFloor', True,, 6);

				if(item.IsA('DeusExWeapon'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_bHasLaser");
					Player.flagBase.SetBool(tname, True,, 5);
					if(!DeusExWeapon(item).bCanHaveLaser)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_bHasSilencer");
					Player.flagBase.SetBool(tname, True,, 5);
					if(!DeusExWeapon(item).bCanHaveSilencer)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_bHasScope");
					Player.flagBase.SetBool(tname, True,, 5);
					if(!DeusExWeapon(item).bCanHaveScope)
						Player.flagBase.DeleteFlag(tname, FLAG_Bool);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModBaseAccuracy");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModBaseAccuracy,, 5);
					if(!DeusExWeapon(item).bCanHaveModBaseAccuracy)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModReloadCount");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModReloadCount,, 5);
					if(!DeusExWeapon(item).bCanHaveModReloadCount)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModAccurateRange");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModAccurateRange,, 5);
					if(!DeusExWeapon(item).bCanHaveModAccurateRange)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModReloadTime");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModReloadTime,, 5);
					if(!DeusExWeapon(item).bCanHaveModReloadTime)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModRecoilStrength");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModRecoilStrength,, 5);
					if(!DeusExWeapon(item).bCanHaveModRecoilStrength)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_ModShotTime");
					Player.flagBase.SetFloat(tname, DeusExWeapon(item).ModShotTime,, 5);
					if(!DeusExWeapon(item).bCanHaveModShotTime)
						Player.flagBase.DeleteFlag(tname, FLAG_Float);

				}
				else if(item.IsA('AugmentationCannister'))
				{
					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_Aug1");
					Player.flagBase.SetName(tname, AugmentationCannister(item).AddAugs[0]);
					Player.flagBase.SetExpiration(tname, FLAG_Name, 5);

					tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c $"_Aug2");
					Player.flagBase.SetName(tname, AugmentationCannister(item).AddAugs[1]);
					Player.flagBase.SetExpiration(tname, FLAG_Name, 5);
				}

				c++;
			}
			//== Make a deliniating endpoint, in case someone comes back and takes/adds stuff
			tname = DeusExRootWindow(Player.rootWindow).StringToName("M03_JC_Item_"$ c);
			Player.flagBase.SetName(tname, '');
			Player.flagBase.SetExpiration(tname, FLAG_Name, 5);
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
	local WaltonSimons Walton;
	local AnnaNavarre Anna;
	local GuntherHermann Gunther;
	local JuanLebedev Juan;
	local TracerTong ttong;
	local JuanLebedevCarcass carc;
	local Hooker1 hook1;
	local ThugMale Thug;
	local ThugMale2 Thug2;
	local ThugMale3 Thug3;
	local ScriptedPawn pawn;
	local Terrorist T;
	local int count;
	local DeusExMover M;
	local bool bCarcFound, bJuanFound;
	local WeaponPistol pistol;
	local VendingMachine vend;
	local ConversationTrigger contrig;
	local ComputerPersonal comp;
	local FlagTrigger flagtrig;
	local Phone aPhone;

	Super.Timer();

	if (localURL == "03_NYC_UNATCOHQ")
	{
		// make Walton Simons walk to the cell
		if (!flags.GetBool('MS_SimonsWalking'))
		{
			if (flags.GetBool('SimonsOverheard_Played'))
			{
				foreach AllActors(class'WaltonSimons', Walton)
					Walton.SetOrders('GoingTo', 'SimonsInterrogating', True);

				flags.SetBool('MS_SimonsWalking', True,, 4);
			}
		}

		// set a flag when Walton Simons gets to his point
		if (!flags.GetBool('SimonsInterrogating'))
		{
			if (flags.GetBool('MS_SimonsWalking'))
			{
				foreach AllActors(class'WaltonSimons', Walton)
					if (Walton.IsInState('Standing'))
						flags.SetBool('SimonsInterrogating', True,, 4);
			}
		}

		// unlock a door when a flag is set
		if (!flags.GetBool('MS_MoverUnlocked') && flags.GetBool('UnlockDoor'))
		{
			foreach AllActors(class'DeusExMover', M, 'Manderley_Office')
			{
				M.bLocked = False;
				M.lockStrength = 0.0;
			}

			flags.SetBool('MS_MoverUnlocked', True,, 4);
		}

		if (flags.GetBool('AnnaAtDesk') &&
			!flags.GetBool('MS_AnnaDeskHome'))
		{
			foreach AllActors(class'AnnaNavarre', Anna)
				Anna.SetHomeBase(Anna.Location, Anna.Rotation);
			flags.SetBool('MS_AnnaDeskHome', True,, 4);
		}

		if (flags.GetBool('AnnaInOffice') &&
			!flags.GetBool('MS_AnnaOfficeHome'))
		{
			foreach AllActors(class'AnnaNavarre', Anna)
				Anna.SetHomeBase(Anna.Location, Anna.Rotation);
			flags.SetBool('MS_AnnaOfficeHome', True,, 4);
		}
	}
	else if (localURL == "03_NYC_AIRFIELDHELIBASE")
	{
		// check for Ambrosia Barrels being tagged
		if (!flags.GetBool('Barrel1Checked'))
		{
			if (flags.GetBool('HelicopterBaseAmbrosia'))
			{
				count = 1;
				if (flags.GetBool('BoatDocksAmbrosia'))
					count++;
				if (flags.GetBool('747Ambrosia'))
					count++;

				if (count == 1)
					Player.StartDataLinkTransmission("DL_TaggedOne");
				else if (count == 2)
					Player.StartDataLinkTransmission("DL_TaggedTwo");
				else if (count == 3)
					Player.StartDataLinkTransmission("DL_TaggedThree");
					
				flags.SetBool('Barrel1Checked', True,, 4);
			}
		}
		if(!flags.GetBool('M03ConversationAdded'))
		{
			do
			{
				//== Spawn Tracer so we get a name to the text
				ttong = Spawn(class'TracerTong', None,, vect(2650,-110,1435));
				if(ttong != None)
				{
					ttong.bInvincible = True;
					ttong.UnfamiliarName = "TT//UnderNet.0924.243.886"; //Give him an anonymous name (the one Alex knows him by)
					ttong.FamiliarName = "TT//UnderNet.0924.243.886";
					ttong.LeaveWorld();
				}
			}until(ttong != None);

			do
			{
				//== Same for Juan
				Juan = Spawn(class'JuanLebedev', None,, vect(2850,-110,1435));
				if(Juan != None)
				{
					Juan.bInvincible = True;
					Juan.UnfamiliarName = "juan//NYCNET.7786.786.658"; //Juan's name is the one Paul's bounced email was sent to, but corrected
					Juan.FamiliarName = "juan//NYCNET.7786.786.658";
					Juan.LeaveWorld();
				}
			}until(Juan != None);

			do
			{
				flagtrig = Spawn(class'FlagTrigger', None,, vect(0,0,-500));
				if(flagtrig != None)
				{
					flagtrig.flagName = 'LebConvoInit';
					flagtrig.flagValue = True;
					flagtrig.bSetFlag = True;
					flagtrig.flagExpiration = -1;
					flagtrig.Tag = 'LebVoIP';
				}
			}
			until(flagtrig != None);

			foreach AllActors(class'ComputerPersonal', comp)
			{
				if(comp.GetUserName(0) == "USER") //"etodd" for the other computer
				{
					for(count = 0; count < 4; count++)
					{
						if(comp.specialOptions[count].Text == "")
							break;
					}
	
					if(count < 4)
					{
						comp.specialOptions[count].Text = VoIPText;
						//comp.specialOptions[count].TriggerEvent = 'LebVoIP'; //Disabled due to new activation method
						comp.specialOptions[count].TriggerText = VoIPTText $ " " $ VoIPNumber;
						//comp.specialOptions[count].bTriggerOnceOnly = True;
						break;
					}
				}
			}

			flags.SetBool('M03ConversationAdded', true);
		}
		if(flags.GetBool('LebConvoInit'))
		{
			if(flags.GetBool('JuanLebedev_Dead') || flags.GetBool('MeetLebedev_Played'))
			{
				flags.SetBool('LebConvoInit', false);
				flags.SetBool('LebConvoPlaying', true);
			}
			else if(Player.CanStartConversation())
			{
				foreach AllActors(class'JuanLebedev', Juan)
					Juan.EnterWorld();

				foreach AllActors(class'TracerTong', ttong)
					ttong.EnterWorld();

				Player.ClientMessage(VoIPJoin);
				Player.StartConversationByName('OverhearLebedev', Player);
				flags.SetBool('LebConvoInit', false);
				flags.SetBool('LebConvoPlaying', true);
			}
		}

		if(flags.GetBool('LebConvoPlaying'))
		{
			if(Player.ConPlay == None)
			{
				foreach AllActors(class'JuanLebedev',Juan)
					Juan.LeaveWorld();

				foreach AllActors(class'TracerTong', ttong)
					ttong.LeaveWorld();

				foreach AllActors(class'ComputerPersonal', comp)
				{
					for(count = 0; count < 4; count++)
					{
						if(comp.specialOptions[count].Text == VoIPText)
						{
							comp.specialOptions[count].Text = "";
							comp.specialOptions[count].TriggerEvent = '';
							if(count < 3)
							{
								if(comp.specialOptions[count + 1].Text != "")
								{
									comp.specialOptions[count].bAlreadyTriggered = True;
									comp.specialOptions[count].Text = VoIPNText; //"No VoIP sessions currently active";
								}
							}
						}
					}
				}

				flags.SetBool('LebConvoPlaying', false);
			}
		}
	}
	else if (localURL == "03_NYC_AIRFIELD")
	{
		// check for Ambrosia Barrels being tagged
		if (!flags.GetBool('Barrel2Checked'))
		{
			if (flags.GetBool('BoatDocksAmbrosia'))
			{
				count = 1;
				if (flags.GetBool('HelicopterBaseAmbrosia'))
					count++;
				if (flags.GetBool('747Ambrosia'))
					count++;

				if (count == 1)
					Player.StartDataLinkTransmission("DL_TaggedOne");
				else if (count == 2)
					Player.StartDataLinkTransmission("DL_TaggedTwo");
				else if (count == 3)
					Player.StartDataLinkTransmission("DL_TaggedThree");
					
				flags.SetBool('Barrel2Checked', True,, 4);
			}
		}

		// unhide Gunther
		if (!flags.GetBool('MS_GuntherUnhidden'))
		{
			if (flags.GetBool('MeetLebedev_Played') ||
				flags.GetBool('JuanLebedev_Dead'))
			{
				foreach AllActors(class'GuntherHermann', Gunther)
					Gunther.EnterWorld();
				flags.SetBool('MS_GuntherUnhidden', True,, 4);
			}
		}
	}
	else if (localURL == "03_NYC_747")
	{
		// check for Lebedev's death
		if (flags.GetBool('JuanLebedev_Dead') &&
			!flags.GetBool('MS_Anna747Unhidden'))
		{
			foreach AllActors(class'AnnaNavarre', Anna)
				Anna.EnterWorld();

			flags.SetBool('MS_Anna747Unhidden', True,, 4);
		}

		if(!flags.GetBool('M03_Magnum_Placed'))
		{
			foreach AllActors(class'WeaponPistol', pistol)
			{
				if(!flags.GetBool('M03_Magnum_Placed'))
				{
					Spawn(class'WeaponMagnum', None,, pistol.Location, pistol.Rotation);
					pistol.Destroy();
					flags.SetBool('M03_Magnum_Placed', true);
				}
			}
		}

		// check for Ambrosia Barrels being tagged
		if (!flags.GetBool('Barrel3Checked'))
		{
			if (flags.GetBool('747Ambrosia'))
			{
				count = 1;
				if (flags.GetBool('HelicopterBaseAmbrosia'))
					count++;
				if (flags.GetBool('BoatDocksAmbrosia'))
					count++;

				if (count == 1)
					Player.StartDataLinkTransmission("DL_TaggedOne");
				else if (count == 2)
					Player.StartDataLinkTransmission("DL_TaggedTwo");
				else if (count == 3)
					Player.StartDataLinkTransmission("DL_TaggedThree");
					
				flags.SetBool('Barrel3Checked', True,, 4);
			}
		}

		// unhide Anna
		if (!flags.GetBool('MS_AnnaUnhidden'))
		{
			if (flags.GetBool('MeetLebedev_Played') ||
				flags.GetBool('JuanLebedev_Dead'))
			{
				foreach AllActors(class'AnnaNavarre', Anna)
				{
					Anna.EnterWorld();

					//== Anna gets a pistol and some explosive ammo, with which to blow shit up
					pistol = spawn(class'WeaponPistol',None);
					if(pistol != None)
					{
						pistol.InitialState='Idle2';
						pistol.GiveTo(Anna);
						pistol.SetBase(Anna);

						pistol.AmmoType = spawn(class'Ammo10mmEX',Anna);
						if(pistol.AmmoType != None)
						{
							pistol.AmmoType.InitialState='Idle2';
							pistol.AmmoType.GiveTo(Anna);
							pistol.AmmoType.SetBase(Anna);
							pistol.AmmoType.AmmoAmount += 45;
						}
					}
				}
				flags.SetBool('MS_AnnaUnhidden', True,, 4);
			}
		}

		// check to see if the player has killed Lebedev
		if (!flags.GetBool('PlayerKilledLebedev') &&
			!flags.GetBool('AnnaKilledLebedev'))
		{
			bCarcFound = False;
			foreach AllActors(class'JuanLebedevCarcass', carc)
			{
				bCarcFound = True;

				if ((carc.KillerBindName == "JCDenton") || (carc.KillerBindName == ""))
				{
					Player.GoalCompleted('AssassinateLebedev');
					flags.SetBool('PlayerKilledLebedev', True,, 6);
				}
				else if (carc.KillerBindName == "AnnaNavarre")
					flags.SetBool('AnnaKilledLebedev', True,, 6);
				else
					flags.SetBool('JuanLebedev_Dead', True,, 0);
			}

			bJuanFound = False;
			foreach AllActors(class'JuanLebedev', Juan)
			{
				if(!flags.GetBool('M03_Juan_Neutral'))
				{
					Juan.ChangeAlly('Player',0,false);
					flags.SetBool('M03_Juan_Neutral',True);
				}

				bJuanFound = True;
			}

			if (!bCarcFound && !bJuanFound && flags.GetBool('JuanLebedev_Dead'))
				flags.SetBool('PlayerKilledLebedev', True,, 6);
		}
	}
	else if (localURL == "03_NYC_MOLEPEOPLE")
	{
		// set a flag when there are less than 4 mole people alive
		if (!flags.GetBool('MolePeopleSlaughtered'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'MolePeople')
				count++;

			if (count < 4)
				flags.SetBool('MolePeopleSlaughtered', True,, 4);
		}

		// set a flag when there are less than 3 terrorists alive
		if (!flags.GetBool('MoleTerroristsDefeated'))
		{
			count = 0;
			foreach AllActors(class'Terrorist', T, 'MoleTerrorist')
				count++;

			if (count < 3)
				flags.SetBool('MoleTerroristsDefeated', True,, 4);
		}
	}
	else if (localURL == "03_NYC_BROOKLYNBRIDGESTATION")
	{
		//== Make sure that El Ray and his ho (and his rival) are neutral
		if(!flags.GetBool('JugHeads_Neutral'))
		{
			foreach AllActors(class'ThugMale', Thug)
				Thug.bLikesNeutral = False;

			foreach AllActors(class'Hooker1', hook1)
				hook1.bLikesNeutral = False;

			foreach AllActors(class'ThugMale3', Thug3)
				Thug3.bLikesNeutral = False;

			flags.SetBool('JugHeads_Neutral', True,, 4);
		}

		// set a flag when the gang's all dead
		if (!flags.GetBool('JugHeadGangDefeated'))
		{
			count = 0;
			foreach AllActors(class'ThugMale2', Thug2, 'ThugMale2')
				 count++;

			 if (count == 0)
				flags.SetBool('JugHeadGangDefeated', True,, 4);
		}
		if(!flags.GetBool('VendingSwitched'))
		{
			foreach AllActors(class'VendingMachine', vend)
			{
				if(vend.Skin == Texture'VendingMachineTex1' || vend.SkinColor == SC_Drink)
				{
					vend.VendProductName = (Class'Liquor40oz').Default.ItemName;
					vend.VendProduct = Class'Liquor40oz';
					vend.cost = 4;
					flags.SetBool('VendingSwitched', True,, 4);
					break;
				}
			}
		}
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    VoIPText="Display VoIP status and details"
    VoIPTText="VoIP session active on telephony node"
    VoIPNText="No VoIP sessions currently active"
    VoIPJoin="VoIP socket connection established via datalink"
    VoIPNumber="5839009"
    emailSubject(0)="Please help us keep your office clean"
    emailFrom(0)="JanitDept"
    emailTo(0)="JCD"
    emailString(0)="Agent Denton,|n|n     Welcome to UNATCO!  Allow me to introduce myself: I'm Dan, the head of Janitorial Services here at HQ.|n|n     Let me cut to the chase: the Janitorial Services Department is not as well-equipped as I would like it.  Rather than the industrial cleaning robots you find in the private sector, we're only able to get the basic model.  ('Budget considerations', Manderley says)  This model has no real pushing power and is impossible to reprogram.  If anybody leaves something heavier than a desk chair on the floor the little things burn out trying to push it out of the way to clean, which is exactly what happened in your office.  Three of our cleaning bots had to have their drive motors replaced after trying to push that... thing up against the shelf in your office.|n|n     As this happened on your first day I can't blame you for not knowing, but in the future please try not to leave anything heavy on the floor of your office.|n|n|nThanks,|n|nDaniel Matsuma|nHead of Janitorial Services"
