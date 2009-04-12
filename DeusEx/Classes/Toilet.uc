//=============================================================================
// Toilet.
//=============================================================================
class Toilet extends DeusExDecoration;

enum ESkinColor
{
	SC_Clean,
	SC_Filthy
};

var() ESkinColor SkinColor;
var bool bUsing;
var bool bNeedsFlushing;
var localized string unflushedString;
var localized string awardString;

function Facelift(bool bOn)
{
	Super.Facelift(bOn);

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPToilet", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		MultiSkins[1] = None;
		MultiSkins[2] = None;
		MultiSkins[3] = None;
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_Clean:	Skin = Texture'ToiletTex1'; break;
			case SC_Filthy:	Skin = Texture'ToiletTex2'; break;
		}
	}
	else
	{
		Skin = None;
		switch(SkinColor)
		{
			case SC_Clean:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanHDTPToiletTex1", class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanHDTPToiletTex2", class'Texture', True));
					break;
			case SC_Filthy:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyHDTPToiletTex1", class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyHDTPToiletTex2", class'Texture', True));
					break;
		}

		if(bNeedsFlushing)
			MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyToiletWaterTex", class'Texture', True));
		else
			MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanToiletWaterTex", class'Texture', True));

	}
}

function BeginPlay()
{
	Super.BeginPlay();

	bNeedsFlushing = False;

	switch (SkinColor)
	{
		case SC_Clean:	if(Skin == None)
				{
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanHDTPToiletTex1", class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanHDTPToiletTex2", class'Texture', True));
				}
				if(frand() > 0.5)
				{
					bNeedsFlushing = True;
					if(Skin == None)
						MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyToiletWaterTex", class'Texture', True));
					ItemName = unflushedString $ " " $ ItemName;
				}
				else if(Skin == None)
					MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanToiletWaterTex", class'Texture', True));

				if(MultiSkins[1] == None || MultiSkins[2] == None || MultiSkins[3] == None)
					Skin = Texture'ToiletTex1';

				break;

		case SC_Filthy:	if(Skin == None)
				{
					MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyHDTPToiletTex1", class'Texture', True));
					MultiSkins[2] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyHDTPToiletTex2", class'Texture', True));
					MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.DirtyToiletWaterTex", class'Texture', True));
				}
				bNeedsFlushing = True;
				ItemName = unflushedString $ " " $ ItemName;

				if(MultiSkins[1] == None || MultiSkins[2] == None || MultiSkins[3] == None)
					Skin = Texture'ToiletTex2';

				break;
	}
}

function Timer()
{
	//== Change the appearance of the water and re-call the timer
	if(bNeedsFlushing)
	{
		ItemName = Default.ItemName;

		if(Skin == None)
			MultiSkins[3] = Texture(DynamicLoadObject("HDTPDecos.Skins.CleanToiletWaterTex", class'Texture'));

		bNeedsFlushing = False;
		SetTimer(6, False);	
	}
	else
		bUsing = False;
}

function Frob(actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	if(bNeedsFlushing)
	{
		if(Skin != None)
			ItemName = Default.ItemName;

		if(DeusExPlayer(Frobber) != None)
		{
			//== I am such a dork
			DeusExPlayer(Frobber).ClientMessage(awardString);
			DeusExPlayer(Frobber).SkillPointsAdd(2);
		}

		SetTimer(3, False);
	}
	else
		SetTimer(9.0, False);

	bUsing = True;

	PlaySound(sound'FlushToilet',,,, 256);
	PlayAnim('Flush');
}

defaultproperties
{
     unflushedString="Unflushed"
     awardString="Public Hygene Awareness Bonus"
     bInvincible=True
     ItemName="Toilet"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Toilet'
     CollisionRadius=28.000000
     CollisionHeight=28.000000
     Mass=100.000000
     Buoyancy=5.000000
}
