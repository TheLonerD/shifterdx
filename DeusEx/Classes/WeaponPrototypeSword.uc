//=============================================================================
// WeaponPrototypeSword.
//=============================================================================
class WeaponPrototypeSword expands WeaponSword;

var() bool bLightOn;
var() float ChangeTimer;

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
				if(Texture == Texture'Effects.Wepn_Prifle_SFX')
				{
					PlaySound(sound'Spark2', SLOT_None,,, 1024);
					Texture=Texture'Effects.LaserBeam2';
					HitDamage = 11;
					LightHue = 160;
				}
				else
				{
					PlaySound(sound'Spark1', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.Wepn_Prifle_SFX';
					HitDamage = 15;
					LightHue = 100;
				}
			}
			else if(rnd >= 0.900000)
			{
				if(Texture == Texture'Effects.Wepn_Prifle_SFX')
				{
					PlaySound(sound'EMPZap', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.Virus_SFX';
					HitDamage = 22;
					LightHue = 0;
				}
				else
				{
					PlaySound(sound'Spark1', SLOT_None,0.75,, 1024);
					Texture=Texture'Effects.Wepn_Prifle_SFX';
					HitDamage = 15;
					LightHue = 100;
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
			PlaySound(sound'DeusExSounds.Weapons.NanoSwordSelect', SLOT_None, 0.5,, 768);
			if(HitDamage < 14)
			{
				PlaySound(sound'Spark2', SLOT_None,0.75,, 1024);
				Texture=Texture'Effects.LaserBeam2';
			}
			else if(HitDamage > 16)
			{
				PlaySound(sound'EMPZap', SLOT_None,0.75,, 1024);
				Texture=Texture'Effects.Virus_SFX';
			}
			else
			{
				PlaySound(sound'Spark1', SLOT_None,,, 1024);
				Texture=Texture'Effects.Wepn_Prifle_SFX';
			}

			LightType = LT_Steady;
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
     HitDamage=15
     AreaOfEffect=AOE_Cone
     mpHitDamage=10
     Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
     InventoryGroup=52
     ItemName="Prototype NanoSword (o' Doom)"
     Description="Some kind of sword.  The only other information available is the following ops note:|n|n<UNATCO OPS FILE NOTE DM333-MAUVE> Congrats, you found the ultra-secret hidden unique weapon.  Pretty, innit? Just don't stab yourself in the eye while you're oggling it. -- Dan Matsuma <END NOTE>"
     beltDescription="DOOMSWORD"
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=224
     LightHue=100
     LightSaturation=64
     LightRadius=4
     bUnique=True
}
