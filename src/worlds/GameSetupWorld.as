package worlds 
{
	import bimbos.*;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.SelectButtonGroup;
	import ui.skins.milk.MilkButton;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ui.skins.milk.PokerSlider;
	import ui.skins.milk.PokerSliderScroller;
	import ui.skins.milk.MilkTextField;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import ui.skins.milk.TooltipTextField;
	import ui2.basic.BasicSlider;
	import ui2.basic.BasicTextField;
	import ui2.basic.BasicGripSlider;
	import ui2.basic.BasicButton
	
	public class GameSetupWorld extends World
	{
		//Screen elements
		private var backB:BasicButton;
		private var startB:BasicButton;
		private var scroller:BasicGripSlider;
		private var player1B:BasicButton;
		private var player2B:BasicButton;
		private var player3B:BasicButton;
		private var player4B:BasicButton;
		private var player5B:BasicButton;
		private var bioF:BasicTextField;
		private var bioIqF:BasicTextField;
		private var bioNameF:BasicTextField;
		private var instructionF:BasicTextField;
		private var roundsS:PokerSlider;
		private var blindS:PokerSlider;
		
		private var selectButtonGroup:SelectButtonGroup;
		
		//Model
		private var empty:BimboSetupBox;
		private var random:BimboSetupBox;
		
		private var boxes:Vector.<BimboSetupBox>;
		private var lockedBoxes:Vector.<BimboSetupBox>;
		private var selectedModel:BimboModel;
		private var selectedModels:Vector.<BimboModel>;
		
		private var devmode:Boolean = false;
		private var cheatmode:Boolean = false;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		private static const selectH:Number = 50; //Scroll Height
		private static const lockX:Number = sw - 600;
		private static const lockY:Number = sh - 340;
		private static const lockRow1H:Number = 50;
		private static const lockRow2H:Number = 30;
		public static const chars:int = 19; // SETUP Nr of latest character + 1 random + 1 empty + 1
		
		public function GameSetupWorld()
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			
			//Buttons and system
			backB = new BasicButton(lockX+400, lockY+200+lockRow1H+lockRow2H, 200, 40, { text:"Back to main menu", callbacks:[back], fontsize:16 }, 1 );
			add(backB);
			startB = new BasicButton(lockX+200, lockY+100+lockRow1H+lockRow2H, 400, 100, { text:"Start Game", callbacks:[start], fontsize:24 }, 1 );
			add(startB);
			scroller = new BasicGripSlider(0, selectH + 240, sw, 40, { minCallback: _getScrollMin, maxCallback: _getScrollMax } );
			add(scroller);
			instructionF = new BasicTextField(0, 0,	sw, selectH,
								{text:"Choose which characters should be in your game! Press their image below and" +
								" choose one of the slots near the start button." +
								" When you feel done, press start!", fontsize:16});
			instructionF.add(this);
			
			
			//Main Setup Boxes
			selectButtonGroup = new SelectButtonGroup();
			empty = new BimboSetupBox(this, new EmptyModel(), 200 * 0, selectH, 200, 40, selectButtonGroup, selected); //sw / 2 - 100 * (chars - 2*0)
			random = new BimboSetupBox(this, new Random(), 200 * 1, selectH, 200, 40, selectButtonGroup, selected);

			boxes = new Vector.<BimboSetupBox>;
			boxes.push(empty);
			boxes.push(random);
			
			// SETUP Add a box for each character
			populateSetupBox(boxes, new Kristyna());
			populateSetupBox(boxes, new Salvatore());
			populateSetupBox(boxes, new Chastity());
			populateSetupBox(boxes, new Rebecca());
			populateSetupBox(boxes, new Stephanie());
			populateSetupBox(boxes, new Nathaniel());
			populateSetupBox(boxes, new Miller());
			populateSetupBox(boxes, new Rosa());
			populateSetupBox(boxes, new Barry());
			populateSetupBox(boxes, new Fuyumi());
			populateSetupBox(boxes, new Sebastian());
			
			populateSetupBox(boxes, new Elena());
			populateSetupBox(boxes, new Maxwell());
			populateSetupBox(boxes, new Dionysus());
			populateSetupBox(boxes, new Anthony());
			populateSetupBox(boxes, new Gonzy());
			populateSetupBox(boxes, new Vanessa());
			
			for each (var box:BimboSetupBox in boxes) {
				selectButtonGroup.add(box.getSelectButton());
			}
			
			//Fields and regular screen items
			bioIqF = new BasicTextField(300, lockY, 100, lockRow1H, {text:"<left><fff>  IQ:</fff> <var0></left>"});
			add(bioIqF);
			bioNameF = new BasicTextField(0, lockY, 300, lockRow1H, {text:"<left><fff>  Name:</fff></left> <var0>"});
			add(bioNameF);
			bioF = new BasicTextField(0, lockY + lockRow1H, 400, lockRow2H + 200, {text:"<var0>"});
			add(bioF);
			new BasicTextField(400 + (lockX - 400) / 2 - 100, lockY, 200, 50, {text:"<fff>Match Options</fff>", fontsize: 20}).add(this);
			roundsS = new PokerSlider(400 + (lockX - 400) / 2 - 100, lockY+50, "Blinds increase every\n ", " rounds.", 200, 50, _minRounds, _maxRounds, null, null, 14, _intervalRounds);
			roundsS.sliderFraction = 4/int((_maxRounds()-_minRounds())/_intervalRounds());
			add(roundsS);
			blindS = new PokerSlider(400 + (lockX - 400) / 2 - 100, lockY + 100, "Big blind starts at $", ".", 200, 50, _minBlind, _maxBlind, null, null, 14, _intervalBlind);
			blindS.sliderFraction = 2/int(((_maxBlind()-_minBlind())/_intervalBlind()));
			add(blindS);
			
			//Lock in Boxs
			lockedBoxes = new Vector.<BimboSetupBox>(5);
			selectedModels = new Vector.<BimboModel>(5);
			player1B = new BasicButton(lockX, lockY, 200, lockRow1H, { text:"You", callbacks:[function():void { lockModel(0); } ], fontsize:16 }, 1 );
			add(player1B);
			player2B = new BasicButton(lockX + 200, lockY, 100, lockRow1H, { text:"Opponent", callbacks:[function():void { lockModel(1); } ], fontsize:16 }, 1 );
			add(player2B);
			player3B = new BasicButton(lockX+300, lockY, 100, lockRow1H, { text:"Opponent", callbacks:[function():void { lockModel(2); } ], fontsize:16 }, 1 );
			add(player3B);
			player4B = new BasicButton(lockX+400, lockY, 100, lockRow1H, { text:"Opponent", callbacks:[function():void { lockModel(3); } ], fontsize:16 }, 1 );
			add(player4B);
			player5B = new BasicButton(lockX+500, lockY, 100, lockRow1H, { text:"Opponent", callbacks:[function():void { lockModel(4); } ], fontsize:16 }, 1 );
			add(player5B);
			
			//Default
			selectedModel = new EmptyModel();
			lockModel(0);
			selectedModel = new Random();
			lockModel(1);
			lockModel(2);
			lockModel(3);
			selectedModel = new EmptyModel();
			lockModel(4);
			
			selected(boxes[0].model);
		}
		
		private function populateSetupBox(boxes:Vector.<BimboSetupBox>, model:BimboModel):void {
			boxes.push(new BimboSetupBox(this, model, 200 * boxes.length, selectH, 200, 40, selectButtonGroup, selected));
		}
		
		private var oldScrollerValue:Number = 0;
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			if (oldScrollerValue > scroller.getSliderValueRound() || oldScrollerValue < scroller.getSliderValueRound() ) {
				moveBoxesTo(-scroller.getSliderValueRound(), 0);
				oldScrollerValue = scroller.getSliderValueRound();
			}
			
			//Input loop
			if (Input.pressed(Key.Q) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedModel.iq += 50;
				} else {
					selectedModel.iq += 5;
				}
				for each (var box:BimboSetupBox in boxes) {
					box.update()
				}
				for each (var lockBox:BimboSetupBox in lockedBoxes) {
					lockBox.update();
				}
			}
			if (Input.pressed(Key.A) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedModel.iq -= 50;
				} else {
					selectedModel.iq -= 5;
				}
				for each (var box2:BimboSetupBox in boxes) {
					box2.update()
				}
				for each (var lockBox2:BimboSetupBox in lockedBoxes) {
					lockBox2.update();
				}
			}
			
			if (Input.keyString.match("devmode")) {
				Input.keyString = Input.keyString.replace("devmode", "");
				cheatmode = !cheatmode;
			}
		}
		
		public function _getScrollMax():Number {
			//return -(sw - 200 * chars - 0)/2;
			return -(sw - 200 * chars);
		}
		
		public function _getScrollMin():Number {
			//return (sw - 200 * chars - 0)/2;
			return 0;
		}
		
		public function _minRounds():int {
			return 2;
		}
		
		public function _maxRounds():int {
			return 20;
		}
		
		public function _intervalRounds():int {
			return 1;
		}
		
		public function _minBlind():int {
			return 20;
		}
		
		public function _maxBlind():int {
			return 200;
		}
		
		public function _intervalBlind():int {
			return 20;
		}
		
		private function lockModel(slot:int):void {
			if (selectedModel != null) {
				selectedModels[slot] = selectedModel;
				
				if (lockedBoxes[slot] == null) {
					if (slot == 0) {
						lockedBoxes[slot] = new BimboSetupBox(this, selectedModel, lockX, lockY + lockRow1H, 200, lockRow2H, selectButtonGroup, lockModel, slot);
					} else {
						lockedBoxes[slot] = new BimboSetupBox(this, selectedModel, lockX + 200 + 100*(slot-1), lockY+lockRow1H, 100, lockRow2H, null, lockModel, slot);
					}
				} else {
					
					for (var i:int = 0; i < lockedBoxes.length; i++) {
						if (lockedBoxes[i].model == selectedModel && lockedBoxes[i].model.typeId != -1 && lockedBoxes[i].model.typeId != -2) {
							lockedBoxes[i].setModel(random.model, random.model.portraitSequence);
							selectedModels[i] = random.model;
						}
					}
					
					lockedBoxes[slot].setModel(selectedModel, selectedModel.portraitSequence);
				}
			}
		}
		
		private function selected(model:BimboModel):void {
			selectedModel = model;
			bioNameF.callbacks[0] = model.getName;
			bioIqF.callbacks[0] = model.getIqString;
			bioF.callbacks[0] = model.getBio;
		}
		
		private function moveBoxesTo(x:Number, y:Number):void {
			for each (var box:BimboSetupBox in boxes) {
				box.moveTo(box.startX + x, box.startY+y);
			}
		}
		
		private function back():void {
			FP.world = LoadingWorld.mainMenuWorld;
		}
		
		private function start():void {
			var notEmpty:int = 0;
			for (var j:int = 0; j < selectedModels.length; j++) {
					if (selectedModels[j].typeId != -2) notEmpty++;
				}
			if (selectedModels[0] != null && selectedModels[0].typeId != -2 && notEmpty >= 2) {
				for (var i:int = 0; i < selectedModels.length; i++) {
					if (selectedModels[i].typeId == -2) selectedModels[i] = null;
				}
				var world:PokerWorld = new PokerWorld(selectedModels, false, getBlindStartValue());
				world.ROUNDS_BETWEEN_BLIND_INCREASE = getRoundsBetweenBlindIncrease();
				LoadingWorld.pokerWorld = world;
				FP.world = world;
			} else {
				new BasicTextField(lockX + 200, lockY, 400, 100 + lockRow1H + lockRow2H, {text:"The game could not be started.\n\nPlease select your character.", fontsize:20}).popup(this, 2, 0.2, 0.3);
			}
		}
		
		private function getRoundsBetweenBlindIncrease():int {
			return int(roundsS.getSliderValueRound());
		}
		
		private function getBlindStartValue():int {
			return int(blindS.getSliderValueRound());
		}
		
	}

}