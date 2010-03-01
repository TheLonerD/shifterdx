//=============================================================================
// AmmoShuriken.
//=============================================================================

//Modified -- Y|yukichigai

class AmmoShuriken extends DeusExAmmo;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
      AmmoAmount = 7;
}

defaultproperties
{
     AmmoAmount=5
     MaxAmmo=25
     ItemName="Throwing Knives"
     ItemArticle="some"
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconShuriken'
     largeIcon=Texture'DeusExUI.Icons.LargeIconShuriken'
     Mesh=LodMesh'DeusExItems.ShurikenPickup'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
