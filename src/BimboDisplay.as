package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ui.skins.milk.MilkButton;
	import ui.skins.milk.MilkTextField;
	import ui.skins.milk.ChatTextField;
	import ui.skins.milk.PokerSelectButton;
	import ui.skins.milk.PokerSliderTextField;
	import ui2.basic.BasicTextField;
	import ui2.Component;
	import ui2.ComponentList;
	import worlds.PokerWorld;
	import worlds.LoadingWorld;

	public class BimboDisplay{

		private var bimbo:Bimbo;
		private var world:worlds.PokerWorld;
		private var portrait:WomanCam;
		private var nameF:BasicTextField;
		//private var chatF:ChatTextField;
		private var iqF:BasicTextField;
		private var moneyF:BasicTextField;
		private var lustF:PokerSliderTextField;
		public var portraitB:PokerSelectButton;
		private var blindF:BasicTextField;
		public var winHandF:BasicTextField; //Displays what kind of hand player won with
		//private var handStrengthF:MilkTextField;
		//private var rateOfReturnF:MilkTextField;
		public var x:Number;
		public var y:Number;
		public var w:Number;
		public var h:Number;
		public var fieldWidth:Number;
		private var componentList:ComponentList;

		private var sprite:Sprite;
		private var g:Graphics;

		//Current player colors
		public static var cTopColor:uint = 0x114488;
		public static var cBorderColor:uint = 0xffd700;
		public static var cGlowColor2:uint = 0x000000;

		//Not Current colors (should be same as normal colors in textfield/button skin class.
		public static var ncTopColor:uint = 0x226622;
		public static var ncBorderColor:uint = 0xdaa520;
		public static var ncGlowColor2:uint = 0x000000;

		//Disabled colors
		public static var dTopColor:uint = 0x324B31;
		public static var dBorderColor:uint = 0x616d4b;
		public static var dGlowColor2:uint = 0x000000;

		//Selected Player colors
		public static var spBorderColor:uint = 0xffffff;

		//Other colors
		private const noChange:uint = 0x012345;

		//Values
		private var chatFieldX:Number;
		private var chatFieldY:Number;
		private var chatFieldWidth:Number;



		public function BimboDisplay(world:worlds.PokerWorld)
		{
			this.world = world;

			sprite = new Sprite;
			g = sprite.graphics;
		}

		public function init(bimbo:Bimbo):void {
			this.bimbo = bimbo;
			x = bimbo.x;
			y = bimbo.y;
			w = bimbo.portraitTargetWidth;
			fieldWidth = 240;

			//h = bimbo.camSequence.frameHeight * (w / bimbo.camSequence.frameWidth);
			bimbo.hand.pos.x = x + w + fieldWidth;
			bimbo.hand.pos.y = y + w - CardEntity.cardHeight * PokerWorld.cardScale;

			chatFieldWidth = 150; //Height is set automatically depending on textLength.
			chatFieldX = x - chatFieldWidth;
			chatFieldY = y;

			portrait = new WomanCam(bimbo.model, bimbo.model.portraitSequence, x, y, w);
			world.add(portrait);

			nameF = new BasicTextField(x + w, y, fieldWidth, 40, {text:"<var0>", fontsize:18, callbacks:[bimbo.getName]});
			nameF.add(world);

			portraitB = new PokerSelectButton(x, y, "", w, w, world.setSelectedBimbo, 16, bimbo, 1, world.selectButtonGroup);
			world.add(portraitB);

			iqF = new BasicTextField(x + w, y + 40, fieldWidth/2, 40, {text:"<var0> IQ", fontsize:18, callbacks:[bimbo.getIqRound]});
			iqF.add(world);

			moneyF = new BasicTextField(x + w + fieldWidth/2, y + 40, fieldWidth/2, 40, {text:"$<var0>", fontsize:18, callbacks:[bimbo.getMoneyRound]});
			moneyF.add(world);

			lustF = new PokerSliderTextField(x + w, y + 80, "Lust: ", " %", fieldWidth, 40, 16, bimbo.getLustFValue, null, 100);
			world.add(lustF);

			blindF = new BasicTextField(x, y + w, 101, 50, {text:"", fontsize:14});
			blindF.add(world);

			winHandF = new BasicTextField(bimbo.hand.pos.x, y + CardEntity.cardHeight * PokerWorld.cardScale, CardEntity.cardWidth * PokerWorld.cardScale + PokerWorld.cardHandOffset, 50, { text:"", fontsize:14 } );
			winHandF.add(world);
			winHandF.changeState(Component.INVISIBLE);

			/*handStrengthF = new MilkTextField(x + w, y + 120, "HS: ", "", fieldWidth * (1 / 2), 25, 14, bimbo.getHandStrengthString);
			if (world.devmode){
				world.add(handStrengthF);
			}

			rateOfReturnF = new MilkTextField(x + w + fieldWidth / 2, y + 120, "RR: ", "", fieldWidth * (1 / 2), 25, 14, bimbo.getRateOfReturnRound);
			if (world.devmode) {
				world.add(rateOfReturnF);
			}*/

			componentList = new ComponentList([nameF, iqF, moneyF, blindF]);

		}

		public function update():void {
			portrait.updateFrame();

			//CURRENT PLAYER ACTIONS
			if (bimbo.hasFolded) {
				componentList.setColor(dTopColor, 0x000001, dGlowColor2, dBorderColor);
				//colorChangeMilkTextField(nameF, dTopColor, dBorderColor, dGlowColor2);
				//colorChangeMilkTextField(iqF, dTopColor, dBorderColor, dGlowColor2);
				//colorChangeMilkTextField(moneyF, dTopColor, dBorderColor, dGlowColor2);
				colorChangePokerSliderTextField(lustF, dTopColor, dBorderColor, dGlowColor2);
				//colorChangeMilkTextField(blindF, dTopColor, dBorderColor, dGlowColor2);
				//colorChangeMilkTextField(handStrengthF, dTopColor, dBorderColor, dGlowColor2);
				//colorChangeMilkTransparentButton(portraitB, dTopColor, dBorderColor, dGlowColor2);
			} else if (bimbo.isCurrentPlayer) {
				componentList.setColor(cTopColor, 0x000001, cGlowColor2, cBorderColor);
				//colorChangeMilkTextField(nameF, cTopColor, cBorderColor, cGlowColor2);
				//colorChangeMilkTextField(iqF, cTopColor, cBorderColor, cGlowColor2);
				//colorChangeMilkTextField(moneyF, cTopColor, cBorderColor, cGlowColor2);
				colorChangePokerSliderTextField(lustF, cTopColor, cBorderColor, cGlowColor2);
				//colorChangeMilkTextField(blindF, cTopColor, cBorderColor, cGlowColor2);
				//colorChangeMilkTransparentButton(portraitB, cTopColor, cBorderColor, cGlowColor2);
			} else {
				componentList.setColor(ncTopColor, 0x000001, ncGlowColor2, ncBorderColor);
				//colorChangeMilkTextField(nameF, ncTopColor, ncBorderColor, ncGlowColor2);
				//colorChangeMilkTextField(iqF, ncTopColor, ncBorderColor, ncGlowColor2);
				//colorChangeMilkTextField(moneyF, ncTopColor, ncBorderColor, ncGlowColor2);
				colorChangePokerSliderTextField(lustF, ncTopColor, ncBorderColor, ncGlowColor2);
				//colorChangeMilkTextField(blindF, ncTopColor, ncBorderColor, ncGlowColor2);
				//colorChangeMilkTextField(handStrengthF, ncTopColor, ncBorderColor, ncGlowColor2);
				//colorChangeMilkTransparentButton(portraitB, ncTopColor, ncBorderColor, ncGlowColor2);
			}

			//BUTTON AND BLIND ACTIONS
			if (bimbo.isBigBlind) {
				blindF.setText("BB: $" + Math.round(world.bigBlind));
				blindF.changeState(ui2.Component.NORMAL);
			} else if (bimbo.isSmallBlind) {
				blindF.setText("SB: $" + Math.round(world.bigBlind/2));
				blindF.changeState(ui2.Component.NORMAL);
			} else {
				blindF.changeState(ui2.Component.INVISIBLE);
				blindF.setText("");
			}

			/* Removed button from displaying.
			 *
			 * else if (bimbo.isButton) {
				blindF.setText("Button");
				blindF.changeState(ui2.Component.NORMAL);*/

			//SELECTED PLAYER ACTIONS
			if (world.getSelectedBimbo() == bimbo) {
				//colorChangeMilkTransparentButton(portraitB, noChange, spBorderColor, noChange);
			}
		}

		private var chatQueue:Array = new Array();
		/**Displays a message in a chat box for a number of seconds. Messages are queued up and displayed after eachother.
		 *
		 * Note that updateChatQueue MUST be run often (probably in the main update) for this to work properly.*/
		public function say(string:String, displayTimeInSeconds:Number = 3):void {
			var showTime:Number = 0;
			if (chatQueue.length > 0) {
				showTime = chatQueue[chatQueue.length - 1]["showTime"] + chatQueue[chatQueue.length - 1]["displayTime"] + 0.75;
			} else {
				showTime = world.runtime;
			}
			var chatF:ChatTextField = new ChatTextField(chatFieldX, chatFieldY, string, "", chatFieldWidth, 16);
			chatQueue.push( { field:chatF, displayTime:displayTimeInSeconds, showTime:showTime } );
		}

		/**This method should be run every update. It updates the chatQueue and displays chat messages with proper timing.*/
		private var showHeight:Number = 0;
		//private var showedNow:Array; //To be added to allow chat messages to slide up when the previous one is gone.
		public function updateChatQueue():void {
			if (chatQueue.length > 0) {
				if (world.runtime > chatQueue[0]["showTime"]) {
					var chatF:ChatTextField = chatQueue[0]["field"];
					chatF.y += showHeight;
					showHeight += chatF.height;

					chatF.disabledSmooth(true, 0.0);
					world.add(chatF);
					chatF.disabledSmooth(false, 1.0 * Math.min(1, LoadingWorld.settingsWorld.chatDelayMult));
					worlds.PokerWorld.delay(chatF.disabledSmooth, [true, 1.0 * LoadingWorld.settingsWorld.chatDelayMult], chatQueue[0]["displayTime"]*1000);
					worlds.PokerWorld.delay(_removeShowHeight, [chatF.height], chatQueue[0]["displayTime"]*1000 + 1000);
					worlds.PokerWorld.delay(world.remove, [chatF], chatQueue[0]["displayTime"] * 1000 + 1000);
					chatQueue.shift();
				}
			}
		}

		private function _removeShowHeight(value:Number):void {
			showHeight -= value;
		}

		public function useBigChat(bool:Boolean):void {
			if (bool) {
				world.remove(blindF);
				blindF = new BasicTextField(x + 4, y + 4, 120, 25, {text:"", fontsize:14});
				blindF.add(world);

				world.remove(winHandF);
				winHandF = new BasicTextField(bimbo.hand.pos.x + bimbo.getDisplayFieldWidth() * (2.0/3.0), y + CardEntity.cardHeight * PokerWorld.cardScale - 50, CardEntity.cardWidth * PokerWorld.cardScale + PokerWorld.cardHandOffset, 50, { text:"", fontsize:14 } );
				winHandF.add(world);
				winHandF.changeState(Component.INVISIBLE);

				chatFieldWidth = 400; //Height is set automatically depending on textLength.
				bimbo.hand.pos.x = x + w + chatFieldWidth;
				chatFieldX = x + w;
				chatFieldY = y + 120;
				/*world.remove(handStrengthF);
				handStrengthF = new MilkTextField(x + w + fieldWidth, y - 25, "HS: ", "", fieldWidth * (3 / 3), 25, 14, bimbo.getHandStrengthString);
				if (world.devmode) {
					world.add(handStrengthF);
				}*/
			} else {
				chatFieldWidth = 150; //Height is set automatically depending on textLength.
				chatFieldX = x - chatFieldWidth;
				chatFieldY = y;
				bimbo.hand.pos.x = x + w + fieldWidth;
			}
		}

		/*Quick function for changing multiple color values. Note that one color (0x012345) is the noChange color, indicating that no change should be made.
		 * Thus this color can not be changed to. Please just an adjacent color insted (ex: 0x012346)*/
		private function colorChangeMilkTextField(tf:MilkTextField, topColor:uint = noChange, borderColor:uint = noChange, glowColor2:uint = noChange):void {
			if (topColor != noChange) {
				tf.topColor = topColor;
			}
			if (borderColor != noChange) {
				tf.borderColor = borderColor;
				tf.borderColorN = borderColor;
			}
			if (glowColor2 != noChange) {
				tf.glowColor2 = glowColor2;
			}
			tf.updateGraphic();
		}

		/*Quick function for changing multiple color values. Note that one color (0x012345) is the noChange color, indicating that no change should be made.
		 * Thus this color can not be changed to. Please just an adjacent color instead (ex: 0x012346)*/
		private function colorChangePokerSliderTextField(tf:PokerSliderTextField, topColor:uint = noChange, borderColor:uint = noChange, glowColor2:uint = noChange):void {
			if (topColor != noChange) {
				tf.topColor = topColor;
			}
			if (borderColor != noChange) {
				tf.borderColor = borderColor;
				tf.borderColorN = borderColor;
			}
			if (glowColor2 != noChange) {
				tf.glowColor2 = glowColor2;
			}
		}

		/*Quick function for changing multiple color values. Note that one color (0x012345) is the noChange color, indicating that no change should be made.
		 * Thus this color can not be changed to. Please just an adjacent color insted (ex: 0x012346)*/
		private function colorChangeMilkTransparentButton(tf:PokerSelectButton, topColor:uint = noChange, borderColor:uint = noChange, glowColor2:uint = noChange):void {
			if (topColor != noChange) {
				tf.topColor = topColor;
			}
			if (borderColor != noChange) {
				tf.borderColor = borderColor;
				tf.borderColorN = borderColor;
			}
			if (glowColor2 != noChange) {
				tf.glowColor2 = glowColor2;
			}
		}

	}

}
