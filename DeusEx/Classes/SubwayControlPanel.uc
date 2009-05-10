//=============================================================================
// SubwayControlPanel.
//=============================================================================
class SubwayControlPanel extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPanim.Animated.SubwayControlPanel01", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = None;

	return true;
}

defaultproperties
{
     bInvincible=True
     ItemName="Subway Control Panel"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.SubwayControlPanel'
     SoundRadius=8
     SoundVolume=255
     SoundPitch=72
     AmbientSound=Sound'DeusExSounds.Generic.ElectronicsHum'
     CollisionRadius=6.000000
     CollisionHeight=8.400000
     Mass=40.000000
     Buoyancy=30.000000
}
