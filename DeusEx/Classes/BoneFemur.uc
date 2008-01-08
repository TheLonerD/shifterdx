//=============================================================================
// BoneFemur.
//=============================================================================
class BoneFemur extends DeusExDecoration;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBoneFemur", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
     bCanBeBase=True
     ItemName="Human Femur"
     Mesh=LodMesh'DeusExDeco.BoneFemur'
     CollisionRadius=12.500000
     CollisionHeight=1.680000
     Mass=8.000000
     Buoyancy=10.000000
}
