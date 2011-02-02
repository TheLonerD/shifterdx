//=============================================================================
// WeaponRailgun.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponRailgun extends WeaponPlasmaRifle;

var LaserEmitter FireBeamEmitter; //== For firing effects

simulated function float CalculateAccuracy()
{
	if(bLasing || bZoomed)
		return 0.0;

	return FMax(0.0, Super.CalculateAccuracy() - 0.5);
}

simulated function DoTraceFire( float Accuracy )
{
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z, LastHit;
	local Rotator rot;
	local actor Other, Last;
	local Pawn pOther;
//	local Decoration dOther;
	local float dist;
	local float volume, radius;
	local float i;
	local int j;

	GetAIVolume(volume, radius);
	Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
	Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
	if (!Owner.IsA('PlayerPawn'))
		Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);

	PlayFiringSound();

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace = ComputeProjectileStart(X, Y, Z);
	AdjustedAim = pawn(owner).AdjustAim(1000000, StartTrace, 2.75*AimError, False, False);

	EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;
	EndTrace += (FMax(1024.0, MaxRange) * vector(AdjustedAim));

	Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
	dist = Abs(VSize(HitLocation - Owner.Location));
	j = 0;
	//=== Note to self, rewrite with less accuracy but make so it does a backwards check when it clears a wall
	while(Other != None && dist <= MaxRange && j <= 250)
	{
		j++;
		i = 1.000000;
		ProcessTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		StartTrace = HitLocation + (0.100000 * vector(AdjustedAim));
		Last = Other;
		Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
		//== If the trace hits the same object we want to force it to continue on.  For Level (map) shapes we want
		//== it to make sure the hit location is close, since it's possible to intersect the Level multiple times
		while(Last == Other && i <= 300.000000 && (Other != Level || (Other == Level && Abs(VSize(HitLocation - StartTrace)) <= 0.200000)))
		{
			i += 1.000000;
			if(i > 300.000000)
			{
				dist = MaxRange + 2.000000;
				Other = None;
				break;
			}
			StartTrace = HitLocation + (0.200000 * vector(AdjustedAim));
			Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
		}
		dist = Abs(VSize(HitLocation - Owner.Location));
	}

	FireBeamEmitter = Spawn(class'LaserEmitter', None, , Location, Pawn(Owner).ViewRotation);
	if(FireBeamEmitter != None)
	{
		FireBeamEmitter.AmbientSound = None;
		if(FireBeamEmitter.proxy != None)
			FireBeamEmitter.proxy.Skin = Texture'Wepn_Prifle_SFX';
		FireBeamEmitter.TurnOn();
		FireBeamEmitter.Lifespan = 0.5;

		for(j=0; j<ArrayCount(FireBeamEmitter.spot); j++)
		{
			if (FireBeamEmitter.spot[j] != None)
			{
				FireBeamEmitter.spot[j].Skin = Texture'proj_Prifle';
			}
		}

		//== This code is supposed to make the beam go through walls, but it doesn't
/*		for (j=0; j<ArrayCount(FireBeamEmitter.spot); j++)
		{
			if (FireBeamEmitter.spot[j] != None)
			{
				FireBeamEmitter.spot[j].Destroy();
				FireBeamEmitter.spot[j] = None;
				if (LaserIterator(FireBeamEmitter.RenderInterface) != None)
					LaserIterator(FireBeamEmitter.RenderInterface).DeleteBeam(j);
			}
		}

		if (LaserIterator(FireBeamEmitter.RenderInterface) != None)
			LaserIterator(FireBeamEmitter.RenderInterface).AddBeam(0, Location, FireBeamEmitter.Rotation, 1200);

		FireBeamEmitter.spot[0] = Spawn(class'LaserSpot', FireBeamEmitter, , Location, FireBeamEmitter.Rotation);
		if(FireBeamEmitter.spot[0] != None)
			FireBeamEmitter.spot[0].Skin = Texture'proj_Prifle';

		FireBeamEmitter.bIsOn = False;
*/
		

		SetTimer(0.6, False); //== Deactivate the laser trail after a little while
	}

	EndTrace = Pawn(Owner).Location;
	EndTrace.Z += Pawn(Owner).BaseEyeHeight;

	//== This will make absolutely sure that we hit a target we're aiming at, just not necessarily in the right place
	foreach allActors(class'Pawn', pOther)
	{
		dist = Abs(VSize(pOther.Location - EndTrace));

		if(pOther != Owner && dist <= AccurateRange)
		{
			LastHit = pOther.Location;
			LastHit.Z += pOther.CollisionHeight / 2;
	
			//== Manually calculate the collision and offset.  Bleh.
			if(pOther.CollisionRadius > VSize( ( (dist * Normal(LastHit - EndTrace) ) - ( dist * Normal(vector(AdjustedAim)) ) ) * vect(1,1,0) ) &&
				(pOther.CollisionHeight / 2) > VSize( ( (dist * Normal(LastHit - EndTrace) ) - ( dist * Normal(vector(AdjustedAim)) ) ) * vect(0,0,1) ) )
			{
				//== Switch this with some code that does trace shot backwards and then forwards really quickly to get a proper hit location
				LastHit = dist * Normal(vector(AdjustedAim));
				Other = Pawn(Owner).TraceShot(HitLocation, HitNormal, LastHit - ( Normal(vector(AdjustedAim)) * pOther.CollisionRadius * 5.000000 / 9.000000), LastHit + (Normal(vector(AdjustedAim)) * pOther.CollisionRadius * 5.000000 / 9.000000));

				//== Since headshot/etc. calculation isn't working properly yet, let's just up the damage to absurd levels
				for(j = 0; j < 5; j++)
					ProcessTraceHit(pOther, HitLocation, HitNormal, vector(AdjustedAim), Y, Z);
			}
		}
	}


	//== This code needs to check for rotation, as decorations can have non-zero Z orientations
/*	foreach allActors(class'Decoration', dOther)
	{
		LastHit = dOther.Location;
		LastHit.Z += dOther.CollisionHeight / 2;

		EndTrace = Pawn(Owner).Location;
		EndTrace.Z += Pawn(Owner).BaseEyeHeight;

		if(dOther.CollisionRadius > VSize( ( (dist * Normal(LastHit - EndTrace) ) - ( dist * vector(Pawn(Owner).ViewRotation) ) ) * vect(1,1,0) ) &&
			(dOther.CollisionHeight / 2) > VSize( ( (dist * Normal(LastHit - EndTrace) ) - ( dist * vector(Pawn(Owner).ViewRotation) ) ) * vect(0,0,1) ) )
		{
			LastHit = dist * vector(Pawn(Owner).ViewRotation);

			ProcessTraceHit(dOther, LastHit, -1 * vector(Pawn(Owner).ViewRotation), vector(AdjustedAim), Y, Z);
		}
	} */

}

function Timer()
{
	if(FireBeamEmitter != None)
	{
		FireBeamEmitter.bIsOn = True;
		FireBeamEmitter.TurnOff();
		FireBeamEmitter.Destroy();
	}
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	//== No timer set and a beam effect active
	if(FireBeamEmitter != None && TimerRate <=0)
	{
		FireBeamEmitter.bIsOn = True;
		FireBeamEmitter.TurnOff();
		FireBeamEmitter.Destroy();
	}
}

defaultproperties
{
     LowAmmoWaterMark=5
     AmmoUseModifier=4
     NoiseLevel=0.250000
     EnviroEffective=ENVEFF_All
     reloadTime=5.000000
     HitDamage=25
     maxRange=36000
     AccurateRange=14000
     BaseAccuracy=0.200000
     bHasScope=True
     bHasAltFire=False
     bPenetrating=True
     recoilStrength=0.600000
     bUnique=True
     bCanHaveModReloadCount=False
     bCanHaveModShotTime=False
     ReloadCount=1
     PickupAmmoCount=4
     bInstantHit=True
     InventoryGroup=98
     ItemName="Railgun"
     Description="A one-of-a-kind prototype, the Railgun compacts standard plasma slugs into a significantly smaller shape, then magnetically accelerates them to near-light speeds.  The force of the projectile allows it to penetrate multiple objects in succession; to compliment this the Railgun has been equipped with a heat scope."
     beltDescription="RAILGUN"
     MultiSkins(1)=FireTexture'Effects.Electricity.BioCell_SFX'
}
