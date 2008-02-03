//=============================================================================
// AmmoCombatKnife.
//=============================================================================

//Modified -- Y|yukichigai

class AmmoCombatKnife extends DeusExAmmo;

defaultproperties
{
     AmmoAmount=1
     MaxAmmo=6
     ItemName="Combat Knife"
     ItemArticle="a"
     Icon=Texture'DeusExUI.Icons.BeltIconCombatKnife'
     PickupViewMesh=LodMesh'DeusExItems.CombatKnifePickup'
     Mesh=LodMesh'DeusExItems.CombatKnifePickup'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
