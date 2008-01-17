//=============================================================================
// Sodacan.
//=============================================================================
class Sodacan extends DeusExPickup;

function Facelift(bool bOn)
{
	local Texture lSkin;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPsodacan", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		lSkin = Skin;
		Mesh = Default.Mesh;
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Skin = lSkin;
	}
	else
	{
		PlayerViewMesh = Mesh;
		PickupViewMesh = Mesh;
		ThirdPersonMesh = Mesh;
	}
}

function BeginPlay()
{
	local Sodacan soda;

	Super.BeginPlay();

	ItemName = Default.ItemName $ " (Nuke!)";

	//=== There's a random chance we'll have a different soda label
	if(frand() > 0.4)
	{
		//== Check for any soda in a 2ft range.
		foreach RadiusActors(class'Sodacan', soda, 32)
		{
			if(soda.Skin == None && soda != Self)
				return;
		}

		//== Reset the mesh, as HDTP only has one skin thus far
		Mesh = Default.Mesh;
		PlayerViewMesh = Default.Mesh;
		PickupViewMesh = Default.Mesh;
		ThirdPersonMesh = Default.Mesh;

		switch(Rand(6))
		{
			case 0:
			case 3:
				Skin = Texture'SodaCanTex2';
				MultiSkins[1] = Texture'SodaCanTex2';
				ItemName = Default.ItemName $ " (Zap!)";
				break;

			case 1:
			case 4:
				Skin = Texture'SodaCanTex3';
				MultiSkins[1] = Texture'SodaCanTex3';
				ItemName = Default.ItemName $ " (Burn!)";
				break;

			case 2:
			case 5:
				Skin = Texture'SodaCanTex4';
				MultiSkins[1] = Texture'SodaCanTex4';
				ItemName = Default.ItemName $ " (Blast!)";
				break;
		}
	}	
}

function bool HandlePickupQuery( inventory Item )
{
	local bool bResult;
	local string tString;

	tString = ItemName;
	ItemName = Default.ItemName;

	bResult = Super.HandlePickupQuery(Item);

	if(!bResult)
		ItemName = tString;

	return bResult;
}

//== Let's make sure the name gets reset in all situations
function inventory SpawnCopy( pawn Other )
{
	ItemName = Default.ItemName;

	return Super.SpawnCopy(Other);
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
//	SwitchList[i++] = class'Sodacan';
	SwitchList[i++] = class'SoyFood';
	SwitchList[i++] = class'WineBottle';
	SwitchList[i++] = class'VialCrack';
	SwitchList[i++] = class'Candybar';
	SwitchList[i++] = class'Liquor40oz';
	SwitchList[i++] = class'LiquorBottle';

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
		local float mult;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			if(player.SkillSystem != None)
			{
				mult = player.SkillSystem.GetSkillLevelValue(class'SkillMedicine');
				if(mult <= 0) mult = 1.0;
				else if(mult == 2.5) mult = 3.0;
				else if(mult == 3.0) mult = 4.0;
			}
//			player.HealPlayer(2, False);
			player.HealPlayer(1 + Int(mult), False);
			//Either reduces your drunkenness or extends your zyme high
			if(player.drugEffectTimer > 4.0 || player.drugEffectTimer < 0.0)
				player.drugEffectTimer -= 4.0;
			else
				player.drugEffectTimer = 0.0;			
		}

		PlaySound(sound'MaleBurp');
		UseOnce();
	}
Begin:
}

defaultproperties
{
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Soda"
     ItemArticle="some"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Sodacan'
     PickupViewMesh=LodMesh'DeusExItems.Sodacan'
     ThirdPersonMesh=LodMesh'DeusExItems.Sodacan'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconSodaCan'
     largeIcon=Texture'DeusExUI.Icons.LargeIconSodaCan'
     largeIconWidth=24
     largeIconHeight=45
     Description="The can is blank except for the phrase 'PRODUCT PLACEMENT HERE.' It is unclear whether this is a name or an invitation."
     beltDescription="SODA"
     Mesh=LodMesh'DeusExItems.Sodacan'
     CollisionRadius=3.000000
     CollisionHeight=4.500000
     Mass=5.000000
     Buoyancy=3.000000
}
