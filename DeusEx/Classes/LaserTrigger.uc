//=============================================================================
// LaserTrigger.
//=============================================================================
class LaserTrigger extends Trigger;

var LaserEmitter emitter;
var() bool bIsOn;
var() bool bNoAlarm;			// if True, does NOT sound alarm
var actor LastHitActor;
var bool bConfused;				// used when hit by EMP
var float confusionTimer;		// how long until trigger resumes normal operation
var float confusionDuration;	// how long does EMP hit last?
var int HitPoints;
var int minDamageThreshold;
var float lastAlarmTime;		// last time the alarm was sounded
var int alarmTimeout;			// how long before the alarm silences itself
var actor triggerActor;			// actor which last triggered the alarm
var vector actorLocation;		// last known location of actor that triggered alarm

var Float lastTickTime;

var() Texture HDTPTex[2];

function bool Facelift(bool bOn)
{
	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPLaserEmitter", class'Mesh', True));
		HDTPTex[0] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPLaserEmitterTex0", class'Texture', True));
		HDTPTex[1] = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPLaserEmitterTex1", class'Texture', True));
	}

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		Skin = Default.Skin;
		HDTPTex[0] = None;
		HDTPTex[1] = None;
	}
	else
	{
		if(bIsOn)
			Skin = HDTPTex[1];
		else
			Skin = HDTPTex[0];
	}

	return true;
}

singular function Touch(Actor Other)
{
	// does nothing when touched
}

function BeginAlarm()
{
	AmbientSound = Sound'Klaxon2';
	SoundVolume = 128;
	SoundRadius = 64;
	lastAlarmTime = Level.TimeSeconds;
	AIStartEvent('Alarm', EAITYPE_Audio, SoundVolume/255.0, 25*(SoundRadius+1));

	// make sure we can't go into stasis while we're alarming
	bStasis = False;
}

function EndAlarm()
{
	AmbientSound = None;
	lastAlarmTime = -alarmTimeout;
	AIEndEvent('Alarm', EAITYPE_Audio);

	// reset our stasis info
	bStasis = Default.bStasis;
}

function Tick(float deltaTime)
{
	local Actor A;
	local AdaptiveArmor armor;
	local bool bTrigger;

	if (emitter != None)
	{
		if(DeusExGameInfo(Level.Game) != None)
			if(lastTickTime <= DeusExGameInfo(Level.Game).PauseStartTime) //== Pause time offset
				lastAlarmTime += (DeusExGameInfo(Level.Game).PauseEndTime - DeusExGameInfo(Level.Game).PauseStartTime);

		lastTickTime = Level.TimeSeconds;

		// shut off the alarm if the timeout has expired
		if (Level.TimeSeconds - lastAlarmTime >= alarmTimeout)
			EndAlarm();

		// if we've been EMP'ed, act confused
		if (bConfused && bIsOn)
		{
			confusionTimer += deltaTime;

			// randomly turn on/off the beam
			if (FRand() > 0.95)
				emitter.TurnOn();
			else
				emitter.TurnOff();

			if (confusionTimer > confusionDuration)
			{
				bConfused = False;
				confusionTimer = 0;
				confusionDuration = Default.confusionDuration;
				emitter.TurnOn();
			}

			return;
		}

		emitter.SetLocation(Location);
		emitter.SetRotation(Rotation);

		if (!bNoAlarm)
		{
			if ((emitter.HitActor != None) && (LastHitActor != emitter.HitActor))
			{
				// TT_PlayerProximity actually works with decorations, too
				if (IsRelevant(emitter.HitActor) ||
					((TriggerType == TT_PlayerProximity) && emitter.HitActor.IsA('Decoration')))
				{
					bTrigger = True;

					if (emitter.HitActor.IsA('DeusExPlayer'))
					{
						// check for adaptive armor - makes the player invisible
						foreach AllActors(class'AdaptiveArmor', armor)
							if ((armor.Owner == emitter.HitActor) && armor.bActive)
							{
								bTrigger = False;
								break;
							}
					}

					if (bTrigger)
					{
						// now, the trigger sounds its own alarm
						if (AmbientSound == None)
						{
							triggerActor = emitter.HitActor;
							actorLocation = emitter.HitActor.Location - vect(0,0,1)*(emitter.HitActor.CollisionHeight-1);
							BeginAlarm();
						}

						// play "beam broken" sound
						PlaySound(sound'Beep2',,,, 1280, 3.0);
					}
				}
			}
		}

		LastHitActor = emitter.HitActor;
	}
}

// if we are triggered, turn us on
function Trigger(Actor Other, Pawn Instigator)
{
	if (bConfused)
		return;

	if (emitter != None)
	{
		if (!bIsOn)
		{
			emitter.TurnOn();
			bIsOn = True;
			LastHitActor = None;
			MultiSkins[1] = Texture'LaserSpot1';
			if(HDTPTex[1] != None)
				Skin = HDTPTex[1];
			else
				Skin = Default.Skin;
		}
	}

	Super.Trigger(Other, Instigator);
}

// if we are untriggered, turn us off
function UnTrigger(Actor Other, Pawn Instigator)
{
	if (bConfused)
		return;

	if (emitter != None)
	{
		if (bIsOn)
		{
			emitter.TurnOff();
			bIsOn = False;
			LastHitActor = None;
			MultiSkins[1] = Texture'BlackMaskTex';
			if(HDTPTex[0] != None)
				Skin = HDTPTex[0];
			else
				Skin = Default.Skin;
			EndAlarm();
		}
	}

	Super.UnTrigger(Other, Instigator);
}

function BeginPlay()
{
	Super.BeginPlay();

	LastHitActor = None;
	emitter = Spawn(class'LaserEmitter');

	if (emitter != None)
	{
		emitter.TurnOn();
		bIsOn = True;

		// turn off the sound if we should
		if (SoundVolume == 0)
			emitter.AmbientSound = None;
	}
	else
		bIsOn = False;
}

function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
	local MetalFragment frag;

	if (DamageType == 'EMP')
	{
		confusionDuration -= confusionTimer;
		confusionTimer = 0;
		confusionDuration += Damage/10.000000; //=== New stuff.  Disabled duration is relative to the damage
		if (!bConfused)
		{
			bConfused = True;
			PlaySound(sound'EMPZap', SLOT_None,,, 1280);
		}
	}
	else if ((DamageType == 'Exploded') || (DamageType == 'Shot') || (DamageType == 'Shell'))
	{
		if (Damage >= minDamageThreshold)
			HitPoints -= Damage;

		if (HitPoints <= 0)
		{
			frag = Spawn(class'MetalFragment', Owner);
			if (frag != None)
			{
				frag.Instigator = EventInstigator;
				frag.CalcVelocity(Momentum,0);
				frag.DrawScale = 0.5*FRand();
				frag.Skin = GetMeshTexture();
			}

			Destroy();
		}
	}
}

function Destroyed()
{
	if (emitter != None)
	{
		emitter.Destroy();
		emitter = None;
	}

	Super.Destroyed();
}

//     confusionDuration=10.000000

defaultproperties
{
     bIsOn=True
     confusionDuration=7.000000
     HitPoints=50
     minDamageThreshold=50
     alarmTimeout=30
     TriggerType=TT_AnyProximity
     bHidden=False
     bDirectional=True
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExDeco.LaserEmitter'
     CollisionRadius=2.500000
     CollisionHeight=2.500000
}
