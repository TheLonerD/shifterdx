//=============================================================================
// Phone.
//=============================================================================
class Phone extends ElectronicDevices;

enum ERingSound
{
	RS_Office1,
	RS_Office2
};

enum EAnswerSound
{
	AS_Dialtone,
	AS_Busy,
	AS_OutOfService,
	AS_Locked,
	AS_ShutDown,
	AS_Unrecognized,
	AS_Random
};

var() ERingSound RingSound;
var() EAnswerSound AnswerSound;
var() float ringFreq;
var float ringTimer;
var bool bUsing;
var String validNumber; //For the phone dialing functionality
var name DialEvent; //What we trigger if we dial the right number
var bool bEventOnlyOnce;

var HUDKeypadWindow dialwindow;

function Facelift(bool bOn)
{
	if(bOn)
		Mesh = mesh(DynamicLoadObject("HDTPDecos.HDTPphone", class'mesh', True));

	if(Mesh == None || !bOn)
		Mesh = Default.Mesh;
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	//== If the phone isn't "active" and there's no timer set to disable the ambient sound, disable it now
	if(dialwindow == None && AmbientSound != None && TimerRate <= 0.0)
		AmbientSound = None;

	//== If the phone is in use or a non-ringing phone don't make any noise
	if(bUsing || ringFreq <= 0.0)
		return;

	ringTimer += deltaTime;

	if (ringTimer >= 1.0)
	{
		ringTimer -= 1.0;

		if (FRand() < ringFreq)
		{
			switch (RingSound)
			{
				case RS_Office1:	PlaySound(sound'PhoneRing1', SLOT_Misc,,, 256); break;
				case RS_Office2:	PlaySound(sound'PhoneRing2', SLOT_Misc,,, 256); break;
			}
		}
	}
}

function Timer()
{
	AmbientSound = None;
	bUsing = False;
}

function Frob(actor Frobber, Inventory frobWith)
{
	local float rnd;
	local DeusExRootWindow root;

	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	bUsing = True;

	//== Look, a working phone
	if(AnswerSound == AS_Dialtone && validNumber != "" && DeusExPlayer(Frobber) != None)
	{
		root = DeusExRootWindow(DeusExPlayer(Frobber).rootWindow);
		if(root != None)
		{
			dialwindow = HUDKeypadWindow(root.InvokeUIScreen(Class'HUDKeypadWindow', True));
			root.MaskBackground(True);

			if(dialwindow != None)
			{
				AmbientSound = Sound'PhoneDialtone';
				dialwindow.phoneOwner = Self;
				dialwindow.player = DeusExPlayer(Frobber);
				dialwindow.InitData();
			}
		}
		return;
	}

	SetTimer(3.0, False);

	rnd = 1.0;

	if(AnswerSound == AS_Random)
		rnd = FRand();

	if (rnd < 0.1 || AnswerSound == AS_Busy)
		PlaySound(sound'PhoneBusy', SLOT_Misc,,, 256);
	else if (rnd < 0.2 || AnswerSound == AS_Dialtone)
		PlaySound(sound'PhoneDialtone', SLOT_Misc,,, 256);
	else if (rnd < 0.4 || AnswerSound == AS_Unrecognized)	//"You are not a recognized user for this device"
		PlaySound(sound'PhoneVoice1', SLOT_Misc,,, 256);
	else if (rnd < 0.6 || AnswerSound == AS_Locked)		//"This account has been locked, pending investigation"
		PlaySound(sound'PhoneVoice2', SLOT_Misc,,, 256);
	else if (rnd < 0.8 || AnswerSound == AS_OutOfService)	//"Awaiting authorization"
		PlaySound(sound'PhoneVoice3', SLOT_Misc,,, 256);
	else	//AS_ShutDown					//"This line has been shut down by order of UNATCO"
		PlaySound(sound'PhoneVoice4', SLOT_Misc,,, 256);
}

defaultproperties
{
     ringFreq=0.010000
     ItemName="Telephone"
     Mesh=LodMesh'DeusExDeco.Phone'
     CollisionRadius=11.870000
     CollisionHeight=3.780000
     Mass=20.000000
     Buoyancy=15.000000
     AnswerSound=AS_Random
}
