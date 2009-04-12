//=============================================================================
// VendingMachineSpec1.
//=============================================================================
class VendingMachineSpec1 expands VendingMachine;

var localized String msgDispErr1, msgDispErr2;

function Frob(actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local Vector loc;
	local int usediff;
	local Pickup product;

	//Super.Frob(Frobber, frobWith);

	if(numUses <= 10)
	{
		if(msgDispensed == msgDispErr2)
			msgDispensed = Default.msgDispensed;

		Super.Frob(Frobber, frobWith);
	}
	else
	{
		player = DeusExPlayer(Frobber);
	
		if (player != None)
		{
			if (numUses <= 0)
			{
				player.ClientMessage(msgEmpty);
				return;
			}
	
			usediff = Default.numUses - numUses;
			if(usediff == 1)
			{
				msgDispensed = msgDispErr2;
			}
			else
			{
				if(usediff == 0)
					msgDispensed = msgDispErr1;
				else
					msgDispensed = Default.msgDispensed;
	
			}
	
			if (player.Credits >= Cost)
			{
				PlaySound(sound'VendingCoin', SLOT_None);
				loc = Vector(Rotation) * CollisionRadius * 0.8;
				loc.Z -= CollisionHeight * 0.7; 
				loc += Location;
	
				if(usediff == 1)
					product = spawn(Class'AugmentationCannister', None,, loc);
				else
					product = spawn(Class'Sodacan', None,, loc);
	
				if (product != None)
				{
					PlaySound(sound'VendingCan', SLOT_None);
	
					if(product.IsA('AugmentationCannister'))
						AugmentationCannister(product).AddAugs[0] = 'AugSkullGun';
	
					product.Velocity = Vector(Rotation) * 100;
					product.bFixedRotationDir = True;
					product.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
					product.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;
					player.Credits -= Cost;
					player.ClientMessage(Sprintf(msgDispensed,Cost));
					numUses--;
				}
	
				if(usediff == 0)
					Cost = 202;
				else
					Cost = Default.Cost;
			}
			else
				player.ClientMessage(Sprintf(msgNoCredits,Cost));
		}
	}
}

defaultproperties
{
     msgDispErr1="%d credits decuttttt!3kd@t]]i8n^ ERROR -- FOREIGN OBJECT DETECTED"
     msgDispErr2="%d cre4di7ts ded0uct3ed fr3669om your acco322222 PLEASE WAIT -- RESTORING FACTORY DEFAULTS"
     numUses=12
     VendProduct=Class'DeusEx.Sodacan'
}
