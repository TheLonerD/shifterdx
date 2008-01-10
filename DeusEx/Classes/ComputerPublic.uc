//=============================================================================
// ComputerPublic.
//=============================================================================
class ComputerPublic extends Computers;

var() name bulletinTag;
var() string bulletinTitles[4];
var() string bulletinText[4];

defaultproperties
{
     terminalType=Class'DeusEx.NetworkTerminalPublic'
     ItemName="Public Computer Terminal"
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.ComputerPublic'
     ScaleGlow=2.000000
     CollisionHeight=49.139999
     BindName="ComputerPublic"
}
