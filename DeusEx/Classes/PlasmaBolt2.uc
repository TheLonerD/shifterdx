//=============================================================================
// PlasmaBolt2.  A "bouncing" plasma bolt
//=============================================================================
class PlasmaBolt2 expands PlasmaBolt;

var int Generation;
var int MaxGeneration;

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		Super.ProcessTouch(Other, HitLocation);
	}
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		Super.HitWall(HitNormal, Wall);
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		local PlasmaBolt2 proj;
		local vector aim;

		if(Generation <= MaxGeneration)
		{
			aim = MirrorVectorByNormal(vector(Rotation), HitNormal);
			proj = Spawn(class'PlasmaBolt2',Owner,,Location,Rotator(aim));
			if(proj != None)
			{
				proj.Generation = Generation + 1;
				proj.MaxGeneration = MaxGeneration;
			}
		}
		Super.Explode(HitLocation, HitNormal);
	}
	simulated function BeginState()
	{
		Super.BeginState();
	}

	simulated function ZoneChange(ZoneInfo NewZone)
	{
		Super.ZoneChange(NewZone);
	}
}

defaultproperties
{
     MaxGeneration=5
}
