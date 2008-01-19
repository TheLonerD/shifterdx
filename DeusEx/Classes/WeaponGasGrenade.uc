//=============================================================================
// WeaponGasGrenade.
//=============================================================================
class WeaponGasGrenade extends DeusExWeapon;

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

// Become a pickup
// Weapons that carry their ammo with them don't vanish when dropped
function BecomePickup()
{
	Super.BecomePickup();
   if (Level.NetMode != NM_Standalone)
      if (bTossedOut)
         Lifespan = 0.0;
}

//== For switching between grenade types, including Zodiac's C4
function SwitchItem()
{
	local Class<DeusExWeapon> SwitchList[5];
	local Inventory inv;
	local int i;
	local DeusExPlayer P;

	P = DeusExPlayer(Owner);

	i = 0;

	SwitchList[i++] = class'WeaponGasGrenade';
	SwitchList[i++] = class'WeaponNanoVirusGrenade';
	SwitchList[i++] = class'WeaponLAM';
	SwitchList[i++] = Class<DeusExWeapon>(DynamicLoadObject("Zodiac.WeaponC4", class'Class', True)); //I am such a badass
	SwitchList[i++] = class'WeaponEMPGrenade';

	for(i = 0; i < 5; i++)
	{
		if(SwitchList[i] != None && SwitchList[i] != Class)
		{
			inv = P.FindInventoryType(SwitchList[i]);

			if(inv != None)
			{
				if(inv.beltPos == -1 && DeusExWeapon(inv).TestCycleable())
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

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 7);
}

defaultproperties
{
     LowAmmoWaterMark=2
     GoverningSkill=Class'DeusEx.SkillDemolition'
     EnemyEffective=ENMEFF_Organic
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_All
     ShotTime=0.300000
     reloadTime=0.100000
     HitDamage=0
     maxRange=4800
     AccurateRange=2400
     BaseAccuracy=1.000000
     bPenetrating=False
     StunDuration=60.000000
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     AITimeLimit=4.000000
     AIFireDelay=20.000000
     bNeedToSetMPPickupAmmo=False
     mpReloadTime=0.100000
     mpHitDamage=2
     mpBaseAccuracy=1.000000
     mpAccurateRange=2400
     mpMaxRange=2400
     AmmoName=Class'DeusEx.AmmoGasGrenade'
     ReloadCount=1
     PickupAmmoCount=1
     FireOffset=(Y=10.000000,Z=20.000000)
     ProjectileClass=Class'DeusEx.GasGrenade'
     shakemag=50.000000
     SelectSound=Sound'DeusExSounds.Weapons.GasGrenadeSelect'
     InventoryGroup=21
     ItemName="Gas Grenade"
     PlayerViewOffset=(Y=-13.000000,Z=-19.000000)
     PlayerViewMesh=LodMesh'DeusExItems.GasGrenade'
     PickupViewMesh=LodMesh'DeusExItems.GasGrenadePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.GasGrenade3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconGasGrenade'
     largeIcon=Texture'DeusExUI.Icons.LargeIconGasGrenade'
     largeIconWidth=23
     largeIconHeight=46
     Description="Upon detonation, the gas grenade releases a large amount of CS (a military-grade 'tear gas' agent) over its area of effect. CS will cause irritation to all exposed mucous membranes leading to temporary blindness and uncontrolled coughing. Like a LAM, gas grenades can be attached to any surface."
     beltDescription="GAS GREN"
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=2.300000
     CollisionHeight=3.300000
     Mass=5.000000
     Buoyancy=2.000000
}
