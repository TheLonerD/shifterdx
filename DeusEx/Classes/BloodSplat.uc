//=============================================================================
// BloodSplat.
//=============================================================================
class BloodSplat extends DeusExDecal;

var Texture BloodTex[4];
var float sizeinc;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		BloodTex[0] = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex3", class'Texture', True));
		BloodTex[1] = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex5", class'Texture', True));
		BloodTex[2] = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex6", class'Texture', True));
		BloodTex[3] = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex2", class'Texture', True));
		sizeinc = 0.05;
		DrawScale=0.025;
	}

	if(BloodTex[0] == None || BloodTex[1] == None || BloodTex[2] == None || BloodTex[3] == None || !bOn)
	{
		for(i = 0; i < 4; i++)
			BloodTex[i] = Default.BloodTex[i];

		sizeinc = Default.sizeinc;
		DrawScale = Default.DrawScale;
	}



	return true;
} 

function BeginPlay()
{
	local Rotator rot;
	local int rnd;

	// Gore check
	if (Level.Game.bLowGore || Level.Game.bVeryLowGore)
	{
		Destroy();
		return;
	}

	rnd = rand(4);

	Texture = BloodTex[rnd];

	DrawScale += FRand() * sizeinc;

	Super.BeginPlay();
}

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex2'
     sizeinc=0.2
     DrawScale=0.200000
     BloodTex(0)=Texture'FlatFXTex2'
     BloodTex(1)=Texture'FlatFXTex5'
     BloodTex(2)=Texture'FlatFXTex6'
     BloodTex(3)=Texture'FlatFXTex3'
}
