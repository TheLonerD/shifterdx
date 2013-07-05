//=============================================================================
// TAD.
//=============================================================================
class TAD extends ElectronicDevices;

var() float beepInterval;
var() sound beepSound;
var HighLight light;
var bool bOn;

var Texture TADtex[2];

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPTAD", class'Mesh', True));
		TADtex[0] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTADTex1", class'Texture', True));
		TADtex[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPTADTex2", class'Texture', True));
	}

	if(Mesh == None || TADTex[0] == None || TADTex[1] == None || !bOn)
	{
		Mesh = Default.Mesh;
		TADtex[0] = Default.TADtex[0];
		TADtex[1] = Default.TADtex[1];
	}

	return true;
}

function Timer()
{
	local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());
	if (player != None)
	{
		if (light == None)
		{
			light = Spawn(class'HighLight', Self,, Location+vect(0,0,32));
			light.LightType = LT_None;
			light.LightBrightness = 128;
			light.LightHue = 0;
			light.LightSaturation = 16;
		}

		if (player.GetActiveConversation(Self, IM_Frob) != None)
		{
			// beep periodically
			if (!IsInState('Conversation'))
			{
				bOn = !bOn;
				if (bOn)
				{
					PlaySound(beepSound, SLOT_Misc,,, 512);
					if (light != None)
						light.LightType = LT_Steady;
					Skin = TADTex[1];
				}
				else
				{
					if (light != None)
						light.LightType = LT_None;
					Skin = TADTex[0];
				}
			}
			else
			{
				if (light != None)
					light.LightType = LT_None;
				Skin = TADTex[0];
			}
		}
		else
		{
			// turn off the light
			if (light != None)
				light.Destroy();
			Skin = TADTex[0];
			SetTimer(0.1, False);
		}
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetTimer(beepInterval*0.5, True);
}

defaultproperties
{
     TADtex(0)=Texture'TADTex1'
     TADtex(1)=Texture'TADTex2'
     beepInterval=2.000000
     beepSound=Sound'DeusExSounds.Generic.Beep5'
     ItemName="Telephone Answering Machine"
     Mesh=LodMesh'DeusExDeco.TAD'
     CollisionRadius=7.400000
     CollisionHeight=2.130000
     Mass=10.000000
     Buoyancy=5.000000
}
