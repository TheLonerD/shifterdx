//=============================================================================
// BoneSkull.
//=============================================================================
class BoneSkull extends DeusExDecoration;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBoneSkull", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
     bCanBeBase=True
     ItemName="Human Skull"
     Mesh=LodMesh'DeusExDeco.BoneSkull'
     CollisionRadius=5.800000
     CollisionHeight=4.750000
     Mass=8.000000
     Buoyancy=10.000000
}
