//=============================================================================
// TrashPaper.
//=============================================================================
class TrashPaper extends Trash;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTrashpaperTex1", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     ItemName="Paper"
     Mesh=LodMesh'DeusExDeco.TrashPaper'
     CollisionRadius=6.000000
     CollisionHeight=6.000000
}
