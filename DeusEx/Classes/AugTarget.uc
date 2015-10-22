//=============================================================================
// AugTarget.
//=============================================================================
class AugTarget extends Augmentation;

var float mpAugValue;
var float mpEnergyDrain;
var() bool bViewWindowActive;
var() bool bWindowActive;

// ----------------------------------------------------------------------------
// Network Replication
// ----------------------------------------------------------------------------

replication
{
   //Server to client function replication
   reliable if (Role == ROLE_Authority)
      SetTargetingAugStatus;
}

state Active
{
Begin:
   SetTargetingAugStatus(CurrentLevel,True);
}

function Deactivate()
{
   local DeusExWeapon W;

   if((!bViewWindowActive && !bwindowActive) || player.Energy <= 0)
   {
    //== Deactivate the scope if we don't actually have one
    if(DeusExWeapon(Player.inHand) != None)
    {
        W = DeusExWeapon(Player.inHand);
        if(W.bZoomed && !W.bHasScope)
            W.ScopeOff();
    }

    Super.Deactivate();

    SetTargetingAugStatus(CurrentLevel,False);
   }
   else //if(bViewWindowActive)
   {
    bViewWindowActive = false;
    DeusExRootWindow(Player.rootWindow).hud.augDisplay.bTargetWindowActive = false;
    //Player.PlaySound(DeactivateSound, SLOT_None);
    Player.ClientMessage("Targeting window hidden");
   }
//   else
//   {
//    bWindowActive = false;
//    DeusExRootWindow(Player.rootWindow).hud.augDisplay.bTargetActive = false;
//    Player.PlaySound(DeactivateSound, SLOT_None);
//   }
}

// ----------------------------------------------------------------------
// SetTargetingAugStatus()
// ----------------------------------------------------------------------

simulated function SetTargetingAugStatus(int Level, bool IsActive)
{
    DeusExRootWindow(Player.rootWindow).hud.augDisplay.bTargetActive = IsActive;
    DeusExRootWindow(Player.rootWindow).hud.augDisplay.bTargetWindowActive = IsActive;
    //bWindowActive = IsActive;
    bViewWindowActive = IsActive && (CurrentLevel > 2);
    DeusExRootWindow(Player.rootWindow).hud.augDisplay.targetLevel = Level;
}

simulated function PreBeginPlay()
{
    Super.PreBeginPlay();

    // If this is a netgame, then override defaults
    if ( Level.NetMode != NM_StandAlone )
    {
        LevelValues[3] = mpAugValue;
        EnergyRate = mpEnergyDrain;
      AugmentationLocation = LOC_Subdermal;
    }
}

defaultproperties
{
     mpAugValue=-0.125000
     mpEnergyDrain=40.000000
     EnergyRate=40.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconTarget'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconTarget_Small'
     AugmentationName="Targeting"
     Description="Image-scaling and recognition provided by multiplexing the optic nerve with doped polyacetylene 'quantum wires' not only increases accuracy, but also delivers limited situational info about a target.|n|nTECH ONE: Slight increase in accuracy and general target information, coupled with minimal telescopic vision.|n|nTECH TWO: Additional increase in accuracy and telescopic vision, and more target information.|n|nTECH THREE: Additional increase in accuracy and telescopic vision, and specific target information.|n|nTECH FOUR: Additional increase in accuracy and telescopic vision."
     MPInfo="When active, all weapon skills are effectively increased by one level, and you can see an enemy's health.  The skill increases allow you to effectively surpass skill level 3.  Energy Drain: Moderate"
     LevelValues(0)=-0.050000
     LevelValues(1)=-0.100000
     LevelValues(2)=-0.150000
     LevelValues(3)=-0.200000
     LevelValues(4)=-0.250000
     AugmentationLocation=LOC_Eye
     MPConflictSlot=4
}
