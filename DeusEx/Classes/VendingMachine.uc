//=============================================================================
// VendingMachine.
//=============================================================================
class VendingMachine extends ElectronicDevices;

#exec OBJ LOAD FILE=Ambient

enum ESkinColor
{
	SC_Drink,
	SC_Snack
};

var() ESkinColor SkinColor;

var localized String msgDispensed;
var localized String msgNoCredits;
var int numUses;
var int Cost;
var localized String VendProductName;
var localized String CostUnit;
var Class<Actor> VendProduct; //what the machine vends.  Using the Actor class means that you can
			      // make it vend pretty much anything: pickups, weapons, grenades, NPCs....
var localized String msgEmpty;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	Skin = None;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPVendingMachine", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		MultiSkins[1] = None;
		MultiSkins[2] = None;
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_Drink: 	Skin = Texture'VendingMachineTex1';
					break;
			case SC_Snack:	Skin = Texture'VendingMachineTex2';
					break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_Drink: 	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingDrinktex1",class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingDrinktex2",class'Texture', True));
					break;
			case SC_Snack:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingSnacktex1",class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingSnacktex2",class'Texture', True));
					break;
		}
	}

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

//	if(VendProduct != None && VendProductName == "")
//		VendProductName = VendProduct.Default.ItemName;

	switch (SkinColor)
	{
		case SC_Drink:	if(Skin == None)
				{
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingDrinktex1",class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingDrinktex2",class'Texture', True));
				}
				if(MultiSkins[1] == None || MultiSkins[2] == None)
					Skin = Texture'VendingMachineTex1';

				if(VendProductName == "") VendProductName = (class'Sodacan').Default.ItemName; break;

		case SC_Snack:	if(Skin == None)
				{
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingSnacktex1",class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPvendingSnacktex2",class'Texture', True));
				}
				if(MultiSkins[1] == None || MultiSkins[2] == None)
					Skin = Texture'VendingMachineTex2';

				if(VendProductName == "") VendProductName = (class'Candybar').Default.ItemName; break;
	}

}

function String GetDecoName()
{
	if(numUses > 0)
	{
		if(Cost <= 0)
			return ItemName $ " (" $ VendProductName $ " - Free!)";
		return ItemName $ " (" $ VendProductName $ " - " $ Cost $ " " $ CostUnit $ ")";
	}
	return ItemName $ " (Empty)";
}

function Frob(actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local Vector loc;
	local Actor product;
	local String hackstring;

	Super.Frob(Frobber, frobWith);
	
	player = DeusExPlayer(Frobber);

	if (player != None)
	{
		if (numUses <= 0)
		{
			player.ClientMessage(msgEmpty);
			return;
		}

		if(player.SkillSystem != None && Cost > 0)
		{
			if(player.SkillSystem.GetSkillLevelValue(class'SkillComputer') >= 4.000000)
			{
				hackstring = (class'HackableDevices').Default.msgHacking;
				player.ClientMessage( hackstring );
				Cost = 0;
			}
		}

		if (player.Credits >= Cost)
		{
			PlaySound(sound'VendingCoin', SLOT_None);
			loc = Vector(Rotation) * CollisionRadius * 0.8;
			loc.Z -= CollisionHeight * 0.7; 
			loc += Location;

			if(VendProduct != None)
				product = Spawn(VendProduct, None,, loc);
			else if (SkinColor == SC_Drink)
				product = Spawn(class'Sodacan', None,, loc);
			else
				product = Spawn(class'Candybar', None,, loc);

			if (product != None)
			{
				if (product.IsA('Sodacan'))
					PlaySound(sound'VendingCan', SLOT_None);
				else
					PlaySound(sound'VendingSmokes', SLOT_None);

				product.Velocity = Vector(Rotation) * 100;
				product.bFixedRotationDir = True;
				product.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
				product.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;
			}

			player.Credits -= Cost;
			player.ClientMessage(Sprintf(msgDispensed,Cost));
			numUses--;
		}
		else
			player.ClientMessage(Sprintf(msgNoCredits,Cost));
	}
}

defaultproperties
{
     msgDispensed="%d credits deducted from your account"
     msgNoCredits="Costs %d credits..."
     numUses=10
     cost=2
     CostUnit="credits"
     msgEmpty="It's empty"
     bCanBeBase=True
     ItemName="Vending Machine"
     Mesh=LodMesh'DeusExDeco.VendingMachine'
     SoundRadius=8
     SoundVolume=96
     AmbientSound=Sound'Ambient.Ambient.HumLow3'
     CollisionRadius=34.000000
     CollisionHeight=50.000000
     Mass=150.000000
     Buoyancy=100.000000
}
