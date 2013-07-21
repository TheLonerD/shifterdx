//=============================================================================
// MJ12TroopCarcass.
//=============================================================================
class MJ12TroopCarcass extends DeusExCarcass;

/*function bool Facelift(bool bOn)
{
	local int i;
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMJ12TroopCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMJ12TroopCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMJ12TroopCarcassC", class'Mesh', True));
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
}*/

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_Jumpsuit_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_Jumpsuit_CarcassC'
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MJ12TroopTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.MJ12TroopTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MJ12TroopTex3'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.MJ12TroopTex4'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=40.000000
}
