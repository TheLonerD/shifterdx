//=============================================================================
// PaulDenton.
//=============================================================================
class PaulDenton extends HumanMilitary;

var Texture PaulTex[5];
var Texture PaulHandTex[5];

//
// Damage type table for Paul Denton:
//
// Shot			- 100%
// Sabot		- 100%
// Exploded		- 100%
// TearGas		- 10%
// PoisonGas	- 10%
// Poison		- 10%
// PoisonEffect	- 10%
// HalonGas		- 10%
// Radiation	- 10%
// Shocked		- 10%
// Stunned		- 0%
// KnockedOut   - 0%
// Flamed		- 0%
// Burned		- 0%
// NanoVirus	- 0%
// EMP			- 0%
//

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPGM_Trench", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];

		for(i = 0; i < 5; ++i)
		{
			PaulTex[i] = Default.PaulTex[i];
			PaulHandTex[i] = Default.PaulHandTex[i];
		}
	}
	else
	{
		MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex1", class'Texture'));
		MultiSkins[2] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex2", class'Texture'));
		MultiSkins[4] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCDentonTex4", class'Texture'));
		MultiSkins[5] = Texture'PinkMaskTex';
		MultiSkins[6] = Texture'PinkMaskTex';
		MultiSkins[7] = Texture'PinkMaskTex';

		PaulTex[0] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex0", class'Texture'));
		PaulHandTex[0] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCHandsTex0", class'Texture'));

		for(i = 1; i < 5; ++i)
		{
			PaulTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPPaulDentonTex"$ (i+1), class'Texture'));
			PaulHandTex[i] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPJCHandsTex"$ i, class'Texture'));
		}
	}

	SetSkin(DeusExPlayer(GetPlayerPawn()));

	return true;
}

function float ShieldDamage(name damageType)
{
	// handle special damage types
	if ((damageType == 'Flamed') || (damageType == 'Burned') || (damageType == 'Stunned') ||
	    (damageType == 'KnockedOut'))
		return 0.0;
	else if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'HalonGas') ||
			(damageType == 'Radiation') || (damageType == 'Shocked') || (damageType == 'Poison') ||
	        (damageType == 'PoisonEffect'))
		return 0.1;
	else
		return Super.ShieldDamage(damageType);
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

//== Paul shouldn't kill anybody in the first mission
function InitializeInventory()
{
	local DeusExLevelInfo info;
	info = DeusExPlayer(GetPlayerPawn()).GetLevelInfo();

	if(caps(info.mapName) == "01_NYC_UNATCOISLAND")
	{
		InitialInventory[0].Inventory = Class'WeaponMiniCrossbow';
		InitialInventory[1].Inventory = Class'AmmoDartPoison';
		InitialInventory[1].Count = 20;
		InitialInventory[2].Inventory = Class'WeaponPepperGun';
		InitialInventory[3].Inventory = Class'AmmoPepper';
		InitialInventory[3].Count = 200;
		InitialInventory[4].Inventory = Class'WeaponProd';
		InitialInventory[5].Inventory = Class'AmmoBattery';
		InitialInventory[5].Count = 12;
		InitialInventory[6].Inventory = Class'WeaponBlackjack';
	}

	Super.InitializeInventory();
}

// ----------------------------------------------------------------------
// SetSkin()
// ----------------------------------------------------------------------

function SetSkin(DeusExPlayer player)
{
	if (player != None)
	{
		MultiSkins[0] = PaulTex[player.PlayerSkin];
		MultiSkins[3] = PaulHandTex[player.PlayerSkin];
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

//     InitialInventory(4)=(Inventory=Class'DeusEx.WeaponSword')

defaultproperties
{
     CarcassType=Class'DeusEx.PaulDentonCarcass'
     WalkingSpeed=0.120000
     bImportant=True
     bInvincible=True
     BaseAssHeight=-23.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponPlasmaRifle')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoPlasma')
     InitialInventory(4)=(Inventory=Class'DeusEx.WeaponPrototypeSwordA')
     BurnPeriod=0.000000
     bHasCloak=True
     CloakThreshold=100
     Health=200
     HealthHead=200
     HealthTorso=200
     HealthLegLeft=200
     HealthLegRight=200
     HealthArmLeft=200
     HealthArmRight=200
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.PaulDentonTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PaulDentonTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.PaulDentonTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.PaulDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.PaulDentonTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="PaulDenton"
     FamiliarName="Paul Denton"
     UnfamiliarName="Paul Denton"
     PaulTex(0)=Texture'PaulDentonTex0'
     PaulTex(1)=Texture'PaulDentonTex4'
     PaulTex(2)=Texture'PaulDentonTex5'
     PaulTex(3)=Texture'PaulDentonTex6'
     PaulTex(4)=Texture'PaulDentonTex7'
     PaulHandTex(0)=Texture'PaulDentonTex0'
     PaulHandTex(1)=Texture'PaulDentonTex4'
     PaulHandTex(2)=Texture'PaulDentonTex5'
     PaulHandTex(3)=Texture'PaulDentonTex6'
     PaulHandTex(4)=Texture'PaulDentonTex7'
}
