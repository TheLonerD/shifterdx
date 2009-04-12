//=============================================================================
// WeaponGrenade.
//  Abstract parent class for LAMs/etc. to reduce the repetition of code
//=============================================================================
class WeaponGrenade extends DeusExWeapon
	abstract;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
	}
}

function PostBeginPlay()
{
   Super.PostBeginPlay();
   bWeaponStay=False;
}

function Fire(float Value)
{
	// if facing a wall, affix the GasGrenade to the wall
	if (Pawn(Owner) != None)
	{
		if (bNearWall)
		{
			bReadyToFire = False;
			GotoState('NormalFire');
			bPointing = True;
			PlayAnim('Place',, 0.1);
			return;
		}
	}

	// otherwise, throw as usual
	Super.Fire(Value);
}

function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Projectile proj;

	proj = Super.ProjectileFire(ProjClass, ProjSpeed, bWarn);

	if (proj != None)
	{
		if(proj.HasAnim('Open'))
			proj.PlayAnim('Open');
	}
}

// Become a pickup
// Weapons that carry their ammo with them don't vanish when dropped
function BecomePickup()
{
	Super.BecomePickup();
   if (Level.NetMode != NM_Standalone)
      if (bTossedOut)
         Lifespan = 0.0;
}

//== For switching between grenade types, including Zodiac's C4.  C4 is a sub-class
//==  of WeaponLAM, so this function works for it
simulated function SwitchItem()
{
	local Class<DeusExWeapon> SwitchList[5];
	local Inventory inv;
	local int i, j;
	local DeusExPlayer P;

	P = DeusExPlayer(Owner);

	i = 0;

	SwitchList[i++] = Class<DeusExWeapon>(DynamicLoadObject("Zodiac.WeaponC4", class'Class', True)); //I am such a badass
	SwitchList[i++] = class'WeaponEMPGrenade';
	SwitchList[i++] = class'WeaponGasGrenade';
	SwitchList[i++] = class'WeaponLAM';
	SwitchList[i++] = class'WeaponNanoVirusGrenade';

	for(i = 0; i < 5; i++)
	{
		if(SwitchList[i] == Class)
			break;
	}

	if(i >= 5) return;

	for(j = 0; j < 5; j++)
	{
		i++;

		if(i >= 5)
			i = 0;

		if(SwitchList[i] != None && SwitchList[i] != Class)
		{
			inv = P.FindInventoryType(SwitchList[i]);

			if(inv != None)
			{
				if((inv.beltPos == -1 || inv.beltPos == beltPos) && DeusExWeapon(inv).TestCycleable())
				{
					if(!bDestroyOnFinish)
						P.ClientMessage(Sprintf(msgSwitchingTo,inv.ItemName));
					P.AddObjectToBelt(inv,Self.beltPos,false);
					P.PutInHand(inv);
					i = 5; //Just to be sure
					break;
				}
			}
		}
	}
}

simulated function bool TestCycleable()
{
	return true;
}

defaultproperties
{
}
