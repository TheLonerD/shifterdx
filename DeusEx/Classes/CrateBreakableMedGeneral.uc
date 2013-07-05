//=============================================================================
// CrateBreakableMedGeneral.
//=============================================================================
class CrateBreakableMedGeneral extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCrateBreakableMed", class'mesh', True));
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCrateBreakableGeneralTex1", class'Texture', True));
	}

	if(Mesh == None || Skin == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Default.Skin;
	}

	return true;
}

defaultproperties
{
     HitPoints=10
     FragType=Class'DeusEx.WoodFragment'
     ItemName="General Supply Crate"
     contents=Class'DeusEx.Lockpick'
     bBlockSight=True
     Skin=Texture'DeusExDeco.Skins.CrateBreakableMedTex2'
     Mesh=LodMesh'DeusExDeco.CrateBreakableMed'
     CollisionRadius=34.000000
     CollisionHeight=24.000000
     Mass=50.000000
     Buoyancy=60.000000
}
