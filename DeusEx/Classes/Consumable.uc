//=============================================================================
// Consumable. (Non-health)
//  Abstract parent class for Soda/etc. to reduce the repetition of code
//=============================================================================
class Consumable extends DeusExPickup
	abstract;

var	float	drugEffect; //What effect, if any, this has on the player's drugEffectTimer
var	int	healthEffect; //What effect, if any, this has on the player's overall health

//== Look ma, we can switch between food items now
function SwitchItem()
{
	local Class<DeusExPickup> SwitchList[8];
	local Inventory inv;
	local int i, j;
	local DeusExPlayer P;

	P = DeusExPlayer(Owner);

	if(P == None)
		return;

	i = 0;

	SwitchList[i++] = class'Candybar';
	SwitchList[i++] = class'Cigarettes';
	SwitchList[i++] = class'Liquor40oz';
	SwitchList[i++] = class'LiquorBottle';
	SwitchList[i++] = class'Sodacan';
	SwitchList[i++] = class'SoyFood';
	SwitchList[i++] = class'WineBottle';
	SwitchList[i++] = class'VialCrack';

	for(i = 0; i < 8; i++)
	{
		if(SwitchList[i] == Class)
			break;
	}

	for(j = 0; j < 8; j++)
	{
		i++;

		if(i >= 8)
			i = 0;

		inv = P.FindInventoryType(SwitchList[i]);

		if(SwitchList[i] != Class && inv != None)
		{
			if(inv.beltPos == -1 || inv.beltPos == beltPos)
			{
				P.ClientMessage(Sprintf(SwitchingTo,inv.ItemName));
				P.AddObjectToBelt(inv,Self.beltPos,false);
				P.PutInHand(inv);
				j = 8;
				break;
			}
		}
	}
}

function Frob(Actor Frobber, Inventory FrobWith)
{
	local DeusExPlayer player;
	local int mult;

	if(Level.NetMode != NM_Standalone && DeusExPlayer(Frobber) != None)
	{
		player = DeusExPlayer(Frobber);
		if (player != None)
		{
			mult = healthEffect;

			if(player.SkillSystem != None)
				mult += player.SkillSystem.GetSkillLevel(class'SkillMedicine');

			if(mult > 0)
				player.HealPlayer(mult, False);
			else if(mult < 0)
				player.TakeDamage(-mult, player, player.Location, vect(0,0,0), 'PoisonGas');

			if(drugEffect != 0.0)
			{
				if(player.drugEffectTimer < 0.0)
					player.drugEffectTimer = FMin(-0.01, player.drugEffectTimer + drugEffect);
				else
					player.drugEffectTimer = FMax(0.00, player.drugEffectTimer + drugEffect);
			}
		}

		Destroy();
	}
	else
		Super.Frob(Frobber, FrobWith);
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
		local int mult;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			mult = healthEffect;

			if(player.SkillSystem != None)
				mult += player.SkillSystem.GetSkillLevel(class'SkillMedicine');

			if(mult > 0)
				player.HealPlayer(mult, False);
			else if(mult < 0)
				player.TakeDamage(-mult, player, player.Location, vect(0,0,0), 'PoisonGas');

			if(drugEffect != 0.0)
			{
				if(player.drugEffectTimer < 0.0)
					player.drugEffectTimer = FMin(-0.01, player.drugEffectTimer + drugEffect);
				else
					player.drugEffectTimer = FMax(0.00, player.drugEffectTimer + drugEffect);
			}
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
}
