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
	
	public class PatchNotesWorld10 extends World
	{
		//Screen elements	
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		
		public function PatchNotesWorld10() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back", callbacks: [back] }, 1 ).add(this);
			
			new BasicTextField(0, 0, sw/2, 250, 
				{ text:	"<sMedium><cBC>Patch 1.0.1 - 1.0.2</cBC></sMedium>" +
						"\n\n<left>*Added Patch Notes. Access from main menu." +
						"\n*Significantly improved performance in poker screen." +
						"\n*Improved performance in game setup screen. More to be done." +
						"\n*Added some dialouge." +
						"\n*Massively buffed striptease strength, but increased cost." +
						"\n*Fixed blind amount not saving correctly." +
						"\n*Added some names for Stephanie." +
						"\n\nNOTE: There are some performance issues that I am aware of, but that I am having trouble pin-pointing. Solving this will take some time."
						, fontsize: 14 } ).add(this);
						
			new BasicTextField(0, 250, sw/2, 150, 
				{ text:	"<sMedium><cBC>Patch 1.0.3</cBC></sMedium>" +
						"\n\n<left>*Added more names for Stephanie, thanks Chickenchaos!" +
						"\n*Removed a bug that made the first 9 cards each new game or after loading be the same." +
						"\n*All players are now out of the game as soon as they reach 40 IQ or below." +
						"\n*Changed how long the AI waits every turn. Overall slightly increased."
						, fontsize: 14 } ).add(this);
						
			new BasicTextField(0, 400, sw/2, 200, 
				{ text:	"<sMedium><cBC>Patch 1.0.4</cBC></sMedium>" +
						"\n\n<left>*Fixed characters looking like bimbos on very high IQ." +
						"\n*Added Cheat Mode. Activate by typing \"cheatmode\" while in-game. If typed right, you will now be able to adjust the targets IQ using Q and A." +
						"\n*Added character specific lines and endings for Salvatore and Christyna, written by Chickenchaos." +
						"\n*Fixed a possible MAJOR bug where the deck was only reshuffled when it ran out of cards. It now reshuffles at the start of each round."
						, fontsize: 14 } ).add(this);
						
			new BasicTextField(sw/2, 0, sw/2, 200, 
				{ text:	"<sMedium><cBC>Patch 1.0.5</cBC></sMedium>" +
						"\n\n<left>*Fixed some typos." +
						"\n*Added character specific lines and endings for Stephanie, written by Chickenchaos." +
						"\n*Added \"Next Round\" button instead of automatically starting next round." +
						"\n*Removed memory leak from game setup and trophy screens." +
						"\n*New character, \"Nathan\", by SwedishCheetah, added." +
						"\n*Added new functionality to Cheat Mode. While active, use W and S to adjust targets money." +
						"", fontsize: 14 } ).add(this);
						
			new BasicTextField(sw/2, 200, sw/2, 200, 
				{ text:	"<sMedium><cBC>Patch 1.0.6</cBC></sMedium>" +
						"\n\n<left>*Updated some Nathan frames." +
						"\n*Fixed a typo in Stephanie's bio." +
						"\n*Fixed some all-in voice lines being used by characters other than Salvatore." +
						"\n*Added Miller. Character by useful89." +
						"\n*Added support for characters having longer names but still being referred to by a short name by other characters." +
						"", fontsize: 14 } ).add(this);
						
			new BasicTextField(sw/2, 400, sw/2, 250, 
				{ text:	"<sMedium><cBC>Patch 1.0.7</cBC></sMedium>" +
						"\n\n<left>*Added Rosa. Character by SimpleKisekaeGuy." +
						"\n*A characters prologue and epilogue can now be accessed from the Trophy Room." +
						"\n*Slightly changed the Casino backstory." +
						"\n*Increased blind field sizes to properly fit blinds >= 1000." +
						"\n*Blind amount should no longer display the wrong value." +
						"\n*Players should now only be out of the game when they visibly have < 40 IQ." +
						"\n*Made AI act slightly faster." +
						"\n*Added a button to toggle quick mode. While on, speech is disabled, and AI act much faster." +
						"\n*Slight tweaks to epilougue style." +
						"\n*Added cheatmode and quickmode information to the How to Play screen." +
						"", fontsize: 14 } ).add(this);
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
		}
		
		private function back():void {
			FP.world = LoadingWorld.patchNotesWorld;
		}
		
		
	}

}