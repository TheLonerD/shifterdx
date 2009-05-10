//=============================================================================
// Cigarettes.
//=============================================================================
class Cigarettes extends Consumable;

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

function bool Facelift(bool bOn)
{
	local string texstr;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		switch (Cig)
		{
			case SC_Default:	 texstr = "HDTPitems.Skins.HDTPcigarettesTex1"; break;
			case SC_BigTop:		 texstr = "HDTPitems.Skins.HDTPcigarettesTex2"; break;
		}
		Skin = Texture(DynamicLoadObject(texstr,class'Texture', True));
	}

	if(Skin == None || !bOn)
		Skin = None;

	return true;

}

//== We can't just use the parent Consumable class, since we gotta do some complex stuff
state Activated
{
	function Activate()
	{

	}

	function BeginState()
	{
		local Pawn P;
		local vector loc;
		local rotator rot;
		local CigSmoke puff; //SmokeTrail puff;
		
		P = Pawn(Owner);
		if (P != None)
		{
			loc = Owner.Location;
			rot = Owner.Rotation;
			loc += 2.0 * Owner.CollisionRadius * vector(P.ViewRotation);
			loc.Z += Owner.CollisionHeight * 0.9;
			puff = Spawn(class'CigSmoke', Owner,, loc, rot);
			if (puff != None)
			{
				puff.DrawScale = 1.0;
				if(Frand() >= 0.5)
					puff.DamageType = 'TearGas';
			}
			PlaySound(sound'MaleCough');
			if(DeusExPlayer(Owner) != None)
			{
				if(DeusExPlayer(Owner).drugEffectTimer >= 0.0)
					DeusExPlayer(Owner).drugEffectTimer = 0.0;
				else
					DeusExPlayer(Owner).drugEffectTimer = -0.1;
			}
		}

		Super.BeginState();
	}
Begin:
}

defaultproperties
{
     healthEffect=-5
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
