//=============================================================================
// BurnMark.
//=============================================================================
class BurnMark extends DeusExDecal;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex40", class'Texture', True));
		DrawScale = 0.03125;
	}

	if(Texture == None || !bOn)
	{
		Texture = Default.Texture;
		DrawScale = Default.DrawScale;
	}

	return true;
} 

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex40'
}
