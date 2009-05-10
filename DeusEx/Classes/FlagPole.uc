//=============================================================================
// FlagPole.
//=============================================================================
class FlagPole extends DeusExDecoration;

enum ESkinColor
{
	SC_China,
	SC_France,
	SC_President,
	SC_UNATCO,
	SC_USA
};

var() travel ESkinColor SkinColor;

// ----------------------------------------------------------------------
// BeginPlay()
// ----------------------------------------------------------------------

function BeginPlay()
{
	Super.BeginPlay();

	SetSkin();
}

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

function TravelPostAccept()
{
	Super.TravelPostAccept();

	SetSkin();
}

// ----------------------------------------------------------------------
// SetSkin()
// ----------------------------------------------------------------------

function SetSkin()
{
	switch (SkinColor)
	{
		case SC_China:		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFlagpole", class'mesh', True));
					if(Mesh == None)
					{
						Mesh = Default.Mesh;
						Skin = Texture'FlagPoleTex1';
					}
					else
						MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlagpoleTex1", class'Texture'));
					break;
		case SC_France:		Skin = Texture'FlagPoleTex2'; break;
		case SC_President:	Skin = Texture'FlagPoleTex3'; break;
		case SC_UNATCO:		Skin = Texture'FlagPoleTex4'; break;
		case SC_USA:		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFlagpole", class'mesh', True));
					if(Mesh == None)
					{
						Mesh = Default.Mesh;
						Skin = Texture'FlagPoleTex5';
					}
					else
						MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlagpoleTex5", class'Texture'));
					break;
	}
}

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPFlagpole", class'mesh', True));
	}

	if(Mesh == None || !bOn)
	{
		MultiSkins[1] = None;
		Mesh = Default.Mesh;
		switch (SkinColor)
		{
			case SC_China:		Skin = Texture'FlagPoleTex1'; break;
			case SC_France:		Skin = Texture'FlagPoleTex2'; break;
			case SC_President:	Skin = Texture'FlagPoleTex3'; break;
			case SC_UNATCO:		Skin = Texture'FlagPoleTex4'; break;
			case SC_USA:		Skin = Texture'FlagPoleTex5'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_China:		MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlagpoleTex1", class'Texture'));
						break;
			case SC_France:		Skin = Texture'FlagPoleTex2'; break;
			case SC_President:	Skin = Texture'FlagPoleTex3'; break;
			case SC_UNATCO:		Skin = Texture'FlagPoleTex4'; break;
			case SC_USA:		MultiSkins[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPFlagpoleTex5", class'Texture'));
						break;
		}

		//== Until the HDTP package is complete we gotta revert to the old mesh for some flags
		if(MultiSkins[1] == None)
			Mesh = Default.Mesh;
	}

	return true;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Flag Pole"
     Mesh=LodMesh'DeusExDeco.FlagPole'
     CollisionRadius=17.000000
     CollisionHeight=56.389999
     Mass=40.000000
     Buoyancy=30.000000
}
