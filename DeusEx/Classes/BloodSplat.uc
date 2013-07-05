//=============================================================================
// BloodSplat.
//=============================================================================
class BloodSplat extends DeusExDecal;

var() Texture BloodTex[4];

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
	}
	else
	{
		for(i = 0; i < 4; i++)
			BloodTex[i] = Default.BloodTex[i];
	}

	for(i = 0; i < 4; i++)
	{
		if(BloodTex[i] == None)
			BloodTex[i] = Default.BloodTex[i];
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

	DrawScale += FRand() * 0.2;

	Super.BeginPlay();
}

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex2'
     DrawScale=0.200000
}
