//=============================================================================
// MenuChoice_Class
//=============================================================================

//[95] was [24] -- Y|yukichigai

class MenuChoice_Class extends MenuUIChoiceEnum
	config;

var globalconfig string  ClassClasses[95]; //Actual classes of classes (sigh)
var localized String     ClassNames[95]; //Human readable class names.


//Portrait variables
var ButtonWindow btnPortrait;
var globalconfig String texPortraits[95]; //Futureproofing for possible optional texture package
var int PortraitIndex;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	PopulateClassChoices();
   CreatePortraitButton();

	Super.InitWindow();

   SetInitialClass();

   SetActionButtonWidth(153);

   btnAction.SetHelpText(HelpText);
   btnInfo.SetPos(0,195);
}

// ----------------------------------------------------------------------
// PopulateClassChoices()
// ----------------------------------------------------------------------

function PopulateClassChoices()
{
	local int typeIndex;

   for (typeIndex = 0; typeIndex < arrayCount(ClassNames); typeIndex++)
   {
      enumText[typeIndex]=ClassNames[typeIndex];
   }
}

// ----------------------------------------------------------------------
// SetInitialClass()
// ----------------------------------------------------------------------

function SetInitialClass()
{
   local string TypeString;
   local int typeIndex;

   
   TypeString = player.GetDefaultURL("Class");
  
   for (typeIndex = 0; typeIndex < arrayCount(ClassNames); typeIndex++)
   {
      if (TypeString==GetModuleName(typeIndex))
         SetValue(typeIndex);
   }
}

// ----------------------------------------------------------------------
// SetValue()
// ----------------------------------------------------------------------

function SetValue(int newValue)
{
   Super.SetValue(newValue);
   UpdatePortrait();
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
   player.UpdateURL("Class", GetModuleName(currentValue), true);
   player.SaveConfig();
}

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
   local string TypeString;
   local int typeIndex;
   
   TypeString = player.GetDefaultURL("Class");

   for (typeIndex = 0; typeIndex < arrayCount(ClassNames); typeIndex++)
   {
      if (TypeString==GetModuleName(typeIndex))
         SetValue(typeIndex);
   }
   UpdatePortrait();
}

// ----------------------------------------------------------------------
// ResetToDefault
// ----------------------------------------------------------------------

function ResetToDefault()
{   
   player.UpdateURL("Class", GetModuleName(defaultValue), true);
   player.SaveConfig();
   LoadSetting();
}

// ----------------------------------------------------------------------
// GetModuleName()
// For command line parsing
// ----------------------------------------------------------------------

function string GetModuleName(int ClassIndex)
{
   return (ClassClasses[ClassIndex]);
}

// ----------------------------------------------------------------------
// CreatePortraitButton()
// ----------------------------------------------------------------------

function CreatePortraitButton()
{
	btnPortrait = ButtonWindow(NewChild(Class'ButtonWindow'));

	btnPortrait.SetSize(116, 163);
	btnPortrait.SetPos(19, 27);

	btnPortrait.SetBackgroundStyle(DSTY_Masked);
}

// ----------------------------------------------------------------------
// UpdatePortrait()
//  Modified.  In the future I may have an optional texture package to go
//   with Shifter which will contain icons for all the new models I've
//   added.  If so, this will load them if present
// ----------------------------------------------------------------------

function UpdatePortrait()
{
   local Texture portTex;

   portTex = Texture(DynamicLoadObject(texPortraits[CurrentValue], class'Texture', True));

   if(portTex == None)
	portTex = Texture'DeusExUI.UserInterface.menuplayersetupautoteam';

   btnPortrait.SetBackground(portTex);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     ClassClasses(0)="DeusEx.JCDentonMale"
     ClassClasses(1)="DeusEx.MPNSF"
     ClassClasses(2)="DeusEx.MPUnatco"
     ClassClasses(3)="DeusEx.MPMJ12"
     ClassClasses(4)="DeusEx.MPTOBATA"
     ClassClasses(5)="DeusEx.MPBARTENDER"
     ClassClasses(6)="DeusEx.MPBOATPER"
     ClassClasses(7)="DeusEx.MPBUSM1"
     ClassClasses(8)="DeusEx.MPBUSM2"
     ClassClasses(9)="DeusEx.MPBUSM3"
     ClassClasses(10)="DeusEx.MPBUSW1"
     ClassClasses(11)="DeusEx.MPBUTLER"
     ClassClasses(12)="DeusEx.MPSAMCAR"
     ClassClasses(13)="DeusEx.MPCHEF"
     ClassClasses(14)="DeusEx.MPMAXCHE"
     ClassClasses(15)="DeusEx.MPCHILD"
     ClassClasses(16)="DeusEx.MPCHILD2"
     ClassClasses(17)="DeusEx.MPHKMIL"
     ClassClasses(18)="DeusEx.MPMAGCHO"
     ClassClasses(19)="DeusEx.MPPAUL"
     ClassClasses(20)="DeusEx.MPDOC"
     ClassClasses(21)="DeusEx.MPSTADOW"
     ClassClasses(22)="DeusEx.MPNICOLE"
     ClassClasses(23)="DeusEx.MPCHAD"
     ClassClasses(24)="DeusEx.MPMOREVE"
     ClassClasses(25)="DeusEx.MPFEM1"
     ClassClasses(26)="DeusEx.MPFEM2"
     ClassClasses(27)="DeusEx.MPFEM3"
     ClassClasses(28)="DeusEx.MPFEM4"
     ClassClasses(29)="DeusEx.MPBUMFEM"
     ClassClasses(30)="DeusEx.MPJUNKFEM"
     ClassClasses(31)="DeusEx.MPSCIFEM"
     ClassClasses(32)="DeusEx.MPHARLEY"
     ClassClasses(33)="DeusEx.MPJOJO"
     ClassClasses(34)="DeusEx.MPJOEGRE"
     ClassClasses(35)="DeusEx.MPMICHAM"
     ClassClasses(36)="DeusEx.MPGUNTHER"
     ClassClasses(37)="DeusEx.MPHOOKER1"
     ClassClasses(38)="DeusEx.MPHOOKER2"
     ClassClasses(39)="DeusEx.MPALEX"
     ClassClasses(40)="DeusEx.MPJANITOR"
     ClassClasses(41)="DeusEx.MPJOCK"
     ClassClasses(42)="DeusEx.MPJUAN"
     ClassClasses(43)="DeusEx.MPTLP"
     ClassClasses(44)="DeusEx.MPTLP2"
     ClassClasses(45)="DeusEx.MPNATMAD"
     ClassClasses(46)="DeusEx.MPMAID"
     ClassClasses(47)="DeusEx.MPMALE1"
     ClassClasses(48)="DeusEx.MPMALE2"
     ClassClasses(49)="DeusEx.MPMALE3"
     ClassClasses(50)="DeusEx.MPMALE4"
     ClassClasses(51)="DeusEx.MPBUMMALE"
     ClassClasses(52)="DeusEx.MPBUMMALE2"
     ClassClasses(53)="DeusEx.MPBUMMALE3"
     ClassClasses(54)="DeusEx.MPJUNKMAL"
     ClassClasses(55)="DeusEx.MPSCIMAL"
     ClassClasses(56)="DeusEx.MPTHUGM"
     ClassClasses(57)="DeusEx.MPTHUGM2"
     ClassClasses(58)="DeusEx.MPTHUGM3"
     ClassClasses(59)="DeusEx.MPMIB"
     ClassClasses(60)="DeusEx.MPJOSMAN"
     ClassClasses(61)="DeusEx.MPMJ12COM"
     ClassClasses(62)="DeusEx.MPPMEAD"
     ClassClasses(63)="DeusEx.MPRMEAD"
     ClassClasses(64)="DeusEx.MPSMEAD"
     ClassClasses(65)="DeusEx.MPMECH"
     ClassClasses(66)="DeusEx.MPANNA"
     ClassClasses(67)="DeusEx.MPNURSE"
     ClassClasses(68)="DeusEx.MPBOB"
     ClassClasses(69)="DeusEx.MPCOP"
     ClassClasses(70)="DeusEx.MPLCMALE"
     ClassClasses(71)="DeusEx.MPLCMALE2"
     ClassClasses(72)="DeusEx.MPLCFEM"
     ClassClasses(73)="DeusEx.MPGORQUI"
     ClassClasses(74)="DeusEx.MPTRA"
     ClassClasses(75)="DeusEx.MPGILREN"
     ClassClasses(76)="DeusEx.MPSANREN"
     ClassClasses(77)="DeusEx.MPJAIME"
     ClassClasses(78)="DeusEx.MPRIOTCOP"
     ClassClasses(79)="DeusEx.MPGARY"
     ClassClasses(80)="DeusEx.MPTIFSAV"
     ClassClasses(81)="DeusEx.MPSAILOR"
     ClassClasses(82)="DeusEx.MPFORD"
     ClassClasses(83)="DeusEx.MPSCUBA"
     ClassClasses(84)="DeusEx.MPSECSER"
     ClassClasses(85)="DeusEx.MPSECRETARY"
     ClassClasses(86)="DeusEx.MPJORSHE"
     ClassClasses(87)="DeusEx.MPWALTON"
     ClassClasses(88)="DeusEx.MPSMUG"
     ClassClasses(89)="DeusEx.MPSOLDIER"
     ClassClasses(90)="DeusEx.MPHOWSTR"
     ClassClasses(91)="DeusEx.MPTRATONG"
     ClassClasses(92)="DeusEx.MPMARWIL"
     ClassClasses(93)="DeusEx.MPWIB"
     ClassNames(0)="JC Denton"
     ClassNames(1)="NSF Terrorist"
     ClassNames(2)="UNATCO Trooper"
     ClassNames(3)="Majestic-12 Agent"
     ClassNames(4)="Toby Atanwe"
     ClassNames(5)="Bartender"
     ClassNames(6)="Boat Person"
     ClassNames(7)="Businessman (1)"
     ClassNames(8)="Businessman (2)"
     ClassNames(9)="Businessman (3)"
     ClassNames(10)="Businesswoman"
     ClassNames(11)="Butler"
     ClassNames(12)="Sam Carter"
     ClassNames(13)="Chef"
     ClassNames(14)="Max Chen"
     ClassNames(15)="Child (1)"
     ClassNames(16)="Child (2)"
     ClassNames(17)="Chinese Military"
     ClassNames(18)="Maggie Chow"
     ClassNames(19)="Paul Denton"
     ClassNames(20)="Doctor"
     ClassNames(21)="Stanton Dowd"
     ClassNames(22)="Nicolette DuClare"
     ClassNames(23)="Chad Dumier"
     ClassNames(24)="Morgan Everett"
     ClassNames(25)="Female (1)"
     ClassNames(26)="Female (2)"
     ClassNames(27)="Female (3)"
     ClassNames(28)="Female (4)"
     ClassNames(29)="Female Bum"
     ClassNames(30)="Female Junkie"
     ClassNames(31)="Female Scientist"
     ClassNames(32)="Harley Filben"
     ClassNames(33)="Jojo Fine"
     ClassNames(34)="Joe Greene"
     ClassNames(35)="Michael Hamner"
     ClassNames(36)="Gunther Hermann"
     ClassNames(37)="Hooker (1)"
     ClassNames(38)="Hooker (2)"
     ClassNames(39)="Alex Jacobson"
     ClassNames(40)="Janitor"
     ClassNames(41)="Jock"
     ClassNames(42)="Juan Lebedev"
     ClassNames(43)="Luminous Path (1)"
     ClassNames(44)="Luminous Path (2)"
     ClassNames(45)="Nathan Madison"
     ClassNames(46)="Maid"
     ClassNames(47)="Male (1)"
     ClassNames(48)="Male (2)"
     ClassNames(49)="Male (3)"
     ClassNames(50)="Male (4)"
     ClassNames(51)="Male Bum (1)"
     ClassNames(52)="Male Bum (2)"
     ClassNames(53)="Male Bum (3)"
     ClassNames(54)="Male Junkie"
     ClassNames(55)="Male Scientist"
     ClassNames(56)="Male Thug (1)"
     ClassNames(57)="Male Thug (2)"
     ClassNames(58)="Male Thug (3)"
     ClassNames(59)="Man In Black"
     ClassNames(60)="Joseph Manderley"
     ClassNames(61)="Majestic-12 Commando"
     ClassNames(62)="Philip Mead"
     ClassNames(63)="Rachel Mead"
     ClassNames(64)="Sarah Mead"
     ClassNames(65)="Mechanic"
     ClassNames(66)="Anna Navarre"
     ClassNames(67)="Nurse"
     ClassNames(68)="Bob Page"
     ClassNames(69)="Police Officer"
     ClassNames(70)="Poor Man (1)"
     ClassNames(71)="Poor Man (2)"
     ClassNames(72)="Poor Woman"
     ClassNames(73)="Gordon Quick"
     ClassNames(74)="Red Arrow"
     ClassNames(75)="Gilbert Renton"
     ClassNames(76)="Sandra Renton"
     ClassNames(77)="Jaime Reyes"
     ClassNames(78)="Riot Cop"
     ClassNames(79)="Gary Savage"
     ClassNames(80)="Tiffany Savage"
     ClassNames(81)="Sailor"
     ClassNames(82)="Ford Schick"
     ClassNames(83)="Scuba Diver"
     ClassNames(84)="Secret Service"
     ClassNames(85)="Secretary"
     ClassNames(86)="Jordan Shea"
     ClassNames(87)="Walton Simons"
     ClassNames(88)="Smuggler"
     ClassNames(89)="Soldier"
     ClassNames(90)="Howard Strong"
     ClassNames(91)="Tracer Tong"
     ClassNames(92)="Margaret Williams"
     ClassNames(93)="Woman In Black"
     texPortraits(0)="DeusExUI.UserInterface.menuplayersetupjcdenton"
     texPortraits(1)="DeusExUI.UserInterface.menuplayersetupnsf"
     texPortraits(2)="DeusExUI.UserInterface.menuplayersetupunatco"
     texPortraits(3)="DeusExUI.UserInterface.menuplayersetupmj12"
     texPortraits(4)="ShifterEX.Pictures.mptobyatanwe"
     texPortraits(5)="ShifterEX.Pictures.mpbartender"
     texPortraits(6)="ShifterEX.Pictures.mpboatperson"
     texPortraits(7)="ShifterEX.Pictures.mpbusinessman1"
     texPortraits(8)="ShifterEX.Pictures.mpbusinessman2"
     texPortraits(9)="ShifterEX.Pictures.mpbusinessman3"
     texPortraits(10)="ShifterEX.Pictures.mpbusinesswoman"
     texPortraits(11)="ShifterEX.Pictures.mpbutler"
     texPortraits(12)="ShifterEX.Pictures.mpsamcarter"
     texPortraits(13)="ShifterEX.Pictures.mpchef"
     texPortraits(14)="ShifterEX.Pictures.mpmaxchen"
     texPortraits(15)="ShifterEX.Pictures.mpchild1"
     texPortraits(16)="ShifterEX.Pictures.mpchild2"
     texPortraits(17)="ShifterEX.Pictures.mpchinesemilitary"
     texPortraits(18)="ShifterEX.Pictures.mpmaggiechow"
     texPortraits(19)="ShifterEX.Pictures.mppauldenton"
     texPortraits(20)="ShifterEX.Pictures.mpdoctor"
     texPortraits(21)="ShifterEX.Pictures.mpstantondowd"
     texPortraits(22)="ShifterEX.Pictures.mpnicolette"
     texPortraits(23)="ShifterEX.Pictures.mpchad"
     texPortraits(24)="ShifterEX.Pictures.mpmorganeverett"
     texPortraits(25)="ShifterEX.Pictures.mpfemale1"
     texPortraits(26)="ShifterEX.Pictures.mpfemale2"
     texPortraits(27)="ShifterEX.Pictures.mpfemale3"
     texPortraits(28)="ShifterEX.Pictures.mpfemale4"
     texPortraits(29)="ShifterEX.Pictures.mpfemalebum"
     texPortraits(30)="ShifterEX.Pictures.mpfemalejunkie"
     texPortraits(31)="ShifterEX.Pictures.mpfemalescientist"
     texPortraits(32)="ShifterEX.Pictures.mpharleyfilben"
     texPortraits(33)="ShifterEX.Pictures.mpjojofine"
     texPortraits(34)="ShifterEX.Pictures.mpjoegreene"
     texPortraits(35)="ShifterEX.Pictures.mpmichaelhamner"
     texPortraits(36)="ShifterEX.Pictures.mpgunther"
     texPortraits(37)="ShifterEX.Pictures.mphooker1"
     texPortraits(38)="ShifterEX.Pictures.mphooker2"
     texPortraits(39)="ShifterEX.Pictures.mpalex"
     texPortraits(40)="ShifterEX.Pictures.mpjanitor"
     texPortraits(41)="ShifterEX.Pictures.mpjock"
     texPortraits(42)="ShifterEX.Pictures.mpjuanlebedev"
     texPortraits(43)="ShifterEX.Pictures.mpluminous1"
     texPortraits(44)="ShifterEX.Pictures.mpluminous2"
     texPortraits(45)="ShifterEX.Pictures.mpnathanmadison"
     texPortraits(46)="ShifterEX.Pictures.mpmaid"
     texPortraits(47)="ShifterEX.Pictures.mpmale1"
     texPortraits(48)="ShifterEX.Pictures.mpmale2"
     texPortraits(49)="ShifterEX.Pictures.mpmale3"
     texPortraits(50)="ShifterEX.Pictures.mpmale4"
     texPortraits(51)="ShifterEX.Pictures.mpmalebum1"
     texPortraits(52)="ShifterEX.Pictures.mpmalebum2"
     texPortraits(53)="ShifterEX.Pictures.mpmalebum3"
     texPortraits(54)="ShifterEX.Pictures.mpmalejunkie"
     texPortraits(55)="ShifterEX.Pictures.mpmalescientist"
     texPortraits(56)="ShifterEX.Pictures.mpthugmale1"
     texPortraits(57)="ShifterEX.Pictures.mpthugmale2"
     texPortraits(58)="ShifterEX.Pictures.mpthugmale3"
     texPortraits(59)="ShifterEX.Pictures.mpmib"
     texPortraits(60)="ShifterEX.Pictures.mpmanderley"
     texPortraits(61)="ShifterEX.Pictures.mpmj12commando"
     texPortraits(62)="ShifterEX.Pictures.mpphilipmead"
     texPortraits(63)="ShifterEX.Pictures.mprachelmead"
     texPortraits(64)="ShifterEX.Pictures.mpsarahmead"
     texPortraits(65)="ShifterEX.Pictures.mpmechanic"
     texPortraits(66)="ShifterEX.Pictures.mpanna"
     texPortraits(67)="ShifterEX.Pictures.mpnurse"
     texPortraits(68)="ShifterEX.Pictures.mpbobpage"
     texPortraits(69)="ShifterEX.Pictures.mppoliceofficer"
     texPortraits(70)="ShifterEX.Pictures.mppoorman1"
     texPortraits(71)="ShifterEX.Pictures.mppoorman2"
     texPortraits(72)="ShifterEX.Pictures.mppoorwoman"
     texPortraits(73)="ShifterEX.Pictures.mpgordonquick"
     texPortraits(74)="ShifterEX.Pictures.mpredarrow"
     texPortraits(75)="ShifterEX.Pictures.mpgilbertrenton"
     texPortraits(76)="ShifterEX.Pictures.mpsandrarenton"
     texPortraits(77)="ShifterEX.Pictures.mpjaime"
     texPortraits(78)="ShifterEX.Pictures.mpriotcop"
     texPortraits(79)="ShifterEX.Pictures.mpgarysavage"
     texPortraits(80)="ShifterEX.Pictures.mptiffanysavage"
     texPortraits(81)="ShifterEX.Pictures.mpsailor"
     texPortraits(82)="ShifterEX.Pictures.mpfordschick"
     texPortraits(83)="ShifterEX.Pictures.mpscubadiver"
     texPortraits(84)="ShifterEX.Pictures.mpsecretservice"
     texPortraits(85)="ShifterEX.Pictures.mpsecretary"
     texPortraits(86)="ShifterEX.Pictures.mpjordanshea"
     texPortraits(87)="ShifterEX.Pictures.mpwalton"
     texPortraits(88)="ShifterEX.Pictures.mpsmuggler"
     texPortraits(89)="ShifterEX.Pictures.mpsoldier"
     texPortraits(90)="ShifterEX.Pictures.mphowardstrong"
     texPortraits(91)="ShifterEX.Pictures.mptracertong"
     texPortraits(92)="ShifterEX.Pictures.mpmargaretwilliams"
     texPortraits(93)="ShifterEX.Pictures.mpwib"
     defaultInfoWidth=153
     defaultInfoPosX=170
     HelpText="Model for your character in non-team games."
     actionText="Non-Team Model"
}
