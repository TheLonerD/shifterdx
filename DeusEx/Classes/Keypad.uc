//=============================================================================
// Keypad.
//=============================================================================
class Keypad extends HackableDevices
	abstract;

var() string validCode;
var() sound successSound;
var() sound failureSound;
var() name FailEvent;
var() bool bToggleLock;		// if True, toggle the lock state instead of triggering

var HUDKeypadWindow keypadwindow;

// ----------------------------------------------------------------------
// Network Replication
// ----------------------------------------------------------------------

replication
{
   //server to client variables
   reliable if ( Role == ROLE_Authority )
      bToggleLock, FailEvent, validCode;
}

simulated function PreBeginPlay()
{
	CleanValidCode();
	Super.PreBeginPlay();
}

//== Strips out illegal characters so we have an enterable code for the keypad
function CleanValidCode()
{
	local string tCode, tChar;
	local int i;
	local bool bAllXes; //Special case.  An all-X code means a purposefully unenterable code

	bAllXes = true;
	tCode = "";

	for(i = 0; i < len(validCode); i++)
	{
		tChar = Mid(validCode, i, 1);

		if(Caps(tChar) != "X")
			bAllXes = False;

		switch(tChar)
		{
			case "0":
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
			case "8":
			case "9":
			case "#":
			case "*":
				tCode = tCode $ tChar;
				tChar = "";
				break;
			case "?":	// Another special case.  A question mark indicates a random number
				tCode = tCode $ Rand(10);
				tChar = "";
				break;
		}

		//== If the tChar variable hasn't been cleared out then it's an invalid character.  Replace with a star
		if(tChar != "")
			tCode = tCode $ "*";
	}

	//== If we have a purposefully unenterable code (including zero-length) use the uncleaned version
	if(bAllXes)
		tCode = validCode;

	//== Set the valid code equal to the tCode
	validCode = tCode;
}

// ----------------------------------------------------------------------
// HackAction()
// ----------------------------------------------------------------------

function HackAction(Actor Hacker, bool bHacked)
{
	local DeusExPlayer Player;

	// if we're already using this keypad, get out
	if (keypadwindow != None)
		return;

	Player = DeusExPlayer(Hacker);

	if (Player != None)
	{
      // DEUS_EX AMSD if we are in multiplayer, just act based on bHacked
      // if you want keypad windows to work in multiplayer, just get rid of this
      // if statement.  I've already got the windows working, they're just disabled.
      if (Level.NetMode != NM_Standalone)
      {
         if (bHacked)
         {
            ToggleLocks(Player);
            RunEvents(Player,True);
            RunUntriggers(Player);
         }
         return;
      }
      
      //DEUS_EX AMSD Must call in player for replication to work.
      Player.ActivateKeypadWindow(Self, bHacked);
	}
}

// ----------------------------------------------------------------------
// ActivateKeypadWindow
// DEUS_EX AMSD Bounce back call from player so function rep works right.
// ----------------------------------------------------------------------
simulated function ActivateKeypadWindow(DeusExPlayer Hacker, bool bHacked)
{
	local DeusExRootWindow root;

   root = DeusExRootWindow(Hacker.rootWindow);
   if (root != None)
   {
      keypadwindow = HUDKeypadWindow(root.InvokeUIScreen(Class'HUDKeypadWindow', True));
      root.MaskBackground(True);
      
      // copy the tag data to the actual class
      if (keypadwindow != None)
      {
         keypadwindow.keypadOwner = Self;
         keypadwindow.player = Hacker;
         keypadwindow.bInstantSuccess = bHacked;
         keypadwindow.InitData();
      }
   }
}

// ----------------------------------------------------------------------
// RunUntriggers()
// DEUS_EX AMSD Bounce back call from player so function rep works right.
// ----------------------------------------------------------------------
function RunUntriggers(DeusExPlayer Player)
{
   local Actor A;
   local int i;

   for (i=0; i<ArrayCount(UnTriggerEvent); i++)
   {
      if (UnTriggerEvent[i] != '')
      {
         foreach AllActors(class 'Actor', A, UnTriggerEvent[i])
         {
            A.UnTrigger(Self, Player);
         }
      }
   }
}

// ----------------------------------------------------------------------
// RunEvents()
// ----------------------------------------------------------------------
function RunEvents(DeusExPlayer Player, bool bSuccess)
{
   local Actor A;

   if ((bSuccess) && (Event != ''))
   {
      foreach AllActors(class 'Actor', A, Event)
         A.Trigger(Self, Player);
   }
   else if ((!bSuccess) && (FailEvent != ''))
   {
      foreach AllActors(class 'Actor', A, FailEvent)
         A.Trigger(Self, Player);
   }
}

// ----------------------------------------------------------------------
// ToggleLocks()
// ----------------------------------------------------------------------
function ToggleLocks(DeusExPlayer Player)
{
   local Actor A;
   if (bToggleLock)
   {
      foreach AllActors(class 'Actor', A, Event)
         if (A.IsA('DeusExMover'))
            DeusExMover(A).bLocked = !DeusExMover(A).bLocked;
   }
}


// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     validCode="1234"
     successSound=Sound'DeusExSounds.Generic.Beep2'
     failureSound=Sound'DeusExSounds.Generic.Buzz1'
     bToggleLock=True
     ItemName="Security Keypad"
     Mass=10.000000
     Buoyancy=5.000000
}
