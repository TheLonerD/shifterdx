//=============================================================================
// Cigarettes.
//=============================================================================
class Cigarettes extends DeusExPickup;

enum ECigType
{
	SC_Default,
	SC_BigTop
};


var ECigType Cig;

function BeginPlay()
{
	Super.BeginPlay();

	SetSkin();
}

function SetSkin()
{
	local Texture lSkin;
	local string texstr;

	switch (Cig)
	{
		case SC_Default:	 texstr = "HDTPitems.Skins.HDTPcigarettesTex1"; break;
		case SC_BigTop:		 texstr = "HDTPitems.Skins.HDTPcigarettesTex2"; break;
	}

	lSkin = Texture(DynamicLoadObject(texstr,class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local Pawn P;
		local vector loc;
		local rotator rot;
		local CigSmoke puff; //SmokeTrail puff;
		
		Super.BeginState();

		P = Pawn(Owner);
		if (P != None)
		{
			P.TakeDamage(5, P, P.Location, vect(0,0,0), 'PoisonGas');
			loc = Owner.Location;
			rot = Owner.Rotation;
			loc += 2.0 * Owner.CollisionRadius * vector(P.ViewRotation);
			loc.Z += Owner.CollisionHeight * 0.9;
			puff = Spawn(class'CigSmoke', Owner,, loc, rot);
			if (puff != None)
			{
				puff.DrawScale = 1.0;
//				puff.origScale = puff.DrawScale;
				if(Frand() >= 0.5)
					puff.DamageType = 'TearGas';
			}
			PlaySound(sound'MaleCough');
			if(DeusExPlayer(Owner) != None)
				DeusExPlayer(Owner).drugEffectTimer = 0.0;
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Cigarettes"
     ItemArticle="some"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Cigarettes'
     PickupViewMesh=LodMesh'DeusExItems.Cigarettes'
     ThirdPersonMesh=LodMesh'DeusExItems.Cigarettes'
     Icon=Texture'DeusExUI.Icons.BeltIconCigarettes'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCigarettes'
     largeIconWidth=29
     largeIconHeight=43
     Description="'COUGHING NAILS -- when you've just got to have a cigarette.'"
     beltDescription="CIGS"
     Mesh=LodMesh'DeusExItems.Cigarettes'
     CollisionRadius=5.200000
     CollisionHeight=1.320000
     Mass=2.000000
     Buoyancy=3.000000
}
