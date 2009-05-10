//=============================================================================
// Toilet2.
//=============================================================================
class Toilet2 extends DeusExDecoration;

enum ESkinColor
{
	SC_Clean,
	SC_Filthy
};

var() ESkinColor SkinColor;
var bool bUsing;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPToilet2", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		MultiSkins[1] = None;
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_Clean:	Skin = Texture'Toilet2Tex1';
					break;
			case SC_Filthy:	Skin = Texture'Toilet2Tex2';
					break;
		}
	}
	else
	{
		Skin = None;
		switch (SkinColor)
		{
			case SC_Clean:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanUrinalTex", class'Texture', True));
					break;
			case SC_Filthy:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyUrinalTex", class'Texture', True));
					break;
		}
	}

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Clean:	if(Skin == None)
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanUrinalTex", class'Texture', True));
				if(MultiSkins[1] == None)
					Skin = Texture'Toilet2Tex1';
				break;

		case SC_Filthy:	if(Skin == None)
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyUrinalTex", class'Texture', True));
				if(MultiSkins[1] == None)
					Skin = Texture'Toilet2Tex2';
				break;
	}
}

function Timer()
{
	bUsing = False;
}

function Frob(actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	SetTimer(2.0, False);
	bUsing = True;

	PlaySound(sound'FlushUrinal',,,, 256);
	PlayAnim('Flush');
}

defaultproperties
{
     bInvincible=True
     ItemName="Urinal"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Toilet2'
     CollisionRadius=18.000000
     CollisionHeight=31.000000
     Mass=100.000000
     Buoyancy=5.000000
}
