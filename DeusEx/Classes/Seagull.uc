//=============================================================================
// Seagull.
//=============================================================================
class Seagull extends Bird;

function Carcass SpawnCarcass()
{
	local Inventory item;

	if (bStunned || DeusExPlayer(GetPlayerPawn()).combatDifficulty <= 4.0)
		return Super.SpawnCarcass();

	item = Inventory;

	while(item != None)
	{
		if(item.Base != Self)
			break;

		if(item.IsA('DeusExWeapon') && DeusExWeapon(item).bNativeAttack)
		{}
		else if(item.IsA('DeusExAmmo') && (!DeusExAmmo(item).bIsNonStandard || item.PickupViewMesh == LodMesh'DeusExItems.TestBox' || item.Description == (class'DeusExAmmo').Default.Description))
		{}
		else
		{
			if(item.IsA('DeusExWeapon'))
			{
				DeusExWeapon(item).AmmoType = None;
				DeusExWeapon(item).PickupAmmoCount = Rand(DeusExWeapon(item).Default.PickupAmmoCount) + 1;
			}

			DeleteInventory(item);
			item.DropFrom(Location + vect(0,0,2));
		}
		item = item.Inventory;

		if(item == Inventory) // looping inventory
			item = None;
	}

	Explode();

	return None;
}

//     InitialAlliances(0)=(AllianceName=Pigeon,AllianceLevel=-1.000000)

defaultproperties
{
     CarcassType=Class'DeusEx.SeagullCarcass'
     WalkingSpeed=0.666667
     GroundSpeed=24.000000
     WaterSpeed=8.000000
     AirSpeed=150.000000
     AccelRate=500.000000
     JumpZ=0.000000
     BaseEyeHeight=3.000000
     Health=20
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Fear
     HealthHead=20
     HealthTorso=20
     HealthLegLeft=20
     HealthLegRight=20
     HealthArmLeft=20
     HealthArmRight=20
     Alliance=Seagull
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Seagull'
     CollisionRadius=16.000000
     CollisionHeight=6.500000
     Mass=2.000000
     Buoyancy=2.500000
     RotationRate=(Pitch=8000)
     BindName="Seagull"
     FamiliarName="Seagull"
     UnfamiliarName="Seagull"
}
