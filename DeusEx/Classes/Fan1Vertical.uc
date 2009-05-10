//=============================================================================
// Fan1Vertical.
//=============================================================================
class Fan1Vertical extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFan1vertical", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bHighlight=False
     ItemName="Fan"
     bPushable=False
     Physics=PHYS_Rotating
     Mesh=LodMesh'DeusExDeco.Fan1Vertical'
     CollisionRadius=326.000000
     CollisionHeight=326.000000
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=500.000000
     Buoyancy=100.000000
     RotationRate=(Pitch=8192)
     BindName="Fan"
}
