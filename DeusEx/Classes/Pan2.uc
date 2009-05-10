//=============================================================================
// Pan2.
//=============================================================================
class Pan2 extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPPan2",class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Skin = None;
		Mesh = Default.Mesh;
	}
	else
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPPan2Tex1",class'Texture'));

	return true;
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Pot"
     Mesh=LodMesh'DeusExDeco.Pan2'
     CollisionRadius=12.040000
     CollisionHeight=4.060000
     Mass=20.000000
     Buoyancy=5.000000
}
