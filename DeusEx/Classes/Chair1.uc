//=============================================================================
// Chair1.
//=============================================================================
class Chair1 extends Seat;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPchair1", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     sitPoint(0)=(X=0.000000,Y=-6.000000,Z=-4.500000)
     ItemName="Chair"
     Mesh=LodMesh'DeusExDeco.Chair1'
     CollisionRadius=23.000000
     CollisionHeight=33.169998
     Mass=30.000000
     Buoyancy=5.000000
}
