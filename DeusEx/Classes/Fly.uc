//=============================================================================
// Fly.
//=============================================================================
class Fly extends Animal;

function Carcass SpawnCarcass()
{
	local Inventory item;

	if(DeusExPlayer(GetPlayerPawn()).combatDifficulty <= 4.0)
		return Super.SpawnCarcass();

	item = Inventory;

	while(item != None)
	{
		if(item.Base != Self)
			break;

		if(item.IsA('DeusExWeapon') && DeusExWeapon(item).bNativeAttack)
		{}
		else if(item.IsA('DeusExAmmo') && (!DeusExAmmo(item).bIsNonStandard || item.PickupViewMesh == LodMesh'DeusExItems.TestBox' || item.Description == (class'DeusExAmmo').Default.Description))
		{}
		else
		{
			if(item.IsA('DeusExWeapon'))
			{
				DeusExWeapon(item).AmmoType = None;
				DeusExWeapon(item).PickupAmmoCount = Rand(DeusExWeapon(item).Default.PickupAmmoCount) + 1;
			}

			DeleteInventory(item);
			item.DropFrom(Location);
		}
		item = item.Inventory;

		if(item == Inventory) // looping inventory
			item = None;
	}

	Explode();

	return None;
}


function bool IsNearHome(vector position)
{
	local bool bNear;

	bNear = true;
	if (bUseHome)
		if (VSize(HomeLoc-position) > HomeExtent)
			bNear = false;

	return bNear;
}


function ReactToInjury(Pawn instigatedBy, Name damageType, EHitLocation hitPos) {}

state Wandering
{
	event HitWall(vector HitNormal, actor HitWall)
	{
		local rotator dir;
		local float   elasticity;
		local float   minVel, maxHVel;
		local vector  tempVect;

		elasticity = 0.3;
		Velocity = elasticity*((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);
		DesiredRotation = Rotation;
	}

	function Tick(float deltaTime)
	{
		Super.Tick(deltatime);
	}

	function vector PickDirection()
	{
		local vector  dirVector;
		local rotator rot;

		if (!IsNearHome(Location))
			dirVector = Normal(homeLoc - Location)*AirSpeed*4;
		else
			dirVector = Velocity;
		dirVector += VRand()*AirSpeed*2;
		dirVector = Normal(dirVector);
		rot = Rotator(dirVector);
		if (VSize(Velocity) < AirSpeed*0.5)
		{
			Acceleration = dirVector*AirSpeed;
			SetRotation(rot);
		}
		return vector(rot)*200+Location;
	}

	function BeginState()
	{
		Super.BeginState();
		BlockReactions();
		Acceleration = vector(Rotation)*AccelRate;
	}

Begin:
	bBounce = True;
	destPoint = None;
	MoveTo(Location+Vector(Rotation)*(CollisionRadius+5), 1);

Init:
	bAcceptBump = false;
	TweenToWalking(0.15);
	WaitForLanding();
	FinishAnim();

Wander:
	PlayWalking();

Moving:
	TurnTo(PickDirection());
	Sleep(0.0);
	Goto('Moving');

ContinueWander:
ContinueFromDoor:
	PlayWalking();
	Goto('Wander');
}


function PlayWalking()
{
	LoopAnimPivot('Still');
}
function TweenToWalking(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}



// Approximately five million stubbed out functions...
function PlayRunningAndFiring() {}
function TweenToShoot(float tweentime) {}
function PlayShoot() {}
function TweenToAttack(float tweentime) {}
function PlayAttack() {}
function PlayPanicRunning() {}
function PlaySittingDown() {}
function PlaySitting() {}
function PlayStandingUp() {}
function PlayRubbingEyesStart() {}
function PlayRubbingEyes() {}
function PlayRubbingEyesEnd() {}
function PlayStunned() {}
function PlayFalling() {}
function PlayLanded(float impactVel) {}
function PlayDuck() {}
function PlayRising() {}
function PlayCrawling() {}
function PlayPushing() {}
function PlayFiring() {}
function PlayTakingHit(EHitLocation hitPos) {}

function PlayTurning() {}
function TweenToRunning(float tweentime) {}
function PlayRunning() {}
function TweenToWaiting(float tweentime) {}
function PlayWaiting() {}
function TweenToSwimming(float tweentime) {}
function PlaySwimming() {}

defaultproperties
{
     WalkingSpeed=1.000000
     bLikesNeutral=False
     bHasShadow=False
     bHighlight=False
     bSpawnBubbles=False
     bCanFly=True
     GroundSpeed=100.000000
     WaterSpeed=100.000000
     AirSpeed=100.000000
     AccelRate=500.000000
     JumpZ=0.000000
     MaxStepHeight=1.000000
     MinHitWall=0.000000
     BaseEyeHeight=1.000000
     Health=1
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Fear
     Alliance=Fly
     bTransient=True
     Physics=PHYS_Flying
     DrawType=DT_Mesh
     Mesh=Mesh'DeusExCharacters.Fly'
     DrawScale=1.400000
     SoundRadius=6
     SoundVolume=128
     AmbientSound=Sound'DeusExSounds.Animal.FlyBuzz'
     CollisionRadius=2.000000
     CollisionHeight=1.000000
     bBlockActors=False
     bBlockPlayers=False
     bBounce=True
     Mass=0.100000
     Buoyancy=0.100000
     RotationRate=(Pitch=16384,Yaw=100000)
     BindName="Fly"
     FamiliarName="Fly"
     UnfamiliarName="Fly"
}
