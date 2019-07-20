package worlds 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.skins.milk.MilkButton;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import ui.skins.milk.MilkTextField;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import ui2.basic.BasicButton;
	import ui2.basic.BasicSlider;
	import ui2.basic.BasicTextField;
	
	public class PatchNotesWorld extends World
	{
		//Screen elements	
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		
		public function PatchNotesWorld() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
						
			new BasicTextField(0, 0, sw/2 + 250, 450, 
				{ text:	"<sMedium><cBC>Patch 1.1.0</cBC></sMedium>" +
						"\n\n<left>*Added Barry. Art by SwedishCheetah. Text by Araten." +
						"\n*Added Fuyumi by Araten." +
						"\n*Added custom text for Chastity by Araten." +
						"\n*Added settings menu." +
						"\n*Settings: Can now change for how long speech bubbles are displayed." +
						"\n*Settings: Can now save current progress (trophy room and settings) to file." +
						"\n*Settings: Can now choose between a few different card backs." +
						"\n*Trophy room: Can now change the IQ of everyone simultaneously." +
						"\n*Trophy room: Re-mapped IQ change keys." +
						"\n*Trophy room: Added View mode. Slowly decreases target IQ and wraps around when reaching min." +
						"\n*Trophy room: Can now move target portrait with LEFT and RIGHT arrows." +
						"\n" + 
						"\n*On-going game is no longer reset to last save when exiting to main menu. It is not paused either." +
						"\n*Activating cheatmode during a game now means that money and IQ from that game will not be added to your Trophy room." +
						"\n*Sliders with a handle are now grabbed in the middle of the handle instead of acting like a regular slider." +
						"\n*Moved player cards to give more room for player lines." +
						"\n" + 
						"\n*Pages that are not pre-loaded may now be cached after being opened once." +
						"\n*Cleared patch notes. Old notes can be accessed from patch notes screen. Old notes are not pre-loaded." +
						"\n*Changed layout of the credits page." +
						"\n*Moved some UI elements." +
						"\n*Changed some of Rosa's text." +
						"\n*Fixed typos in character texts." +
						"\n*Fixed Fondle tooltip text not displaying correctly." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(0, 450, sw/2 + 250, 150, 
				{ text:	"<sMedium><cBC>Patch 1.1.1</cBC></sMedium>" +
						"\n\n<left>*Added Sebastian by MythicalCreatureBone."+
						"\n*Shortened Barry's high IQ name." +
						"\n*Fixed a bug where the displayed cards where not the actual cards, causing hands to seem valued erroneously." +
						"\n*Fixed a bug causing the fold button not disabling properly." +
						"\n*Trophy Room: Increased size of information box." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(sw/2 + 250, 0, sw/2 - 250, 400, 
				{ text:	"<sMedium><cBC>Patch 1.2</cBC></sMedium>\n<left>" +
						"\n*Added Elena. Art by Tfgame. Text by Araten" +
						"\n*Added Maxwell by MythicalCreatureBone." +
						"\n*Added Dionysus by MythicalCreatureBone." +
						"\n*Added Anthony by MythicalCreatureBone." +
						"\n*Added Gonzy by Mistress-Gonzy." +
						"\n*Added Vanessa." +
						"\n*Added indicators for what hands are held during showdown." +
						"\n*Added pink card backs." +
						"\n*Added setting for toggling if the trophy rooms view mode should wrap around or stop when reaching minimum IQ." +
						"\n" +
						"\n*Added character specific defeat story for Rebecca." +
						"\n*Added more IQ variation to default voice lines." +
						"\n*Added notification for that Save/Load to file may only work in the downloaded version of the game." +
						"\n*Fixed voice line typos." +
						"\n*Added unique lines for Barry." +
						"\n*All character lines should now correctly be using the dollar sign to the left side of the number. Hopefully." +
						"\n*Fixed the Call/Check button not updating text immediately." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(sw/2 + 250, 400, sw/2 - 250, 100, 
				{ text:	"<sMedium><cBC>Patch 1.2.1</cBC></sMedium>\n<left>" +
						"\n*Added cheatmode toggle in Settings." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(sw/2 + 250, 500, sw/2 - 250, 100, 
				{ text:	"<sMedium><cBC>Patch 1.2.2</cBC></sMedium>\n<left>" +
						"\n*It is now possible to read character lines in the trophy room." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(sw/2 + 250, 600, sw/2 - 250, 80, 
				{ text:	"<sMedium><cBC>Patch 1.2.3</cBC></sMedium>\n<left>" +
						"\n*Fixed typo." +
						"", fontsize: 14 } ).add(this);
			new BasicTextField(0, 600, sw/2 + 250, 80, 
				{ text:	"<sMedium><cBC>Patch 1.2.4</cBC></sMedium>\n<left>" +
						"\n*Fixed bug that caused games to not end and allowed eliminated players to bet. Fix pointed out by MaddieMeadows." +
						"", fontsize: 14 } ).add(this);
						
						
				
			new BasicButton(0, sh - 40, 150, 40, { text:"1.0 Patch Notes", callbacks:[notes10] }, 1).add(this);
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
		}
		
		private function notes10():void
		{
			if (LoadingWorld.patchNotesWorld10 == null) {
				LoadingWorld.patchNotesWorld10 = new PatchNotesWorld10();
			}
			FP.world = LoadingWorld.patchNotesWorld10;
		}
		
		private function back():void {
			FP.world = LoadingWorld.mainMenuWorld;
		}
		
		
	}

}