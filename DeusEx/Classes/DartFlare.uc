//=============================================================================
// DartFlare.
//=============================================================================

//Modified -- Y|yukichigai

class DartFlare extends Dart;

var float mpDamage;
var Fire fireGen;

function GrabProjectile(DeusExPlayer player)
{
	if(fireGen != None)
		fireGen.Destroy();//DelayedDestroy();

	Super.GrabProjectile(player);
}

function Tick(float deltaTime)
{
	local vector loc;
	if(fireGen == None && !Region.Zone.bWaterZone)
	{
		loc = Location;
		loc.Z += 3.5;
		loc += vector(Rotation) * 5.5;
		fireGen = Spawn(class'Fire', Self,, loc, rot(16384,0,0));
		if(fireGen != None)
		{
			fireGen.Texture = FireTexture'Effects.Fire.OneFlame_J';
			fireGen.DrawScale = 0.3;
			fireGen.AmbientSound = None;
			fireGen.smokeGen.Destroy();
			fireGen.SetBase(Self);
		}
	}
	else if(Region.Zone.bWaterZone && bStuck)
	{
		if((LifeSpan % 1.000000) + deltaTime > 1.000000)
		{
			Spawn(class'AirBubble', Self,, Location, rot(16384,0,0));
		}
	}
	Super.Tick(deltaTime);
}

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		if(fireGen != None && !bStuck)
			fireGen.Destroy(); //DelayedDestroy();

		Super.ProcessTouch(Other, HitLocation);
	}
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		Super.HitWall(HitNormal, Wall);
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		if(fireGen != None && !bStuck)
			fireGen.Destroy(); //DelayedDestroy();

		Super.Explode(HitLocation, HitNormal);
	}
	simulated function BeginState()
	{
		local vector loc;
		//== Make a pretty fire effect
		if(!Region.Zone.bWaterZone)
		{
			loc = Location;
			loc.Z += 3.5;
			loc += vector(Rotation) * 5.5;
			fireGen = Spawn(class'Fire', Self,, loc, rot(16384,0,0));
			if(fireGen != None)
			{
				fireGen.Texture = FireTexture'Effects.Fire.OneFlame_J';
				fireGen.DrawScale = 0.3;
				fireGen.AmbientSound = None;
				fireGen.smokeGen.Destroy();
				fireGen.SetBase(Self);
			}
		}
		Super.BeginState();
	}
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		local vector loc;
		if(NewZone.bWaterZone && !Region.Zone.bWaterZone)
		{
			if(fireGen != None)
				fireGen.Destroy(); //DelayedDestroy();
		}
		if(!NewZone.bWaterZone && Region.Zone.bWaterZone)
		{
			loc = Location;
			loc.Z += 3.5;
			loc += vector(Rotation) * 5.5;
			fireGen = Spawn(class'Fire', Self,, loc, rot(16384,0,0));
			if(fireGen != None)
			{
				fireGen.Texture = FireTexture'Effects.Fire.OneFlame_J';
				fireGen.DrawScale = 0.3;
				fireGen.AmbientSound = None;
				fireGen.smokeGen.Destroy();
				fireGen.SetBase(Self);
			}
		}
		Super.ZoneChange(NewZone);
	}
}

simulated function Destroyed()
{
	if (fireGen != None)
		fireGen.Destroy();//DelayedDestroy();

	Super.Destroyed();
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
}

//Damage type changed from Burned to Flared
// Damage level decreased from 5 to 2.5

defaultproperties
{
     mpDamage=10.000000
     DamageType=Flared
     spawnAmmoClass=Class'DeusEx.AmmoDartFlare'
     ItemName="Flare Dart"
     Damage=2.500000
     bUnlit=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=255
     LightHue=16
     LightSaturation=192
     LightRadius=4
}
