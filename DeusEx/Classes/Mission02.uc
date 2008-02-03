//=============================================================================
// Mission02.
//=============================================================================
class Mission02 expands MissionScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local ScriptedPawn pawn;

	Super.FirstFrame();

	if (localURL == "02_NYC_STREET")
	{
		flags.SetBool('M02StreetLoaded', True,, 3);

		// if you went to the warehouse without finishing the streets,
		// set some flags
		if (!flags.GetBool('MS_GuardsWandering') &&
			flags.GetBool('WarehouseDistrictEntered'))
		{
			if (!flags.GetBool('StreetOpened') ||
				!flags.GetBool('ClinicCleared'))
			{
				foreach AllActors(class'ScriptedPawn', pawn)
				{
					if (pawn.Tag == 'ClinicGuards')
						pawn.SetOrders('Wandering', '', True);
					else if (pawn.Tag == 'HotelGuards')
						pawn.SetOrders('Wandering', '', True);
				}
			}

			flags.SetBool('MS_GuardsWandering', True,, 3);
		}

		// Manderley will be disappointed if you don't finish the streets
		if (!flags.GetBool('M02ManderleyDisappointed') &&
			!flags.GetBool('BatteryParkComplete'))
		{
			flags.SetBool('M02ManderleyDisappointed', True,, 3);
		}

		// get rid of Sandra if you've talked to her already
		if (flags.GetBool('MeetSandraRenton_Played'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
				if (pawn.IsA('SandraRenton'))
					pawn.Destroy();
		}

		// unhide some hostages if you've rescued them
		if (flags.GetBool('EscapeSuccessful'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if (pawn.IsA('BumMale') && (pawn.Tag == 'hostageMan'))
					pawn.EnterWorld();
				else if (pawn.IsA('BumFemale') && (pawn.Tag == 'hostageWoman'))
					pawn.EnterWorld();
			}
		}
	}
	else if (localURL == "02_NYC_BAR")
	{
		// unhide Sandra if you've talked to her already
		if (flags.GetBool('MeetSandraRenton_Played'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
				if (pawn.IsA('SandraRenton'))
				{
					pawn.EnterWorld();
					flags.SetBool('MS_SandraInBar', True,, 3);
				}
		}
	}
	else if (localURL == "02_NYC_SMUG")
	{
		// unhide Ford if you've rescued him
		if (flags.GetBool('FordSchickRescued'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
				if (pawn.IsA('FordSchick'))
					pawn.EnterWorld();

			flags.SetBool('SchickThankedPlayer', True);
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
	local MJ12Troop mj12;
	local int count;

	if (localURL == "02_NYC_BATTERYPARK")
	{
		// if you leave without finishing, set some flags and remove the terrorists
		if (!flags.GetBool('MS_MapLeftEarly'))
		{
			if (!flags.GetBool('AmbrosiaTagged') ||
				!flags.GetBool('SubTerroristsDead'))
			{
				flags.SetBool('MS_MapLeftEarly', True,, 3);
			}
		}
	}
	else if (localURL == "02_NYC_UNDERGROUND")
	{
		// if you leave the level with Ford Schick, set a flag
		if (flags.GetBool('MS_FordFollowing') &&
			!flags.GetBool('FordSchick_Dead'))
		{
			flags.SetBool('FordSchickRescued', True,, 9);
		}
		//== If nobody's guarding Ford we can assume he won't die
		else if(!flags.GetBool('FordSchick_Dead'))
		{
			count = 0;
			foreach AllActors(Class'MJ12Troop', mj12)
				count++;

			if(count <= 0)
				flags.SetBool('FordSchickRescued', True,, 9);
		}
	}

	Super.PreTravel();
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
	local UNATCOTroop guard;
	local ThugMale thug;
	local ThugMale2 thug2;
	local BumMale bum;
	local BlackHelicopter chopper;
	local Doctor doc;
	local BarrelAmbrosia barrel;
	local ScriptedPawn pawn;
	local DeusExCarcass carc2;
	local GuntherHermann Gunther;
	local Actor A;
	local SandraRenton Sandra;
	local int count;
	local Phone amach;
	local ConversationTrigger contrig;
	local ConListItem conList;
	local ComputerPublic compPub;
	local Pillow fluffy;
	local DataCube dCube;

	Super.Timer();

	if (localURL == "02_NYC_BATTERYPARK")
	{
		// after terrorists are dead, set guards to wandering
		if (!flags.GetBool('BatteryParkSlaughter') && !flags.GetBool('CastleClintonCleared'))
		{
			count = 0;

			// count the number of living terrorists
			foreach AllActors(class'Terrorist', T, 'ClintonTerrorist')
				count++;

			// one way or another, the castle has been cleared
			if(count == 0)
			{
				// nothing to do here anymore, so wander
				foreach AllActors(class'UNATCOTroop', guard, 'ClintonGuard')
					guard.SetOrders('Wandering', '', True);

				flags.SetBool('CastleClintonCleared', True,, 3);
			}

			// count the number of unconscious terrorists
			foreach AllActors(class'TerroristCarcass', carc, 'ClintonTerrorist')
				if (carc.bNotDead || carc.KillerBindName != "JCDenton" || carc.itemName == "Unconscious")
					count++;

			// if there are less than four, then the player killed at least two.  For shame.
			if (count <= 3 && !flags.GetBool('BatteryParkSlaughter'))
			{
				// free up the guards so they can kill 'em
				foreach AllActors(class'UNATCOTroop', guard, 'ClintonGuard')
					guard.SetOrders('Wandering', '', True);

				flags.SetBool('BatteryParkSlaughter', True,, 6);
			}
		}

		// set guards to wandering after sub terrorists are dead
		if (!flags.GetBool('SubTerroristsDead'))
		{
			count = 0;

			foreach AllActors(class'Terrorist', T, 'SubTerrorist')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', guard, 'SubGuards')
					guard.SetOrders('Wandering', '', True);

				Player.GoalCompleted('LiberateBatteryParkSubway');
				flags.SetBool('SubTerroristsDead', True,, 6);
			}
		}

		// check to see if hostages are dead
		if (!flags.GetBool('HostagesKilled') && flags.GetBool('SubHostageMale_Dead') &&
			flags.GetBool('SubHostageFemale_Dead'))
		{
			flags.SetBool('HostagesKilled', True,, 3);
		}

		// check a bunch of flags, and start a datalink
		if (!flags.GetBool('MS_MapLeftEarly') &&
			!flags.GetBool('MS_DL_Played'))
		{
			if (!flags.GetBool('SubTerroristsDead') &&
				flags.GetBool('EscapeSuccessful') &&
				!flags.GetBool('HostagesKilled'))
			{
				Player.StartDataLinkTransmission("DL_SubwayComplete3");
				flags.SetBool('MS_DL_Played', True,, 3);
			}
			else if (flags.GetBool('HostagesKilled'))
			{
				Player.StartDataLinkTransmission("DL_SubwayComplete2");
				flags.SetBool('MS_DL_Played', True,, 3);
			}
			else if (flags.GetBool('SubTerroristsDead') ||
				flags.GetBool('EscapeSuccessful'))
			{
				Player.StartDataLinkTransmission("DL_SubwayComplete");
				flags.SetBool('MS_DL_Played', True,, 3);
			}
		}

		if (!flags.GetBool('ShantyTownSecure'))
		{
			count = 0;

			foreach AllActors(class'Terrorist', T, 'ShantyTerrorists')
				count++;

			if (count == 0)
				flags.SetBool('ShantyTownSecure', True);
		}
	}
	else if (localURL == "02_NYC_STREET")
	{
		// set guards to wandering after clinc terrorists are dead
		if (!flags.GetBool('ClinicCleared'))
		{
			count = 0;

			foreach AllActors(class'Terrorist', T, 'ClinicTerrorist')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', guard, 'ClinicGuards')
					guard.SetOrders('Wandering', '', True);

				flags.SetBool('ClinicCleared', True,, 6);
			}
		}

		// set guards to wandering after street terrorists are dead
		if (!flags.GetBool('StreetOpened'))
		{
			count = 0;

			foreach AllActors(class'Terrorist', T, 'StreetTerrorist')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', guard, 'HotelGuards')
					guard.SetOrders('Wandering', '', True);

				flags.SetBool('StreetOpened', True,, 6);

				// there are 5 terrorists total
				// if player killed 3 or more, call it a slaughter
				foreach AllActors(class'TerroristCarcass', carc, 'StreetTerrorist')
				{
					if ((carc.KillerBindName == "JCDenton") && (carc.itemName != "Unconscious"))
						count++;
				}

				if (count >= 3)
					flags.SetBool('TenderloinSlaughter', True,, 6);
			}
		}

		// check to see if player rescued bum
		if (!flags.GetBool('MS_ThugsDead'))
		{
			count = 0;

			foreach AllActors(class'ThugMale2', thug2, 'AlleyThug')
				count++;

			// set the resuced flag if the bum is still alive
			if (count == 0)
			{
				foreach AllActors(class'BumMale', bum, 'AlleyBum')
					flags.SetBool('AlleyBumRescued', True,, 3);

				flags.SetBool('MS_ThugsDead', True,, 3);
			}
		}

		// if the pimp is dead, set a flag
		if (!flags.GetBool('SandrasPimpDone'))
		{
			count = 0;
			foreach AllActors(class'ThugMale', thug, 'Pimp')
				count++;

			if (count == 0)
			{
				flags.SetBool('SandrasPimpDone', True,, 3);
				Player.GoalCompleted('HelpJaneysFriend');
			}
		}

		// if Sandra is dead, set a flag
		if (!flags.GetBool('MS_SandraDead'))
		{
			count = 0;
			foreach AllActors(class'SandraRenton', Sandra)
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_SandraDead', True,, 3);
				Player.GoalCompleted('HelpJaneysFriend');
			}
		}

		if (flags.GetBool('OverhearAlleyThug_Played') &&
			!flags.GetBool('MS_ThugAttacks'))
		{
			foreach AllActors(class'Actor', A, 'ThugAttacks')
				A.Trigger(Self, Player);

			flags.SetBool('MS_ThugAttacks', True,, 3);
		}
	}
	else if (localURL == "02_NYC_WAREHOUSE")
	{
		// start infolink after generator blown
		// also unhide the helicopter and Gunther on the roof
		if (!flags.GetBool('MS_GeneratorStuff'))
		{
			if (!flags.GetBool('DL_Pickup_Played') &&
				flags.GetBool('GeneratorBlown'))
			{
				Player.StartDataLinkTransmission("DL_Pickup");

				foreach AllActors(class'BlackHelicopter', chopper, 'Helicopter')
					chopper.EnterWorld();

				foreach AllActors(class'GuntherHermann', Gunther)
					Gunther.EnterWorld();

				flags.SetBool('MS_GeneratorStuff', True,, 3);
			}
		}
	}
	else if (localURL == "02_NYC_FREECLINIC")
	{
		// make the bum disappear when he gets to his destination
		if (flags.GetBool('MS_BumLeaving') &&
			!flags.GetBool('MS_BumRemoved'))
		{
			foreach AllActors(class'BumMale', bum, 'SickBum1')
				if (bum.IsInState('Standing'))
					bum.Destroy();

			flags.SetBool('MS_BumRemoved', True,, 3);
			flags.DeleteFlag('MS_BumLeaving', FLAG_Bool);
		}

		// make the bum leave after talking to the doctor
		if (flags.GetBool('Doctor2_Saved') &&
			!flags.GetBool('MS_BumRemoved') &&
			!flags.GetBool('MS_BumLeaving'))
		{
			foreach AllActors(class'BumMale', bum, 'SickBum1')
				bum.SetOrders('GoingTo', 'SickBumDestination', True);

			flags.SetBool('MS_BumLeaving', True,, 3);
		}

		// make the bum face the doctor
		if (flags.GetBool('SickBumInterrupted_Played') &&
			!flags.GetBool('Doctor2_Saved') &&
			!flags.GetBool('MS_BumTurned'))
		{
			foreach AllActors(class'Doctor', doc, 'Doctor2')
				foreach AllActors(class'BumMale', bum, 'SickBum1')
				{
					bum.DesiredRotation = Rotator(doc.Location - bum.Location);
					break;
				}

			flags.SetBool('MS_BumTurned', True,, 3);
		}
	}
	else if (localURL == "02_NYC_BAR")
	{
		// if the player kills anybody in the bar, set a flag
		if (!flags.GetBool('M02ViolenceInBar'))
		{
			count = 0;

			foreach AllActors(class'DeusExCarcass', carc2)
			{
				if(carc2.KillerBindName == "JCDenton")
					count++;
			}

			if (count > 0)
				flags.SetBool('M02ViolenceInBar', True,, 4);
		}

		if (!flags.GetBool('M02_Bar_Warning_Placed'))
		{
			foreach AllActors(class'ComputerPublic', compPub)
			{
				compPub.bulletinTitles[0] = "A warning from Project Mayhem";
				compPub.bulletinText[0] = "If you are reading this then this warning is for you. Every word you read of this useless fine print is another second of your life. Don't you have other things to do?";
				compPub.bulletinText[0] = compPub.bulletinText[0] $ " Is your life so empty that you honestly can't think of a better way to spend these moments? Or are you so impressed with authority that you give respect and credence to all who claim it?";
				compPub.bulletinText[0] = compPub.bulletinText[0] $ " Do you think everything you're supposed to think? Buy what you're told you should want? Get out of your apartment. Meet a member of the opposite sex.";
				compPub.bulletinText[0] = compPub.bulletinText[0] $ " Stop excessive shopping and masturbation. Quit your job. Start a fight. Prove you're alive. If you don't claim your humanity you will become a statistic. You have been warned......Tyler";
			}
		}
	}
	else if (localURL == "02_NYC_HOTEL")
	{
		// if the player kills all the terrorists, set a flag
		if (!flags.GetBool('M02HostagesRescued'))
		{
			count = 0;

			foreach AllActors(class'Terrorist', T)
				if (T.Tag == 'SecondFloorTerrorist')
					count++;

			if (count == 0)
				flags.SetBool('M02HostagesRescued', True,, 3);
		}

		if (!flags.GetBool('M02_Ans_Mach_Placed'))
		{
			amach = Spawn(class'Phone',None,, vect(-613.23, -3236.47, 117.19));

			if(amach != None)
			{
				contrig = Spawn(class'ConversationTrigger',None,, vect(0,0,-40));
				if(contrig != None)
				{
					contrig.conversationTag = 'M03AnsweringMachineMessage';
					contrig.BindName = "AnsweringMachine";
					contrig.Tag = 'PlayAnsweringMachineMessage';
					contrig.bTriggerOnceOnly = False;
				}

				amach.Event = 'PlayAnsweringMachineMessage';
				amach.BindName = "AnsweringMachine";
				amach.bUsing = True;
				conList = New class'ConListItem';
				conList.con = Conversation(DynamicLoadObject("DeusExConText.Conversation354",class'Conversation')); //Took me forever to find this
				amach.ConListItems = conList;
				amach.ringFreq = 0.0;

				flags.SetBool('M02_Ans_Mach_Placed', True,, 3);
			}
		}

		//== If the player's been all non-violent and crap, give him an extra tool to continue doing so
		if(!flags.GetBool('M02_Blackjack_Placed') && !flags.GetBool('M01PlayerAggressive') && !flags.GetBool('BatteryParkSlaughter'))
		{
			foreach AllActors(class'Datacube', dCube)
			{
				if(dCube.textTag == '02_Datacube07')
				{
					dCube.SpecialText = emailString[0];
					break;
				}
			}

			if(spawn(class'WeaponBlackjack', None,, (dCube.Location + vect(0,0,4)), rot(0,16383,0)) != None)
				flags.SetBool('M02_Blackjack_Placed', True,, 9); //== Further placements of the blackjack are sorta moot
		}
	}
	else if (localURL == "02_NYC_UNDERGROUND")
	{
		if (flags.GetBool('FordSchick_Dead') &&
			!flags.GetBool('FordSchickRescueDone'))
		{
			flags.SetBool('FordSchickRescueDone', True,, 9);
		}
	}
	else if (localURL == "02_NYC_SMUG")
	{
		if(!flags.GetBool('M02_ToxinBladeAdded'))
		{
			foreach AllActors(Class'Pillow', fluffy)
			{
				if(spawn(Class'WeaponToxinBlade', None,, fluffy.Location, rot(0,16383,0) + fluffy.Rotation) != None)
				{
					flags.setBool('M02_ToxinBladeAdded', True,, 3);
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
   emailString(0)="|n|nP.S. You've managed to keep the casualties to a minimum so far, but I know it hasn't been easy.  I've left you a baton I modified that should make the use of minimal force less challenging."
}
