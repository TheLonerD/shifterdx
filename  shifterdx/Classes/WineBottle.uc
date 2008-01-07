//=============================================================================
// WineBottle.
//=============================================================================
class WineBottle extends DeusExPickup;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPWineBottle", class'mesh', TRue));

	if(Mesh == None)
		Mesh = Default.Mesh;
	else
	{
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPWineBottletex2", class'Texture'));
		PickupViewMesh = Mesh;
		PlayerViewMesh = Mesh;
		ThirdPersonMesh = Mesh;
	}
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			player.HealPlayer(2, False);
			if(player.drugEffectTimer < 0.0 && player.drugEffectTimer >= -5.0)
			{
				player.drugEffectTimer = -0.1;
			}
			else
				player.drugEffectTimer += 5.0;
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
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
