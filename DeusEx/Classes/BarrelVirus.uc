//=============================================================================
// BarrelVirus.
//=============================================================================
class BarrelVirus extends Containers;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPItems.HDTPBarrelAmbrosia", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;
		MultiSkins[1] = Default.MultiSkins[1];
		MultiSkins[2] = Default.MultiSkins[2];
	}
	else
	{
		MultiSkins[1] = None;
		MultiSkins[2] = FireTexture'Effects.liquid.Virus_SFX';
	}

	return true;
}

defaultproperties
{
     HitPoints=30
     bInvincible=True
     bFlammable=False
     ItemName="NanoVirus Storage Container"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.BarrelAmbrosia'
     MultiSkins(1)=FireTexture'Effects.liquid.Virus_SFX'
     CollisionRadius=16.000000
     CollisionHeight=28.770000
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=96
     LightRadius=4
     Mass=80.000000
     Buoyancy=90.000000
}
