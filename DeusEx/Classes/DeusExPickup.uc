//=============================================================================
// DeusExPickup.
//=============================================================================
class DeusExPickup extends Pickup
	abstract;

var bool            bBreakable;		// true if we can destroy this item
var class<Fragment> fragType;		// fragments created when pickup is destroyed
var int				maxCopies;		// 0 means unlimited copies

var localized String CountLabel;
var localized String msgTooMany;
var localized String SwitchingTo;
var localized String OutOf;

// ----------------------------------------------------------------------
// Networking Replication
// ----------------------------------------------------------------------

replication
{
   //client to server function
   reliable if ((Role < ROLE_Authority) && (bNetOwner))
      UseOnce;
}

// ----------------------------------------------------------------------
// PreBeginPlay()
// ----------------------------------------------------------------------
simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if(Level.NetMode == NM_Standalone && DeusExPlayer(GetPlayerPawn()).flagBase.GetBool('HDTP_NotDetected') != True)
		Facelift(true);
}

// ----------------------------------------------------------------------
// Facelift()
//  Applies the new HDTP textures and meshes if present, stays the same
//  otherwise.  Also, the name of this function is made of win
// ----------------------------------------------------------------------
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

// ----------------------------------------------------------------------
// HandlePickupQuery()
//
// If the bCanHaveMultipleCopies variable is set to True, then we want
// to stack items of this type in the player's inventory.
// ----------------------------------------------------------------------

function bool HandlePickupQuery( inventory Item )
{
	local DeusExPlayer player;
	local Inventory anItem;
	local Bool bAlreadyHas;
	local Bool bResult;

	if ( Item.Class == Class )
	{
		player = DeusExPlayer(Owner);
		bResult = False;

		// Check to see if the player already has one of these in 
		// his inventory
		anItem = player.FindInventoryType(Item.Class);

		if ((anItem != None) && (bCanHaveMultipleCopies))
		{
			// don't actually put it in the hand, just add it to the count
			NumCopies += DeusExPickup(item).NumCopies;

			if ((MaxCopies > 0) && (NumCopies > MaxCopies))
			{
				NumCopies -= DeusExPickup(item).NumCopies;
				player.ClientMessage(msgTooMany);

				// abort the pickup
				return True;
			}

			DeusExPickup(Item).NumCopies--;
			DeusExPickup(anItem).TransferSkin(Item); //== Handle multi-skin pickups
			DeusExPickup(Item).NumCopies++;
			bResult = True;
		}

		if (bResult)
		{
			player.ClientMessage(Item.PickupMessage @ Item.itemArticle @ Item.itemName, 'Pickup');

			// Destroy me!
         		// DEUS_EX AMSD In multiplayer, we don't want to destroy the item, we want it to set to respawn
         		if (Level.NetMode != NM_Standalone)
         		   Item.SetRespawn();
         		else			
         		   Item.Destroy();
		}
		else
		{
			bResult = Super.HandlePickupQuery(Item);
		}

		// Update object belt text
		if (bResult)
		{			
			UpdateBeltText();	
		}

		return bResult;
	}

	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

// ----------------------------------------------------------------------
// UseOnce()
//
// Subtract a use, then destroy if out of uses
// ----------------------------------------------------------------------

function UseOnce()
{
	local DeusExPlayer player;

	player = DeusExPlayer(Owner);
	NumCopies--;

	if (!IsA('SkilledTool'))
		GotoState('DeActivated');

	if (NumCopies <= 0)
	{
		if (player.inHand == Self)
			player.PutInHand(None);
		Destroy();
	}
	else
	{
		UpdateBeltText();
	}
}

// ----------------------------------------------------------------------
// UpdateBeltText()
// ----------------------------------------------------------------------

function UpdateBeltText()
{
	local DeusExRootWindow root;

	if (DeusExPlayer(Owner) != None)
	{
		root = DeusExRootWindow(DeusExPlayer(Owner).rootWindow);

		// Update object belt text
		if ((bInObjectBelt) && (root != None) && (root.hud != None) && (root.hud.belt != None))
			root.hud.belt.UpdateObjectText(beltPos);
	}
}

// ----------------------------------------------------------------------
// BreakItSmashIt()
// ----------------------------------------------------------------------

simulated function BreakItSmashIt(class<fragment> FragType, float size) 
{
	local int i;
	local DeusExFragment s;

	for (i=0; i<Int(size); i++) 
	{
		s = DeusExFragment(Spawn(FragType, Owner));
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity,0);
			s.DrawScale = ((FRand() * 0.05) + 0.05) * size;
			s.Skin = GetMeshTexture();

			// play a good breaking sound for the first fragment
			if (i == 0)
				s.PlaySound(sound'GlassBreakSmall', SLOT_None,,, 768);
		}
	}

	Destroy();
}

singular function BaseChange()
{
	Super.BaseChange();

	// Make sure we fall if we don't have a base
	if ((base == None) && (Owner == None))
		SetPhysics(PHYS_Falling);
}

// ----------------------------------------------------------------------
// state Pickup
// ----------------------------------------------------------------------

auto state Pickup
{
	// if we hit the ground fast enough, break it, smash it!!!
	function Landed(Vector HitNormal)
	{
		Super.Landed(HitNormal);

		if (bBreakable)
			if (VSize(Velocity) > 400)
				BreakItSmashIt(fragType, (CollisionRadius + CollisionHeight) / 2);
	}
}

state DeActivated
{
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

	if (bCanHaveMultipleCopies)
	{
		// Print the number of copies
		str = CountLabel @ String(NumCopies);
		winInfo.AppendText(str);
	}

	return True;
}

// ----------------------------------------------------------------------
// PlayLandingSound()
// ----------------------------------------------------------------------

function PlayLandingSound()
{
	if (LandSound != None)
	{
		if (Velocity.Z <= -200)
		{
			PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768);
			AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 768);
		}
	}
}

// ----------------------------------------------------------------------
// SwitchItem()
// Changes from lockpick to multitool and medkit to bioelectric cell
// ----------------------------------------------------------------------
function SwitchItem()
{
	local Inventory W;
	local DeusExPlayer P;
	local string Ws;

	P = DeusExPlayer(Owner);
	W = None;
	Ws = "-1";

	if(IsA('Multitool') && Level.NetMode == NM_Standalone)
	{
		W = P.FindInventoryType(Class'DeusEx.Lockpick');
		Ws = (Class'Lockpick').Default.ItemName;
	}
	else if(IsA('Lockpick') && Level.NetMode == NM_Standalone)
	{
		W = P.FindInventoryType(Class'DeusEx.Multitool');
		Ws = (Class'Multitool').Default.ItemName;
	}
	else if(IsA('Medkit'))
	{
		W = P.FindInventoryType(Class'DeusEx.BioelectricCell');
		Ws = (Class'BioelectricCell').Default.ItemName;
	}
	else if(IsA('BioelectricCell'))
	{
		W = P.FindInventoryType(Class'DeusEx.Medkit');
		Ws = (Class'Medkit').Default.ItemName;
	}

	if(W != None)
	{
		if(Ws != "-1")
			P.ClientMessage(sprintf(SwitchingTo, Ws));
		if(W.beltPos == -1)
			P.AddObjectToBelt(W,Self.beltPos,false);
		P.PutInHand(W);
	}
	else
	{
		P.ClientMessage(sprintf(OutOf, Ws));
	}
}

function TransferSkin(Inventory inv)
{

}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     CountLabel="COUNT:"
     msgTooMany="You can't carry any more of those"
     SwitchingTo="Switching to %s"
     OutOf="Out of %s"
     NumCopies=1
     PickupMessage="You found"
     ItemName="DEFAULT PICKUP NAME - REPORT THIS AS A BUG"
     RespawnTime=30.000000
     LandSound=Sound'DeusExSounds.Generic.PaperHit1'
}
