//=============================================================================
// Seagull.
//=============================================================================
class Seagull extends Bird;

function Carcass SpawnCarcass()
{
	if (bStunned)
		return Super.SpawnCarcass();

	Explode();

	return None;
}

function Explode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 125;
	explosionRadius = 128;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/12; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Location);
		else
			spawn(class'FleshFragment',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
}

//     InitialAlliances(0)=(AllianceName=Pigeon,AllianceLevel=-1.000000)

defaultproperties
{
     CarcassType=Class'DeusEx.SeagullCarcass'
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
     Alliance=Seagull
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Seagull'
     CollisionRadius=16.000000
     CollisionHeight=6.500000
     Mass=2.000000
     Buoyancy=2.500000
     RotationRate=(Pitch=8000)
     BindName="Seagull"
     FamiliarName="Seagull"
     UnfamiliarName="Seagull"
}
