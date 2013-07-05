//=============================================================================
// ShellCasing2.
//=============================================================================
class ShellCasing2 extends DeusExFragment;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPShotguncasing", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		Fragments[0] = Default.Fragments[0];
	}
	else
		Fragments[0] = Mesh;

	return true;
}

defaultproperties
{
     Fragments(0)=LodMesh'DeusExItems.ShellCasing2'
     numFragmentTypes=1
     elasticity=0.400000
     ImpactSound=Sound'DeusExSounds.Generic.ShellHit'
     MiscSound=Sound'DeusExSounds.Generic.ShellHit'
     Mesh=LodMesh'DeusExItems.ShellCasing2'
     CollisionRadius=2.570000
     CollisionHeight=0.620000
}
