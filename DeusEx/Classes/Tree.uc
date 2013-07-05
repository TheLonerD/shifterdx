//=============================================================================
// Tree.
//=============================================================================
class Tree extends OutdoorThings
	abstract;

var mesh Altmesh;
var Texture HDTPTex[2];

var() float soundFreq;		// chance of making a sound every 5 seconds

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		HDTPTex[0] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTreeTex2", class'Texture', True));
		HDTPTex[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTreeTex3", class'Texture', True));
		bUnlit = False;
	}

	if(HDTPTex[0] == None || HDTPTex[1] == None || !bOn)
	{
		Mesh = Default.Mesh;
		HDTPTex[0] = None;
		HDTPTex[1] = None;
		return false;
	}

	return true;
} 

function BeginPlay()
{
	if(Mesh != Default.Mesh)
	{
		if(location.X + location.Y %2 > 0)
			mesh = altmesh;
		if(location.X * location.Y %2 > 0)
			multiskins[2] = HDTPTex[0];
		else
			multiskins[2] = HDTPTex[1];
	}

	super.BeginPlay();
}

function Timer()
{
	if (FRand() < soundFreq)
	{
		// play wind sounds at random pitch offsets
		if (FRand() < 0.5)
			PlaySound(sound'WindGust1', SLOT_Misc,,, 2048, 0.7 + 0.6 * FRand());
		else
			PlaySound(sound'WindGust2', SLOT_Misc,,, 2048, 0.7 + 0.6 * FRand());
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(4.0 + 2.0 * FRand(), True);
}

defaultproperties
{
     soundFreq=0.200000
     ItemName="Tree"
     bStatic=False
     Mass=2000.000000
     Buoyancy=5.000000
}
