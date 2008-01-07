//=============================================================================
// Ammo10mmEX.
//=============================================================================
class Ammo10mmEX extends Ammo10mm;

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

      if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      {
         shell = None;
      }
      else
      {
         shell = spawn(class'ShellCasing',,, Owner.Location + offset);
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
     bIsNonStandard=True
     MaxAmmo=75
     ItemName="Explosive 10mm ammo"
     Description="By tipping standard 10mm rounds with a modest amount of magnesium, an average handgun can take down a wide range of targets, including bots.  The United Nations has banned the sale and use of explosive rounds for this reason."
     beltDescription="EXP AMMO"
}
