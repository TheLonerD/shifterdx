//=============================================================================
// Dart.
//=============================================================================
class Dart extends DeusExProjectile;

var float mpDamage;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
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
		local Inventory inv;
		if(ScriptedPawn(damagee) != None)
		{
			inv = Pawn(damagee).FindInventoryType(Class'AmmoDart');
			if(inv == None)
			{
				inv = spawn(Class'AmmoDart',damagee);
				if(inv != None)
				{
					inv.InitialState='Idle2';
					inv.GiveTo(Pawn(damagee));
					inv.SetBase(Pawn(damagee));
					Ammo(inv).AmmoAmount = 0;
				}
			}
			if(inv != None)
				Ammo(inv).AmmoAmount++;
				
		}
		Super.Explode(HitLocation, HitNormal);
	}
	simulated function BeginState()
	{
		Super.BeginState();
	}
}

defaultproperties
{
     mpDamage=20.000000
     bBlood=True
     bStickToWall=True
     DamageType=shot
     spawnAmmoClass=Class'DeusEx.AmmoDart'
     bIgnoresNanoDefense=True
     ItemName="Dart"
     ItemArticle="a"
     speed=2000.000000
     MaxSpeed=3000.000000
     Damage=18.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Mesh=LodMesh'DeusExItems.Dart'
     CollisionRadius=3.000000
     CollisionHeight=0.500000
}
