//=============================================================================
// ParticleProxy.
//=============================================================================
class ParticleProxy extends Effects;
//var() texture normalTexture;		// texture to use out of water
//var() texture waterTexture;		// texture to use under water
//var() bool bDiesInWater;		// Destroyed if it enters water
//var() bool bOnlyInWater;		// Only valid in water;

//function Tick(float deltaTime)
//{
//	if(Texture == Texture'DeusExItems.Skins.FlatFXTex45')
//	{
//		Velocity.X += 8 - FRand() * 17;
//		Velocity.Y += 8 - FRand() * 17;
//		//Velocity.Z = RiseRate * (FRand() * 0.2 + 0.9);
//	}
//	Super.Tick(deltaTime);
//}

//function ZoneChange(ZoneInfo NewZone)
//{
//	local actor splash;

//	if(NewZone.bWaterZone)
//	{
//		if(bDiesInWater)
//			Destroy();
//		else if(waterTexture != None)
//			Texture = waterTexture;

//	}
//	else if(!NewZone.bWaterZone)
//	{
//		if(Region.Zone.bWaterZone && Region.Zone.ExitActor != None)
//		{
//			splash = Spawn(Region.Zone.ExitActor); 
//			if ( splash != None )
//			{
//				splash.DrawScale = DrawScale;
//				splash.LifeSpan = 0.300000;
//				if(WaterRing(splash) != None)
//					WaterRing(splash).bNoExtraRings = True;
//	
//			}
//		}
//		if(bOnlyInWater)
//			Destroy();
//		else if(normalTexture != None)
//			Texture = normalTexture;
//	}
//	Super.ZoneChange(NewZone);
//}

defaultproperties
{
     RemoteRole=ROLE_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'Engine.S_Light'
     DrawScale=0.100000
     bCollideWorld=True
}
