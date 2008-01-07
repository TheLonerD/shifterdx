//=============================================================================
// Flask.
//=============================================================================
class Flask extends DeusExDecoration;

simulated function PreBeginPlay()
{
	local Texture lSkin;

	Super.PreBeginPlay();

	lSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlaskTex1", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
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
