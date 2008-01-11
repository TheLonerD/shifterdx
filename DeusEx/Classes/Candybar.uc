//=============================================================================
// Candybar.
//=============================================================================
class Candybar extends DeusExPickup;

simulated function BeginPlay()
{
	Super.BeginPlay();

	if(Rand(2) == 1)
		Skin = Texture'CandybarTex2';
}

function Facelift(bool bOn)
{
	local Texture lSkin;

	lSkin = Skin;

	if(bOn && lSkin != Texture'CandybarTex2')
		Skin = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPCandybartex1", class'Texture', true));

	if(Skin == None || !bOn)
	{
		if(lSkin == Texture'CandybarTex2')
			Skin = lSkin;

		else
			Skin = None;
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
//			player.HealPlayer(3, False);
			player.HealPlayer(2 + Int(mult), False);
		}
		
		UseOnce();
	}
Begin:
}

defaultproperties
{
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Candy Bar"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Candybar'
     PickupViewMesh=LodMesh'DeusExItems.Candybar'
     ThirdPersonMesh=LodMesh'DeusExItems.Candybar'
     Icon=Texture'DeusExUI.Icons.BeltIconCandyBar'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCandyBar'
     largeIconWidth=46
     largeIconHeight=36
     Description="'CHOC-O-LENT DREAM. IT'S CHOCOLATE! IT'S PEOPLE! IT'S BOTH!(tm) 85% Recycled Material.'"
     beltDescription="CANDY BAR"
     Mesh=LodMesh'DeusExItems.Candybar'
     CollisionRadius=6.250000
     CollisionHeight=0.670000
     Mass=3.000000
     Buoyancy=4.000000
}
