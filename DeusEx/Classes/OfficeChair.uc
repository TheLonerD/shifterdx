//=============================================================================
// OfficeChair.
//=============================================================================
class OfficeChair extends Seat;

enum ESkinColor
{
	SC_GrayLeather,
	SC_BrownLeather,
	SC_BrownCloth,
	SC_GrayCloth
};

var() ESkinColor SkinColor;

function bool Facelift(bool bOn)
{
	local String texstr;

	if(!Super.Facelift(bOn))
		return false;

	switch (SkinColor)
	{
		case SC_GrayLeather:		texstr = "OfficeChairTex1"; break;
		case SC_BrownLeather:		texstr = "OfficeChairTex2"; break;
		case SC_BrownCloth:		texstr = "OfficeChairTex3"; break;
		case SC_GrayCloth:		texstr = "OfficeChairTex4"; break;
	}

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPOfficeChair", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Texture(DynamicLoadObject("DeusExDeco."$ texstr, class'Texture'));
	}
	else
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture'));

	return true;
}

function BeginPlay()
{
	local String texstr;

	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_GrayLeather:		texstr = "OfficeChairTex1"; break;
		case SC_BrownLeather:		texstr = "OfficeChairTex2"; break;
		case SC_BrownCloth:		texstr = "OfficeChairTex3"; break;
		case SC_GrayCloth:		texstr = "OfficeChairTex4"; break;
	}

	if(Mesh != Default.Mesh)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture'));
	else
		Skin = Texture(DynamicLoadObject("DeusExDeco."$ texstr, class'Texture'));
}

defaultproperties
{
     sitPoint(0)=(X=0.000000,Y=-4.000000,Z=0.000000)
     ItemName="Swivel Chair"
     Mesh=LodMesh'DeusExDeco.OfficeChair'
     CollisionRadius=16.000000
     CollisionHeight=25.549999
     Mass=30.000000
     Buoyancy=5.000000
}
