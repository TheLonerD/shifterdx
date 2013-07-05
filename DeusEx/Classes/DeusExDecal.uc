//=============================================================================
// DeusExDecal
//=============================================================================
class DeusExDecal extends Decal
	abstract;

var bool bAttached, bStartedLife, bImportant;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	if(Level.NetMode == NM_StandAlone)
		Facelift(true);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1.0, false);
}

function bool Facelift(bool bOn)
{
	//== Only do this for DeusEx classes
	if(instr(String(Class.Name), ".") > -1 && bOn)
		if(instr(String(Class.Name), "DeusEx.") <= -1)
			return false;
	else
		if((Class != Class(DynamicLoadObject("DeusEx."$ String(Class.Name), class'Class', True))) && bOn)
			return false;

	return true;
}

simulated function Timer()
{
	// Check for nearby players, if none then destroy self

	if ( !bAttached )
	{
		Destroy();
		return;
	}

	if ( !bStartedLife )
	{
		RemoteRole = ROLE_None;
		bStartedLife = true;
		if ( Level.bDropDetail )
			SetTimer(5.0 + 2 * FRand(), false);
		else
			SetTimer(18.0 + 5 * FRand(), false);
		return;
	}
	if ( Level.bDropDetail && (MultiDecalLevel < 6) )
	{
		if ( (Level.TimeSeconds - LastRenderedTime > 0.35)
			|| (!bImportant && (FRand() < 0.2)) )
			Destroy();
		else
		{
			SetTimer(1.0, true);
			return;
		}
	}
	else if ( Level.TimeSeconds - LastRenderedTime < 1 )
	{
		SetTimer(5.0, true);
		return;
	}
	Destroy();
}

function ReattachDecal(optional vector newrot)
{
	DetachDecal();
	if (newrot != vect(0,0,0))
		AttachDecal(32, newrot);
	else
		AttachDecal(32);
}

defaultproperties
{
     bAttached=True
     bImportant=True
}
