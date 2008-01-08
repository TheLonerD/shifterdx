//=============================================================================
// Shuriken.
//=============================================================================
class BatonThrown extends DeusExProjectile;

var float	mpDamage;
var int		mpAccurateRange;
var int		mpMaxRange;

// set it's rotation correctly
simulated function Tick(float deltaTime)
{
	local Rotator rot;

	if (bStuck)
		return;

	Super.Tick(deltaTime);

	if (Level.Netmode != NM_DedicatedServer)
	{
		rot = Rotation;
		rot.Roll += 16384;
		rot.Pitch -= 16384;
		SetRotation(rot);
	}
}

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		Super.ProcessTouch(Other, HitLocation);
	}
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		Super.HitWall(HitNormal, Wall);
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		spawn(spawnWeaponClass, None,, HitLocation + (HitNormal * 0.1));
		Super.Explode(HitLocation, HitNormal);
	}
	simulated function BeginState()
	{
		Super.BeginState();
	}
}


simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		Damage = mpDamage;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		Mesh = LodMesh'DeusExItems.CombatKnifePickup';
	}
}

defaultproperties
{
     mpDamage=15.000000
     mpAccurateRange=640
     mpMaxRange=640
     DamageType=KnockedOut
     AccurateRange=640
     maxRange=1280
     spawnWeaponClass=Class'DeusEx.WeaponBaton'
     bIgnoresNanoDefense=True
     ItemName="Baton"
     ItemArticle="a"
     speed=750.000000
     MaxSpeed=750.000000
     Damage=17.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Weapons.BatonHitHard'
     Mesh=LodMesh'DeusExItems.BatonPickup'
     CollisionRadius=10.000000
     CollisionHeight=5.000000
}
