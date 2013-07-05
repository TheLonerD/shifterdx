//=============================================================================
// WeaponPrototypeSword.
//=============================================================================
class WeaponPrototypeSwordB expands WeaponSword;

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
			if(rnd <= 0.200000)
			{
				if(Texture == Texture'Effects.Ambrosia_SFX')
				{
					PlaySound(sound'Spark2', SLOT_None, 0.5,, 1024);
					Texture=Texture'Effects.Wepn_Prifle_SFX';
					HitDamage=15;
				}
				else
				{
					PlaySound(sound'Spark2', SLOT_None, 0.5,, 1024);
					Texture=Texture'Effects.Ambrosia_SFX';
					HitDamage=8;
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
		LightType = LT_Steady;
		if(!bLightOn)
		{
			PlaySound(sound'Spark1', SLOT_None,0.5,, 768);
			PlaySound(sound'DeusExSounds.Weapons.NanoSwordSelect', SLOT_None, 0.5,, 768);
			if(HitDamage < 12)
				Texture=Texture'Effects.Ambrosia_SFX';
			else
				Texture=Texture'Effects.Wepn_Prifle_SFX';

			bUnlit = True;
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
     HitDamage=14
     AreaOfEffect=AOE_Cone
     bUnique=True
     mpHitDamage=14
     Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
     InventoryGroup=54
     ItemName="Prototype NanoSword (Mk II)"
     Description="The second prototype of the NanoSword technology combined early-gen nanoscale whetting devices with a significantly weaker stasis field, the hope being that the instabilities in the stasis technology could be eliminated by reducing the power of the field.  This proved untrue, and the stasis technology was abandoned completely."
     beltDescription="NANOSWORD"
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=224
     LightHue=100
     LightSaturation=80
     LightRadius=4
}
