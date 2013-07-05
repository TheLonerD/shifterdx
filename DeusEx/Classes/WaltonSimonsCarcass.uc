//=============================================================================
// WaltonSimonsCarcass.
//=============================================================================
class WaltonSimonsCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	local int i;
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPWaltonSimonsCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPWaltonSimonsCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPWaltonSimonsCarcassC", class'Mesh', True));
	}

	if(Mesh == None || Mesh2 == None || Mesh3 == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = None;
	}

	return true;
} 

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_Trench_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_Trench_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GM_Trench_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.WaltonSimonsTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.WaltonSimonsTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.WaltonSimonsTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.WaltonSimonsTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.WaltonSimonsTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
