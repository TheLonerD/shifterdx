//=============================================================================
// GuntherHermannCarcass.
//=============================================================================
class GuntherHermannCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	Mesh = Mesh(DynamicLoadObject("HDTPcharacters.HDTPGuntherCarcassA", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;

		Texture = Default.Texture;

		for(i = 0; i < 8; i++)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		Texture = None;

		for(i = 0; i < 8; i++)
			MultiSkins[i] = None;

		Mesh2 = Mesh(DynamicLoadObject("HDTPcharacters.HDTPGuntherCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPcharacters.HDTPGuntherCarcassC", class'Mesh', True));
	}

	return true;
}

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_DressShirt_B_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_DressShirt_B_CarcassC'
     Texture=Texture'DeusExItems.Skins.BlackMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_B_Carcass'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.GuntherHermannTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PantsTex9'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.GuntherHermannTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.GuntherHermannTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=44.000000
     CollisionHeight=7.700000
}
