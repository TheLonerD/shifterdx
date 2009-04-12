//=============================================================================
// BoneFemur.
//=============================================================================
class BoneFemur extends DeusExDecoration;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBoneFemur", class'Texture', True));
	else
		Skin = None;
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
