//=============================================================================
// WineBottle.
//=============================================================================
class WineBottle extends DeusExPickup;

function Facelift(bool bOn)
{
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
}

//== Look ma, we can switch between food items now
function SwitchItem()
{
	local Class<DeusExPickup> SwitchList[6];
	local Inventory inv;
	local int i;
	local DeusExPlayer P;

	P = DeusExPlayer(Owner);

	i = 0;

	//== Comment out the self reference here and we're done
//	SwitchList[i++] = class'WineBottle';
	SwitchList[i++] = class'VialCrack';
	SwitchList[i++] = class'Candybar';
	SwitchList[i++] = class'Liquor40oz';
	SwitchList[i++] = class'LiquorBottle';
	SwitchList[i++] = class'Sodacan';
	SwitchList[i++] = class'SoyFood';

	for(i = 0; i < 6; i++)
	{
		inv = P.FindInventoryType(SwitchList[i]);

		if(inv != None)
		{
			if(inv.beltPos == -1)
			{
				P.ClientMessage(Sprintf(SwitchingTo,inv.ItemName));
				P.AddObjectToBelt(inv,Self.beltPos,false);
				P.PutInHand(inv);
				i = 6;
				break;
			}
		}
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
		local int mult;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			if(player.SkillSystem != None)
				mult += player.SkillSystem.GetSkillLevel(class'SkillMedicine') + 1;

//			player.HealPlayer(2, False);
			player.HealPlayer(1 + mult, False);
			if(player.drugEffectTimer < 0.0 && player.drugEffectTimer >= -5.0)
				player.drugEffectTimer = -0.1;
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
