//=============================================================================
// Sodacan.
//=============================================================================
class Sodacan extends DeusExPickup;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPsodacan", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
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
