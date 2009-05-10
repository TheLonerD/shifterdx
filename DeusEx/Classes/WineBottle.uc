//=============================================================================
// WineBottle.
//=============================================================================
class WineBottle extends Consumable;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPWineBottle", class'mesh', TRue));

	if(Mesh == None || !bOn)
	{
		Texture = None;
		PickupViewMesh = Default.PickupViewMesh;
		PlayerViewMesh = Default.PlayerViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Mesh = Default.Mesh;
	}
	else
	{
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPWineBottletex2", class'Texture'));
		PickupViewMesh = Mesh;
		PlayerViewMesh = Mesh;
		ThirdPersonMesh = Mesh;
	}

	return true;
}

state Activated
{
	function Activate()
	{
		Super.Activate();
	}

	function BeginState()
	{
		Super.BeginState();
	}
Begin:
}

defaultproperties
{
     drugEffect=5.000000
     healthEffect=2
     bBreakable=True
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Wine"
     ItemArticle="some"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.WineBottle'
     PickupViewMesh=LodMesh'DeusExItems.WineBottle'
     ThirdPersonMesh=LodMesh'DeusExItems.WineBottle'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconWineBottle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWineBottle'
     largeIconWidth=36
     largeIconHeight=48
     Description="A nice bottle of wine."
     beltDescription="WINE"
     Mesh=LodMesh'DeusExItems.WineBottle'
     CollisionRadius=4.060000
     CollisionHeight=16.180000
     Mass=10.000000
     Buoyancy=8.000000
}
