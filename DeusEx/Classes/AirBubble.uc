//=============================================================================
// AirBubble.
//=============================================================================
class AirBubble expands Effects;

var() float RiseRate;
var vector OrigVel;
var Class<Effects> EmitOnSurface; // An effect to emit when we surface

auto state Flying
{
	simulated function Tick(float deltaTime)
	{
		Velocity.X = OrigVel.X + 8 - FRand() * 17;
		Velocity.Y = OrigVel.Y + 8 - FRand() * 17;
		Velocity.Z = RiseRate * (FRand() * 0.2 + 0.9);

		ScaleGlow = FMin(LifeSpan / 2.000000, 1.000000);

		if (!Region.Zone.bWaterZone)
			Destroy();
	}

	//== Spawn a little ring when we hit the surface
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		local actor splash;

		if(!NewZone.bWaterZone && Region.Zone.bWaterZone)
		{
			//== Every pop reaffirms the waterzone surface level
			WaterZone(Region.Zone).SurfaceLevel = Location.Z;
			if(!WaterZone(Region.Zone).bSurfaceLevelKnown)
				WaterZone(Region.Zone).bSurfaceLevelKnown = True;

			if(Region.Zone.ExitActor != None)
			{
				splash = Spawn(Region.Zone.ExitActor); 
				if ( splash != None )
				{
					splash.DrawScale = DrawScale;
					splash.LifeSpan = 0.300000;
					if(WaterRing(splash) != None)
						WaterRing(splash).bNoExtraRings = True;
	
				}

				if(EmitOnSurface != None)
				{
					splash = Spawn(EmitOnSurface);

					if(splash != None)
					{
						splash.Velocity.Z = Velocity.Z;

						if(Effects(splash) != None)
							splash.DrawScale = DrawScale;

						//== Special cases, because nobody could think to have a unified RiseRate variable
						if(SmokeTrail(splash) != None)
						{
//							SmokeTrail(splash).RiseRate = RiseRate;
							SmokeTrail(splash).OrigVel.Z = Velocity.Z;
						}
					}
				}
			}
		}
		Super.ZoneChange(NewZone);
	}

	simulated function BeginState()
	{
		Super.BeginState();

		OrigVel = Velocity;
		DrawScale += FRand() * 0.1;
	}
}

defaultproperties
{
     RiseRate=50.000000
     Physics=PHYS_Projectile
     LifeSpan=20.000000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExItems.Skins.FlatFXTex45'
     DrawScale=0.050000
}
