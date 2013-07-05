//=============================================================================
// FleshFragment.
//=============================================================================
class FleshFragment expands DeusExFragment;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFleshFragTex1", class'Texture', True));

	if(Skin == None || !bOn)
		Skin = Default.Skin;

	return true;
}

auto state Flying
{
	function BeginState()
	{
		Super.BeginState();

		Velocity = VRand() * 300;
		DrawScale = FRand() + 1.5;
	}

	//== If we bump an NPC who doesn't like dead bodies, put the fear of God in 'em
	function Bump(actor Other)
	{
		if(Other.IsA('ScriptedPawn'))
		{
			if(ScriptedPawn(Other).bFearCarcass)
				ScriptedPawn(Other).IncreaseFear(Self,2.0);
		}
		Super.Bump(Other);
	}
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);
	
	if (!IsInState('Dying'))
		if (FRand() < 0.5)
			Spawn(class'BloodDrop',,, Location);
}

defaultproperties
{
     Fragments(0)=LodMesh'DeusExItems.FleshFragment1'
     Fragments(1)=LodMesh'DeusExItems.FleshFragment2'
     Fragments(2)=LodMesh'DeusExItems.FleshFragment3'
     Fragments(3)=LodMesh'DeusExItems.FleshFragment4'
     numFragmentTypes=4
     elasticity=0.400000
     ImpactSound=Sound'DeusExSounds.Generic.FleshHit1'
     MiscSound=Sound'DeusExSounds.Generic.FleshHit2'
     Mesh=LodMesh'DeusExItems.FleshFragment1'
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     Mass=5.000000
     Buoyancy=5.500000
     bVisionImportant=True
}
