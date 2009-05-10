//=============================================================================
// SignFloor.
//=============================================================================
class SignFloor extends DeusExDecoration;

var bool bSmartass;

simulated function PreBeginPlay()
{
	if(fRand() > 0.82)
		bSmartass = True;

	Super.PreBeginPlay();
}


function bool Facelift(bool bOn)
{
	local Texture lSkin;

	if(!Super.Facelift(bOn))
		return false;

	Skin = None;

	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPSignfloor", class'mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		if(bSmartass && bOn)
			lSkin = Texture(DynamicLoadObject("ShifterEX.Decos.SignFloorS", class'Texture', True));
	}
	else if(bSmartass)
		lSkin = Texture(DynamicLoadObject("ShifterEX.Decos.HDTPSignFloorS", class'Texture', True));

	if(lSkin != None)
		Skin = lSkin;

	return true;
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Caution Sign"
     Mesh=LodMesh'DeusExDeco.SignFloor'
     CollisionRadius=12.500000
     CollisionHeight=15.380000
     Mass=10.000000
     Buoyancy=12.000000
}
