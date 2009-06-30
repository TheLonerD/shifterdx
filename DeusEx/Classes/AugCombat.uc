//=============================================================================
// AugCombat.
//  Electrostatic Discharge.  Was Combat Strength
//=============================================================================
//Description="Sorting rotors accelerate calcium ion concentration in the sarcoplasmic reticulum, increasing an agent's muscle speed several-fold and multiplying the damage they inflict in melee combat.|n|nTECH ONE: The effectiveness of melee weapons is increased slightly.|n|nTECH TWO: The effectiveness of melee weapons is increased moderately.|n|nTECH THREE: The effectiveness of melee weapons is increased significantly.|n|nTECH FOUR: Melee weapons are almost instantly lethal."
//MPInfo="When active, you do double damage with melee weapons.  Energy Drain: Low"
//     LevelValues(0)=1.250000
//     LevelValues(1)=1.500000
//     LevelValues(2)=1.750000
//     LevelValues(3)=2.000000

class AugCombat extends Augmentation;

var float mpAugValue;
var float mpEnergyDrain;

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
		LevelValues[3] = mpAugValue;
		EnergyRate = mpEnergyDrain;
	}
	else if(IsA('tnmpcAugCombat'))
	{
		AugmentationName = "Combat Strength";
		Description = "Hit things.  Hit hard.  Make go smash.|n|nTECH ONE: Extra smashey.|n|nTECH TWO: More extra smashey.|n|nTECH THREE: More more smashey!|n|nTECH FOUR: EXTRA LOTS OF MEGA SMASHEY!";
		MPInfo="When active, you do double damage with melee weapons.  Energy Drain: Low";
		LevelValues[0] = 1.25;
		LevelValues[1] = 1.50;
		LevelValues[2] = 1.75;
		LevelValues[3] = 2.00;
		LevelValues[4] = 2.25;
	}
}

defaultproperties
{
     mpAugValue=2.000000
     mpEnergyDrain=20.000000
     EnergyRate=20.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconCombat'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconCombat_Small'
     AugmentationName="Electrostatic Discharge"
     Description="Nanomolecular capacitors under the skin store bioelectric energy in the agent's hands, discharging bursts of static electricity during hand-to-hand combat.|n|nTECH ONE: Melee weapons inflict a low amount of EMP damage.|n|n|TECH TWO: Melee weapons inflict a moderate amount of EMP damage and can disrupt the AI routines of some bots.|n|nTECH THREE: Melee weapons inflict a moderate amount of EMP damage and can disrupt the AI routines of most bots.|n|nTECH FOUR: The agent can take out a dozen bots with a toothpick."
     MPInfo="When active, melee weapons do EMP damage.  Energy Drain: Low"
     LevelValues(0)=0.500000
     LevelValues(1)=1.500000
     LevelValues(2)=3.250000
     LevelValues(3)=5.000000
     LevelValues(4)=7.500000
     AugmentationLocation=LOC_Arm
     MPConflictSlot=1
}
