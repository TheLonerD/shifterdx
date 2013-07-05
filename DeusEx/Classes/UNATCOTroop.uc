//=============================================================================
// UNATCOTroop.
//=============================================================================
class UNATCOTroop extends HumanMilitary;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPUNATCOTroop", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = None;
	}

	return true;
}

defaultproperties
{
     CarcassType=Class'DeusEx.UNATCOTroopCarcass'
     WalkingSpeed=0.296000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.UNATCOTroopTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.UNATCOTroopTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.UNATCOTroopTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="UNATCOTroop"
     FamiliarName="UNATCO Troop"
     UnfamiliarName="UNATCO Troop"
}
