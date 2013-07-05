//=============================================================================
// AnnaNavarre.
//=============================================================================
class AnnaNavarre extends HumanMilitary;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPcharacters.HDTPAnna", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Texture = Default.Texture;
		Mesh = Default.Mesh;
		for(i = 0; i < 8; i++)
		{
			MultiSkins[i] = Default.MultiSkins[i];
		}
	}
	else
	{
		Texture = None;
		for(i = 0; i < 8; i++)
		{
			MultiSkins[i] = None;
		}
	}

	return true;
}

// ----------------------------------------------------------------------
// SpawnCarcass()
//
// Blow up instead of spawning a carcass
// ----------------------------------------------------------------------

function Carcass SpawnCarcass()
{
	if (bStunned)
		return Super.SpawnCarcass();

	Explode();

	return None;
}

function Explode(optional vector HitLocation) //== For cross-mod compatibility
{
	Super.Explode(HitLocation);
}

function Bool HasTwoHandedWeapon()
{
	return False;
}

function float ModifyDamage(int Damage, Pawn instigatedBy, Vector hitLocation,
                            Vector offset, Name damageType)
{
	if ((damageType == 'Stunned') || (damageType == 'KnockedOut') || (damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return 0;
	else
		return Super.ModifyDamage(Damage, instigatedBy, hitLocation, offset, damageType);
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

defaultproperties
{
     CarcassType=Class'DeusEx.AnnaNavarreCarcass'
     WalkingSpeed=0.280000
     bImportant=True
     bInvincible=True
     CloseCombatMult=0.500000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     BurnPeriod=5.000000
     bHasCloak=True
     CloakThreshold=100
     walkAnimMult=1.000000
     bIsFemale=True
     GroundSpeed=220.000000
     BaseEyeHeight=38.000000
     Health=300
     HealthHead=400
     HealthTorso=300
     HealthLegLeft=300
     HealthLegRight=300
     HealthArmLeft=300
     HealthArmRight=300
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex9'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.AnnaNavarreTex1'
     CollisionHeight=47.299999
     BindName="AnnaNavarre"
     FamiliarName="Anna Navarre"
     UnfamiliarName="Anna Navarre"
}
