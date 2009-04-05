//=============================================================================
// MenuSelectDifficulty
//=============================================================================

class MenuSelectDifficulty expands MenuUIMenuWindow;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
}

// ----------------------------------------------------------------------
// WindowReady() 
// ----------------------------------------------------------------------

event WindowReady()
{
	// Set focus to the Medium button
	SetFocusWindow(winButtons[1]);

	//== Enable right click for realistic button
	winButtons[3].EnableRightMouseClick();
}

// ----------------------------------------------------------------------
// ProcessCustomMenuButton()
// ----------------------------------------------------------------------

function ProcessCustomMenuButton(string key)
{
	switch(key)
	{
		case "EASY":
			InvokeNewGameScreen(1.0);
			break;

		case "MEDIUM":
			InvokeNewGameScreen(1.5);
			break;

		case "HARD":
			InvokeNewGameScreen(2.0);
			break;

		case "REALISTIC":
			InvokeNewGameScreen(4.0);
			break;

		case "UNREALISTIC":
			InvokeNewGameScreen(4.1);
			break;
	}
}

//-----------------------------------------------------------------------
// 
//-----------------------------------------------------------------------

function bool ButtonActivatedRight( Window buttonPressed )
{
	local int i;

	if(buttonPressed == winButtons[3])
	{
		if(buttonDefaults[3].Key == "REALISTIC")
		{
			winButtons[3].SetButtonText("Unrealistic");
			buttonDefaults[3].Key = "UNREALISTIC";
			PlaySound(Sound'Menu_Press', 0.25);
			return True;
		}
		else if(buttonDefaults[3].Key == "UNREALISTIC")
		{
			winButtons[3].SetButtonText(ButtonNames[3]);
			buttonDefaults[3].Key = "REALISTIC";
			PlaySound(Sound'Menu_Press', 0.25);
			return True;
		}
	}
}

// ----------------------------------------------------------------------
// InvokeNewGameScreen()
// ----------------------------------------------------------------------

function InvokeNewGameScreen(float difficulty)
{
	local MenuScreenNewGame newGame;

	newGame = MenuScreenNewGame(root.InvokeMenuScreen(Class'MenuScreenNewGame'));

	if (newGame != None)
		newGame.SetDifficulty(difficulty);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     ButtonNames(0)="Easy"
     ButtonNames(1)="Medium"
     ButtonNames(2)="Hard"
     ButtonNames(3)="Realistic"
     ButtonNames(4)="Previous Menu"
     buttonXPos=7
     buttonWidth=245
     buttonDefaults(0)=(Y=13,Action=MA_Custom,Key="EASY")
     buttonDefaults(1)=(Y=49,Action=MA_Custom,Key="MEDIUM")
     buttonDefaults(2)=(Y=85,Action=MA_Custom,Key="HARD")
     buttonDefaults(3)=(Y=121,Action=MA_Custom,Key="REALISTIC")
     buttonDefaults(4)=(Y=179,Action=MA_Previous)
     Title="Select Combat Difficulty"
     ClientWidth=258
     ClientHeight=221
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuDifficultyBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuDifficultyBackground_2'
     textureRows=1
     textureCols=2
}
