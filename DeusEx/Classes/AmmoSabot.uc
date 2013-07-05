//=============================================================================
// AmmoSabot.
//=============================================================================

//Modified -- Y|yukichigai

class AmmoSabot extends DeusExAmmo;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPAmmoShell", class'Mesh', True));
		Skin = Texture(DynamicLoadObject("HDTPItems.HDTPAmmoShellTex2", class'Texture', True));
	}

	if(Mesh == None || Skin == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Default.Skin;
	}

	PickupViewMesh = Mesh;
	MultiSkins[1] = Skin;

	return true;
} 

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local ShellCasing2 shell;

	if (Super.UseAmmo(AmountNeeded))
	{
		GetAxes(Pawn(Owner).ViewRotation, X, Y, Z);
		offset = Owner.CollisionRadius * X + 0.3 * Owner.CollisionRadius * Y;
		tempvec = 0.8 * Owner.CollisionHeight * Z;
		offset.Z += tempvec.Z;
      if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      {
         shell = None;
      }
      else
      {
         shell = spawn(class'ShellCasing2',,, Owner.Location + offset);
      }
		if (shell != None)
		{
			shell.Velocity = (FRand()*20+90) * Y + (10-FRand()*20) * X;
			shell.Velocity.Z = 0;
		}
		return True;
	}

	return False;
}

defaultproperties
{
     bShowInfo=True
     bIsNonStandard=True
     AmmoAmount=12
     MaxAmmo=96
     ItemName="12 Gauge Sabot Shells"
     ItemArticle="some"
     PickupViewMesh=LodMesh'DeusExItems.AmmoShell'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoSabot'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoSabot'
     largeIconWidth=35
     largeIconHeight=46
     Description="A 12 gauge shotgun shell surrounding a solid core of tungsten that can punch through all but the thickest hardened steel armor at close range; however, its ballistic profile will result in minimal damage to soft targets."
     beltDescription="SABOT"
     Skin=Texture'DeusExItems.Skins.AmmoShellTex2'
     Mesh=LodMesh'DeusExItems.AmmoShell'
     CollisionRadius=9.300000
     CollisionHeight=10.210000
     bCollideActors=True
}
