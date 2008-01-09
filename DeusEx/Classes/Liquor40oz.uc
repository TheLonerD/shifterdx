//=============================================================================
// Liquor40oz.
//=============================================================================
class Liquor40oz extends DeusExPickup;

enum ESkinColor
{
	SC_Super45,
	SC_Bottle2,
	SC_Bottle3,
	SC_Bottle4
};

var() ESkinColor SkinColor;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPLiquor40oz", class'mesh', True));

	if(Mesh == None)
		Mesh = Default.Mesh;
	else
	{
		PlayerViewMesh = Mesh;
		PickupViewMesh = Mesh;
		ThirdPersonMesh = Mesh;
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLiquor40oztex2", class'Texture'));
	}
}

function BeginPlay()
{
	local string texstr;

	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Super45:		texstr = "Liquor40ozTex1"; break;
		case SC_Bottle2:		texstr = "Liquor40ozTex2"; break;
		case SC_Bottle3:		texstr = "Liquor40ozTex3"; break;
		case SC_Bottle4:		texstr = "Liquor40ozTex4"; break;
	}

	if(Mesh != Default.Mesh)
		Skin = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLiquor40oztex1", class'Texture', True)); //This is always the same image, for now
	else
		Skin = Texture(DynamicLoadObject("DeusExItems."$ texstr, class'Texture'));
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
//			player.HealPlayer(5, False);
			player.HealPlayer(4 + Int(mult), False);
			if(player.drugEffectTimer < 0.0 && player.drugEffectTimer >= -7.0)
				player.drugEffectTimer = -0.1;
			else
				player.drugEffectTimer += 7.0;
		}

		UseOnce();
	}
Begin:
}

//     Description="'COLD SWEAT forty ounce malt liquor. Never let 'em see your COLD SWEAT.'"

defaultproperties
{
     bBreakable=True
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Forty"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Liquor40oz'
     PickupViewMesh=LodMesh'DeusExItems.Liquor40oz'
     ThirdPersonMesh=LodMesh'DeusExItems.Liquor40oz'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconBeerBottle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBeerBottle'
     largeIconWidth=14
     largeIconHeight=47
     Description="'COLD SWEAT forty ounce malt liquor. Never let 'em see your COLD SWEAT.'"
     beltDescription="FORTY"
     Mesh=LodMesh'DeusExItems.Liquor40oz'
     CollisionRadius=3.000000
     CollisionHeight=9.140000
     Mass=10.000000
     Buoyancy=8.000000
}
