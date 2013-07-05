//=============================================================================
// Ammo3006.
//=============================================================================
class Ammo3006 extends DeusExAmmo;

var() Mesh shellmesh;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPAmmo3006", class'Mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
	else
		shellmesh = Mesh(DynamicLoadObject("HDTPItems.HDTPSniperCasing", class'Mesh', True));

	PickupViewMesh = Mesh;

	return true;
} 

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local ShellCasing shell;
	local DeusExWeapon W;

	if (Super.UseAmmo(AmountNeeded))
	{
		GetAxes(Pawn(Owner).ViewRotation, X, Y, Z);
		offset = Owner.CollisionRadius * X + 0.3 * Owner.CollisionRadius * Y;
		tempvec = 0.8 * Owner.CollisionHeight * Z;
		offset.Z += tempvec.Z;

		// use silent shells if the weapon has been silenced
		W = DeusExWeapon(Pawn(Owner).Weapon);
      if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      {
         shell = None;
      }
      else
      {
         if ((W != None) && ((W.NoiseLevel < 0.1) || W.bHasSilencer))
            shell = spawn(class'ShellCasingSilent',,, Owner.Location + offset,Pawn(Owner).viewrotation);
         else
            shell = spawn(class'ShellCasing',,, Owner.Location + offset,Pawn(Owner).viewrotation);
      }

		if (shell != None)
		{
			shell.Velocity = (FRand()*20+90) * Y + (10-FRand()*20) * X;
			shell.Velocity.Z = 0;

			if(shellmesh != None)
				shell.Mesh = shellmesh;
		}
		return True;
	}

	return False;
}

defaultproperties
{
     bShowInfo=True
     AmmoAmount=6
     MaxAmmo=96
     ItemName="30.06 Ammo"
     ItemArticle="some"
     PickupViewMesh=LodMesh'DeusExItems.Ammo3006'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmo3006'
     largeIconWidth=43
     largeIconHeight=31
     Description="Its high velocity and accuracy have made sniper rifles using the 30.06 round the preferred tool of individuals requiring 'one shot, one kill' for over fifty years."
     beltDescription="3006 AMMO"
     Mesh=LodMesh'DeusExItems.Ammo3006'
     CollisionRadius=8.000000
     CollisionHeight=3.860000
     bCollideActors=True
}
