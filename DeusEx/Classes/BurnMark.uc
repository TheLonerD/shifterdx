//=============================================================================
// BurnMark.
//=============================================================================
class BurnMark extends DeusExDecal;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex40", class'Texture', True));

	if(Texture == None || !bOn)
		Texture = Default.Texture;

	return true;
} 

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex40'
}
