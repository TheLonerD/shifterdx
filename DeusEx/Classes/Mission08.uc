//=============================================================================
// Mission08.
//=============================================================================
class Mission08 expands MissionScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local SandraRenton Sandra;
	local FordSchick Ford;
	local vector loc;

	Super.FirstFrame();

	if (flags.GetBool('SandraWentToCalifornia'))
	{
		foreach AllActors(class'SandraRenton', Sandra)
			Sandra.Destroy();
	}

	if (localURL == "08_NYC_SMUG")
	{
		// unhide Ford if you've rescued him
		if (flags.GetBool('FordSchickRescued'))
		{
			foreach AllActors(class'FordSchick', Ford)
				Ford.EnterWorld();
		}
		if(!flags.getBool('M08_Pickup1_Placed'))
		{
			loc.X = -564.548157;
			loc.Y = 1705.896484;
			loc.Z = 250.310501;
			spawn(class'WeaponModAuto', None,, loc);
			flags.SetBool('M08_Pickup1_Placed', True,, 9);
		}
		if(!flags.getBool('M08_Pickup2_Placed'))
		{
			loc.X = -283.971252;
			loc.Y = 26.320299;
			loc.Z = -3.072773;
			spawn(class'WeaponJackHammer', None,, loc);
			flags.SetBool('M08_Pickup2_Placed', True,, 9);
		}
	}
	else if(localURL == "08_NYC_UNDERGROUND")
	{
		if(!flags.GetBool('M08_ILAW_Placed'))
		{
			loc.X = -1080.712158;
			loc.Y = -63.224194;
			loc.Z = -807.898682;
			spawn(class'WeaponMiniRocket', None,, loc);
			flags.SetBool('M08_ILAW_Placed', True,, 9);
		}
	}
	else if(localURL == "08_NYC_HOTEL")
	{
		if(!flags.GetBool('PaulDenton_Dead') && !flags.GetBool('M08_Blackjack_Placed'))
		{
			loc.X = -880.00;
			loc.Y = -1203.00;
			loc.Z = -76.25;
			spawn(class'WeaponBlackjack',None,, loc);
			flags.SetBool('M08_Blackjack_Placed', True,, 9);
		}

		//== We need to set the phone here one last time
		if (!flags.GetBool('M08_Ans_Mach_Placed'))
		{
			if(Spawn(class'Phone',None,, vect(-613.23, -3236.47, 117.19)) != None)
				flags.SetBool('M08_Ans_Mach_Placed', True,, 9);
		}
	}
	else if(localURL == "08_NYC_STREET")
	{
		if(flags.GetBool('PaulDenton_Dead') && !flags.GetBool('M08_SwordA_Placed'))
		{
			loc.X = 3230.000000;
			loc.Y = -4225.000000;
			loc.Z = -391.000000;
			spawn(class'WeaponPrototypeSwordA',None,, loc);
			flags.SetBool('M08_SwordA_Placed', True,, 9);
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
	local BlackHelicopter chopper;

	Super.PreTravel();

	if (localURL == "08_NYC_STREET")
	{
		// make sure that damn helicopter is gone
		foreach AllActors(class'BlackHelicopter', chopper, 'EntranceCopter')
			chopper.Destroy();
	}
}

function PostPostBeginPlay()
{
	Super.PostPostBeginPlay();

	if(localURL == "08_NYC_STREET")
	{
		//== For the users that have issues with the music in this map, give the backup method something to work with
		flags.SetName('Song_Name','NYCStreets2_Music',, 9);
	}
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local ScriptedPawn pawn;
	local RiotCop cop;
	local UNATCOTroop troop;
	local MJ12Troop mj12;
	local StantonDowd Stanton;
	local ThugMale Thug;
	local BlackHelicopter chopper;
	local FordSchick Ford;
	local int count;

	Super.Timer();

	if (localURL == "08_NYC_FREECLINIC")
	{
		if (flags.GetBool('JoeGreene_Dead') &&
			!flags.GetBool('MS_GreeneGoalSet'))
		{
			Player.GoalCompleted('KillGreene');
			flags.SetBool('MS_GreeneGoalSet', True,, 9);
		}
	}
	else if (localURL == "08_NYC_STREET")
	{
		// spawn reinforcements as cops are killed
		if (!flags.GetBool('MS_UnhideTroop1'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop1')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop1')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop1', True,, 9);
			}
		}
		if (!flags.GetBool('MS_UnhideTroop2'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop2')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop2')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop2', True,, 9);
			}
		}
		if (!flags.GetBool('MS_UnhideTroop3'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop3')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop3')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop3', True,, 9);
			}
		}
		if (!flags.GetBool('MS_UnhideTroop4'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop4')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop4')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop4', True,, 9);
			}
		}
		if (!flags.GetBool('MS_UnhideTroop5'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop5')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop5')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop5', True,, 9);
			}
		}
		if (!flags.GetBool('MS_UnhideTroop6'))
		{
			count = 0;
			foreach AllActors(class'RiotCop', cop, 'Cop6')
				count++;

			if (count == 0)
			{
				foreach AllActors(class'UNATCOTroop', troop, 'troop6')
					troop.EnterWorld();

				flags.SetBool('MS_UnhideTroop6', True,, 9);
			}
		}

		// unhide Thomas Dieter
		if (!flags.GetBool('MS_ThomasUnhidden'))
		{
			if (flags.GetBool('HarleyFilben_Dead'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'ThomasDieter')
					if (pawn.IsA('Janitor'))
						pawn.EnterWorld();

				flags.SetBool('MS_ThomasUnhidden', True,, 9);
			}
		}

		// unhide Stanton Dowd
		if (!flags.GetBool('MS_StantonUnhidden'))
		{
			if (flags.GetBool('M08MeetHarleyFilben_Played') ||
				flags.GetBool('MeetThomasDieter_Played'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'StantonDowd')
					if (pawn.IsA('StantonDowd'))
						pawn.EnterWorld();

				flags.SetBool('MS_StantonUnhidden', True,, 9);
			}
		}

		// unhide shady guy
		if (!flags.GetBool('MS_ShadyGuyUnhidden'))
		{
			if (flags.GetBool('MS_StantonUnhidden'))
			{
				if ((flags.GetBool('GreenKnowsAboutDowd') &&
					!flags.GetBool('JoeGreen_Dead')) ||
					flags.GetBool('SheaKnowsAboutDowd'))
				{
					foreach AllActors(class'ScriptedPawn', pawn, 'ShadyGuy')
						if (pawn.IsA('ThugMale'))
							pawn.EnterWorld();

					flags.SetBool('MS_ShadyGuyUnhidden', True,, 9);
				}
			}
		}

		// spawn MJ12 attack force when Shady Guy gets close (8 feet) to Dowd
		if (!flags.GetBool('StantonAmbush'))
		{
			Stanton = None;
			foreach AllActors(class'ScriptedPawn', pawn, 'StantonDowd')
				if (pawn.IsA('StantonDowd'))
					Stanton = StantonDowd(pawn);

			if (Stanton != None)
			{
				Thug = None;
				foreach AllActors(class'ScriptedPawn', pawn, 'ShadyGuy')
					Thug = ThugMale(pawn);

				if (Thug != None)
				{
					if (VSize(Thug.Location - Stanton.Location) <= 128)
					{
						foreach AllActors(class'MJ12Troop', mj12, 'MJ12AttackForce')
							mj12.EnterWorld();

						flags.SetBool('StantonAmbush', True,, 9);
					}
				}
			}
		}

		// spawn MJ12 attack force when a flag is set
		if (!flags.GetBool('StantonAmbush') &&
			flags.GetBool('MJ12Converging'))
		{
			foreach AllActors(class'MJ12Troop', mj12, 'MJ12AttackForce')
				mj12.EnterWorld();

			flags.SetBool('StantonAmbush', True,, 9);
		}

		// if the MJ12 attack force is killed, set a flag
		if (flags.GetBool('StantonAmbush') &&
			!flags.GetBool('StantonAmbushDefeated'))
		{
			count = 0;
			foreach AllActors(class'MJ12Troop', mj12, 'MJ12AttackForce')
				count++;

			if (count == 0)
				flags.SetBool('StantonAmbushDefeated', True,, 9);
		}

		// unhide the helicopter when its time
		if (flags.GetBool('StantonDowd_Played') &&
			flags.GetBool('DL_Exit_Played') &&
			!flags.GetBool('MS_Helicopter_Unhidden'))
		{
			foreach AllActors(class'BlackHelicopter', chopper, 'CopterExit')
				chopper.EnterWorld();

			flags.SetBool('MS_Helicopter_Unhidden', True,, 9);
		}
	}
	else if(localURL == "08_NYC_SMUG")
	{
		if(flags.getBool('FordSchickRescued'))
		{
			if(!flags.getBool('M08FordShick_Appeared'))
			{
				foreach AllActors(class'FordSchick', Ford)
				{
					Ford.EnterWorld();
					flags.SetBool('M08FordSchick_Appeared', True,, 9);
				}
			}
		}
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
