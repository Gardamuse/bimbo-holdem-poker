package worlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	import ui2.basic.BasicButton;
	import net.flashpunk.FP;
	import ui2.basic.BasicGripSlider;
	import ui2.basic.BasicSlider;
	import ui2.Slider;
	import net.flashpunk.utils.Data;
	import ui2.basic.BasicTextField;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	import flash.utils.getQualifiedClassName;
	
	public class SettingsWorld extends World
	{
		//Screen elements
		private var backdrop:Backdrop;
		private var chatDelayMultS:BasicSlider;
		private var cardBackS:BasicGripSlider;
		private var cardBackPreview:CardEntity;
		private var cardBackPreviewBox:BasicTextField;
		private var viewmodeStopS:BasicGripSlider;
		private var cheatmodeS:BasicGripSlider;
		
		//Model
		public var chatDelayMult:Number = 0;
		public var cardBackI:int = 0;
		private static var CARD_BACKS:Vector.<NamedAsset> = Vector.<NamedAsset>([
			new NamedAsset(Assets.CARD_BACK_RED, "Red"),
			new NamedAsset(Assets.CARD_BACK_GREEN, "Green"),
			new NamedAsset(Assets.CARD_BACK_BLUE, "Blue"),
			new NamedAsset(Assets.CARD_BACK_PINK, "Pink")
		]);
		public var backgroundI:int = 0;
		private static var BACKGROUNDS:Vector.<NamedAsset> = Vector.<NamedAsset>([
			new NamedAsset(Assets.BACKGROUND, "Green")
		]);
		public var viewModeStopOnComplete:int = 1;
		public var toggleCheatmode:int = 0;
		
		private var returnWorld:World;
		
		private var initialized:Boolean = false;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		private static const col2x:Number = sw/2 - col1w/2;
		private static const col2y:Number = 200;
		private static const col1w:Number = 250;
		
		private static const col1x:Number = col2x - col1w - 150;
		
		private static const cardPreviewScale:Number = 0.49;
		private static const cbsw:Number = col1w; //Card Back Slider Width
		private static const cbpx:Number = col2x + cbsw; //Card Back Preview X
		private static const cbpy:Number = col2y + 150; //Card Back Preview Y
		
		public function SettingsWorld()
		{
			super();
			FP.screen.color = 0x003300;
			backdrop = new Backdrop(Assets.BACKGROUND);
			add(new Entity(0, 0, backdrop));
			
			load();
			
			new BasicTextField(sw / 2 - (100 * 2 + 200) / 2, 50, (100 * 2 + 200), 50, { text:"<cBC>Settings</cBC>", fontsize:22 } ).add(this);
			
			new BasicTextField(col2x, col2y, col1w, 50, { text: "<fff>Chat Delay</fff>\n<sSmall>How long speech bubbles are visible.</sSmall>" } ).add(this);
			chatDelayMultS = new BasicSlider( col2x, col2y + 50, col1w, 50, { text:"<var0>%", minCallback: function():Number { return 10; }, maxCallback: function():Number { return 200; }} );
			chatDelayMultS.setSliderValue(chatDelayMult * 100.0);
			chatDelayMultS.add(this);
			
			new BasicTextField(col2x, col2y + 50 + 100, col1w, 50, { text: "<fff>Select Card Back</fff>" } ).add(this);
			cardBackS = new BasicGripSlider(col2x, col2y + 50 + 150, cbsw, 50, { 
				text:"<var1>", 
				minCallback: function():Number { return 0; }, 
				maxCallback: function():Number { return CARD_BACKS.length - 1; },
				intervalCallback: function():Number { return 1; },
				callbacks: [function():String { return LoadingWorld.settingsWorld.getCardBack().name } ],
				gripWidth: cbsw / CARD_BACKS.length
				} );
			
			cardBackS.setSliderValue(cardBackI);
			cardBackS.add(this);
			
			new BasicTextField(col1x, col2y+100, col1w, 35, { text: "<sSmall>This feature may only work in the downloaded version of the game.</sSmall>" } ).add(this); 
			new BasicTextField(col1x, col2y, col1w, 50, { text: "<fff>Backup or Restore</fff>\n<sSmall>On-going games will not be saved.</sSmall>" } ).add(this); 
			new BasicButton(col1x, col2y + 50, col1w/2, 50, { text: "Save", callbacks:[onSaveButton] }, 1).add(this);
			new BasicButton(col1x + col1w / 2, col2y + 50, col1w / 2, 50, { text: "Load", callbacks:[onLoadButton] }, 1).add(this);
			
			viewmodeStopS = new BasicGripSlider(col2x, col2y + 50 + 150 + 100, cbsw, 50, { 
				text:"On min IQ, view mode will\n<var1>.", 
				minCallback: function():Number { return 0; }, 
				maxCallback: function():Number { return 1; },
				intervalCallback: function():Number { return 1; },
				callbacks: [function():String { if (viewModeStopOnComplete == 1) { return "turn off"; } else { return "wrap around"; } } ],
				gripWidth: cbsw / 4
				} );
			viewmodeStopS.setSliderValue(viewModeStopOnComplete);
			viewmodeStopS.add(this);
			
			cheatmodeS = new BasicGripSlider(col2x, col2y + 50 + 150 + 100 + 50, cbsw, 50, { 
				text:"Cheatmode will <var1>.", 
				minCallback: function():Number { return 0; }, 
				maxCallback: function():Number { return 1; },
				intervalCallback: function():Number { return 1; },
				callbacks: [function():String { if (toggleCheatmode == 1) { return "be toggled"; } else { return "not be toggled"; } } ],
				gripWidth: cbsw / 4
				} );
			cheatmodeS.setSliderValue(toggleCheatmode);
			cheatmodeS.add(this);
			
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Save and Exit", callbacks: [back] }, 1 ).add(this);
			setReturnWorld(LoadingWorld.mainMenuWorld);
		}
		
		private function init():void {
			cardBackS.onChangeCallback = function():void { 
					LoadingWorld.settingsWorld.cardBackI = LoadingWorld.settingsWorld.cardBackS.getSliderValueRound();
					cardBackPreview.hidden = true;
					}
			cardBackPreviewBox = new BasicTextField(cbpx, cbpy, 100 * ((CardEntity.cardWidth + 6) / CardEntity.cardHeight), 100);
			cardBackPreviewBox.add(this);
			cardBackPreview = new CardEntity(52, cbpx + 3, cbpy + 3, true, cardPreviewScale);
			add(cardBackPreview);
			
			initialized = true;
		}
		
		override public function update():void {
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			if (!initialized) {
				init();
			}
			
			chatDelayMult = chatDelayMultS.getSliderValue() / 100.0;
			
			viewModeStopOnComplete = viewmodeStopS.getSliderValue();
			toggleCheatmode = cheatmodeS.getSliderValue();
			
		}
		
		// To be run when entering this world.
		public function setReturnWorld(returnWorld:World):void {
			this.returnWorld = returnWorld;
		}
		
		public function getCardBack():NamedAsset
		{
			return getNamedAsset(CARD_BACKS, cardBackI);
		}
		
		public function getBackground():NamedAsset
		{
			return getNamedAsset(BACKGROUNDS, backgroundI);
		}
		
		private function getNamedAsset(vector:Vector.<NamedAsset>, i:int, slider:Slider = null):NamedAsset {
			if (i < 0 || i >= vector.length) {
				i = 0;
				if (slider != null) {
					cardBackS.setSliderValue(i);
				}
			}
			return vector[i];
		}
		
		/** 0: don't toggle, 1: toggle */
		public function setToggleCheatmode(value:int):void {
			toggleCheatmode = value;
			cheatmodeS.setSliderValue(toggleCheatmode);
		}
		
		private function back():void {
			if (getQualifiedClassName(returnWorld) == getQualifiedClassName(PokerWorld)) {
				PokerWorld(returnWorld).updateCardBacks();
			}
			FP.world = returnWorld;
			save();
		}
		
		private function onSaveButton():void {
			save();
			LoadingWorld.saveFile();
		}
		
		private function onLoadButton():void {
			LoadingWorld.loadFile();
		}
		
		/** Clears the savefile and rewrites it from current data.*/
		private function save():void {
			//Data.clear("bhp_save");
			Data.load("bhp_save");
			Data.writeNumber("chatDelayMult", chatDelayMult);
			Data.writeInt("cardBackI", cardBackI);
			Data.writeInt("backgroundI", backgroundI);
			Data.writeInt("viewModeStopOnComplete", viewModeStopOnComplete);
			Data.save("bhp_save");
		}
		
		public function load():void {
			Data.load("bhp_save");
			chatDelayMult = Data.readNumber("chatDelayMult", 1.0);
			cardBackI = Data.readInt("cardBackI", 0);
			backgroundI = Data.readInt("backgroundI", 0);
			viewModeStopOnComplete = Data.readInt("viewModeStopOnComplete", 1);
		}
		
	}

}