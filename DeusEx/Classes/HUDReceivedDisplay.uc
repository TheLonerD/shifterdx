//=============================================================================
// HUDReceivedDisplay
//=============================================================================
class HUDReceivedDisplay extends HUDSharedBorderWindow;

var TileWindow winTile;
var TextWindow txtReceived;
var Font  fontReceived;
var Float displayTimer;
var Float displayLength;
var int   topMargin;

var localized string TextReceivedLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	CreateTileWindow();
	CreateReceivedLabel();

	StyleChanged();

	bTickEnabled = False;
}

// ----------------------------------------------------------------------
// CreateTileWindow()
// ----------------------------------------------------------------------

function CreateTileWindow()
{
	winTile = TileWindow(NewChild(Class'TileWindow'));

	winTile.SetOrder(ORDER_RightThenDown);
	winTile.SetChildAlignments(HALIGN_Left, VALIGN_Center);
	winTile.SetPos(0, topMargin);
	winTile.SetMargins(10, 10);
	winTile.SetMinorSpacing(4);
	winTile.MakeWidthsEqual(False);
	winTile.MakeHeightsEqual(True);
}

// ----------------------------------------------------------------------
// CreateReceivedLabel()
// ----------------------------------------------------------------------

function CreateReceivedLabel()
{
	txtReceived = TextWindow(winTile.NewChild(Class'TextWindow'));
	txtReceived.SetFont(fontReceived);
	txtReceived.SetText(TextReceivedLabel);
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

event Tick(float deltaSeconds)
{
	displayTimer += deltaSeconds;

	if (displayTimer > displayLength)
		RemoveItems();
}

// ----------------------------------------------------------------------
// ParentRequestedPreferredSize()
// ----------------------------------------------------------------------

event ParentRequestedPreferredSize(bool bWidthSpecified, out float preferredWidth,
                                   bool bHeightSpecified, out float preferredHeight)
{
	local float tileWidth, tileHeight;

	if ((!bWidthSpecified) && (!bHeightSpecified))
	{
		winTile.QueryPreferredSize(preferredWidth, preferredHeight);

		preferredHeight += topMargin;
		if (preferredHeight < minHeight)
			preferredHeight = minHeight;
	}
	else if (bWidthSpecified)
	{
		preferredHeight = winTile.QueryPreferredHeight(preferredWidth);
		preferredHeight += topMargin;

		if (preferredHeight < minHeight)
			preferredHeight = minHeight;
	}
	else
	{
		preferredWidth = winTile.QueryPreferredWidth(preferredHeight);
	}
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	winTile.ConfigureChild(0, topMargin, width, height);
}

// ----------------------------------------------------------------------
// ChildRequestedReconfiguration()
// ----------------------------------------------------------------------

function bool ChildRequestedReconfiguration(window child)
{
	ConfigurationChanged();

	return True;
}

// ----------------------------------------------------------------------
// AddItem()
// ----------------------------------------------------------------------

function AddItem(Inventory invItem, Int count)
{
	local HUDReceivedDisplayItem item;
	local Window itemWindow, nextWindow;
	local string labelText;

	if(count <= 0)
		return;

	if(invItem == None || invItem.IsA('AmmoNone'))
		return;

	//== Check for duplicate items
	if(winTile != None)
		itemWindow = winTile.GetTopChild();
	while( itemWindow != None )
	{
		nextWindow = itemWindow.GetLowerSibling();
		if(itemWindow.IsA('HudReceivedDisplayItem'))
		{
			if(HudReceivedDisplayItem(itemWindow).itemClass == invItem.Class && invItem.Class != None) //== Duplicate entry, we should just update the number
			{
				labelText = invItem.beltDescription;
				if(labelText == "")
					labelText = invItem.Default.beltDescription;
	
				HudReceivedDisplayItem(itemWindow).itemCount += count;
	
				if(HudReceivedDisplayItem(itemWindow).itemCount > 1)
					labelText = labelText $ " (" $ string(HudReceivedDisplayItem(itemWindow).itemCount) $ ")";
	
				if(HudReceivedDisplayItem(itemWindow).winLabel != None)
					HudReceivedDisplayItem(itemWindow).winLabel.SetText(labelText);
			}
		}
		itemWindow = nextWindow;
	}

	if(labelText == "")
	{
		item = HUDReceivedDisplayItem(winTile.NewChild(Class'HUDReceivedDisplayItem'));
		item.SetItem(invItem, count);
	}

	displayTimer = 0.0;
	Show();
	bTickEnabled = True;
	AskParentForReconfigure();
}

// ----------------------------------------------------------------------
// RemoveItems()
// ----------------------------------------------------------------------

function RemoveItems()
{
	local Window itemWindow;
	local Window nextWindow;

	bTickEnabled = False;

	itemWindow = winTile.GetTopChild();
	while( itemWindow != None )
	{
		nextWindow = itemWindow.GetLowerSibling();

		// Don't destroy the "Received" TextWindow()
		if (!itemWindow.IsA('TextWindow'))
		{
			itemWindow.Destroy();
		}

		itemWindow = nextWindow;
	}

	Hide();
}

// ----------------------------------------------------------------------
// GetTimeRemaining()
// ----------------------------------------------------------------------

function float GetTimeRemaining()
{
	if (IsVisible())
		return displayLength - displayTimer;
	else
		return 0.0;
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	Super.StyleChanged();

	if (txtReceived != None)
		txtReceived.SetTextColor(colText);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     fontReceived=Font'DeusExUI.FontMenuHeaders_DS'
     displayLength=3.000000
     TopMargin=5
     TextReceivedLabel="Received:"
}
