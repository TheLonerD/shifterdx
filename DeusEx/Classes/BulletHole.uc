//=============================================================================
// BulletHole.
//=============================================================================
class BulletHole extends DeusExDecal;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex9", class'Texture', True));

	if(Texture == None || !bOn)
		Texture = Default.Texture;

	return true;
} 

// overridden to NOT rotate decal
simulated event BeginPlay()
{
	if(Texture == Default.Texture)
	{
		if(!AttachDecal(32, vect(0.1,0.1,0)))
			Destroy();
	}
	else
	{
		drawscale = 0.0125;
		drawscale *= 1.0 + frand()*0.2;
		Super.BeginPlay();
	}
}

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex9'
     DrawScale=0.100000
}
