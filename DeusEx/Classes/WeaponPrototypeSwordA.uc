//=============================================================================
// WeaponPrototypeSword.
//=============================================================================
class WeaponPrototypeSwordA expands WeaponSword;

var() bool bLightOn;
var() float ChangeTimer;

//== No facelift because HDTP lacks the shine overlay layer
function bool Facelift(bool bOn)
{
	return false;
}

simulated function Tick(float DeltaTime)
{
	local float rnd;

	Super.Tick(DeltaTime);

	if(GetStateName() != 'Pickup')
	{
		if(bLightOn && ChangeTimer >= 1.000000)
		{
			ChangeTimer = 0.000000;
			rnd = FRand();
			if(rnd <= 0.100000)
			{
				if(Texture == Texture'Effects.LaserBeam1')
				{
					PlaySound(sound'Spark2', SLOT_None,,, 1024);
					Texture=Texture'DeusExItems.Skins.ReflectionMapTex1';
					AreaOfEffect=AOE_Point;
					bUnlit=False;
					LightType = LT_None;
				}
				else
				{
					PlaySound(sound'Spark1', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.LaserBeam1';
					AreaOfEffect=AOE_Cone;
					bUnlit=True;
					LightType = LT_Steady;
				}
			}
			else if(rnd >= 0.900000)
			{
				if(Texture == Texture'Effects.LaserBeam1')
				{
					PlaySound(sound'EMPZap', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.Virus_SFX';
					AreaOfEffect=AOE_Sphere;
					bUnlit=True;
					LightType = LT_Steady;
				}
				else
				{
					PlaySound(sound'Spark1', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.LaserBeam1';
					AreaOfEffect=AOE_Cone;
					bUnlit=True;
					LightType = LT_Steady;
				}
			}
		}
		else if(bLightOn)
			ChangeTimer += DeltaTime;
	}
}

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;
		Texture=Texture'DeusExItems.Skins.ReflectionMapTex1';
		bUnlit = False;
		bLightOn = False;
	}
}

state Idle
{
	function BeginState()
	{
		Super.BeginState();
		if(!bLightOn)
		{
			if(AreaOfEffect == AOE_Cone)
			{
				LightType = LT_Steady;
				PlaySound(sound'Spark1', SLOT_None,0.75,, 1024);
				Texture=Texture'Effects.LaserBeam1';
				bUnlit = True;
			}
			else if(AreaOfEffect == AOE_Sphere)
			{
				LightType = LT_Steady;
				PlaySound(sound'EMPZap', SLOT_None,0.75,, 1024);
				Texture=Texture'Effects.Virus_SFX';
				bUnlit = True;
			}
			else
			{
				PlaySound(sound'Spark2', SLOT_None,,, 1024);
			}
			bLightOn = True;
		}
	}
}

auto state Pickup
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
		bLightOn = False;
	}

	function EndState()
	{
		Super.EndState();
		LightType = LT_None;
		Texture=Texture'DeusExItems.Skins.ReflectionMapTex1';
		bUnlit = False;
		bLightOn = False;
	}
}

defaultproperties
{
     HitDamage=10
     AreaOfEffect=AOE_Sphere
     bUnique=True
     mpHitDamage=10
     InventoryGroup=53
     ItemName="Prototype NanoSword (Mk I)"
     Description="The first attempt at creating what would become the Dragon's Tooth Sword used a dramatically different approach, generating a ultrathin stasis field around the blade to effectively amplify momentum and force.  However, the inherent instabilities of the stasis technology caused the approach to be abandoned."
     beltDescription="NANOSWORD"
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=224
     LightSaturation=80
     LightRadius=4
}
