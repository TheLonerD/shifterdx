//=============================================================================
// Terrorist.
//=============================================================================
class Terrorist extends HumanMilitary;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPTerrorist", class'Mesh', True));

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
     MinHealth=40.000000
     CarcassType=Class'DeusEx.TerroristCarcass'
     WalkingSpeed=0.296000
     AvoidAccuracy=0.100000
     CrouchRate=0.250000
     SprintRate=0.250000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Health=75
     HealthHead=75
     HealthTorso=75
     HealthLegLeft=75
     HealthLegRight=75
     HealthArmLeft=75
     HealthArmRight=75
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.TerroristTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TerroristTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.TerroristTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.TerroristTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.TerroristTex0'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.GogglesTex1'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Terrorist"
     FamiliarName="Terrorist"
     UnfamiliarName="Terrorist"
}
