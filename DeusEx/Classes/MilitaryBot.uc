//=============================================================================
// MilitaryBot.
//=============================================================================
class MilitaryBot extends Robot;

enum ESkinColor
{
	SC_UNATCO,
	SC_Chinese
};

var() ESkinColor SkinColor;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMilBot", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		MultiSkins[1] = Default.MultiSkins[1];
		switch (SkinColor)
		{
			case SC_UNATCO:		Skin = Texture'MilitaryBotTex1'; break;
			case SC_Chinese:	Skin = Texture'MilitaryBotTex2'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_UNATCO:		Skin = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex1", class'Texture', True)); Multiskins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex2", class'Texture', True)); break;
			case SC_Chinese:	Skin = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex1HK", class'Texture', True)); Multiskins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex2HK", class'Texture', True)); break;
		}
	}

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

	if(Mesh == Default.Mesh)
	{
		switch (SkinColor)
		{
			case SC_UNATCO:		Skin = Texture'MilitaryBotTex1'; break;
			case SC_Chinese:	Skin = Texture'MilitaryBotTex2'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_UNATCO:		Skin = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex1", class'Texture', True)); Multiskins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex2", class'Texture', True)); break;
			case SC_Chinese:	Skin = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex1HK", class'Texture', True)); Multiskins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPMilBotTex2HK", class'Texture', True)); break;
		}
	}
}

function PlayDisabled()
{
	local int rnd;

	rnd = Rand(3);
	if (rnd == 0)
		TweenAnimPivot('Disabled1', 0.2);
	else if (rnd == 1)
		TweenAnimPivot('Disabled2', 0.2);
	else
		TweenAnimPivot('Still', 0.2);
}

defaultproperties
{
     EMPHitPoints=200
     explosionSound=Sound'DeusExSounds.Robot.MilitaryBotExplode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponRobotMachinegun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=24)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponRobotRocket')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoRocket',Count=10)
     WalkSound=Sound'DeusExSounds.Robot.MilitaryBotWalk'
     SearchingSound=Sound'DeusExSounds.Robot.MilitaryBotSearching'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.MilitaryBotTargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.MilitaryBotTargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.MilitaryBotOutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.MilitaryBotCriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.MilitaryBotScanning'
     GroundSpeed=44.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=600
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.MilitaryBot'
     CollisionRadius=80.000000
     CollisionHeight=79.000000
     Mass=2000.000000
     Buoyancy=100.000000
     RotationRate=(Yaw=10000)
     BindName="MilitaryBot"
     FamiliarName="Military Bot"
     UnfamiliarName="Military Bot"
}
