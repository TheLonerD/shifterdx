//=============================================================================
// FireballDragon -- for Dragon's Breath shells
//=============================================================================
class FireballDragon extends Fireball;

simulated function Tick(float deltaTime)
{
	// don't Super.Tick() becuase we don't want gravity to affect the stream
	time += deltaTime;

	DrawScale += ((MaxDrawScale - DrawScale) * (deltaTime/LifeSpan));
	ScaleGlow = FMax((((LifeSpan * 2.0) - Time )/LifeSpan), 0.20);
	LightBrightness = Default.LightBrightness * ScaleGlow;

	//== Strobe effect
	if(LightRadius != Default.LightRadius)
		LightRadius = Default.LightRadius;
	else if(Time < 0.1)
		LightRadius *= 300;
}

defaultproperties
{
     maxDrawScale=1.000000
     speed=1600.000000
     MaxSpeed=1600.000000
     LifeSpan=0.300000
     DrawScale=0.001000
}
