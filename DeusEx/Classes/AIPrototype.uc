//=============================================================================
// AIPrototype.
//=============================================================================
class AIPrototype extends DeusExDecoration;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPAIPrototype", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

defaultproperties
{
     bInvincible=True
     ItemName="AI Prototype"
     bPushable=False
     BaseEyeHeight=50.000000
     Mesh=LodMesh'DeusExDeco.AIPrototype'
     CollisionRadius=27.280001
     CollisionHeight=21.139999
     Mass=40.000000
     Buoyancy=45.000000
}
