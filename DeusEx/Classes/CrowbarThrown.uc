//=============================================================================
// CrowbarThrown.
//=============================================================================
class CrowbarThrown extends DeusExProjectile;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPCrowbarPickup", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Texture = None;
		Mesh = Default.Mesh;
	}
	else
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPWeaponCrowbarTex2", class'Texture'));

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

auto simulated state Flying
{
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		Super.Explode(HitLocation, HitNormal);
		spawn(spawnWeaponClass, None,, HitLocation + (HitNormal * 0.1));
	}
}

defaultproperties
{
     DamageType=shot
     AccurateRange=640
     maxRange=1280
     spawnWeaponClass=Class'DeusEx.WeaponCrowbar'
     bIgnoresNanoDefense=True
     ItemName="Crowbar"
     ItemArticle="a"
     speed=750.000000
     MaxSpeed=750.000000
     Damage=24.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.MetalHit2'
     Mesh=LodMesh'DeusExItems.CrowbarPickup'
     CollisionRadius=15.000000
     CollisionHeight=4.000000
}
