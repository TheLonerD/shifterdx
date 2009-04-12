//=============================================================================
// BoneSkull.
//=============================================================================
class BoneSkull extends DeusExDecoration;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBoneSkull", class'Texture', True));
	else
		Skin = None;
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
