//=============================================================================
// CrateBreakableMedCombat.
//=============================================================================
class CrateBreakableMedCombat extends Containers;

function Facelift(bool bOn)
{
	if(bOn)
	{
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPCrateBreakableMed", class'mesh', True));
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPCrateBreakableTex3", class'Texture', True));
	}

	if(Mesh == None || Skin == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Default.Skin;
	}
}

defaultproperties
{
     HitPoints=10
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Combat Supply Crate"
     contents=Class'DeusEx.Ammo10mm'
     bBlockSight=True
     Skin=Texture'DeusExDeco.Skins.CrateBreakableMedTex3'
     Mesh=LodMesh'DeusExDeco.CrateBreakableMed'
     CollisionRadius=34.000000
     CollisionHeight=24.000000
     Mass=50.000000
     Buoyancy=60.000000
}
