//=============================================================================
// Cat.
//=============================================================================
class Cat extends Animal;

var float time;
var name LastStateName;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPCat", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

// ----------------------------------------------------------------------
// WillTakeStompDamage()
// ----------------------------------------------------------------------

function bool WillTakeStompDamage(Actor stomper)
{
	if(stomper == GetPlayerPawn())
		return False; //== Really, JC isn't THAT clumsy

	return Super.WillTakeStompDamage(stomper);
}

function bool ShouldBeStartled(Pawn startler)
{
	local float speed;
	local float time;
	local float dist;
	local float dist2;
	local bool  bPh33r;

	bPh33r = false;
	if (startler != None)
	{
		speed = VSize(startler.Velocity);
		if (speed >= 20 && (startler.CollisionRadius * startler.CollisionHeight) > (CollisionRadius * CollisionHeight * 1.5))
		{
			dist = VSize(Location - startler.Location);
			time = dist/speed;
			if (time <= 3.0)
			{
				dist2 = VSize(Location - (startler.Location+startler.Velocity*time));
				if (dist2 < speed*1.5)
					bPh33r = true;
			}
		}
	}

	return bPh33r;
}

//== Kitties eat birds and rats, y'know
function bool IsValidFood(Actor foodActor)
{
	if(foodActor.IsA('RatCarcass') || foodActor.IsA('SeagullCarcass') || foodActor.IsA('PigeonCarcass'))
	{
		return Super.IsValidFood(foodActor);
	}
	return False;
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if(LastStateName != GetStateName())
	{
		LastStateName = GetStateName();
	}

	time += deltaTime;

	// check for random noises
	if (time > 1.0)
	{
		time = 0;
		if (FRand() < 0.05)
			PlaySound(sound'CatPurr', SLOT_None,,, 128);
	}
}

// ----------------------------------------------------------------------
// CheckEnemyParams()  [internal use only]
// ----------------------------------------------------------------------

function CheckEnemyParams(Pawn checkPawn,
                          out Pawn bestPawn, out int bestThreatLevel, out float bestDist)
{
	local int threatLevel;

	if((!checkPawn.IsA('Animal') || checkPawn.IsA('Cat')) && CheckPawnAllianceType(checkPawn) != ALLIANCE_Hostile) //== Only go after the truly hostile
		return;

	if(checkPawn == Self) //Really now...
		return;

	if(checkPawn.Physics == PHYS_Flying && checkPawn != Enemy) //== Only track flying things if we're already watching them
		return;

	Super.CheckEnemyParams(checkPawn, bestPawn, bestThreatLevel, bestDist);

	if(checkPawn.CollisionHeight * checkPawn.CollisionRadius <= CollisionHeight * CollisionRadius)
		threatLevel = 4;

	if(checkPawn.Physics == PHYS_Flying)
	{
		if(VSize(checkPawn.Location - Location) > 128 && checkPawn.Location.Z - Location.Z >= 16) //Flying things which are too far away get ignored
			threatLevel = -1;
		else
			threatLevel /= 2;
	}

	if(threatLevel > bestThreatLevel)
	{
		bestPawn = checkPawn;
		bestThreatLevel = threatLevel;
		bestDist = VSize(checkPawn.Location - Location);
	}
}

state Attacking
{
	function Tick(float deltaSeconds)
	{
		Super.Tick(deltaSeconds);
		if (Enemy != None)
		{
			if(Enemy.CollisionRadius * Enemy.CollisionHeight > CollisionRadius * CollisionHeight * 1.2 && Weapon.IsA('WeaponCatScratch'))
				GotoState('Fleeing');
		}
	}
}

state Alerting
{
ignores all;
begin:
	GoToState('Wandering');
}

function PlayTakingHit(EHitLocation hitPos)
{
	// nil
}

function PlayAttack()
{
	// nil
}

function TweenToAttack(float tweentime)
{
	// nil
}

function PlayEatingSound()
{
	PlaySound(sound'CatPurr', SLOT_None,,, 128);
}

function PlayStartEating()
{
	AmbientSound = Sound'DeusExSounds.Animal.CatPurr';
}

function PlayEating()
{
	LoopAnim('BreatheLight');
}

function PlayStopEating()
{
	AmbientSound = None;
}

defaultproperties
{
     bPlayDying=True
     FoodClass=Class'DeusEx.DeusExCarcass'
     bFleeBigPawns=True
     MinHealth=0.000000
     CarcassType=Class'DeusEx.CatCarcass'
     WalkingSpeed=0.111111
     InitialAlliances(0)=(AllianceName=Rat,AllianceLevel=-1.000000,bPermanent=True)
     InitialAlliances(1)=(AllianceName=Seagull,AllianceLevel=-1.000000,bPermanent=True)
     InitialAlliances(2)=(AllianceName=Pigeon,AllianceLevel=-1.000000,bPermanent=True)
     InitialAlliances(3)=(AllianceName=Fly,AllianceLevel=1.000000,bPermanent=True)
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponCatScratch')
     GroundSpeed=180.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     MaxStepHeight=14.000000
     BaseEyeHeight=6.000000
     Health=30
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     HitSound1=Sound'DeusExSounds.Animal.CatHiss'
     HitSound2=Sound'DeusExSounds.Animal.CatHiss'
     Die=Sound'DeusExSounds.Animal.CatDie'
     Alliance=Cat
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Cat'
     CollisionRadius=17.000000
     CollisionHeight=11.300000
     bBlockActors=False
     Mass=10.000000
     Buoyancy=97.000000
     RotationRate=(Yaw=100000)
     BindName="Cat"
     FamiliarName="Cat"
     UnfamiliarName="Cat"
}
