//=============================================================================
// UNATCOTroopCarcass.
//=============================================================================
class UNATCOTroopCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
    local int i;
    if(!Super.Facelift(bOn))
        return false;

    if(bOn)
    {
        Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPUNATCOTroopCarcass", class'Mesh', True));
        Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPUNATCOTroopCarcassB", class'Mesh', True));
        Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPUNATCOTroopCarcassC", class'Mesh', True));
    }

    if(Mesh == None || Mesh2 == None || Mesh3 == None || !bOn)
    {
        Mesh = Default.Mesh;
        Mesh2 = Default.Mesh2;
        Mesh3 = Default.Mesh3;

        for(i = 0; i < 8; ++i)
            MultiSkins[i] = Default.MultiSkins[i];
    }
    else
    {
        for(i = 0; i < 8; ++i)
            MultiSkins[i] = None;
    }

    return true;
} 

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_Jumpsuit_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_Jumpsuit_CarcassC'
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.UNATCOTroopTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.UNATCOTroopTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.UNATCOTroopTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=40.000000
}
