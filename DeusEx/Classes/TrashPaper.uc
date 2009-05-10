//=============================================================================
// TrashPaper.
//=============================================================================
class TrashPaper extends Trash;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTrashpaperTex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;

	return true;
}

defaultproperties
{
     ItemName="Paper"
     Mesh=LodMesh'DeusExDeco.TrashPaper'
     CollisionRadius=6.000000
     CollisionHeight=6.000000
}
