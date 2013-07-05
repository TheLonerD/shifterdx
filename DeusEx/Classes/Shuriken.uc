//=============================================================================
// Shuriken.
//=============================================================================
class Shuriken extends DeusExProjectile;

var float	mpDamage;
var int		mpAccurateRange;
var int		mpMaxRange;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPShurikenPickup", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

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

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		Damage = mpDamage;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		Mesh = LodMesh'DeusExItems.ShurikenPickup';
	}
}
// Changed the mesh
//     Mesh=LodMesh'DeusExItems.CombatKnifePickup'
//     CollisionRadius=10.000000
//     CollisionHeight=0.800000

defaultproperties
{
     mpDamage=17.000000
     mpAccurateRange=640
     mpMaxRange=640
     bBlood=True
     bStickToWall=True
     DamageType=shot
     AccurateRange=640
     maxRange=1280
     spawnWeaponClass=Class'DeusEx.WeaponShuriken'
     bIgnoresNanoDefense=True
     ItemName="Throwing Knife"
     ItemArticle="a"
     speed=750.000000
     MaxSpeed=750.000000
     Damage=22.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Mesh=LodMesh'DeusExItems.ShurikenPickup'
     CollisionRadius=5.000000
     CollisionHeight=0.800000
}
