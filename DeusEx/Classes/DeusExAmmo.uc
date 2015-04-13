//=============================================================================
// DeusExAmmo.
//=============================================================================

//Modified -- Y|yukichigai

class DeusExAmmo extends Ammo
	abstract;

var localized String msgInfoRounds;

// True if this ammo can be displayed in the Inventory screen
// by clicking on the "Ammo" button.

var bool bShowInfo;
var int MPMaxAmmo; //Max Ammo in multiplayer.
var bool bIsNonStandard; //For the purposes of picking it up from corpses
var String DynamicLoadIcon; //The icon we should optionally load to use in the GUI, if present

var config bool bNoFacelift; //== Disable HDTP facelift

// ----------------------------------------------------------------------
// PreBeginPlay()
// ----------------------------------------------------------------------
simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if(Level.NetMode == NM_Standalone)// && DeusExPlayer(GetPlayerPawn()).flagBase.GetBool('HDTP_NotDetected') != True)
		Facelift(true);
}

// ----------------------------------------------------------------------
// Facelift()
//  Applies the new HDTP textures and meshes if present, stays the same
//  otherwise.  Also, the name of this function is made of win
// ----------------------------------------------------------------------
function bool Facelift(bool bOn)
{
	if(bNoFacelift && bOn)
		return false;

	//== Only do this for DeusEx classes
	if(instr(String(Class.Name), ".") > -1 && bOn)
		if(instr(String(Class.Name), "DeusEx.") <= -1)
			return false;
	//else
	//	if((Class != Class(DynamicLoadObject("DeusEx."$ String(Class.Name), class'Class', True))) && bOn)
	//		return false;

	return true;
}

// ----------------------------------------------------------------------
// PostBeginPlay()
// ----------------------------------------------------------------------
function PostBeginPlay()
{
	Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
   {   
      if (MPMaxAmmo == 0)      
         MPMaxAmmo = AmmoAmount * 3;
      MaxAmmo = MPMaxAmmo;
   }
}

// ----------------------------------------------------------------------
// HandlePickupQuery() //== Override to display ammo count on pickup
// ----------------------------------------------------------------------
function bool HandlePickupQuery( inventory Item )
{
	if ( (class == item.class) || 
		(ClassIsChildOf(item.class, class'Ammo') && (class == Ammo(item).parentammo)) ) 
	{
		if (AmmoAmount==MaxAmmo) return true;
		if (Level.Game.LocalLog != None)
			Level.Game.LocalLog.LogPickup(Item, Pawn(Owner));
		if (Level.Game.WorldLog != None)
			Level.Game.WorldLog.LogPickup(Item, Pawn(Owner));
		if (Item.PickupMessageClass == None)
			// DEUS_EX CNN - use the itemArticle and itemName
			Pawn(Owner).ClientMessage( Item.PickupMessage @ Item.itemArticle @ Item.ItemName @ "("$Ammo(Item).AmmoAmount$")", 'Pickup' );
		else
			Pawn(Owner).ReceiveLocalizedMessage( Item.PickupMessageClass, 0, None, None, item.Class );
		item.PlaySound( item.PickupSound );
		AddAmmo(Ammo(item).AmmoAmount);
		item.SetRespawn();
		return true;				
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

	// number of rounds left
	winInfo.AppendText(Sprintf(msgInfoRounds, AmmoAmount));

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
// ----------------------------------------------------------------------

defaultproperties
{
     msgInfoRounds="%d Rounds remaining"
     bDisplayableInv=False
     PickupMessage="You found"
     ItemName="DEFAULT AMMO NAME - REPORT THIS AS A BUG"
     ItemArticle=""
     LandSound=Sound'DeusExSounds.Generic.PaperHit1'
}
