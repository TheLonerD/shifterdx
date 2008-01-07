//=============================================================================
// Mailbox.
//=============================================================================
class Mailbox extends Containers;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPmailbox", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
}

defaultproperties
{
     ItemName="Mailbox"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Mailbox'
     CollisionHeight=36.500000
     Mass=400.000000
     Buoyancy=200.000000
}
