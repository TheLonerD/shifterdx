//=============================================================================
// WaterFountain.
//=============================================================================

// Modified -- Y|yukichigai

class WaterFountain extends DeusExDecoration;

var bool bUsing;
var int numUses;
var localized String msgEmpty;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPWaterFountain", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

function Timer()
{
	bUsing = False;
	PlayAnim('Still');
	AmbientSound = None;
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local int mult;

	Super.Frob(Frobber, frobWith);

	mult = 1;

	if (numUses <= 0)
	{
		if (Pawn(Frobber) != None)
			Pawn(Frobber).ClientMessage(msgEmpty);
		return;
	}

	if (bUsing)
		return;

	SetTimer(1.0, False); //Down from 2.0
	bUsing = True;

	// heal the frobber a small bit
	if (DeusExPlayer(Frobber) != None)
	{
		if(DeusExPlayer(Frobber).SkillSystem != None)
			mult += DeusExPlayer(Frobber).SkillSystem.GetSkillLevel(class'SkillMedicine');

		DeusExPlayer(Frobber).HealPlayer(mult);
	}

	LoopAnim('Use');
	AmbientSound = sound'WaterBubbling';
	numUses--;
}

//Uses increased from 10

defaultproperties
{
     numUses=20
     msgEmpty="It's out of water"
     ItemName="Water Fountain"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.WaterFountain'
     CollisionRadius=20.000000
     CollisionHeight=24.360001
     Mass=70.000000
     Buoyancy=100.000000
}
