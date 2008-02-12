//=============================================================================
// Pigeon.
//=============================================================================
class Pigeon extends Bird;

//== Who would have thought it'd take so much damn effort to make a pigeon turn into a rat when it died?
function Carcass SpawnCarcass()
{
	local Fire f;
	local Rat notcarc;
	local Inventory item;

	if(DeusExPlayer(GetPlayerPawn()).combatDifficulty > 4.0 && !Region.Zone.bWaterZone && Health > -100)
	{
		if(frand() > 0.5)
		{
			notcarc = Spawn(class'Rat',Self,, Location, Rotation);
			if(notcarc != None)
			{				
				notcarc.SetLocation(Location);
				notcarc.Velocity = Velocity;
				notcarc.Acceleration = Acceleration;
				notcarc.BurnPeriod = BurnPeriod;

				//== Transfer inventory to the pseudo-carcass
				item = Inventory;
				while(item != None)
				{
					if(item.Owner != Self)
						break;

					DeleteInventory(item);
					item.InitialState='Idle2';
					item.GiveTo(notcarc);
					item.SetBase(notcarc);

					item = item.Inventory;

					if(item == Inventory)
						item = None;
				}

				//== If we're on fire, transfer the fire to the carc
				if(bOnFire)
				{
		
					// Change the base of the fires so we can reuse the existing ones (makes the change seamless)
					foreach BasedActors(class'Fire', f)
					{
						f.SetBase(notcarc);
						f.SetOwner(notcarc);
						if(f.smokeGen != None)
						{
							f.smokeGen.SetBase(notcarc);
							f.smokeGen.SetLocation(f.Location);
							if(f.smokeGen.proxy != None)
							{
								f.smokeGen.proxy.SetCollision(false,false,false);
								f.smokeGen.proxy.bCollideWorld = False;
							}
						}
						if(f.fireGen != None)
						{
							f.fireGen.SetBase(notcarc);
							f.fireGen.SetLocation(f.Location);
							if(f.fireGen.proxy != None)
							{
								f.fireGen.proxy.SetCollision(false,false,false);
								f.fireGen.proxy.bCollideWorld = False;
							}
						}
					}
		
					// Mark the carcass as being on fire
					notcarc.bOnFire = True;			
					notcarc.burnTimer = burnTimer;
		
					// Do everything in ExtinguishFire manually, save the clearing of the fires
					bOnFire = False;
					burnTimer = 0;
					SetTimer(0, False);
				}
				return None;
			}
		}
	}
	return Super.SpawnCarcass();
}

//     InitialAlliances(0)=(AllianceName=Seagull,AllianceLevel=-1.000000)

defaultproperties
{
     CarcassType=Class'DeusEx.PigeonCarcass'
     WalkingSpeed=0.666667
     GroundSpeed=24.000000
     WaterSpeed=8.000000
     AirSpeed=150.000000
     AccelRate=500.000000
     JumpZ=0.000000
     BaseEyeHeight=3.000000
     Health=20
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Fear
     HealthHead=20
     HealthTorso=20
     HealthLegLeft=20
     HealthLegRight=20
     HealthArmLeft=20
     HealthArmRight=20
     Alliance=Pigeon
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Pigeon'
     CollisionRadius=10.000000
     CollisionHeight=3.000000
     Mass=2.000000
     Buoyancy=2.500000
     RotationRate=(Pitch=6000)
     BindName="Pigeon"
     FamiliarName="Pigeon"
     UnfamiliarName="Pigeon"
}
