//=============================================================================
// Flare.
//=============================================================================
class Flare extends DeusExPickup;

var ParticleGenerator gen; //, flaregen;

//== HDTP texture variables
//== Not used because I can't dynamically load the right textures.  Yet.  Maybe someday
//var effects flamething;
//var Texture HDTPspark;
//var Mesh HDTPfiremesh;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		PlayerViewMesh = mesh(DynamicLoadObject("HDTPItems.HDTPFlare", class'mesh', True));

	if(PlayerViewMesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		PlayerViewMesh = Default.PlayerViewMesh;
		PickupViewMesh = Default.PickupViewMesh;
		ThirdPersonMesh = Default.ThirdPersonMesh;
		//HDTPfire = None;
		//HDTPfiremesh = None;
		//HDTPspark = None;

		//if (flaregen != None)
		//	flaregen.DelayedDestroy();
		//if(flamething != none)
		//	flamething.Destroy();
	}
	else
	{
		Mesh = PlayerViewMesh;
		PickupViewMesh = Mesh;
		ThirdPersonMesh = Mesh;

		//HDTPfire = Texture(DynamicLoadObject("HDTPAnim.Effects.HDTPflrflame", class'Texture')); // Already loaded by the mesh probably
		//HDTPfiremesh = Mesh(DynamicLoadObject("HDTPItems.HDTPflareflame", class'Mesh'));
		//HDTPspark = Texture(DynamicLoadObject("HDTPAnim.Effects.HDTPFlarespark", class'Texture'));
		//if(HDTPspark == None)
		//	HDTPspark = Default.HDTPspark;
	}

	return true;
}

function ExtinguishFlare()
{
	LightType = LT_None;
	AmbientSound = None;
	if (gen != None)
		gen.DelayedDestroy();
	//if (flaregen != None)
	//	flaregen.DelayedDestroy();
	//if(flamething != none)
	//	flamething.Destroy();
}

auto state Pickup
{
	function ZoneChange(ZoneInfo NewZone)
	{
		if (NewZone.bWaterZone)
		{
			//ExtinguishFlare();
			//== Don't destroy the flare, just make it stop smoking
			if(gen != None)
				gen.DelayedDestroy();
		}

		Super.ZoneChange(NewZone);
	}

	function Frob(Actor Frobber, Inventory frobWith)
	{
		// we can't pick it up again if we've already activated it
		if (gen == None && AmbientSound == None)
			Super.Frob(Frobber, frobWith);
		else if (Frobber.IsA('Pawn'))
		{
/*			if(Frobber.IsA('DeusExPlayer'))
			{
				SetBase(Frobber);
				DeusExPlayer(Frobber).PutInHand(Self);
			}
			else */
				Pawn(Frobber).ClientMessage(ExpireMessage);
		}
	}
}

state Activated
{
	function ZoneChange(ZoneInfo NewZone)
	{
		if (NewZone.bWaterZone)
		{
			//ExtinguishFlare();
			//== Don't destroy the flare, just make it stop smoking
			if(gen != None)
				gen.DelayedDestroy();
		}

		Super.ZoneChange(NewZone);
	}

	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local Flare flare;

		Super.BeginState();

		// Create a Flare and throw it
		flare = Spawn(class'Flare', Owner);
		flare.LightFlare();

		UseOnce();
	}
Begin:
}

function LightFlare()
{
	//== Code trickery for speical effects lifted straight from HDTP.  I'm glad SOMEONE figured out rotators
	local Vector X, Y, Z, dropVect, loc, loc2, offset;
	local Pawn P;
	local rotator rota;

	if (gen == None)
	{	
		LifeSpan = 360; //30;
		bUnlit = True;
		LightType = LT_Steady;
		AmbientSound = Sound'Flare';

		P = Pawn(Owner);
		if (P != None)
		{
			GetAxes(P.ViewRotation, X, Y, Z);
			dropVect = P.Location + 0.8 * P.CollisionRadius * X;
			dropVect.Z += P.BaseEyeHeight;
			Velocity = Vector(P.ViewRotation) * 500 + vect(0,0,220);
			bFixedRotationDir = True;
			RotationRate = RotRand(False);
			DropFrom(dropVect);

			// increase our collision height so we light up the ground better
			SetCollisionSize(CollisionRadius, CollisionHeight*2);
		}

		loc2.Y += collisionradius*1.05;
		loc = loc2 >> rotation;
		loc += location;
		gen = Spawn(class'ParticleGenerator', Self,, Loc, rot(16384,0,0));
		if (gen != None)
		{
			gen.attachTag = Name;
			gen.SetBase(Self);
			gen.LifeSpan = Self.LifeSpan;
			gen.bRandomEject = True;
			gen.ejectSpeed = 20;
			gen.riseRate = 20;
			gen.checkTime = 0.3;
			gen.particleLifeSpan = 10;
			gen.particleDrawScale = 0.25; //0.5;
			gen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
		}

		/*if(HDTPspark != None || (HDTPfiremesh != None))// && HDTPfire != None))
		{
			loc2.Y = collisionradius*0.8;    //I hate coordinate shifting
			loc = loc2 >> rotation;
			loc += location;
			rota = rotation;
			rota.Roll = 0;
			rota.Yaw += 16384;

			if(HDTPspark != None)
				flaregen = Spawn(class'ParticleGenerator',Self,, Loc, rota);

			if (flaregen != None)
			{
				flaregen.LifeSpan = Self.LifeSpan;
				flaregen.attachTag = Name;
				flaregen.SetBase(Self);
				flaregen.bRandomEject=true;
				//flaregen.RandomEjectAmt=0.1; //== Not in Shifter since it doesn't do anything yet
				flaregen.bParticlesUnlit=true;
				flaregen.frequency=0.5 + 0.5*frand();
				flaregen.numPerSpawn=2;
				flaregen.bGravity=false;
				flaregen.ejectSpeed = 60; //100;
				flaregen.riseRate = -1;
				flaregen.checkTime = 0.02;
				flaregen.particleLifeSpan = 0.4*(1 + frand());//0.6*(1 + frand());
				flaregen.particleDrawScale = 0.05 + 0.05*frand();
				flaregen.particleTexture = HDTPspark;
			}

			if(HDTPfiremesh != None)// && HDTPfire != None)
				flamething = Spawn(class'Effects', Self,, Location, rotation);

			if(flamething != none)
			{
				flamething.setbase(self);
				flamething.DrawType=DT_mesh;
				flamething.mesh=HDTPfiremesh;
				//flamething.multiskins[1]=HDTPfire;
				flamething.Style=STY_Translucent;
				flamething.bUnlit=true;
				flamething.DrawScale=0.4;
				flamething.Scaleglow=5;
				flamething.lifespan=0;
				flamething.bHidden=false;
			}
		}*/

		if(Region.Zone.bWaterZone)
			gen.DelayedDestroy();
	}
}

function Tick(float deltaTime)
{
	local AirBubble airbub;

	Super.Tick(deltaTime);

	if(Region.Zone.bWaterZone && AmbientSound != None)
	{
		if((LifeSpan % 1.000000) + deltaTime > 1.000000)
		{
			airbub = Spawn(class'AirBubble', Self,, Location, rot(16384,0,0));
			if(airbub != None)
				airbub.EmitOnSurface = class'SmokeTrail';
		}
	}

}

//HDTPspark=Texture'Effects.Fire.SparkFX1'

defaultproperties
{
     maxCopies=50
     bCanHaveMultipleCopies=True
     ExpireMessage="It's already been used"
     bActivatable=True
     ItemName="Flare"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Flare'
     PickupViewMesh=LodMesh'DeusExItems.Flare'
     ThirdPersonMesh=LodMesh'DeusExItems.Flare'
     Icon=Texture'DeusExUI.Icons.BeltIconFlare'
     largeIcon=Texture'DeusExUI.Icons.LargeIconFlare'
     largeIconWidth=42
     largeIconHeight=43
     Description="A flare."
     beltDescription="FLARE"
     Mesh=LodMesh'DeusExItems.Flare'
     SoundRadius=16
     SoundVolume=96
     CollisionRadius=6.200000
     CollisionHeight=1.200000
     LightEffect=LE_TorchWaver
     LightBrightness=255
     LightHue=16
     LightSaturation=96
     LightRadius=8
     Mass=2.000000
     Buoyancy=1.300000
}
