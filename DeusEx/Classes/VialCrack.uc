//=============================================================================
// VialCrack.
//=============================================================================

//Modified -- Y|yukichigai
//Okay, here's the skinny: the Activated state sets the drug timer to a number
//less than zero.  The code that calculates drug effects has been modified so
//that values that are less than zero provide a boost rather than an impairment.

class VialCrack extends DeusExPickup;

//== Look ma, we can switch between food items now
function SwitchItem()
{
	local Class<DeusExPickup> SwitchList[6];
	local Inventory inv;
	local int i;
	local DeusExPlayer P;

	P = DeusExPlayer(Owner);

	i = 0;

	//== Comment out the self reference here and we're done
//	SwitchList[i++] = class'VialCrack';
	SwitchList[i++] = class'Candybar';
	SwitchList[i++] = class'Liquor40oz';
	SwitchList[i++] = class'LiquorBottle';
	SwitchList[i++] = class'Sodacan';
	SwitchList[i++] = class'SoyFood';
	SwitchList[i++] = class'WineBottle';

	for(i = 0; i < 6; i++)
	{
		inv = P.FindInventoryType(SwitchList[i]);

		if(inv != None)
		{
			if(inv.beltPos == -1)
			{
				P.ClientMessage(Sprintf(SwitchingTo,inv.ItemName));
				P.AddObjectToBelt(inv,Self.beltPos,false);
				P.PutInHand(inv);
				i = 6;
				break;
			}
		}
	}
}
state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player;
		local Inventory inv;

		player = DeusExPlayer(Owner);

		if(player.drugEffectTimer < 0.0)
			return;
		
		Super.BeginState();

		if (player != None)
		{
			//=== Here begin the bullet time effects.  Neat how simple it is, huh?
			//=== The values are relative and not set in stone so that users who must
			//===  modify the GameSpeed for play (usually laptop users) don't get
			//===  messed up when they use Zyme.  There is still a risk if the speed has been
			//===  lowered to something below 0.2, since the absolute lowest the game can run
			//===  is 0.1 speed.
			if(Level.NetMode == NM_Standalone)
				Level.Game.SetGameSpeed(Level.Game.GameSpeed / 2.000);

			//=== Since game speed is halved the time is doubled.  15 seconds is actually 30 seconds
			player.drugEffectTimer = -15.0;
			player.HealPlayer(-10, False);
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
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
