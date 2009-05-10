//=============================================================================
// Button1.
//=============================================================================
class Button1 extends DeusExDecoration;

enum EButtonType
{
	BT_Up,
	BT_Down,
	BT_1,
	BT_2,
	BT_3,
	BT_4,
	BT_5,
	BT_6,
	BT_7,
	BT_8,
	BT_9,
	BT_Blank
};

var() EButtonType ButtonType;
var() float buttonLitTime;
var() sound buttonSound1;
var() sound buttonSound2;
var() bool bLit;
var() bool bWaitForEvent;
var bool isPressed;

var Vector	lastLoc, rpcLocation;
var bool		bIsMoving;

replication 
{
	reliable if ( Role == ROLE_Authority )
		rpcLocation;
}

// WOW! What a mess.  I wish you could convert strings to names!
//== Well you can.  Silly Deus Ex devs -- Y|yukichigai
function SetSkin(EButtonType type, bool lit)
{
	local String texstr;

	switch (type)
	{
		case BT_Up:			if(lit)		texstr = "Button1Tex2";
						else		texstr = "Button1Tex1";
							break;
		case BT_Down:			if(lit)		texstr = "Button1Tex4";
						else		texstr = "Button1Tex3";
							break;
		case BT_1:			if(lit)		texstr = "Button1Tex6";
						else		texstr = "Button1Tex5";
							break;
		case BT_2:			if(lit)		texstr = "Button1Tex8";
						else		texstr = "Button1Tex7";
							break;
		case BT_3:			if(lit)		texstr = "Button1Tex10";
						else		texstr = "Button1Tex9";
							break;
		case BT_4:			if(lit)		texstr = "Button1Tex12";
						else		texstr = "Button1Tex11";
							break;
		case BT_5:			if(lit)		texstr = "Button1Tex14";
						else		texstr = "Button1Tex13";
							break;
		case BT_6:			if(lit)		texstr = "Button1Tex16";
						else		texstr = "Button1Tex15";
							break;
		case BT_7:			if(lit)		texstr = "Button1Tex18";
						else		texstr = "Button1Tex17";
							break;
		case BT_8:			if(lit)		texstr = "Button1Tex20";
						else		texstr = "Button1Tex19";
							break;
		case BT_9:			if(lit)		texstr = "Button1Tex22";
						else		texstr = "Button1Tex21";
							break;
		case BT_Blank:			if(lit)		texstr = "Button1Tex24";
						else		texstr = "Button1Tex23";
							break;
	}

	if(lit)
		ScaleGlow = 3.0;
	else
		ScaleGlow = Default.ScaleGlow;


	Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture', True));

	if(Skin == None)
		Skin = Texture(DynamicLoadObject("DeusExDeco.Skins." $ texstr, class'Texture', True));
}

function bool Facelift(bool bOn)
{
	local String texstr;

	if(!Super.Facelift(bOn))
		return false;

	switch (ButtonType)
	{
		case BT_Up:			if(bLit)	texstr = "Button1Tex2";
						else		texstr = "Button1Tex1";
							break;
		case BT_Down:			if(bLit)	texstr = "Button1Tex4";
						else		texstr = "Button1Tex3";
							break;
		case BT_1:			if(bLit)	texstr = "Button1Tex6";
						else		texstr = "Button1Tex5";
							break;
		case BT_2:			if(bLit)	texstr = "Button1Tex8";
						else		texstr = "Button1Tex7";
							break;
		case BT_3:			if(bLit)	texstr = "Button1Tex10";
						else		texstr = "Button1Tex9";
							break;
		case BT_4:			if(bLit)	texstr = "Button1Tex12";
						else		texstr = "Button1Tex11";
							break;
		case BT_5:			if(bLit)	texstr = "Button1Tex14";
						else		texstr = "Button1Tex13";
							break;
		case BT_6:			if(bLit)	texstr = "Button1Tex16";
						else		texstr = "Button1Tex15";
							break;
		case BT_7:			if(bLit)	texstr = "Button1Tex18";
						else		texstr = "Button1Tex17";
							break;
		case BT_8:			if(bLit)	texstr = "Button1Tex20";
						else		texstr = "Button1Tex19";
							break;
		case BT_9:			if(bLit)	texstr = "Button1Tex22";
						else		texstr = "Button1Tex21";
							break;
		case BT_Blank:			if(bLit)	texstr = "Button1Tex24";
						else		texstr = "Button1Tex23";
							break;
	}

	if(bLit)
		ScaleGlow = 3.0;
	else
		ScaleGlow = Default.ScaleGlow;

	if(bOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTP" $ texstr, class'Texture', True));
	else
		Skin = Texture(DynamicLoadObject("DeusExDeco." $ texstr, class'Texture', True));

	return true;
}

function BeginPlay()
{
	Super.BeginPlay();

	SetSkin(ButtonType, bLit);

	if ( Level.NetMode != NM_Standalone )
		rpcLocation = Location;
}

function Trigger(Actor Other, Pawn Instigator)
{
	if (bWaitForEvent)
		Timer();
}

function Timer()
{
	PlaySound(buttonSound2, SLOT_None);
	SetSkin(ButtonType, bLit);
	isPressed = False;
	bUnlit = False;
}

//== If we shoot the button, make it activate
function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
	//log("Event Instigator = " $ EventInstigator $ " and DamageType = " $ DamageType);

	if(DeusExPlayer(EventInstigator) != None && (DamageType == 'Shot' || DamageType == 'Shell'))
		Frob(EventInstigator, None);

	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType);
}

function Frob(Actor Frobber, Inventory frobWith)
{
	if (!isPressed)
	{
		isPressed = True;
		PlaySound(buttonSound1, SLOT_None);
		SetSkin(ButtonType, !bLit);
		bUnlit = True;
		if (!bWaitForEvent)
			SetTimer(buttonLitTime, False);

		Super.Frob(Frobber, frobWith);
	}
}

singular function SupportActor(Actor standingActor)
{
	// do nothing
}

function Bump(actor Other)
{
	// do nothing
}

simulated function Tick( float deltaTime )
{						  	
	if ( Level.NetMode != NM_Standalone )
	{
		if ( Role == ROLE_Authority )
		{
			// Was moving, now at rest
			if ( bIsMoving && ( Location == lastLoc ))
				rpcLocation = Location;

			bIsMoving = ( Location != lastLoc );
			lastLoc = Location;
		}
		else
		{
			// Our replicated location changed which means the button has come to rest
			if ( lastLoc != rpcLocation )
			{
				SetLocation( rpcLocation );
				lastLoc = rpcLocation;
			}
		}
	}
	Super.Tick( deltaTime );
}

defaultproperties
{
     ButtonType=BT_Blank
     buttonLitTime=0.500000
     buttonSound1=Sound'DeusExSounds.Generic.Beep1'
     bInvincible=True
     ItemName="Button"
     bPushable=False
     Physics=PHYS_None
     RemoteRole=ROLE_SimulatedProxy
     Mesh=LodMesh'DeusExDeco.Button1'
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=False
     bBlockActors=False
     Mass=5.000000
     Buoyancy=2.000000
}
