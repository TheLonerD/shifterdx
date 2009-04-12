//=============================================================================
// Pinball.
//=============================================================================
class Pinball extends ElectronicDevices;

var bool bUsing;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPpinball", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

function Timer()
{
	bUsing = False;
}

function Frob(actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	SetTimer(2.0, False);
	bUsing = True;

	PlaySound(sound'PinballMachine',,,, 256);
}

defaultproperties
{
     ItemName="Pinball Machine"
     Mesh=LodMesh'DeusExDeco.Pinball'
     CollisionRadius=37.000000
     CollisionHeight=45.000000
     Mass=100.000000
     Buoyancy=5.000000
}
