//=============================================================================
// Lightbulb.
//=============================================================================
class Lightbulb extends DeusExDecoration;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPLightBulb", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     HitPoints=5
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     ItemName="Light Bulb"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Lightbulb'
     ScaleGlow=2.000000
     bUnlit=True
     CollisionRadius=1.600000
     CollisionHeight=2.900000
     LightType=LT_Steady
     LightBrightness=255
     LightHue=32
     LightSaturation=224
     LightRadius=8
     Mass=3.000000
     Buoyancy=2.000000
}
