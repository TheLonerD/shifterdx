//=============================================================================
// Multitool.
//=============================================================================
class Multitool extends SkilledTool;

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

//== Support for HDTP's new hand textures
simulated function renderoverlays(Canvas canvas)
{
	if(HDTPHandTex[1] != HDTPHandTex[0])
	{
		multiskins[1] = Getweaponhandtex();
	
		super.renderoverlays(canvas);
	
		multiskins[1] = none; 
	}
	else
		Super.RenderOverlays(canvas);
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   //Was BeltSpot 9 until I realized you don't need a keyring in MP
   return (BeltSpot == 0);
}


simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 5;
   
}

defaultproperties
{
     UseSound=Sound'DeusExSounds.Generic.MultitoolUse'
     maxCopies=20
     bCanHaveMultipleCopies=True
     ItemName="Multitool"
     PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
     largeIconWidth=28
     largeIconHeight=46
     Description="A disposable electronics tool. By using electromagnetic resonance detection and frequency modulation to dynamically alter the flow of current through a circuit, skilled agents can use the multitool to manipulate code locks, cameras, autogun turrets, alarms, or other security systems."
     beltDescription="MULTITOOL"
     Mesh=LodMesh'DeusExItems.Multitool'
     CollisionRadius=4.800000
     CollisionHeight=0.860000
     Mass=20.000000
     Buoyancy=10.000000
}
