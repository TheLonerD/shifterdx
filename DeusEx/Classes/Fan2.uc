//=============================================================================
// Fan2.
//=============================================================================
class Fan2 extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFan2", class'mesh', True));

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
     Mesh=LodMesh'DeusExDeco.Fan2'
     CollisionRadius=17.660000
     CollisionHeight=16.240000
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=500.000000
     Buoyancy=100.000000
     RotationRate=(Roll=65535)
     BindName="Fan"
}
