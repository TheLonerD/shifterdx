//=============================================================================
// NicoletteDuClare.
//=============================================================================
class NicoletteDuClare extends HumanThug;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPNicolette", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;

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
     CarcassType=Class'DeusEx.NicoletteDuClareCarcass'
     WalkingSpeed=0.320000
     bImportant=True
     BaseAssHeight=-18.000000
     walkAnimMult=1.460000
     bIsFemale=True
     GroundSpeed=280.000000
     BaseEyeHeight=38.000000
     Mesh=LodMesh'DeusExCharacters.GFM_Dress'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="NicoletteDuClare"
     FamiliarName="Nicolette DuClare"
     UnfamiliarName="Nicolette DuClare"
}
