//=============================================================================
// AnnaNavarreCarcass.
//=============================================================================
class AnnaNavarreCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPAnnaCarcass", class'Mesh', True));

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

		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPAnnaCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPAnnaCarcassC", class'Mesh', True));
	}

	return true;
}

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GFM_TShirtPants_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GFM_TShirtPants_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants_Carcass'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex9'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.AnnaNavarreTex1'
     CollisionRadius=44.000000
     CollisionHeight=7.700000
}
