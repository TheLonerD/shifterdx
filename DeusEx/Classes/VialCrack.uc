//=============================================================================
// VialCrack.
//=============================================================================

//Modified -- Y|yukichigai
//Okay, here's the skinny: the Activated state sets the drug timer to a number
//less than zero.  The code that calculates drug effects has been modified so
//that values that are less than zero provide a boost rather than an impairment.

class VialCrack extends Consumable;

state Activated
{
	function Activate()
	{

	}

	function BeginState()
	{
		local DeusExPlayer player;

		player = DeusExPlayer(Owner);

		if(player == None)
			return;

		if(player.drugEffectTimer < 0.0)
			return;
		else
			player.drugEffectTimer = -1.0;
		
		//=== Here begin the bullet time effects.  Neat how simple it is, huh?
		//=== The values are relative and not set in stone so that users who must
		//===  modify the GameSpeed for play (usually laptop users) don't get
		//===  messed up when they use Zyme.  There is still a risk if the speed has been
		//===  lowered to something below 0.2, since the absolute lowest the game can run
		//===  is 0.1 speed.
		if(player.Level.NetMode == NM_Standalone)
			player.Level.Game.SetGameSpeed(player.Level.Game.GameSpeed / 2.000);
		else
			log("VialCrack: Some smartass put Zyme in a multiplayer map.  Hit them.");
	
		Super.BeginState(); //The parent class handles setting the drug effect and all that
	}
Begin:
}

defaultproperties
{
     drugEffect=-14.000000
     healthEffect=-10
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Zyme Vial"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.VialCrack'
     PickupViewMesh=LodMesh'DeusExItems.VialCrack'
     ThirdPersonMesh=LodMesh'DeusExItems.VialCrack'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconVial_Crack'
     largeIcon=Texture'DeusExUI.Icons.LargeIconVial_Crack'
     largeIconWidth=24
     largeIconHeight=43
     Description="A vial of zyme, brewed up in some basement lab.|n|n<UNATCO OPS FILE NOTE JR127-VIOLET>Zyme was once considered for distribution to agents in the field as an emergency ability-booster, but the significant after-effects were determined to be too prolonged for Zyme to be effective for in-field use. -- Jaime Reyes <END NOTE>"
     beltDescription="ZYME"
     Mesh=LodMesh'DeusExItems.VialCrack'
     CollisionRadius=0.910000
     CollisionHeight=1.410000
     Mass=2.000000
     Buoyancy=3.000000
}
