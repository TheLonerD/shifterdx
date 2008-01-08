//=============================================================================
// VialVirus
//=============================================================================
class VialVirus expands VialAmbrosia;

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
			player.ClientMessage(msgNoEffect);

		UseOnce();
	}
Begin:
}

defaultproperties
{
     ItemName="Gray Death Vial"
     ItemArticle="a"
     Description="A small vial of the 'Gray Death' virus, so named because of the severe pale complexion of those afflicted with the disease."
     beltDescription="GRAY DEATH"
     MultiSkins(1)=FireTexture'Effects.liquid.Virus_SFX'
}
