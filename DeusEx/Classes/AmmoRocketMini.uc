//=============================================================================
// AmmoRocketMini.
//=============================================================================
class AmmoRocketMini extends DeusExAmmo;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Skin = Texture(DynamicLoadObject("ShifterEX.Ammo.AmmoRocketMini",class'Texture', True));

	if(!bOn || Skin == None)
		Skin = Default.Skin;

	return true;
}

defaultproperties
{
     bShowInfo=True
     bIsNonStandard=True
     DynamicLoadIcon="ShifterEX.Icons.BeltIconAmmoRocketMini"
     AmmoAmount=10
     MaxAmmo=60
     ItemName="Light Rockets"
     ItemArticle="some"
     PickupViewMesh=LodMesh'DeusExItems.GEPAmmo'
     LandSound=Sound'DeusExSounds.Generic.WoodHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoRockets'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoRockets'
     largeIconWidth=46
     largeIconHeight=36
     Description="A lighter version of the standard Guided Explosive Projectile.  As such it carries a smaller explosive charge than a standard GEP."
     beltDescription="L-ROCKET"
     Mesh=LodMesh'DeusExItems.GEPAmmo'
     CollisionRadius=18.000000
     CollisionHeight=7.800000
     bCollideActors=True
}
