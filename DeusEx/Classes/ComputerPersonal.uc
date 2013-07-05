//=============================================================================
// ComputerPersonal.
//=============================================================================
class ComputerPersonal extends Computers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPComputerPersonal", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     terminalType=Class'DeusEx.NetworkTerminalPersonal'
     lockoutDelay=60.000000
     UserList(0)=(userName="USER",Password="USER")
     ItemName="Personal Computer Terminal"
     Mesh=LodMesh'DeusExDeco.ComputerPersonal'
     CollisionRadius=36.000000
     CollisionHeight=7.400000
     BindName="ComputerPersonal"
}
