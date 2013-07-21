//=============================================================================
// LAM.
//=============================================================================
class NapalmBomb extends ThrownProjectile;

var() bool bBurning;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPAmmoNapalm", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
} 

//== No beeping, just 'sploding and burning
function PlayBeepSound(float Range, float Pitch, float volume)
{
	local fire f;
	local vector loc;

	loc.X = 0.500000*CollisionRadius * (1.000000-2.000000*FRand());
	loc.Y = 0.500000*CollisionRadius * (1.000000-2.000000*FRand());
	loc.Z = 0.600000*CollisionHeight * (1.000000-2.000000*FRand());
	loc += Location;
	f = Spawn(class'Fire', Self,, loc);
	if (f != None)
	{
		f.DrawScale = 0.5*FRand() + 1.0;

		// turn off the sound and lights for all but the first one
		if(bBurning)
		{
			f.AmbientSound = None;
			f.LightType = LT_None;
		}
		else
			bBurning = true;

		// turn on/off extra fire and smoke
		if (FRand() < 0.5)
			f.smokeGen.Destroy();
		if (FRand() < 0.5)
			f.AddFire();
	}
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local int i;
	local SmokeTrail puff;
	local Fragment frag;
	local ParticleGenerator gen;
	local ProjectileGenerator projgen;
	local vector loc;
	local rotator rot;
	local ExplosionLight light;
	local DeusExDecal mark;
   local AnimatedSprite expeffect;

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	if (bStuck)
	{
		gen = spawn(class'ParticleGenerator',,, HitLocation, rot);
		if (gen != None)
		{
         //DEUS_EX AMSD Don't send this to clients unless really spawned server side.
         if (bDamaged)
            gen.RemoteRole = ROLE_SimulatedProxy;
         else
   			gen.RemoteRole = ROLE_None;
			gen.LifeSpan = FRand() * 10 + 10;
			gen.CheckTime = 0.25;
			gen.particleDrawScale = 0.4;
			gen.RiseRate = 20.0;
			gen.bRandomEject = True;
			gen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
		}
	}

	// don't draw damage art on destroyed movers
	if (DeusExMover(Other) != None)
		if (DeusExMover(Other).bDestroyed)
			ExplosionDecal = None;

	if (ExplosionDecal != None)
	{
		mark = DeusExDecal(Spawn(ExplosionDecal, Self,, HitLocation, Rotator(HitNormal)));
		if (mark != None)
		{
			mark.DrawScale = FClamp(damage/30, 0.1, 3.0);
			mark.ReattachDecal();
         if (!bDamaged)
            mark.RemoteRole = ROLE_None;
		}
	}

	for (i=0; i<blastRadius/18; i++)
	{
		if (FRand() < 0.9)
		{
			if (bDebris && bStuck)
			{
				frag = spawn(FragmentClass, Owner,, HitLocation);
				if (!bDamaged)
					frag.RemoteRole = ROLE_None;
				if (frag != None)
					frag.CalcVelocity(VRand(), blastRadius);
			}
		}
	}
}

defaultproperties
{
     fuseLength=3.000000
     FragmentClass=Class'DeusEx.FireComet2'
     proxRadius=128.000000
     DamageType=Flamed
     gradualHurtSteps=3
     spawnWeaponClass=Class'DeusEx.WeaponFlamethrower'
     ItemName="Napalm Canister"
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=100.000000
     MomentumTransfer=50000
     ImpactSound=Sound'DeusExSounds.Weapons.LAMExplode'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExItems.AmmoNapalm'
     CollisionRadius=3.130000
     CollisionHeight=11.480000
     Mass=5.000000
     Buoyancy=2.000000
}
