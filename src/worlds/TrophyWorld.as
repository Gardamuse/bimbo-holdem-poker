package worlds 
{
	import bimbos.EmptyModel;
	import bimbos.Random;
	import bimbos.Rosa;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.SharedObject;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import ui.SelectButton;
	import ui.SelectButtonGroup;
	import ui.skins.milk.PokerSelectButton;
	import ui2.basic.BasicButton;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Data;
	import ui.skins.milk.PokerSliderScroller;
	import ui2.basic.BasicGripSlider;
	import ui2.basic.BasicSlider;
	import ui2.basic.BasicTextField;
	import ui2.Slider;
	import net.flashpunk.utils.Key;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class TrophyWorld extends World
	{
		
		private var backB:BasicButton;
		private var selectButtonGroup:SelectButtonGroup;
		private var scroller:BasicGripSlider;
		private var targetCam:WomanCam;
		private var targetBorder:PokerSelectButton;
		private var iqS:Slider;
		private var epilogueB:BasicButton;
		
		private var boxes:Vector.<BimboSetupBox>;
		private var models:Vector.<BimboModel>;
		private var money:Number;
		private var iq:Number;
		private var selectedModel:BimboModel;
		private var lastSelected:int = 0; //The index of the last selected model. This value is loaded from savefile.
		
		private var bioF:BasicTextField;
		private var bioNameF:BasicTextField;
		private var bioIqF:BasicTextField;
		private var chatF:BasicTextField;
		
		public static const sw:Number = FP.screen.width; //Screen Width
		public static const sh:Number = FP.screen.height; //Screen Height
		
		public static const xa:Number = 340; //X Adjustment for the information block
		
		public function TrophyWorld()
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			
			new BasicButton( sw - 100, sh - LoadingWorld.backBH * 2, 100, LoadingWorld.backBH, {text:"Settings", callbacks: [settings] }, 1 ).add(this);
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
			new BasicTextField(0, 0, sw / 2, 50, { text:"Money: $<var0>", callbacks:[function():Number { return money; }]}).add(this);
			new BasicTextField(sw / 2, 0, sw / 2, 50, { text:"IQ Storage: <var0> IQ", callbacks:[function():Number { return iq; } ] } ).add(this);
			
			new BasicTextField(xa, 360, 500, 40, { text:"Information"}).add(this);
			new BasicButton(xa + 500, 360, 400, 40, { text:"Read epilogue", callbacks:[function():void { save(); if (models != null && models.length > 0) FP.world = new DefeatSubmitWorld(selectedModel, 1); } ] }, 1).add(this);
			bioNameF = new BasicTextField(xa, 400, 350, 50, {text:"<left><fff>  Name:</fff></left> <var0>"});
			bioNameF.add(this);
			bioIqF = new BasicTextField(xa + 50 + 300, 400, 150, 50, {text:"<left><fff>  IQ:</fff> <var0></left>"});
			bioIqF.add(this);
			bioF = new BasicTextField(xa, 450, 500, 200, {text:"<var0>"});
			bioF.add(this);
			chatF = new BasicTextField(xa + 500, 450, 400, 100, { text:"" } );
			chatF.add(this);
			
			scroller = new BasicGripSlider(300, 50 + 240, sw - 300, 40, { minCallback: _getScrollMin, maxCallback: _getScrollMax } );
			add(scroller);
			
			load();
			
			drawBoxes();
			
			
			selectedModel = new EmptyModel();
			
			drawTargetCam();
			
			iqS = new BasicSlider(0, targetCam.imageHeight + 50, targetCam.imageWidth, 50,
				{ text: "IQ: <var0>", callbacks: [function():void { printLine("__"); } ], minCallback: function():Number { return 30; }, maxCallback: function():Number { return 180; }} );
			iqS.add(this);
			new BasicTextField(0, targetCam.imageHeight + 100, targetCam.imageWidth, 120, { text:
				"<cBC>Q</cBC>/<cBC>A</cBC>: Change target IQ." +
				"\n<cBC>W</cBC>/<cBC>S</cBC>: Change IQ of everyone." +
				"\n<cBC>SHIFT</cBC>/<cBC>SPACE</cBC>: Increased speed." +
				"\n<cBC>V</cBC>: Toggle View mode." +
				"\n\n<cBC>LEFT</cBC>/<cBC>RIGHT</cBC>: Move target portrait."
				, fontsize:14 } ).add(this);
			
			if (boxes.length > 0 && boxes[0] != null && lastSelected >= 0 && lastSelected < boxes.length) {
				select(boxes[lastSelected].model);
				boxes[lastSelected].getSelectButton().externalClick();
			} else {
				select(new EmptyModel());
			}
			
			//MaxCallback has to match getLineVector and should match up with gripWidth divisor.
			var lineS:BasicGripSlider = new BasicGripSlider(xa + 500, 400, 400, 50, { text: "<var1>", minCallback: function():int { return 0; }, maxCallback: function():int { return 13; }, gripWidth: 400/13} );
			lineS.addCallback(function():String { return getLineVectorName(lineS.getSliderValue()) } );
			lineS.addCallback(function():void { currentLine = getLineVector(lineS.getSliderValue()) } );
			lineS.add(this);
			
		}
		
		//Has to match the maxCallbackNr in lineS.
		private function getLineVector(i:int):Vector.<String> {
			switch(i){
				case 0: return selectedModel.ALL_IN;
				case 1: return selectedModel.ALREADY_ALL_IN;
				case 2: return selectedModel.BUY_IN;
				case 3: return selectedModel.CALLING;
				case 4: return selectedModel.CHECKING;
				case 5: return selectedModel.CUM;
				case 6: return selectedModel.FOLDING;
				case 7: return selectedModel.FONDLING;
				case 8: return selectedModel.FONDLING_SELF;
				case 9: return selectedModel.IQ_UP;
				case 10: return selectedModel.RAISING;
				case 11: return selectedModel.RELAXING;
				case 12: return selectedModel.STRIPTEASE;
				case 13: return selectedModel.WINNING;
				default: return selectedModel.NAMES;
			}
		}
		
		//Has to match getLineVector
		private function getLineVectorName(i:int):String {
			switch(i){
				case 0: return "All in";
				case 1: return "Already all-in";
				case 2: return "Buy-in";
				case 3: return "Calling";
				case 4: return "Checking";
				case 5: return "Cumming";
				case 6: return "Folding";
				case 7: return "Fondling";
				case 8: return "Fondling self";
				case 9: return "IQ Up";
				case 10: return "Raising";
				case 11: return "Relaxing";
				case 12: return "Striptease";
				case 13: return "Winning";
				default: return "";
			}
		}
		
		private var currentLine:Vector.<String> = null;
		private function printLine(variable:Object = null):void {
			var string:String = selectedModel.getLine(currentLine, variable);
			chatF.setText(string);
		}
		
		private function removeBoxes():void {
			for each (var box:BimboSetupBox in boxes) {
				box.remove();
			}
		}
		
		private function drawBoxes():void {
			boxes = new Vector.<BimboSetupBox>(models.length);
			selectButtonGroup = new SelectButtonGroup();
			var startX:Function = function() : Number { var i:Number = sw - 200 * models.length;  if (i > 300) { return i} else {return 300}};
			for (var i:int = 0; i < models.length; i++) {
				boxes[i] = new BimboSetupBox(this, models[i], startX() + 200 * i, 50, 200, 40, selectButtonGroup, select);
				selectButtonGroup.add(boxes[i].getSelectButton());
			}
		}
		
		private function removeTargetCam():void {
			remove(targetCam);
			remove(targetBorder);
		}
		
		private function drawTargetCam():void {
			targetCam = new WomanCam(selectedModel, selectedModel.camSequence, 0, 50, 300);
			add(targetCam);
			targetBorder = new PokerSelectButton(0, 50, "", targetCam.imageWidth, targetCam.imageHeight)
			add(targetBorder);
		}
		
		private function redrawRooster():void {
			if (models == null || models.length <= 0) {
				return;
			}
			// Temp store
			var tempBoxes:Vector.<BimboSetupBox> = new Vector.<BimboSetupBox>(boxes.length);
			for (var i:int = 0; i < boxes.length; i++) {
				tempBoxes[i] = boxes[i];
			}
			var tempCam:WomanCam = targetCam;
			var tempBorder:PokerSelectButton = targetBorder;
			
			// Redraw
			drawBoxes();
			drawTargetCam();
			select(models[lastSelected]);
			boxes[lastSelected].getSelectButton().externalClick();
			
			// Remove
			for each (var box:BimboSetupBox in tempBoxes) {
				if (tempBoxes.length < 5) {
					box.remove(); // This makes the rooster blink once while it is gone.
				} else {
					PokerWorld.delay(box.remove, [], 0); // But this makes the old rooster visible underneath if dragging simulatenously. Thus only do this when background is not visible.
				}
			}
			PokerWorld.delay(remove, [tempCam], 0);
			PokerWorld.delay(remove, [tempBorder], 0);
		}
		
		private var viewMode:Boolean = false;
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
			var iqChange:Number = 0.09;
			if (Input.check(Key.SHIFT)) {
				iqChange = 0.8;
			} else if (Input.check(Key.SPACE)) {
				iqChange = 0.25;
			} else {
				iqChange = 0.09;
			}
			
			// Target
			if (Input.check(Key.Q)) {
				viewMode = false;
				iqS.sliderFraction += iqChange * FP.elapsed;
				selectedModel.iq = iqS.getSliderValueRound();
			}
			if (Input.check(Key.A)) {
				viewMode = false;
				iqS.sliderFraction -= iqChange * FP.elapsed;
				selectedModel.iq = iqS.getSliderValueRound();
			}
						
			// Everyone
			if (Input.check(Key.W)) {
				viewMode = false;
				iqS.sliderFraction += iqChange * FP.elapsed;
				for each (var model:BimboModel in models) {
					model.iq = iqS.getSliderValueRound();
				}
			}
			if (Input.check(Key.S)) {
				viewMode = false;
				iqS.sliderFraction -= iqChange * FP.elapsed;
				for each (var model2:BimboModel in models) {
					model2.iq = iqS.getSliderValueRound();
				}
			}
			
			// Extra
			if (Input.released(Key.V)) {
				viewMode = !viewMode;
				if (iqS.sliderFraction == 0) {
					iqS.sliderFraction = 1;
				}
			}
			
			if (viewMode) {
				iqS.sliderFraction -= 0.15 * (iqS.sliderFraction + 1) * iqChange * FP.elapsed;
				selectedModel.iq = iqS.getSliderValueRound();
				if (iqS.sliderFraction == 0) {
					//PokerWorld.delay(function():void { iqS.sliderFraction = 1; }, [], 1000);
					if (LoadingWorld.settingsWorld.viewModeStopOnComplete == 1) {
						viewMode = false;
					} else {
						iqS.sliderFraction = 1;
					}
				}
			}
			
			// Change position
			if ( Input.released(Key.LEFT) || Input.released(Key.RIGHT)) {
				var tmpBox:BimboSetupBox;
				var tmpModel:BimboModel
				if (Input.released(Key.LEFT)) {
					if (lastSelected > 0) {
						tmpBox = boxes[lastSelected];
						boxes[lastSelected] = boxes[lastSelected - 1];
						boxes[lastSelected - 1] = tmpBox;
						
						tmpModel = models[lastSelected];
						models[lastSelected] = models[lastSelected - 1];
						models[lastSelected - 1] = tmpModel;
					}
					if (lastSelected == 0) {
						tmpBox = boxes[lastSelected];
						boxes[lastSelected] = boxes[boxes.length - 1];
						boxes[boxes.length - 1] = tmpBox;
						
						tmpModel = models[lastSelected];
						models[lastSelected] = models[models.length - 1];
						models[models.length - 1] = tmpModel;
					}
					lastSelected--;
					if (lastSelected < 0) {
						lastSelected = boxes.length - 1;
					}
				}
				if (Input.released(Key.RIGHT)) {
					if (lastSelected < boxes.length - 1) {
						tmpBox = boxes[lastSelected];
						boxes[lastSelected] = boxes[lastSelected + 1];
						boxes[lastSelected + 1] = tmpBox;
						
						tmpModel = models[lastSelected];
						models[lastSelected] = models[lastSelected + 1];
						models[lastSelected + 1] = tmpModel;
					}
					if (lastSelected == boxes.length - 1) {
						tmpBox = boxes[lastSelected];
						boxes[lastSelected] = boxes[0];
						boxes[0] = tmpBox;
						
						tmpModel = models[lastSelected];
						models[lastSelected] = models[0];
						models[0] = tmpModel;
					}
					lastSelected++;
					if (lastSelected > boxes.length - 1) {
						lastSelected = 0;
					}
				}
				
				redrawRooster();
			}
			
			// Update
			if (selectedModel.iq != iqS.getSliderValueRound()) { // Needed tp update on changing slider with mouse
				selectedModel.iq = iqS.getSliderValueRound();
			}
			targetCam.setTargetTo(selectedModel, selectedModel.camSequence);
			targetCam.updateFrame();
			for each (var box:BimboSetupBox in boxes) {
				box.update();
			}
			
			moveBoxesTo( -scroller.getSliderValueRound(), 0);
		}
		
		override public function begin():void {
			super.begin();
			load();
			redrawRooster();
		}
		
		private function select(model:BimboModel):void {
			selectedModel = model;
			iqS.sliderFraction = (model.iq - 30) / 150;
			bioNameF.callbacks[0] = model.getName;
			bioIqF.callbacks[0] = model.getIqString;
			bioF.callbacks[0] = model.getBio;
			
			lastSelected = models.indexOf(model);
		}
		
		private function back():void {
			save();
			FP.world = LoadingWorld.mainMenuWorld;
		}
		
		private function moveBoxesTo(x:Number, y:Number):void {
			for each (var box:BimboSetupBox in boxes) {
				if (box != null) box.moveTo(box.startX + x, box.startY+y);
			}
		}
		
		private function _getScrollMax():Number {
			return Math.abs(sw - 300 - 200 * models.length);
		}
		
		private function _getScrollMin():Number {
			return 0;
		}		
		
		/** Clears the savefile and rewrites it from current data.*/
		private function save():void {
			Data.load("bhp_save");
			Data.writeInt("numberOfModels", 0); //Clear
			Data.save("bhp_save");
			for each (var model:BimboModel in models) {
				addModel(model);
			}
			Data.writeInt("iq", iq);
			Data.writeInt("money", money);
			Data.writeInt("lastSelected", lastSelected);
			Data.writeInt("scroller", scroller.sliderFraction * 1000);
			Data.save("bhp_save");
		}
		
		/**Adds a model to the trophy room savegame.*/
		public static function addModel(model:BimboModel):void {
			Data.load("bhp_save");
			var numberOfModels:int = Data.readInt("numberOfModels", 0);
			Data.writeInt("numberOfModels",  numberOfModels + 1);
			Data.writeInt("p" + numberOfModels + "type", model.typeId);
			Data.writeInt("p" + numberOfModels + "iq", model.iq);
			Data.writeInt("p" + numberOfModels + "money", model.money);
			Data.writeInt("p" + numberOfModels + "lust", model.lust);
			Data.save("bhp_save");
		}
		
		/**Adds players current stats to the trophy savegame.*/
		public static function finishGame(player:BimboModel):void {
			Data.load("bhp_save");
			Data.writeInt("money", Data.readInt("money", 0) + player.money);
			Data.writeInt("iq", Data.readInt("iq", 0) + (player.iq - 100));
			Data.save("bhp_save");
		}
		
		private function load():void {
			Data.load("bhp_save");
			
			models = new Vector.<BimboModel>();
			var numberOfModels:int = Data.readInt("numberOfModels", 0);
			
			for (var i:int = 0; i < numberOfModels; i++) {
				var type:int = Data.readInt("p" + i + "type", 0);
				
				var model:BimboModel = BimboModel.getBimboModelByType(type);
				model.iq = Data.readInt("p" + i + "iq", 100);
				model.money = Data.readInt("p" + i + "money", 100);
				model.lust = (Data.readInt("p" + i + "lust", 0) / 100);
				if (!models.some(function(m:BimboModel, index:int, vector:Vector.<BimboModel>) : Boolean { if (m.typeId == model.typeId) { return true; } else { return false; } } )) {
					models.push(model);
				}
			}
			money = Data.readInt("money", 0);
			iq = Data.readInt("iq", 0);
			lastSelected = Data.readInt("lastSelected", 0);
			scroller.sliderFraction = Data.readInt("scroller", 0) / 1000.0;
		}
		
		private function settings():void
		{
			save();
			LoadingWorld.settingsWorld.setReturnWorld(this);
			FP.world = LoadingWorld.settingsWorld;
		}
		
	}

}