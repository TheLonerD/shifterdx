//=============================================================================
// ScorchMark.
//=============================================================================
class ScorchMark extends DeusExDecal;

var Texture alttex;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex38", class'Texture', True));
		alttex = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex39", class'Texture', True));
		drawscale = 0.03125;
	}

	if(Texture == None || !bOn)
	{
		Texture = Default.Texture;
		alttex = Default.alttex;
		drawscale = Default.drawscale;
	}

	return true;
}

function BeginPlay()
{
	if (FRand() < 0.5)
		Texture = alttex;

	if(alttex != Default.alttex)
		drawscale = 0.03125;

	Super.BeginPlay();
}

defaultproperties
{
     alttex=Texture'DeusExItems.Skins.FlatFXTex39'
     Texture=Texture'DeusExItems.Skins.FlatFXTex38'
}
