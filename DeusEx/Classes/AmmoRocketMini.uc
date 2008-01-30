//=============================================================================
// AmmoRocketMini.
//=============================================================================
class AmmoRocketMini extends DeusExAmmo;

function Facelift(bool bOn)
{
	local Texture temptex;
	if(bOn)
	{
		temptex = Texture(DynamicLoadObject("ShifterEX.Ammo.AmmoRocketMini",class'Texture', True));
		if(temptex != None)
			Skin = temptex;
	}
	else
		Skin = Default.Skin;
}

defaultproperties
{
     bShowInfo=True
     bIsNonStandard=True
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
     DynamicLoadIcon="ShifterEX.Icons.BeltIconAmmoRocketMini"
}
