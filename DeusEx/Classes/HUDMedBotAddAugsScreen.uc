//=============================================================================
// HUDMedBotAddAugsScreen
//=============================================================================

class HUDMedBotAddAugsScreen extends PersonaScreenAugmentations;

var MedicalBot medBot;

var PersonaActionButtonWindow btnInstall;
var TileWindow winAugsTile;
var Bool bSkipAnimation;
var Bool bInstallPending;
var HUDMedBotAugItemButton buttontemp;

var Localized String AvailableAugsText;
var Localized String MedbotInterfaceText;
var Localized String InstallButtonLabel;
var Localized String UpgradeButtonLabel;
var Localized String NoCansAvailableText;
var Localized String AlreadyHasItText;
var Localized String SlotFullText;
var Localized String SelectAnotherText;
var Localized String MayUpgradeText;
var Localized String CannotUpgradeText;
var Localized String SelectReplaceText;
var Localized String InstalledText;
var Localized String UpgradedText;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	HUDMedBotNavBarWindow(winNavBar).btnAugs.SetSensitivity(False);

	PopulateAugCanList();

	EnableButtons();
}

// ----------------------------------------------------------------------
// DestroyWindow()
//
// Let the medbot go about its business.
// ----------------------------------------------------------------------

event DestroyWindow()
{
	if (medBot != None)
	{
		if (!bSkipAnimation)
		{
			medBot.PlayAnim('Stop');
			medBot.PlaySound(sound'MedicalBotLowerArm', SLOT_None);
			medBot.FollowOrders();
		}
	}

	Super.DestroyWindow();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	CreateNavBarWindow();
	CreateClientBorderWindow();
	CreateClientWindow();

	CreateTitleWindow(9, 5, AugmentationsTitleText);
	CreateInfoWindow();
	CreateButtons();
	CreateAugmentationLabels();
	CreateAugmentationHighlights();
	CreateAugmentationButtons();
	CreateOverlaysWindow();
	CreateBodyWindow();
	CreateAugsLabel();
	CreateAugCanList();
	CreateMedbotLabel();
}

// ----------------------------------------------------------------------
// CreateNavBarWindow()
// ----------------------------------------------------------------------

function CreateNavBarWindow()
{
	winNavBar = PersonaNavBarBaseWindow(NewChild(Class'HUDMedBotNavBarWindow')); 
	winNavBar.SetPos(0, 0);
}

// ----------------------------------------------------------------------
// CreateButtons()
// ----------------------------------------------------------------------

function CreateButtons()
{
	local PersonaButtonBarWindow winActionButtons;

	winActionButtons = PersonaButtonBarWindow(winClient.NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(346, 371);
	winActionButtons.SetWidth(96);

	btnInstall = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnInstall.SetButtonText(InstallButtonLabel);
}

// ----------------------------------------------------------------------
// CreateInfoWindow()
// ----------------------------------------------------------------------

function CreateInfoWindow()
{
	winInfo = PersonaInfoWindow(winClient.NewChild(Class'PersonaInfoWindow'));
	winInfo.SetPos(348, 158);
	winInfo.SetSize(238, 210);
}

// ----------------------------------------------------------------------
// CreateAugsLabel()
// ----------------------------------------------------------------------

function CreateAugsLabel()
{
	CreatePersonaHeaderText(349, 15, AvailableAugsText, winClient);
}

// ----------------------------------------------------------------------
// CreateMedbotLabel()
// ----------------------------------------------------------------------

function CreateMedbotLabel()
{
	local PersonaHeaderTextWindow txtLabel;

	txtLabel = PersonaHeaderTextWindow(NewChild(Class'PersonaHeaderTextWindow'));
	txtLabel.SetPos(305, 9);
	txtLabel.SetSize(250, 16);
	txtLabel.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	txtLabel.SetText(MedbotInterfaceText);
}

// ----------------------------------------------------------------------
// CreateAugCanList()
// ----------------------------------------------------------------------

function CreateAugCanList()
{
	local PersonaScrollAreaWindow winScroll;

	// First create the scroll window
	winScroll = PersonaScrollAreaWindow(winClient.NewChild(Class'PersonaScrollAreaWindow'));
	winScroll.SetPos(348, 34);
	winScroll.SetSize(238, 116);

	winAugsTile = TileWindow(winScroll.ClipWindow.NewChild(Class'TileWindow'));
	winAugsTile.MakeWidthsEqual(False);
	winAugsTile.MakeHeightsEqual(False);
	winAugsTile.SetMinorSpacing(1);
	winAugsTile.SetMargins(0, 0);
	winAugsTile.SetOrder(ORDER_Down);
}

// ----------------------------------------------------------------------
// PopulateAugCanList()
// ----------------------------------------------------------------------

function PopulateAugCanList()
{
	local Inventory item;
	local int canCount;
	local HUDMedBotAugCanWindow augCanWindow;
	local PersonaNormalTextWindow txtNoCans;

	winAugsTile.DestroyAllChildren();

	// Loop through all the Augmentation Cannisters in the player's 
	// inventory, adding one row for each can.
	item = player.Inventory;

	while(item != None)
	{
		if (item.IsA('AugmentationCannister'))
		{
			augCanWindow = HUDMedBotAugCanWindow(winAugsTile.NewChild(Class'HUDMedBotAugCanWindow'));
			augCanWindow.SetCannister(AugmentationCannister(item));

			canCount++;
		}
		item = item.Inventory;
	}

	// If we didn't add any cans, then display "No Aug Cannisters Available!"
	if (canCount == 0)
	{
		txtNoCans = PersonaNormalTextWindow(winAugsTile.NewChild(Class'PersonaNormalTextWindow'));
		txtNoCans.SetText(NoCansAvailableText);
		txtNoCans.SetTextMargins(4, 4);
		txtNoCans.SetTextAlignments(HALIGN_Left, VALIGN_Center);
	}
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated(Window buttonPressed)
{
	local bool bHandled;
	local int level;
	local int hkey;
	local Augmentation anAug;

	bHandled   = True;

	if(bInstallPending)
	{
		anAug = Augmentation(buttonPressed.GetClientObject());
		if(anAug != None && anAug.bHasIt)
		{
			if(anAug.AugmentationLocation == selectedAug.AugmentationLocation)
			{
				level = anAug.CurrentLevel;
				anAug.CurrentLevel = 0;
				anAug.bHasIt = false;
				hkey = anAug.HotKeyNum;
				player.RemoveAugmentationDisplay(anAug);
				player.AugmentationSystem.AugLocs[anAug.AugmentationLocation].augCount--;
				anAug.HotKeyNum = -1;
				bInstallPending = false;
				winInfo.Clear();
				winInfo.SetTitle(selectedAug.AugmentationName);
				winInfo.SetText(selectedAug.AugmentationName$" installed at Level "$ level + 1 $".");
				selectedAug.HotKeyNum = hkey;
				InstallAugmentation(level);
				selectedAug.HotKeyNum = hkey;
				Super.CreateAugmentationButtons();
				selectedAug = None;
				selectedAugButton = None;
				EnableButtons();
				return true;
			}
		}
		else
			bInstallPending = false;
	}

	switch(buttonPressed)
	{
		case btnInstall:
			bInstallPending = false;
			if(player.AugmentationSystem.AreSlotsFull(selectedAug))
				bInstallPending = true;

			InstallAugmentation();
			break;

		default:
			bInstallPending = false;
			bHandled = False;
			break;
	}

	if (bHandled)
		return true;
	else 
		return Super.ButtonActivated(buttonPressed);

	return bHandled;
}

// ----------------------------------------------------------------------
// SelectAugmentation()
// ----------------------------------------------------------------------

//Y|yukichigai -- Modified so you can now upgrade augmentations you already have using
// Augmentation Cannisters for the existing augs

function SelectAugmentation(PersonaItemButton buttonPressed)
{
	// Don't do extra work.
	if (selectedAugButton != buttonPressed)
	{
		// Deselect current button
		if (selectedAugButton != None)
			selectedAugButton.SelectButton(False);

		selectedAugButton = buttonPressed;
		selectedAug       = Augmentation(selectedAugButton.GetClientObject());

		// Check to see if this augmentation has already been installed
		if (HUDMedBotAugItemButton(buttonPressed).bHasIt)
		{
			winInfo.Clear();
			winInfo.SetTitle(selectedAug.AugmentationName);
			winInfo.SetText(AlreadyHasItText);
			if(selectedAug.CurrentLevel < selectedAug.MaxLevel)
			{
				winInfo.SetText(MayUpgradeText);
				selectedAug.UsingMedBot(True);
				selectedAug.AppendInfo(winInfo);
			}
			else
			{
				winInfo.SetText(CannotUpgradeText);
				winInfo.SetText(SelectAnotherText); 
				selectedAug = None;
				selectedAugButton = None;
			}
		}
		else if (HUDMedBotAugItemButton(buttonPressed).bSlotFull) 
		{
			winInfo.Clear();
			winInfo.SetTitle(selectedAug.AugmentationName);
			winInfo.SetText(SlotFullText);
			selectedAug.UsingMedBot(True);
			selectedAug.AppendInfo(winInfo);
//			winInfo.SetText("In order to install this augmentation you must replace an existing one.");
//			winInfo.SetText(SelectAnotherText); 
//			selectedAug = None;
//			selectedAugButton = None;
		}
		else
		{
			selectedAug.UsingMedBot(True);
			if(!HUDMedBotAugItemButton(buttonPressed).bHasIt)
				selectedAug.UpdateInfo(winInfo);
		}

		if(selectedAugButton != None)
			selectedAugButton.SelectButton(True);

		EnableButtons();
		if(HUDMedBotAugItemButton(buttonPressed).bHasIt)
			btnInstall.SetButtonText(UpgradeButtonLabel);
		else
			btnInstall.SetButtonText(InstallButtonLabel);
	}
}

// ----------------------------------------------------------------------
// InstallAugmentation()
// ----------------------------------------------------------------------

function InstallAugmentation(optional int level)
{
	local AugmentationCannister augCan;
	local Augmentation aug;

	if (HUDMedBotAugItemButton(selectedAugButton) == None)
		return;

	if(bInstallPending)
	{
		winInfo.Clear();
		winInfo.SetTitle(selectedAug.AugmentationName);
		winInfo.SetText(Sprintf(SelectReplaceText,selectedAug.AugLocsText[selectedAug.AugmentationLocation]));
		return;
	}
		
	// Get pointers to the AugmentationCannister and the 
	// Augmentation Class

	augCan = HUDMedBotAugItemButton(selectedAugButton).GetAugCan();
	aug    = HUDMedBotAugItemButton(selectedAugButton).GetAugmentation();

	// Add this augmentation (if we can get this far, then the augmentation
	// to be added is a valid one, as the checks to see if we already have
	// the augmentation and that there's enough space were done when the 
	// AugmentationAddButtons were created)

	winInfo.Clear();
	winInfo.setTitle(selectedAug.AugmentationName);

	if(selectedAug.bHasIt)
		winInfo.setText(Sprintf(UpgradedText, (selectedAug.CurrentLevel + 2) ));
	else
		winInfo.setText(InstalledText);

	player.AugmentationSystem.GivePlayerAugmentation(aug.class);

	while(level >= 1)
	{
		player.AugmentationSystem.GivePlayerAugmentation(aug.class);
		level--;
	}

	// play a cool animation
	medBot.PlayAnim('Scan');

	// Now Destroy the Augmentation cannister
	player.DeleteInventory(augCan);

	// Now remove the cannister from our list
	selectedAugButton.GetParent().Destroy();
	selectedAugButton = None;
	selectedAug       = None;

	// Update the Installed Augmentation Icons
	DestroyAugmentationButtons();
	CreateAugmentationButtons();

	// Need to update the aug list
	PopulateAugCanList();

	//Added this in because of my upgrade stuff -- Y|yukichigai
	btnInstall.SetButtonText(InstallButtonLabel);
	EnableButtons();
}

// ----------------------------------------------------------------------
// DestroyAugmentationButtons()
// ----------------------------------------------------------------------

function DestroyAugmentationButtons()
{
	local int buttonIndex;

	for(buttonIndex=0; buttonIndex<arrayCount(augItems); buttonIndex++)
	{
		if (augItems[buttonIndex] != None)
			augItems[buttonIndex].Destroy();
	}
}

// ----------------------------------------------------------------------
// EnableButtons()
// ----------------------------------------------------------------------

function EnableButtons()
{
	// Only enable the Install button if the player has an
	// Augmentation Cannister aug button selected

	if (HUDMedBotAugItemButton(selectedAugButton) != None)
	{
		btnInstall.EnableWindow(True);
	}
	else
	{
		btnInstall.EnableWindow(False);
	}
}

// ----------------------------------------------------------------------
// SetMedicalBot()
// ----------------------------------------------------------------------

function SetMedicalBot(MedicalBot newBot, optional bool bPlayAnim)
{
	medBot = newBot;

	if (medBot != None)
	{
		medBot.StandStill();

		if (bPlayAnim)
		{
			medBot.PlayAnim('Start');
			medBot.PlaySound(sound'MedicalBotRaiseArm', SLOT_None);
		}
	}
}

// ----------------------------------------------------------------------
// SkipAnimation()
// ----------------------------------------------------------------------

function SkipAnimation(bool bNewSkipAnimation)
{
	bSkipAnimation = bNewSkipAnimation;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     AvailableAugsText="Available Augmentations"
     MedbotInterfaceText="MEDBOT INTERFACE"
     InstallButtonLabel="|&Install"
     UpgradeButtonLabel="|&Upgrade"
     NoCansAvailableText="No Augmentation Cannisters Available!"
     AlreadyHasItText="You already have this augmentation, therefore you cannot install it a second time."
     SlotFullText="The slot that this augmentation occupies is already full. To install you must replace an exisiting augmentation."
     SelectAnotherText="Please select another augmentation to install."
     MayUpgradeText="You may upgrade this augmentation instead."
     CannotUpgradeText="This augmentation is at its maximum level and cannot be upgraded."
     SelectReplaceText="Select the augmentation to replace.  The augmentation must be in the %s slot."
     InstalledText="Augmentation installed."
     UpgradedText="Augmentation upgraded to level %d."
     clientTextures(0)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_4'
     clientTextures(4)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_5'
     clientTextures(5)=Texture'DeusExUI.UserInterface.HUDMedbotBackground_6'
     clientBorderTextures(0)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_1'
     clientBorderTextures(1)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_2'
     clientBorderTextures(2)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_3'
     clientBorderTextures(3)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_4'
     clientBorderTextures(4)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_5'
     clientBorderTextures(5)=Texture'DeusExUI.UserInterface.HUDMedBotAugmentationsBorder_6'
}
