//=============================================================================
// MP Orange (Agent O-range, a vending machine)
//=============================================================================
class MPORANGE extends Human;

function PlayTurning(){}
function TweenToWalking(float tweentime){}
function PlayWalking(){}
function TweenToRunning(float tweentime){}
function PlayRunning(){}
function TweenToWaiting(float tweentime){}
function PlayWaiting(){}
function PlaySwimming(){}
function TweenToSwimming(float tweentime){}
function PlayInAir(){}

function PlayLanded(float impactVel)
{
	PlayFootStep();
}

function PlayDuck(){}
function PlayRising(){}
function PlayFiring(){}
function PlayWeaponSwitch(Weapon newWeapon){}

function PlayDying(name damageType, vector hitLoc)
{
	PlayDyingSound();
}

function Carcass SpawnCarcass()
{
	local VendingMachine vend;
	local Inventory item;
	local DeusExFragment s;
	local int i;

	for (item=Inventory; item!=None; item=Inventory)
	{
		DeleteInventory(item);
		if(!item.IsA('DeusExAmmo'))
		{
			item.DropFrom(Location);
			item.Velocity = (Vector(Rotation) + (VRand() * 14)) * (10 + Rand(30));
			item.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
			item.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;
		}
		i++;
	}


	if(Health < -80)
	{
		//== Free soda, yay! ^_^
		while(i > 0)
		{
			item = Spawn(class'Sodacan');
			if(item != None)
			{
				item.Velocity = (Vector(Rotation) + (VRand() * 14)) * (10 + Rand(30));
				item.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
				item.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;
			}
			i--;
		}

		for (i=0; i<3; i++)
		{
			s = Spawn(class'MetalFragment', Self);
			if (s != None)
			{
				s.Instigator = Self;
				s.CalcVelocity(Velocity, 80);
				s.DrawScale = 80*0.075*FRand();
				s.Skin = GetMeshTexture();
				if (FRand() < 0.75)
					s.bSmoking = True;
			}
		}
	}
	else
	{
		for (i=0 ; i<7 ; i++) 
		{
			s = Spawn(class'GlassFragment', Self);
			if (s != None)
			{
				s.Instigator = Self;
				s.CalcVelocity(Velocity,0);
				s.DrawScale = 1*0.5+0.7*1*FRand();
			}
		}
		vend = Spawn(Class'VendingMachine');
		vend.bPushable = False;
		vend.bInvincible = False;
		vend.Cost = 0;
	}
	return None;
}

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();
}

state PlayerWalking
{
	function ProcessMove ( float DeltaTime, vector newAccel, eDodgeDir DodgeMove, rotator DeltaRot)
	{
		local int newSpeed, defSpeed;
		local name mat;
		local vector HitLocation, HitNormal, checkpoint, downcheck;
		local Actor HitActor, HitActorDown;
		local bool bCantStandUp;
		local Vector loc, traceSize;
		local float alpha, maxLeanDist;
		local float legTotal, weapSkill;
		local vector OldAccel;

		// if the spy drone augmentation is active
		if (bSpyDroneActive)
		{
			if ( aDrone != None ) 
			{
				// put away whatever is in our hand
				if (inHand != None)
					PutInHand(None);

				// make the drone's rotation match the player's view
				aDrone.SetRotation(ViewRotation);

				// move the drone
				loc = Normal((aUp * vect(0,0,1) + aForward * vect(1,0,0) + aStrafe * vect(0,1,0)) >> ViewRotation);

				// opportunity for client to translate movement to server
				MoveDrone( DeltaTime, loc );

				// freeze the player
				Velocity = vect(0,0,0);
			}
			return;
		}

		defSpeed = GetCurrentGroundSpeed();

      // crouching makes you two feet tall
		if (bIsCrouching || bForceDuck)
		{
			if ( Level.NetMode != NM_Standalone )
				SetBasedPawnSize(Default.CollisionRadius * 3.0 / 4.0, 30.0);
			else
				SetBasedPawnSize(Default.CollisionRadius * 3.0 / 4.0, 16);

			// check to see if we could stand up if we wanted to
			checkpoint = Location;
			// check normal standing height
			checkpoint.Z = checkpoint.Z - CollisionHeight + 2 * GetDefaultCollisionHeight();
			traceSize.X = CollisionRadius;
			traceSize.Y = CollisionRadius;
			traceSize.Z = 1;
			HitActor = Trace(HitLocation, HitNormal, checkpoint, Location, True, traceSize);
			if (HitActor == None)
				bCantStandUp = False;
			else
				bCantStandUp = True;
		}
		else
		{
         // DEUS_EX AMSD Changed this to grab defspeed, because GetCurrentGroundSpeed takes 31k cycles to run.
			GroundSpeed = defSpeed;

			// make sure the collision height is fudged for the floor problem - CNN
			if (!IsLeaning())
			{
				ResetBasedPawnSize();
			}
		}

		if (bCantStandUp)
			bForceDuck = True;
		else
			bForceDuck = False;

		// if the player's legs are damaged, then reduce our speed accordingly
		newSpeed = defSpeed;

		if ( Level.NetMode == NM_Standalone )
		{
			if (HealthLegLeft < 1)
				newSpeed -= (defSpeed/2) * 0.25;
			else if (HealthLegLeft < 34)
				newSpeed -= (defSpeed/2) * 0.15;
			else if (HealthLegLeft < 67)
				newSpeed -= (defSpeed/2) * 0.10;

			if (HealthLegRight < 1)
				newSpeed -= (defSpeed/2) * 0.25;
			else if (HealthLegRight < 34)
				newSpeed -= (defSpeed/2) * 0.15;
			else if (HealthLegRight < 67)
				newSpeed -= (defSpeed/2) * 0.10;

			if (HealthTorso < 67)
				newSpeed -= (defSpeed/2) * 0.05;
		}

		// let the player pull themselves along with their hands even if both of
		// their legs are blown off
		if ((HealthLegLeft < 1) && (HealthLegRight < 1))
		{
			newSpeed = defSpeed * 0.8;
			bIsWalking = True;
			bForceDuck = True;
		}
		// make crouch speed faster than normal
		else if (bIsCrouching || bForceDuck)
		{
//			newSpeed = defSpeed * 1.8;		// DEUS_EX CNN - uncomment to speed up crouch
			bIsWalking = True;
		}

		// slow the player down if he's carrying something heavy
		// Like a DEAD BODY!  AHHHHHH!!!
		if (CarriedDecoration != None)
		{
			newSpeed -= CarriedDecoration.Mass * 2;
		}
		// don't slow the player down if he's skilled at the corresponding weapon skill  
		else if ((DeusExWeapon(Weapon) != None) && (Weapon.Mass > 30) && (DeusExWeapon(Weapon).GetWeaponSkill() > -0.25) && (Level.NetMode==NM_Standalone))
		{
			bIsWalking = True;
			newSpeed = defSpeed;
		}
		else if ((inHand != None) && inHand.IsA('POVCorpse'))
		{
			newSpeed -= inHand.Mass * 3;
		}

		// Multiplayer movement adjusters
		if ( Level.NetMode != NM_Standalone )
		{
			if ( Weapon != None )
			{
				weapSkill = DeusExWeapon(Weapon).GetWeaponSkill();
				// Slow down heavy weapons in multiplayer
				if ((DeusExWeapon(Weapon) != None) && (Weapon.Mass > 30) )
				{
					newSpeed = defSpeed;
					newSpeed -= ((( Weapon.Mass - 30.0 ) / (class'WeaponGEPGun'.Default.Mass - 30.0 )) * (0.70 + weapSkill) * defSpeed );
				}
				// Slow turn rate of GEP gun in multiplayer to discourage using it as the most effective close quarters weapon
				if ((WeaponGEPGun(Weapon) != None) && (!WeaponGEPGun(Weapon).bZoomed))
					TurnRateAdjuster = FClamp( 0.20 + -(weapSkill*0.5), 0.25, 1.0 );
				else
					TurnRateAdjuster = 1.0;
			}
			else
				TurnRateAdjuster = 1.0;
		}

		// if we are moving really slow, force us to walking
		if ((newSpeed <= defSpeed / 3) && !bForceDuck)
		{
			bIsWalking = True;
			newSpeed = defSpeed;
		}

		// if we are moving backwards, we should move slower
	      // DEUS_EX AMSD Turns out this wasn't working right in multiplayer, I have a fix
	      // for it, but it would change all our balance.
		if ((aForward < 0) && (Level.NetMode == NM_Standalone))
			newSpeed *= 0.65;

		//Zyme effect
		if(drugEffectTimer < 0) //(FindInventoryType(Class'DeusEx.ZymeCharged') != None)
			newSpeed *= 1.2;

		GroundSpeed = FMax(newSpeed, 100);

		// if we are moving or crouching, we can't lean
		// uncomment below line to disallow leaning during crouch

			if ((VSize(Velocity) < 10) && (aForward == 0))		// && !bIsCrouching && !bForceDuck)
				bCanLean = True;
			else
				bCanLean = False;

			// check leaning buttons (axis aExtra0 is used for leaning)
			maxLeanDist = 40;

			if (IsLeaning())
			{
				if ( PlayerIsClient() || (Level.NetMode == NM_Standalone) )
					ViewRotation.Roll = curLeanDist * 20;
			
				if (!bIsCrouching && !bForceDuck)
					SetBasedPawnSize(CollisionRadius, GetDefaultCollisionHeight() - Abs(curLeanDist) / 3.0);
			}
			if (bCanLean && (aExtra0 != 0))
			{
				// lean
				DropDecoration();		// drop the decoration that we are carrying
				if (AnimSequence != 'CrouchWalk')
					PlayCrawling();

				alpha = maxLeanDist * aExtra0 * 2.0 * DeltaTime;

				loc = vect(0,0,0);
				loc.Y = alpha;
				if (Abs(curLeanDist + alpha) < maxLeanDist)
				{
					// check to make sure the destination not blocked
					checkpoint = (loc >> Rotation) + Location;
					traceSize.X = CollisionRadius;
					traceSize.Y = CollisionRadius;
					traceSize.Z = CollisionHeight;
					HitActor = Trace(HitLocation, HitNormal, checkpoint, Location, True, traceSize);

					// check down as well to make sure there's a floor there
					downcheck = checkpoint - vect(0,0,1) * CollisionHeight;
					HitActorDown = Trace(HitLocation, HitNormal, downcheck, checkpoint, True, traceSize);
					if ((HitActor == None) && (HitActorDown != None))
					{
						if ( PlayerIsClient() || (Level.NetMode == NM_Standalone))
						{
							SetLocation(checkpoint);
							ServerUpdateLean( checkpoint );
							curLeanDist += alpha;
						}
					}
				}
				else
				{
					if ( PlayerIsClient() || (Level.NetMode == NM_Standalone) )
						curLeanDist = aExtra0 * maxLeanDist;
				}
			}
			else if (IsLeaning())	//if (!bCanLean && IsLeaning())	// uncomment this to not hold down lean
			{
				// un-lean
				if (AnimSequence == 'CrouchWalk')
					PlayRising();

				if ( PlayerIsClient() || (Level.NetMode == NM_Standalone))
				{
					prevLeanDist = curLeanDist;
					alpha = FClamp(7.0 * DeltaTime, 0.001, 0.9);
					curLeanDist *= 1.0 - alpha;
					if (Abs(curLeanDist) < 1.0)
						curLeanDist = 0;
				}

				loc = vect(0,0,0);
				loc.Y = -(prevLeanDist - curLeanDist);

				// check to make sure the destination not blocked
				checkpoint = (loc >> Rotation) + Location;
				traceSize.X = CollisionRadius;
				traceSize.Y = CollisionRadius;
				traceSize.Z = CollisionHeight;
				HitActor = Trace(HitLocation, HitNormal, checkpoint, Location, True, traceSize);

				// check down as well to make sure there's a floor there
				downcheck = checkpoint - vect(0,0,1) * CollisionHeight;
				HitActorDown = Trace(HitLocation, HitNormal, downcheck, checkpoint, True, traceSize);
				if ((HitActor == None) && (HitActorDown != None))
				{
					if ( PlayerIsClient() || (Level.NetMode == NM_Standalone))
					{
						SetLocation( checkpoint );
						ServerUpdateLean( checkpoint );
					}
				}
			}

		      
		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );
		if ( (DodgeMove == DODGE_Active) && (Physics == PHYS_Falling) )
			DodgeDir = DODGE_Active;	
		else if ( (DodgeMove != DODGE_None) && (DodgeMove < DODGE_Active) )
			Dodge(DodgeMove);

		if ( bPressedJump )
			DoJump();

	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     HitSound3=Sound'DeusExSounds.Generic.ArmorRicochet'
     CarcassType=Class'DeusEx.GuntherHermannCarcass'
     JumpSound=Sound'DeusExSounds.Robot.SpiderBotWalk'
     HitSound1=Sound'DeusExSounds.Generic.MetalBounce1'
     HitSound2=Sound'DeusExSounds.Generic.GlassBreakSmall'
     Land=Sound'DeusExSounds.Pickup.PickupDeactivate'
     Die=Sound'DeusExSounds.Generic.GlassBreakLarge'
     Mesh=LodMesh'DeusExDeco.VendingMachine'
     CollisionRadius=34.000000
     CollisionHeight=50.000000
}
