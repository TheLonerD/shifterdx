//=============================================================================
// AmmoPlasma.
//=============================================================================
class AmmoPlasma extends DeusExAmmo;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPAmmoPlasma", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		PickupViewMesh = Default.Mesh;
	}
	else
		PickupViewMesh = Mesh;

	return true;
} 

defaultproperties
{
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=84
     ItemName="Plasma Clip"
     ItemArticle="a"
     PickupViewMesh=LodMesh'DeusExItems.AmmoPlasma'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoPlasma'
     largeIconWidth=22
     largeIconHeight=46
     Description="A clip of extruded, magnetically-doped plastic slugs that can be heated and delivered with devastating effect using the plasma gun."
     beltDescription="PMA CLIP"
     Mesh=LodMesh'DeusExItems.AmmoPlasma'
     CollisionRadius=4.300000
     CollisionHeight=8.440000
     bCollideActors=True
}
