//=============================================================================
// CigaretteMachine.
//=============================================================================
class CigaretteMachine extends ElectronicDevices;

#exec OBJ LOAD FILE=Ambient

var() int Cost;

var localized String msgDispensed;
var localized String msgNoCredits;
var int numUses;
var localized String msgEmpty;
var localized String CostUnit;
var Class<Actor> VendProduct;
var localized String VendProductName;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPcigarettemachine", class'mesh', True));
	
	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

//	if(VendProduct != None && VendProductName == "")
//		VendProductName = VendProduct.Default.ItemName;

	if(VendProductName == "") VendProductName = (class'Cigarettes').Default.ItemName;
}

function String GetDecoName()
{
	if(numUses > 0)
	{
		if(ClassIsChildOf(Class, class'CigaretteMachine'))
		{
			if(Cost <= 0)
				return ItemName $ " (Free!)";
			return ItemName $ " (" $ Cost $" Credits)";
		}

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
	local string hackstring;

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
			else
				product = Spawn(class'Cigarettes', None,, loc);

			if (product != None)
			{
				PlaySound(sound'VendingSmokes', SLOT_None);
				product.Velocity = Vector(Rotation) * 100;
				product.bFixedRotationDir = True;
				product.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
				product.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;

				if(product.IsA('Cigarettes') && Rand(2) == 1)
				{
					Cigarettes(product).Cig = SC_BigTop;
					Cigarettes(product).SetSkin();
				}
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
     msgEmpty="It's empty"
     cost=8
     CostUnit="credits"
     ItemName="Cigarette Machine"
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.CigaretteMachine'
     SoundRadius=8
     SoundVolume=96
     AmbientSound=Sound'Ambient.Ambient.HumLight3'
     CollisionRadius=27.000000
     CollisionHeight=26.320000
     Mass=150.000000
     Buoyancy=100.000000
}
