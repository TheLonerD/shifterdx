//=============================================================================
// FireComet2.
//=============================================================================
class FireComet2 expands FireComet;

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		local BurnMark mark;
		local Fire f;

		mark = spawn(class'BurnMark',,, Location, Rotator(HitNormal));
		if (mark != None)
		{
			f = spawn(class'Fire',mark,, Location, Rotator(HitNormal));
			f.livetime = FRand() * 25.000000 + 5.000000;
			if(Frand() < 0.5)
				f.AmbientSound = None;
			if(Frand() < 0.5)
				f.smokeGen.Destroy();
			mark.DrawScale = 0.4*DrawScale;
			mark.ReattachDecal();
		}
		if(Wall != Level)
		{
			Wall.TakeDamage(5.0, Pawn(Owner), Location, 1000.0*HitNormal, 'Flamed');
		}
		Destroy();
	}
	simulated function BeginState()
	{
		Velocity = VRand() * 300;
		Velocity.Z = FRand() * 200 + 200;
		DrawScale = 0.3 + FRand();
		SetRotation(Rotator(Velocity));
	}
}

simulated function Tick(float deltaTime)
{
	local BurnMark mark;
	local Fire f;
	if (Velocity == vect(0,0,0))
	{
		mark = spawn(class'BurnMark',,, Location, rot(16384,0,0));
		f = spawn(class'Fire',mark,, Location, rot(16384,0,0));
		f.LiveTime = FRand() * 25.000000 + 5.000000;
		Destroy();
	}
	else
		SetRotation(Rotator(Velocity));
}

defaultproperties
{
}
