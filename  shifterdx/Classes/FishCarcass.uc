//=============================================================================
// FishCarcass.
//=============================================================================
class FishCarcass extends DeusExCarcass;

//auto state Dead
//{
//	function Timer()
//	{
//		Super.Timer();
//	}
//
//	function HandleLanding()
//	{
//		//Do nothing
//	}
//
//Begin:
//	//== Make our fishy float upside-down
//	if(Region.Zone.bWaterZone)
//	{
//		DesiredRotation = Rotation;
//		DesiredRotation.Roll = 32768;
//	}
//}

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.Fish'
     Mesh3=LodMesh'DeusExCharacters.Fish'
     bAnimalCarcass=True
     Mesh=LodMesh'DeusExCharacters.Fish'
     CollisionRadius=7.760000
     CollisionHeight=3.890000
}
