//=============================================================================
// Earth.
//=============================================================================
class Earth expands OutdoorThings;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Multiskins[0] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPEarthTex1", class'Texture', True));
		Multiskins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPEarthTex2", class'Texture', True));
	}	

	if(Multiskins[0] == None || Multiskins[1] == None || !bOn)
	{
		Multiskins[0] = None;
		Multiskins[1] = None;
	}

	return true;
} 

defaultproperties
{
     bStatic=False
     Physics=PHYS_Rotating
     Mesh=LodMesh'DeusExDeco.Earth'
     CollisionRadius=48.000000
     CollisionHeight=48.000000
     bCollideActors=False
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=10.000000
     Buoyancy=5.000000
     RotationRate=(Yaw=-128)
}
