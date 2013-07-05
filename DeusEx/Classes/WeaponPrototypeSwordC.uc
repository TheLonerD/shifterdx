//=============================================================================
// WeaponPrototypeSword.
//=============================================================================
class WeaponPrototypeSwordC expands WeaponSword;

//== No facelift because HDTP lacks the shine overlay layer
function bool Facelift(bool bOn)
{
	return false;
}

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;
		Texture=Texture'DeusExItems.Skins.ReflectionMapTex1';
		bUnlit = False;
	}
}

state Idle
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
		if(!bUnlit)
		{
			PlaySound(sound'DeusExSounds.Weapons.NanoSwordSelect', SLOT_None, 0.5,, 768);
			Texture=Texture'Effects.LaserBeam2';
			bUnlit = True;
		}
	}
}

auto state Pickup
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
	}
	function EndState()
	{
		Super.EndState();
		LightType = LT_None;
		Texture=Texture'DeusExItems.Skins.ReflectionMapTex1';
		bUnlit = False;
	}
}

defaultproperties
{
     HitDamage=12
     AreaOfEffect=AOE_Cone
     bUnique=True
     mpHitDamage=10
     Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
     InventoryGroup=55
     ItemName="Prototype NanoSword (Mk III)"
     Description="The third prototype of what would eventually become the Dragon's Tooth Sword relied on a traditional blade to do the cutting, kept incredibly sharp by nanoscale whetting devices.  Later revisions of these same whetting devices can be found in the current Dragon's Tooth Sword."
     beltDescription="NANOSWORD"
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=224
     LightHue=160
     LightSaturation=80
     LightRadius=4
}
