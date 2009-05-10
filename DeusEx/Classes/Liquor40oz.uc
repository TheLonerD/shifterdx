//=============================================================================
// Liquor40oz.
//=============================================================================
class Liquor40oz extends Consumable;

enum ESkinColor
{
	SC_Super45,
	SC_Bottle2,
	SC_Bottle3,
	SC_Bottle4
};

var() ESkinColor SkinColor;

var() ESkinColor StackSkins[9];

function bool Facelift(bool bOn)
{
	local int skinnum;

	if(!Super.Facelift(bOn))
		return false;

	skinnum = SkinColor;

	if(numCopies > 1 && numCopies <= 10)
		skinnum = StackSkins[numCopies - 2];

	skinnum++;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPItems.HDTPLiquor40oz", class'mesh', True));

	if(Mesh == None || !bOn || skinnum != 1)
	{
		Texture = None;
		Mesh = Default.Mesh;
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Skin = Texture(DynamicLoadObject("DeusExItems.Liquor40ozTex"$ skinnum, class'Texture'));
	}
	else
	{
		PlayerViewMesh = Mesh;
		PickupViewMesh = Mesh;
		ThirdPersonMesh = Mesh;
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLiquor40oztex2", class'Texture')); //The formula will probably be skinnum * 2 in the future
		Skin = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLiquor40oztex1", class'Texture', True)); //This is always the same image, for now
	}

	return true;
}

function BeginPlay()
{
	local int skinnum;

	Super.BeginPlay();

	skinnum = SkinColor + 1;

	if(Mesh != Default.Mesh && skinnum == 1)
		Skin = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPLiquor40oztex" $ skinnum, class'Texture', True));
	else
	{
		Texture = None;
		Mesh = Default.Mesh;
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		Skin = Texture(DynamicLoadObject("DeusExItems.Liquor40ozTex"$ skinnum, class'Texture'));
	}
}

function TransferSkin(Inventory inv)
{
	if(numCopies > 1 && numCopies <= 10)
	{
		if(DeusExPickup(inv).numCopies >= 1 && DeusExPickup(inv).numCopies < 10)
			StackSkins[numCopies - 2] = Liquor40oz(inv).StackSkins[DeusExPickup(inv).numCopies - 1];
		else
			StackSkins[numCopies - 2] = Liquor40oz(inv).SkinColor;
	}
	else
	{
		if(DeusExPickup(inv).numCopies >= 1 && DeusExPickup(inv).numCopies < 10)
			SkinColor = Liquor40oz(inv).StackSkins[DeusExPickup(inv).numCopies - 1];
		else
			SkinColor = Liquor40oz(inv).SkinColor;
	}

	if(Level.NetMode == NM_Standalone)
	{
		Facelift(True);
		DeusExPickup(inv).Facelift(True);
	}
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
     drugEffect=7.000000
     healthEffect=5
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
