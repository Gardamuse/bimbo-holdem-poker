package worlds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import worlds.PokerWorld;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	import ui2.*;
	import ui2.basic.*;
	
	public class MainMenuWorld extends World
	{
		//Screen elements
		private var backstoryB:BasicButton;
		private var startNewB:BasicButton;
		private var startB:BasicButton;
		private var tutorialB:BasicButton;
		private var creditsB:BasicButton;
		private var trophyB:BasicButton;

		private var loadingWorld:LoadingWorld;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		private static const rows:Number = 5; //Screen Height
		private static const ha:Number = 170; //Height Adjustment
		private static const inbs:Number = 10; //In-between Space
		
		private static const bw:Number = 200; //Button Width
		private static const bh:Number = 50; //Button Height
		
		private static const fontsize:Number = 18;
		
		public function MainMenuWorld() 
		{
			//System Setup
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			this.loadingWorld = loadingWorld;
			
			new BasicTextField(sw / 2 - (bw * 2 + 200) / 2, 50, (bw * 2 + 200), 100, { text:"<cBC>Bimbo Holdem Poker</cBC>", fontsize:22 } ).add(this);
			
			startNewB = new BasicButton(sw/2 - bw - inbs/2, (sh-ha*2) * (2 / (rows + 1)) + ha - 50, bw, bh, { text:"Start New Game", callbacks:[startNew], fontsize:fontsize }, 1 );
			startNewB.add(this);
			
			startB = new BasicButton(sw/2 + inbs/2, (sh-ha*2) * (2 / (rows + 1)) + ha - 50, bw, bh, { text:"Continue Game", callbacks:[continueLast], fontsize:fontsize }, 1 );
			startB.add(this);
			
			trophyB = new BasicButton(sw / 2 - bw / 2, (sh - ha * 2) * (3 / (rows + 1)) + ha - 50, bw, bh, {text:"Trophy Room", fontsize:fontsize, callbacks:[trophy]}, 1);
			trophyB.add(this);
			
			new BasicButton(sw / 2 - bw / 2, (sh - ha * 2) * (5 / (rows + 1)) + ha - 50, bw, bh, { text: "Settings", callbacks:[settings], fontsize: fontsize }, 1).add(this);
			
			backstoryB = new BasicButton(sw/2 - bw / 2, (sh-ha*2) * (6 / (rows + 1)) + ha - 50, bw, bh, { text:"Backstory", callbacks:[backstory], fontsize:fontsize }, 1 );
			backstoryB.add(this);
			
			tutorialB = new BasicButton(sw/2 - bw/2, (sh-ha*2) * (7 / (rows + 1)) + ha - 50, bw, bh, { text:"How to Play", callbacks:[tutorial], fontsize:fontsize }, 1 );
			tutorialB.add(this);
			
			creditsB = new BasicButton(sw/2 - bw/2, (sh-ha*2) * (8 / (rows + 1)) + ha - 50, bw, bh, { text:"Credits", callbacks:[credits], fontsize:fontsize }, 1 );
			creditsB.add(this);
			
			new BasicTextField(sw - 230, sh - 25, 230, 25, { text:"Version 1.2.3", fontsize: 14 } ).add(this);

			new BasicTextField(sw - 230, sh - 40 - 25, 230, 40, { text:
				"<cBC>This game contains sexual content.</cBC>" +
				"\nThis includes: <fff>BE</fff>, <fff>TF/TG</fff>, <fff>TF/Ment</fff>",
			fontsize: 12 } ).add(this);
			
			new BasicButton(0, sh - 40, 150, 40, { text:"Patch Notes", callbacks:[patchNotes] }, 1).add(this);
			
			
			
		}
		
		private function _min():int {
			return 3;
		}
		
		private function _max():int {
			return 50;
		}
		
		private var asd:int = 0;
		private function addasd(i:int):void {
			asd += i;
		}
		
		private function five(i:int):int {
			return asd + i;
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
		}
		
		private function startNew():void {
			FP.world = new GameSetupWorld();
		}
		
		private function continueLast():void {
			if (LoadingWorld.pokerWorld != null) { // By default, return to previous instance.
				LoadingWorld.pokerWorld.updateCardBacks();
				FP.world = LoadingWorld.pokerWorld;
			} else { // Otherwise, try to load one.
				Data.load("saved_gamestate");
				if (Data.readBool("saveExists", false)) {
					FP.world = new PokerWorld(null, true);
				} else {
					new ui2.basic.BasicTextField(sw/2 + inbs/2, (sh-ha*2) * (2 / (rows + 1)) + ha - 50, bw, bh, {text:"No save could be found.", fontsize:16}).popup(this, 2, 0.2, 0.2);
				}
			}
			
		}
		
		private function tutorial():void {
			FP.world = LoadingWorld.tutorialWorld;
		}
		
		private function credits():void {
			FP.world = LoadingWorld.creditsWorld;
		}
		
		private function trophy():void {
			FP.world = new TrophyWorld();
		}
		
		private function settings():void
		{
			LoadingWorld.settingsWorld.setReturnWorld(this);
			FP.world = LoadingWorld.settingsWorld;
		}
		
		private function backstory():void {
			FP.world = LoadingWorld.backstoryWorld;
		}
		
		private function patchNotes():void {
			FP.world = LoadingWorld.patchNotesWorld;
		}
		
	}

}