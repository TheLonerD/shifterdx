//=============================================================================
// BoneFemur.
//=============================================================================
class BoneFemur extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPBoneFemur", class'Texture', True));
	else
		Skin = None;

	return true;
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
