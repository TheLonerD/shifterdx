//=============================================================================
// SecurityBot2.
//=============================================================================
class SecurityBot2 extends Robot;

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
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPSecBot2", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		MultiSkins[1] = Default.MultiSkins[1];
		switch (SkinColor)
		{
			case SC_UNATCO:		MultiSkins[1] = Texture'SecurityBot2Tex1'; break;
			case SC_Chinese:	MultiSkins[1] = Texture'SecurityBot2Tex2'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_UNATCO:		MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPSecBot2tex1", class'Texture', True)); break;
			case SC_Chinese:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPSecBot2tex2", class'Texture', True)); break;
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
			case SC_UNATCO:		MultiSkins[1] = Texture'SecurityBot2Tex1'; break;
			case SC_Chinese:	MultiSkins[1] = Texture'SecurityBot2Tex2'; break;
		}
	}
	else
	{
		switch (SkinColor)
		{
			case SC_UNATCO:		MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPSecBot2tex1", class'Texture', True)); break;
			case SC_Chinese:	MultiSkins[1] = Texture(DynamicLoadObject("HDTPCharacters.Skins.HDTPSecBot2tex2", class'Texture', True)); break;
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
     EMPHitPoints=100
     explosionSound=Sound'DeusExSounds.Robot.SecurityBot2Explode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponRobotMachinegun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=50)
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     SearchingSound=Sound'DeusExSounds.Robot.SecurityBot2Searching'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.SecurityBot2TargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.SecurityBot2TargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.SecurityBot2OutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot2CriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.SecurityBot2Scanning'
     GroundSpeed=95.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=250
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SecurityBot2'
     CollisionRadius=62.000000
     CollisionHeight=58.279999
     Mass=800.000000
     Buoyancy=100.000000
     BindName="SecurityBot2"
     FamiliarName="Security Bot"
     UnfamiliarName="Security Bot"
}
