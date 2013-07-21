//=============================================================================
// AugSkullGun. -- Idea graciously stolen from AllSystemsGo on the GameFAQs
//  Deus Ex message board. -- Y|yukichigai
//=============================================================================
class AugSkullGun extends Augmentation;

var float mpAugValue;
var float mpEnergyDrain;

function Activate() //Doesn't need to be overridden, but it makes things easier to do it here.
{
	local Vector Start;
	local Rotator AdjustedAim;
	local float ProjSpeed;
	local class<projectile> ProjClass;
	local DeusExProjectile proj;
	local float perc, temp;

	if(!bHasIt)
		return;

	//== Set some variables
	ProjClass = Class'DeusEx.PlasmaBolt';
	ProjSpeed = ProjClass.Default.speed;
	Start = Player.Location + Player.BaseEyeHeight * vect(0,0,1); //Start point
	AdjustedAim = Player.AdjustAim(ProjSpeed,Start,0.000000,True,False); //Vector path

	//== Spawn the projectile
	proj = DeusExProjectile(Spawn(ProjClass,Player,,Start,AdjustedAim));

	//== Whoops, we need to manually specify who created this projectile.
	//==  Bug reported by NotAVeryGoodName on the SVN
	proj.Instigator = Player;

	//== Get the amount of available BioE Energy the player has and turn it into a percent
	perc = (Player.Energy / Player.EnergyMax) / LevelValues[CurrentLevel];
	if(perc > 1.000000) perc = 1.000000; //Only drain 100% of the required for the current level

	proj.blastRadius = 50.000000; //Smaller blast radius for accuracy
	proj.Damage = (100.000000 + (25.00000/LevelValues[CurrentLevel])) * perc; //Set the damage based on the percentage

	temp = Player.EnergyMax * perc * LevelValues[CurrentLevel]; //Calculate the amount to be drained

	Player.Energy -= temp; //Drain that amount

	Player.PlaySound(sound'DeusExSounds.Weapons.PlasmaRifleFire',,perc,, 1280 * perc);
}

state Active
{
Begin:
}

function Deactivate()
{
	Super.Deactivate();
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		EnergyRate = mpEnergyDrain;
	}
}

defaultproperties
{
     mpAugValue=0.500000
     mpEnergyDrain=10.000000
     EnergyRate=10.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconDatalink'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconDatalink_Small'
     AugmentationName="Skull Gun"
     Description="Nanomolecular fabricators generate a large mass of plastic at the exterior of the cranium, superheating it to plasma just after ejecting it along the agent's line of sight.|n|nTECH ONE: Agent can generate one shot before exhausting energy reserves.|n|nTECH TWO: Energy drain is halved and damage increased.|n|nTECH THREE: Energy drain is reduced by one third and damage is increased.|n|nTECH FOUR: Agent can deploy 4 bursts of high-damage plasma before exhausting energy reserves."
     MPInfo="Fires a burst of plasma from the cranial area.  Energy Drain: Incredibly High"
     LevelValues(0)=1.000000
     LevelValues(1)=0.500000
     LevelValues(2)=0.333333
     LevelValues(3)=0.250000
     LevelValues(4)=0.125000
     MPConflictSlot=3
}
