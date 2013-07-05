//=============================================================================
// NicoletteDuClareCarcass.
//=============================================================================
class NicoletteDuClareCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	local int i;
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPNicoletteCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPNicoletteCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPNicoletteCarcassC", class'Mesh', True));
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
     Mesh2=LodMesh'DeusExCharacters.GFM_Dress_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GFM_Dress_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GFM_Dress_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
}
