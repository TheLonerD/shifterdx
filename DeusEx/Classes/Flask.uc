//=============================================================================
// Flask.
//=============================================================================
class Flask extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlaskTex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;

	return true;
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     ItemName="Lab Flask"
     Mesh=LodMesh'DeusExDeco.Flask'
     CollisionRadius=4.300000
     CollisionHeight=7.470000
     Mass=5.000000
     Buoyancy=3.000000
}
