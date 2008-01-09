//=============================================================================
// MissionScript.
//=============================================================================
class MissionScript extends Info
	transient
	abstract;

//
// State machine for each mission
// All flags set by this mission controller script should be
// prefixed with MS_ for consistency
//

var float checkTime;
var DeusExPlayer Player;
var FlagBase flags;
var string localURL;
var DeusExLevelInfo dxInfo;

var String emailFrom[25];
var String emailTo[25];
var String emailCC[25];
var localized String emailSubject[25];
var localized String emailString[25];

// ----------------------------------------------------------------------
// PostPostBeginPlay()
//
// Set the timer
// ----------------------------------------------------------------------

function PostPostBeginPlay()
{
	// start the script
	SetTimer(checkTime, True);
}

// ----------------------------------------------------------------------
// InitStateMachine()
//
// Get the player's flag base, get the map name, and set the player
// ----------------------------------------------------------------------

function InitStateMachine()
{
	local DeusExLevelInfo info;
	local int i;

	Player = DeusExPlayer(GetPlayerPawn());

	foreach AllActors(class'DeusExLevelInfo', info)
		dxInfo = info;

	if (Player != None)
	{
		flags = Player.FlagBase;

		// Get the mission number by extracting it from the
		// DeusExLevelInfo and then delete any expired flags.
		//
		// Also set the default mission expiration so flags
		// expire in the next mission unless explicitly set
		// differently when the flag is created.

		if (flags != None)
		{
			// Don't delete expired flags if we just loaded
			// a savegame
			if (flags.GetBool('PlayerTraveling'))
				flags.DeleteExpiredFlags(dxInfo.MissionNumber);

			flags.SetDefaultExpiration(dxInfo.MissionNumber + 1);

			localURL = Caps(dxInfo.mapName);

			for(i = 0; emailSubject[i] != ""; i++)
			{
				dxInfo.emailSubject[i] = emailSubject[i];
				dxInfo.emailFrom[i] = emailFrom[i];
				dxInfo.emailTo[i] = emailTo[i];
				dxInfo.emailString[i] = emailString[i];
			}

			log("**** InitStateMachine() -"@player@"started mission state machine for"@localURL);
		}
		else
		{
			log("**** InitStateMachine() - flagBase not set - mission state machine NOT initialized!");
		}
	}
	else
	{
		log("**** InitStateMachine() - player not set - mission state machine NOT initialized!");
	}
}

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	local name flagName;
	local ScriptedPawn P;
	local int i;
	local bool skillon;

	flags.DeleteFlag('PlayerTraveling', FLAG_Bool);
	flags.DeleteFlag('NPCInventoryChecked', FLAG_Bool);

	if(!flags.GetBool('SkillPointsPendingCurrent'))
	{
		i = flags.GetInt('PendingSkillPoints');
		if(i > 0)
		{
			Player.ClientMessage("Calculating cumulative stealth bonus for previous mission");
			Player.SkillPointsAdd(i);
		}

		flags.SetBool('SkillPointsPendingCurrent',True,, dxInfo.MissionNumber + 1);

		i = 0;
	}
	else
		i = flags.GetInt('PendingSkillPoints');

	// Check to see which NPCs should be dead from prevous missions
	foreach AllActors(class'ScriptedPawn', P)
	{
		if(P.PendingSkillPoints > 0)
		{
			i -= P.PendingSkillPoints;
		}
		if (P.bImportant)
		{
			flagName = Player.rootWindow.StringToName(P.BindName$"_Dead");
			if (flags.GetBool(flagName))
				P.Destroy();
		}
	}

	flags.SetInt('PendingSkillPoints', i,, 0);

	// print the mission startup text only once per map
	flagName = Player.rootWindow.StringToName("M"$Caps(dxInfo.mapName)$"_StartupText");
	if (!flags.GetBool(flagName) && (dxInfo.startupMessage[0] != ""))
	{
		for (i=0; i<ArrayCount(dxInfo.startupMessage); i++)
			DeusExRootWindow(Player.rootWindow).hud.startDisplay.AddMessage(dxInfo.startupMessage[i]);
		DeusExRootWindow(Player.rootWindow).hud.startDisplay.StartMessage();
		flags.SetBool(flagName, True);
	}

	flagName = Player.rootWindow.StringToName("M"$dxInfo.MissionNumber$"MissionStart");
	if (!flags.GetBool(flagName))
	{
		// Remove completed Primary goals and all Secondary goals
		Player.ResetGoals();

		// Remove any Conversation History.
		Player.ResetConversationHistory();

		// Set this flag so we only get in here once per mission.
		flags.SetBool(flagName, True);
	}
}

// ----------------------------------------------------------------------
// PreTravel()
// 
// Set flags upon exit of a certain map
// ----------------------------------------------------------------------

function PreTravel()
{
	local int points;
	local ScriptedPawn pawn;

	// turn off the timer
	SetTimer(0, False);

	points = flags.getInt('PendingSkillPoints');

	foreach allActors(class'ScriptedPawn', pawn)
	{
		if(pawn.PendingSkillPoints > 0)
			points += pawn.PendingSkillPoints;
	}

	flags.SetInt('PendingSkillPoints', points,, 0);

	// zero the flags so FirstFrame() gets executed at load
	flags = None;
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local ScriptedPawn S;
	local Inventory inv, itemp;
	local bool bWhatever, bCheck;
	local int check; //Guard against infinite inventory

	// make sure our flags are initialized correctly
	if (flags == None)
	{
		InitStateMachine();

		// Don't want to do this if the user just loaded a savegame
		if ((player != None) && (flags.GetBool('PlayerTraveling')))
			FirstFrame();
	}


	if(!flags.getBool('NPCInventoryChecked'))
	{
		bCheck = true;
		foreach AllActors(Class'ScriptedPawn', S)
		{
			if(S.bNPCRandomCheck && !S.bNPCRandomGiven)
			{
				bCheck = false;
				bWhatever = false;
				inv = S.Inventory;
				check = 0;
				while(inv != None && check <= 10)
				{
					check++;
					itemp = None;
					if(DeusExWeapon(inv) != None)
					{
						bWhatever = true;
					}
					if(inv.IsA('WeaponCombatKnife') && S.bCheckedCombat)
					{
						switch(Rand(4))
						{
							case 2:
							case 3:
							case 0:
								itemp = spawn(Class'WeaponCrowbar', S);
								break;
							case 1:
								itemp = spawn(Class'WeaponSword', S);
								break;
						}
						if(itemp != None)
						{
							itemp.InitialState='Idle2';
							itemp.GiveTo(S);
							itemp.setBase(S);
	
							S.bCheckedCombat = False;
						}
					}
					if(itemp != None)
						itemp = inv;
					inv = inv.Inventory;
					if(itemp != None)
					{
						S.DeleteInventory(itemp);
						itemp.destroy();
					}
	
				}
				if(bWhatever)
				{
					S.GenerateRandomInventory();
					S.bNPCRandomGiven = True;
				}
			}
		}
		if(bCheck)
		{
			flags.SetBool('NPCInventoryChecked',True,, 0);
		}
	}
}

// ----------------------------------------------------------------------
// GetPatrolPoint()
// ----------------------------------------------------------------------

function PatrolPoint GetPatrolPoint(Name patrolTag, optional bool bRandom)
{
	local PatrolPoint aPoint;

	aPoint = None;

	while(aPoint == None)
	{
		foreach AllActors(class'PatrolPoint', aPoint, patrolTag)
		{
			if (bRandom)
			{
				if(FRand() < 0.5)
					break;
			}
			else
				break;
		}
	}

	return aPoint;
}

// ----------------------------------------------------------------------
// GetSpawnPoint()
// ----------------------------------------------------------------------

function SpawnPoint GetSpawnPoint(Name spawnTag, optional bool bRandom)
{
	local SpawnPoint aPoint;

	aPoint = None;

	while(aPoint == None)
	{
		foreach AllActors(class'SpawnPoint', aPoint, spawnTag)
		{
			if (bRandom)
			{
				if(FRand() < 0.5)
					break;
			}
			else
				break;
		}
	}

	return aPoint;
}

defaultproperties
{
     checkTime=1.000000
     localURL="NOTHING"
}
