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
var globalconfig Texture texPortraits[95];
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
// ----------------------------------------------------------------------

function UpdatePortrait()
{
   btnPortrait.SetBackground(texPortraits[CurrentValue]);
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
     texPortraits(0)=Texture'DeusExUI.UserInterface.menuplayersetupjcdenton'
     texPortraits(1)=Texture'DeusExUI.UserInterface.menuplayersetupnsf'
     texPortraits(2)=Texture'DeusExUI.UserInterface.menuplayersetupunatco'
     texPortraits(3)=Texture'DeusExUI.UserInterface.menuplayersetupmj12'
     texPortraits(4)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(5)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(6)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(7)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(8)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(9)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(10)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(11)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(12)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(13)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(14)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(15)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(16)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(17)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(18)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(19)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(20)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(21)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(22)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(23)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(24)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(25)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(26)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(27)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(28)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(29)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(30)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(31)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(32)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(33)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(34)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(35)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(36)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(37)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(38)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(39)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(40)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(41)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(42)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(43)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(44)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(45)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(46)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(47)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(48)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(49)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(50)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(51)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(52)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(53)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(54)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(55)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(56)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(57)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(58)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(59)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(60)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(61)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(62)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(63)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(64)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(65)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(66)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(67)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(68)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(69)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(70)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(71)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(72)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(73)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(74)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(75)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(76)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(77)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(78)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(79)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(80)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(81)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(82)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(83)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(84)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(85)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(86)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(87)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(88)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(89)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(90)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(91)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(92)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     texPortraits(93)=Texture'DeusExUI.UserInterface.menuplayersetupautoteam'
     defaultInfoWidth=153
     defaultInfoPosX=170
     HelpText="Model for your character in non-team games."
     actionText="Non-Team Model"
}
