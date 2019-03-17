package worlds 
{
	import bimbos.Chastity;
	import bimbos.Random;
	import bimbos.Rebecca;
	import bimbos.Salvatore;
	import bimbos.Kristyna;
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import ui.RadioButtonGroup;
	import ui.skins.player.PlayerButton;
	import ui.Slider;
	import com.greensock.TweenLite;
	import flash.utils.getTimer;
	import ui.SelectButtonGroup;
	import Poker;
	import flash.utils.setTimeout;
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.Backdrop;
	import ui2.basic.BasicButton;
	import ui2.basic.BasicSlider;
	import ui2.basic.BasicTextField;
	import ui2.Component;
	import ui.skins.milk.PokerSelectButton;
	import ui.skins.milk.MilkButton;
	import ui.skins.milk.MilkTextField;
	import ui2.ComponentList;
	
	public class PokerWorld extends World
	{		
		private var deck:Deck;
		public var players:Array;
		private var communityCards:CardHand;	
		private var cardsToDeal:Array = [];
		private var timeSinceLastDeal:Number = 1;
		private var selectedBimbo:Bimbo;
		private var paused:Boolean = false;
		public var runtime:Number = 0;
		public var targetCam:WomanCam;
		private var targetCamBorder:PokerSelectButton;
		public var selectButtonGroup:SelectButtonGroup;
		private var poker:Poker2;
		
		//Model vars (these would have to be saved and loaded to restore a game at any moment)
		private var pot:Number = 0;
		private var iqPot:Number = 0;
		private var buttonPlayerNr:int = 1;
		private var consequentChecks:int = 0;
		public var currentBet:Number = 0;
		public var betRoundNr:int = 0;
		private var lastRaise:Number = bigBlind;
		private var roundNr:int = 1;
		
		public static var devmode:Boolean = false;
		public static var cheatmode:Boolean = false;
		public static var quickmode:Boolean = false;
		
		private var cheatmodeUsed:Boolean = false;
		
		//Helper variables
		private var currentPlayerNr:int = buttonPlayerNr + 1;
		public var bigBlind:Number = BLIND_START_VALUE;
		private var foldedPlayers:int = 0;
		private var iqPotIsActive:Boolean = false;
		private var outPlayers:int = 0;
		
		//UI
		
		
		public static const sw:Number = FP.screen.width; //Screen Width
		public static const sh:Number = FP.screen.height; //Screen Height
		
		private const deckLocation:Point = new Point(550, 160);
		private const potX:Number = 425;
		private const potY:Number = 50;
		
		public static const cardScale:Number = 0.53; // 0.53 is the default value in cardentity. PokerWorld doesn't actually place this value in constructors.
		private static const cardHeight:Number = CardEntity.cardHeight*cardScale;
		private static const cardWidth:Number = CardEntity.cardWidth*cardScale
		public static const cardHandOffset:Number = (cardWidth/4);
		
		private const dealHeight:Number = sh / 2 + cardHeight / 2;
		private const buttonWidth:Number = cardWidth;
		
		private var chipImages:Vector.<Image> = new Vector.<Image>;
		
		private var backB:BasicButton;
		private var iqPotF:BasicTextField;
		private var devmodeF:ui.skins.milk.MilkTextField;
		private var cheatmodeF:ui.skins.milk.MilkTextField;
		private var quickmodeB:BasicButton;
		private var quickmodeF:BasicTextField;
		public var deckEntity:CardEntity;
		
		//Constants
		private var IQ_AMOUNT:Number = 1; //How much IQ you can buy per turn
		private var IQ_PRICE:Number = 200; //How much that much IQ costs
		private var FORCE_SOLD_IQ:Number = 5; //How much IQ you are forced to sell after nullifying debt on buyin.
		private var FORCE_SOLD_MULTIPLIER:Number = 1; //How many times IQ_PRICE you get per IQ on forced buy in.
		private var DEBT_MULTIPLIER:Number = 2; //How many times IQ_PRICE you have to pay per IQ when nullifying debt.
		
		public var STRIPTEASE_COST:Number = 3;
		private var WAIT_TIME_BETWEEN_ROUNDS:Number = 0; //3.5
		private var WAIT_AFTER_SHOWDOWN:Number = 4; //3.5
		private var SMALL_BLIND_WAIT_TIME:Number = 2000; //How long to wait until paying small blind in ms.
		private var BIG_BLIND_WAIT_TIME:Number = 3000; //How long to wait until paying big blind in ms.
		private var DEAL_PER_CARD_DELAY:Number = 0.15; //0.25
		public var BLIND_START_VALUE:Number = 20;
		private var IQ_POT_ACTIVATION_VALUE:Number = 10; //The amount of IQ that needs to be in the iqPot for that pot to come into play.
		
		public var ROUNDS_BETWEEN_BLIND_INCREASE:int = 10;
		
		private var MASTERTF_EASTER_EGG:String = "Master-TF";
		private var ACTIVATE_DEVMODE_STRING:String = "devmode";
		private var TOGGLE_CHEATMODE_STRING:String = "cheatmode";
		private var MONEY_CHEAT:String = "money_cheat";
		
		/*TODO 
		 * 
		 * limit the amount of times the AI will raise on hole cards
		 * the first ai will always fold if there's no iq pot (make so that first ai decided more base on hand strength, not so much on rate of return)
		 * the ai should raise with as much as is needed so that they won't raise again, i.e. so that rate of return is less than what makes them likely to raise
		 * stop game from progressing if chat text has fallen behind
		 * 
		 * Fix commuity cards sometimes not being dealt?
		 * 
		*/
		public function PokerWorld(loadList:Vector.<BimboModel> = null, loadData:Boolean = false, blindStartValue:Number = 20) 
		{
			//System Setup
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			Input.define("q", Key.Q);
			Input.define("a", Key.A);
			
			this.BLIND_START_VALUE = blindStartValue;
			var vector:Vector.<int> = new Vector.<int>();
			vector.push(3, 1, 1, 1);
			poker = new Poker2();
			poker.init();
			//trace("Handstrength: " + poker2.getHandStrength(Vector.<int>([1,2]), Vector.<int>([8,25,30,47]), 4, 1000));
			//trace(poker.genAllHoleStrengthsString());
			//paused = true;
			
			backB = new BasicButton(sw-200, sh-LoadingWorld.backBH, 200, LoadingWorld.backBH, { text:"Back to main menu", callbacks:[back], fontsize:16 }, 1 ); //Added further down
			devmodeF = new MilkTextField(300, 130, "Devmode on", "", 125, 30, 14);
			devmodeF.setInvisible(!devmode);
			add(devmodeF);
			cheatmodeF = new MilkTextField(300, 130, "Cheatmode on", "", 125, 30, 14);
			cheatmodeF.setInvisible(!cheatmode);
			add(cheatmodeF);
			quickmodeF = new BasicTextField(375, 100, 50, 30, { text: "Off" } );
			quickmodeF.add(this);
			quickmodeB = new BasicButton(300, 100, 75, 30, { text:"Quick", callbacks: [
				function() : void { 
					quickmode = !quickmode;
					if (quickmode) {
						quickmodeF.setText("On");
						quickmodeF.updateGraphic();
					} else {
						quickmodeF.setText("Off");
						quickmodeF.updateGraphic();
					}
			} ] }, 1 );
			quickmodeB.add(this);
			
			var thisWorld:World = this;
			new BasicButton(sw-100, sh-LoadingWorld.backBH*2, 100, LoadingWorld.backBH, { text:"Settings", callbacks: [
				function() : void { 
					LoadingWorld.settingsWorld.setReturnWorld(thisWorld);
					FP.world = LoadingWorld.settingsWorld;
				}
			] }, 1 ).add(this);
			
			//Game Logic and Field Setup
			deck = new Deck();
			deck.shuffle();
			
			
			/*deck.putCardOnTop(0);
			deck.putCardOnTop(24);
			deck.putCardOnTop(4);
			deck.putCardOnTop(3);
			deck.putCardOnTop(2);
			deck.putCardOnTop(31);
			deck.putCardOnTop(1);
			deck.putCardOnTop(30);
			deck.putCardOnTop(0);*/
			
			deckEntity = new CardEntity(52, deckLocation.x, deckLocation.y, true, cardScale);
			add(deckEntity);
			new BasicTextField(potX, potY, 125, 50, {text:"Pot: $<var0>", fontsize:16, callbacks:[getPotRound]}).add(this); //Amount in pot field
			iqPotF = new BasicTextField(potX-125, potY, 125, 50, {text:"IQ Pot: <var0>/10", fontsize:16, callbacks:[getIqPotRound]}); //Amount in IQ pot field
			new BasicTextField(potX, potY - 50, 125, 50, {text:"Bet: $<var0>", fontsize:16, callbacks:[getBetRound]}).add(this); //Bet this round field
			new BasicTextField(potX - 125, potY - 50, 125, 50, {text:"Round <var0>", fontsize:16, callbacks:[getRoundNr]}).add(this); //Round Nr Field
			
			iqPotF.changeState(Component.DISABLED);
			iqPotF.add(this);
			
			selectButtonGroup = new SelectButtonGroup()
			
			communityCards = new CardHand(deckLocation.x - cardHandOffset*2, deckLocation.y + cardHeight);
			
			Bimbo.idCounter = 0;
			
			if (loadData) {
				load();
			
			//No models on loadList can be the same type if it's not -1 (the Random model)
			} else if (loadList != null){
				players = new Array();
				for (var i:int = 0; i < loadList.length; i++) {
					if (loadList[i] != null) {
						if (loadList[i].typeId == -1) {
							var rand:BimboModel;
							rand = getRandomBimboModel(loadList);
							if (i == 0) {
								players.push(new Bimbo(rand, this, false));
							} else {
								players.push(new Bimbo(rand, this, true));
							}
							loadList[i] = rand;
						} else if (i == 0) {
							players.push(new Bimbo(BimboModel.getCopy(loadList[i]), this, false));
						} else {
							players.push(new Bimbo(BimboModel.getCopy(loadList[i]), this, true));
						}
					}
				}
			}else {
				players = new Array(
				new Bimbo(new Kristyna(), this, false),
				new Bimbo(new Salvatore(), this, true),
				new Bimbo(new Chastity(), this, true),
				new Bimbo(new Rebecca(), this, true),
				new Bimbo(new Salvatore(), this, true));
			}
			bigBlind = getBlindForRound(roundNr);
			selectedBimbo = players[0];
			players[0].useBigChat(true);
			roundEndChecks();
				
			var mh:Number = FP.screen.height / 2 - 25; //Middle Height
			
			chipImages.push(new Image(Assets.CHIP_GREEN_WHITE_BORDER));
			chipImages.push(new Image(Assets.CHIP_RED_WHITE_BORDER));
			chipImages.push(new Image(Assets.CHIP_BLUE_WHITE_BORDER));
			chipImages.push(new Image(Assets.CHIP_BLACK_WHITE_BORDER));
			chipImages.push(new Image(Assets.CHIP_WHITE_BLUE_BORDER));
			for each (var chipImage:Image in chipImages) {
				chipImage.scale = 0.5;
			}
			
			targetCam = new WomanCam(selectedBimbo.model, selectedBimbo.model.camSequence, 0, 0, 300);
			add(targetCam);
			targetCamBorder = new PokerSelectButton(0, 0, "", 300, 500);
			targetCamBorder.disabled(true);
			add(targetCamBorder);
			
			for each (var player:Bimbo in players) {
				selectButtonGroup.add(player.getSelectButton());
				player.update();
			}
			
			add(backB);
			
			//nextRound();
			startRound();
			
			reset();
		}
		
		private function reset():void
		{
			
		}
		
		private function quit():void
		{
		}
		
		private function deal(woman:Bimbo, cardAmount:int, nrOfHidden:int = 0):void {
			if (woman.isOut == false) {
				for (var i:int = 0; i < nrOfHidden; i++) {
					giveCardFromDeck(woman.hand, deck, true);
				}
				for (i = 0; i < cardAmount-nrOfHidden; i++) {
					giveCardFromDeck(woman.hand, deck, false);
				}
			}
			
		}
		
		private var gameOver:Boolean = false;
		private var winAiWindow:ComponentList;
		private function winAi(winner:Bimbo):void {
			var winM:String = "<sLarge><cBC>Congratulations to " + winner.getName() + "!</cBC></sLarge><sMedium>\nThey have won!</sMedium>" +
							"\n\n For the rest of you, you will all have to stay here to pay off your debts!" + 
							"\n\nThat is, unless you are very lucky! You see, if you behave really nicely and " + winner.getName() +
							" thinks you look pretty, they might nullify your debts and bring you home with them instead!";
			winAiWindow = new ComponentList();
			winAiWindow.addComponent(new BasicTextField(300, 0, 548, 250, { text:winM, fontsize:14 } ));
			winAiWindow.addComponent(new BasicButton(300, 250, 548, 50, { text:"Submit to your new life", callbacks:[submitDefeat] }, 1 ));
			
			winAiWindow.add(this, 0.5);
		}
		
		private function submitDefeat():void {
			FP.world = new DefeatSubmitWorld(players[0].model);
		}
		
		private var loseHumanWindow:ComponentList;
		private var loseHumanSkipB:BasicButton;
		private function loseHuman(loser:Bimbo):void {
			pause();
			var loseM:String = "<sLarge><cBC>You have lost!</cBC></sLarge><sMedium>\nWelcome to your new life, " + loser.getName() +"!</sMedium>" +
							"\n\n As you won't understand much from now on anyways, there really is no reason for us to explain any of this to you." +
							" So you just sit there like a good girl and wait until one of the smart people win, and you will see!";
			loseHumanWindow = new ComponentList();
			loseHumanWindow.addComponent(new BasicTextField(300, 0, 548, 250, {text:loseM, fontsize:14}));
			loseHumanWindow.addComponent(new BasicButton( 300, 250, 275, 50, {text:"Skip", callbacks: [lostSkip], params:[[true]]}, 1));
			loseHumanWindow.addComponent(new BasicButton( 575, 250, 273, 50, {text:"Watch the game", callbacks: [lostSkip], params:[[false]]}, 1));
			
			loseHumanWindow.add(this, 0.5);
			
			
		}
		
		/** True will skip the rest of the game. False will let you watch the rest of the game.*/
		private function lostSkip(bool:Boolean):void {
			pause();
			if (bool) {
				var winner:Bimbo = getPlayer(getNearestNonOutPlayerNrAfter(int(Math.random()*players.length)));
				var winnableIq:Number = 0;
				for each (var bimbo:Bimbo in players) {
					if (!bimbo.isOut && bimbo != winner) {
						winnableIq += (bimbo.iq - 30);
					}
				}
				winnableIq *= 0.8;
				winner.iq = winner.iq + winnableIq;
				for each (var player:Bimbo in players) {
					if (player != winner) {
						player.iq = 30;
						player.isOut = true;
					}
					player.update();
				}
				
				
				delay(winAi, [winner], 500);
			} else {
				unpause();
				cardsToDeal = [];
				startRound();
				loseHumanSkipB = new BasicButton( sw - 300, sh - 30, 100, 30, { text:"Skip", callbacks: [lostSkipForButton] }, 1);
				loseHumanSkipB.add(this, 0.5);
			}
			
			loseHumanWindow.remove(0.5);
		}
		
		private function lostSkipForButton():void {
			lostSkip(true);
			loseHumanSkipB.remove(0.5);
		}
		
		private var winHumanWindow:ComponentList;
		private function winHuman(winner:Bimbo):void {
			var winM:String = "<sLarge><cBC>Congratulations " + winner.getName() + "!</cBC></sLarge><sMedium>\nYou have won!</sMedium>" +
							"\n\nYou can keep all your winnings, or pick up on one of our special winners-only offers below!";
			var winIqM:String = "<sMedium><cBC>Intelligence Enhancements</cBC></sMedium>\n\nFeeling a bit ditzy after the game? For cash, our facilities will quickly increase your IQ!";
			var winGirlM:String = "<sMedium><cBC>Bring her home!</cBC></sMedium>\n\nTake one of the girls home! They won't mind, and for cash, we won't either!" +
								"\n\n Just tell us which one you like the best and we will set you up!";
			var iqMin:Function = function () : Number { return 0; };
			var iqMax:Function = function () : Number { 
				var maxIq:Number = 180 - winner.iq;
				var maxIqMoney:Number = winner.money / IQ_PRICE;
				if (maxIqMoney < maxIq) maxIq = maxIqMoney;
				if (maxIq > 0) { return maxIq; } else {return 0} };
			var iqInterval:Function = function () : Number { return 1; };
			winHumanWindow = new ComponentList();
			winHumanWindow.addComponent(new BasicTextField(300, 0, 548, 125, {text:winM, fontsize:14}));
			winHumanWindow.addComponent(new BasicTextField(300, 125, 275, 125, { text:winIqM, fontsize:14 } ));
			winHumanWindow.addComponent(new BasicTextField(575, 125, 273, 175, { text:winGirlM }));
			var winIqS:BasicSlider = new BasicSlider( 300 + 75, 250, 200, 50, {text:"<var0> IQ for $<var1>", minCallback:iqMin, maxCallback:iqMax, intervalCallback:iqInterval});
			winIqS.addCallback(function() : Number { return Math.round(getBuyIqPrice() * winIqS.getSliderValue()); } );
			winIqS.sliderFraction = 0.5;
			winHumanWindow.addComponent(winIqS);
			var buyIqWin:Function = function (bimbo:Bimbo, func:Function) : void {
				if (bimbo.money >= winIqS.getSliderValue() * IQ_PRICE) {
					bimbo.money -= winIqS.getSliderValue() * IQ_PRICE;
					payBimboIq(bimbo, func());
				}
			};
			winHumanWindow.addComponent(new BasicButton( 300, 250, 75, 50, { text:"Buy", callbacks:[buyIqWin], params:[[winner, winIqS.getSliderValue]] }, 1 ));
			
			var getHomeCost:Function = function () : Number {return 10000; };
			for (var i:int = 1; i < players.length; i++) {
				winHumanWindow.addComponent(new BasicButton(players[i].x + 340, players[i].y, cardWidth + cardHandOffset, 120,
					{text:"Bring her home!\n\n$<var0>", callbacks:[bringHerHome, getHomeCost], params:[[winner, players[i], getHomeCost()]]}, 1));
			}
			
			winHumanWindow.addComponent(new BasicButton(300, 300, 548, 50, { text:"Done! To the trophy room!", callbacks:[toTheTrophyRoom] }, 1));
			
			winHumanWindow.add(this, 0.2);
			
		}
		
		private function toTheTrophyRoom():void {
			if (!cheatmodeUsed) TrophyWorld.finishGame(players[0].model); //Only save IQ and money if cheatmode was not used.
			Data.clear("saved_gamestate");
			FP.world = new TrophyWorld();
		}
		
		private function bringHerHome(winner:Bimbo, bimbo:Bimbo, cost:Number):void {
			if (winner.money >= cost) {
				winner.money -= cost;
				var field:BasicTextField = new BasicTextField(bimbo.x + 100, bimbo.y, 240, 120, { text: "<var0> will be waiting for you!", callbacks:[bimbo.getName] } );
				field.add(this, 0.1);
				winHumanWindow.addComponent(field);
				TrophyWorld.addModel(bimbo.model);
				Data.clear("saved_gamestate");
			} else {
				new BasicTextField(bimbo.x+100, bimbo.y, 240, 120, { text: "You can't afford that!" } ).popup(this, 1.5, 0.1, 0.2);
			}
			
		}
		
		//GAME MOVES
		
		public function check(bimbo:Bimbo):void
		{
			if (getPlayer(currentPlayerNr) == bimbo) {
				if (getCheckAmount(bimbo) < 0.5) {
					bimbo.speak(bimbo.model.CHECKING);
				} else {
					bimbo.speak(bimbo.model.CALLING);
				}
				
				giveMoneyToPot(bimbo, getCheckAmountRound(bimbo));
				consequentChecks++;
				turnToNext();
			}
		}
		
		public function raise(bimbo:Bimbo, value:Number):void
		{
			if (getPlayer(currentPlayerNr) == bimbo && getPlayer(currentPlayerNr).money >= value && value >= getMinRaiseAmount(bimbo)) {
				bimbo.speak(bimbo.model.RAISING, Math.round(value));
				consequentChecks = 1;
				lastRaise = value-getCheckAmount(bimbo);
				currentBet += value-getCheckAmount(bimbo);
				
				giveMoneyToPot(bimbo, value);
				turnToNext();
			} else {
				trace("ILLEGAL RAISE");
			}
		}
		
		public function fold(bimbo:Bimbo):void
		{
			if (getPlayer(currentPlayerNr) == bimbo) {
				bimbo.speak(bimbo.model.FOLDING);
				getPlayer(currentPlayerNr).setHasFolded(true);
				foldedPlayers += 1;
				bimbo.update();
				turnToNext();
			}
		}
		
		/**The user raises targets lust*/
		public function fondle(bimbo:Bimbo, target:Bimbo):void {
			if (getPlayer(currentPlayerNr) == bimbo) {
				if (bimbo == target) {
					bimbo.speak(bimbo.model.FONDLING_SELF);
					
					bimbo.addLust(bimbo.getBimboFactor() * 1);
				} else {
					bimbo.speak(bimbo.model.FONDLING, target.getShortName());
					
					target.addLust((bimbo.getBimboFactor() - 0.2) * 3 );
					bimbo.addLust(target.getBimboFactor() * 0.6);
				}
				
			}
		}
		
		/**The user raises */
		public function striptease(bimbo:Bimbo):void {
			if (getPlayer(currentPlayerNr) == bimbo) {
				bimbo.speak(bimbo.model.STRIPTEASE);
				iqLoss(bimbo, getStripteaseCost());
				bimbo.lust -= 0.5;
				for each (var target:Bimbo in players) {
					if (target != bimbo && !target.isOut) {
						target.addLust(bimbo.getBimboFactor() * 1.5 + bimbo.getBimboFactor() * bimbo.lust * 2.0);
					}
				}
				
			}
		}
		
		/**The user buys iq for the target*/
		public function bimbofy(bimbo:Bimbo, target:Bimbo):void {
			if (getPlayer(currentPlayerNr) == bimbo) {
				target.speak(bimbo.model.BIMBOFY);
				target.iq -= 9;
				target.update();
			}
		}
		
		/**Lowers lust for the user*/
		public function relax(bimbo:Bimbo, target:Bimbo):void {
			if (getPlayer(currentPlayerNr) == bimbo) {
				bimbo.lust -= 0.2;
				bimbo.speak(bimbo.model.RELAXING);
			}
		}
		
		//GAME LOGIC
		private function goToNextPlayer():void {
			goToNearestPlayerAfter(currentPlayerNr);
		}
		
		/** Sets the current player to the closest one after the playernr given*/
		private function goToNearestPlayerAfter(nr:int):void {
			currentPlayerNr = getNearestNonFoldedPlayerNrAfter(nr);
		}
		
		private function getNearestNonFoldedPlayerNrAfter(nr:int):int {
			var startNr:int = nr;
			while (getPlayer(nr + 1).hasFolded && nr < 102) {
				nr += 1;
			}
			if (nr > 100) {
				trace("Can't find nearest player.");
			}
			return nr + 1;
		}
		
		private function getNearestNonOutPlayerNrAfter(nr:int):int {
			var startNr:int = nr;
			while (getPlayer(nr + 1).isOut && nr < 102) {
				nr += 1;
			}
			if (nr > 100) {
				trace("Can't find nearest player.");
			}
			return nr + 1;
		}
		
		private function turnToNext():void 
		{
			for each (var bimbo:Bimbo in players) {
				bimbo.turnUpdate();
				outPlayer(bimbo);
			}
			goToNextPlayer();
			
			//If enough checks have been done, progress to next part of the round.
			if (consequentChecks == players.length - foldedPlayers && (players.length - foldedPlayers) > 1) {
				if (betRoundNr == 0) {
					giveCardFromDeck(communityCards, deck, false);
					giveCardFromDeck(communityCards, deck, false);
					giveCardFromDeck(communityCards, deck, false);
				}
				else if (betRoundNr == 1) {
					giveCardFromDeck(communityCards, deck, false);
				}
				else if (betRoundNr == 2) {
					giveCardFromDeck(communityCards, deck, false);
				}
				//Showdown! 
				if (betRoundNr == 3) {
					showdown();
				} else {
					goToNearestPlayerAfter(buttonPlayerNr);
					lastRaise = bigBlind;
					consequentChecks = 0;
					betRoundNr++;
				}
			}
			
			//If all but one player has folded, the remaining player win.
			if (foldedPlayers == players.length - 1) {
				for each (var player:Bimbo in players) {
					if (!player.hasFolded) {
						payBimbo(player, pot);
						if (iqPotIsActive) {
							payBimboIq(player, iqPot);
						}
					}
				}
				addNextRoundButton();
				//nextRound();
			}
		}
		
		
		private function nextRound():void {
			buttonPlayerNr = getNearestNonOutPlayerNrAfter(buttonPlayerNr);
			currentPlayerNr = buttonPlayerNr + 1;
			consequentChecks = 0;
			currentBet = 0;
			betRoundNr = 0;
			roundNr += 1;
			bigBlind = getBlindForRound(roundNr);
			lastRaise = bigBlind;
			foldedPlayers = outPlayers;
			resetHand(communityCards);
			
			if (roundNr % ROUNDS_BETWEEN_BLIND_INCREASE == 1) {
				new BasicTextField(potX + 125, 0, 125, 100, { text:"Blinds have been increased!" } ).popup(this, 7, 0.3, 0.3);
			}
			
			
			if (!roundEndChecks()){
				pause(WAIT_TIME_BETWEEN_ROUNDS);
				delay(startRound, null, WAIT_TIME_BETWEEN_ROUNDS * 1000);
				
			}
			
			for each (var player:Bimbo in players) {
				player.display.winHandF.changeState(Component.INVISIBLE, 0.2);
				delay(player.display.winHandF.setText, [""], 300);
			}
		}
		
		private function outPlayer(player:Bimbo):void {
			if (player.iq < 39.5 && player.isOut == false) {
				player.isOut = true;
				outPlayers += 1;
				foldedPlayers += 1;
				if (players[0] == player) {
					loseHuman(player);
				}
				if (player.hasFolded) {
					foldedPlayers -= 1; //foldedPlayers must be correct. This adjusts it if the player had already folded.
				} else {
					player.setHasFolded(true);
				}
			}
		}
		
		/** Checks needed to be performed on round end, but also when starting game for the first time.
		 * 
		 * Returns true or false. This is to be used by nextRound() to determine whether or not it should call startRound(). */
		private function roundEndChecks():Boolean {
			//Reset players
			for each (var player:Bimbo in players) {
				resetHand(player.hand);
				outPlayer(player);
				if (player.isAllIn && player.money < 0.5 && player.isOut == false) {
					buyIn(player);
				}
				player.isAllIn = false;
				player.isButton = false;
				player.isBigBlind = false;
				player.isSmallBlind = false;
				player.betThisRound = 0;
				if (player.isOut) {
					player.hasFolded = true;
				} else {
					player.hasFolded = false;
				}
			}
			
			if (Math.round(iqPot) >= IQ_POT_ACTIVATION_VALUE) {
				iqPotIsActive = true;
				iqPotF.changeState(Component.NORMAL, 1);
			} else {
				iqPotIsActive = false;
				iqPotF.changeState(Component.DISABLED, 1);
			}
			
			if (outPlayers >= players.length - 1) {
				pause();
				gameOver = true;
				//Check for the player that is not out. That player has won. Check their type and win accordingly.
				for each (var player2:Bimbo in players) {
					player2.update();
					if (!player2.isOut && player2.isAiControlled) {
						delay(winAi, [player2], 1000);
					} else if (!player2.isOut && !player2.isAiControlled){
						delay(winHuman, [player2], 1000);
					}
				}
				return true;
			} else {
				return false;
			}
		}
		
		private function startRound():void {
			save();
			deck.reshuffle();
			
			if (!gameOver) {
				
				var hidden:int = 0; 
				//Deal to all players. Small blind gets cards first. Clockwise.
				for (var i:int = buttonPlayerNr + 1; i < players.length + buttonPlayerNr + 1; i++ ) {
					if (getPlayer(i).isAiControlled) {
						hidden = 1;
					} else {
						hidden = 0;
					}
					deal(getPlayer(i), 1, hidden);
				}
				for (var j:int = buttonPlayerNr + 1; j < players.length + buttonPlayerNr + 1; j++ ) {
					if (getPlayer(j).isAiControlled) {
						hidden = 1;
					} else {
						hidden = 0;
					}
					deal(getPlayer(j), 1, hidden);
				}
				unpause();
				if (!paused) {
					
					var smallBlindNr:int = getNearestNonOutPlayerNrAfter(buttonPlayerNr);
					var bigBlindNr:int = getNearestNonOutPlayerNrAfter(smallBlindNr);
					
					getPlayer(buttonPlayerNr).isButton = true;
					getPlayer(smallBlindNr).isSmallBlind = true;
					getPlayer(bigBlindNr).isBigBlind = true;
					
					
					placeBlind(getPlayer(smallBlindNr), bigBlind / 2, SMALL_BLIND_WAIT_TIME);
					placeBlind(getPlayer(bigBlindNr), bigBlind, BIG_BLIND_WAIT_TIME);
					currentPlayerNr = getNearestNonFoldedPlayerNrAfter(bigBlindNr);
					currentBet = bigBlind;
					
					for each (var player:Bimbo in players) {
						//player.update();
						delay(player.update, null, 1); //At the time of writing this, not delaying this update causes the BigBlind text to not appear during the update. Some kind of overload?
					}
				}
			}
		}
		
		private function showdown():void {
			var nonFoldedPlayers:Array = new Array();
			for each (var player:Bimbo in players) {
				if (!player.getHasFolded()) {
					nonFoldedPlayers.push(player);
					hideHand(player.hand, false);
				}
			}
			var winners:Array = poker.getPotWinners(nonFoldedPlayers, communityCards.getList());
			//trace(poker.getHandRank7String(Vector.<int>(Bimbo(winners[0].player).hand.getList().concat(communityCards.getList())))); //TODO Print winning hand in some good way
			//trace(Bimbo(winners[0].player).hand.getList().concat(communityCards.getList()));
			for (var i:int = 0; i < winners.length; i++) {
				payBimbo(winners[i]["player"], pot * winners[i]["potPart"]);
				
				// Print hands
				if (winners[i].potPart > 0) { // Actual winners
					Bimbo(winners[i].player).display.winHandF.setText(
						"<fff>" + 
						poker.getHandRank7String(Vector.<int>(Bimbo(winners[i].player).hand.getList().concat(communityCards.getList())))
					);
					Bimbo(winners[i].player).display.winHandF.changeState(Component.NORMAL, 0.2);
				} else { // Everyone who didn't fold
					Bimbo(winners[i].player).display.winHandF.setText(poker.getHandRank7String(Vector.<int>(Bimbo(winners[i].player).hand.getList().concat(communityCards.getList())))); //Print winning hand
					Bimbo(winners[i].player).display.winHandF.changeState(Component.DISABLED, 0.2);
				}
				
				if (iqPotIsActive) {
					payBimboIq(winners[i]["player"], iqPot * winners[i]["potPart"]);
				}
			}
			addNextRoundButton();
			//delay(nextRound, null, WAIT_AFTER_SHOWDOWN * 1000);
		}
		
		private function addNextRoundButton():void{
			new BasicButton(440, 450, 240, 50, { text:"Next Round", callbacks:[function():void { nextRound() } ] }, 1).addForOneClick(this, 0.1, 0.1);
			pause();
		}
		
		/**Gives money to the pot, lastRaise is set immediately but the money is given after a delay if specified.*/
		private function placeBlind(bimbo:Bimbo, value:Number, delayTime:Number = 0):void {
			//giveMoneyToPot(bimbo, value);
			delay(giveMoneyToPot, [bimbo, value], delayTime);
			lastRaise = value;
		}
		
		private function giveMoneyToPot(bimbo:Bimbo, value:Number):void {
			if (bimbo.isAllIn) {
				payPot(bimbo, value, 0.5);
				bimbo.speak(bimbo.model.ALREADY_ALL_IN);
			} else if (bimbo.money - value >= 0.5) {
				payPot(bimbo, value);
			} else {
				payPot(bimbo, value);
				bimbo.isAllIn = true;
				bimbo.speak(bimbo.model.ALL_IN);
			}
			bimbo.betThisRound += value;
		}
		
		/** Exchanges IQ for money for the specified bimbo*/
		private function buyIn(bimbo:Bimbo):void {
			var iqDebt:Number = Math.abs(bimbo.debt / IQ_PRICE);
			iqLoss(bimbo, iqDebt * DEBT_MULTIPLIER)
			
			iqLoss(bimbo, FORCE_SOLD_IQ);
			payBimboFromCasino(bimbo, IQ_PRICE * FORCE_SOLD_MULTIPLIER * FORCE_SOLD_IQ);
			
			bimbo.speak(bimbo.model.BUY_IN);
			bimbo.update();
		}

		private function restart():void {
			FP.world = new PokerWorld();
		}
		
		//UPDATES
		
		private var devTime:Number = 0;
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
			//Time tracking, necessary for some things. Firstly the chat queue.
			runtime += FP.elapsed;
			
			//Chat queue updating
			for each (var bimbo:Bimbo in players) {
				bimbo.updateChatQueue();
				bimbo.update();
			}
			
			targetCam.setTargetTo(selectedBimbo.model, selectedBimbo.model.camSequence);
			targetCam.updateFrame();
			
			//PAUSABLE
			if (!paused) {
				//Deal loop
				if (cardsToDeal.length > 0 && timeSinceLastDeal > DEAL_PER_CARD_DELAY) {
					var o:Object = cardsToDeal.shift();
					actuallyAddCard(o.hand, o.card, o.hidden);
					timeSinceLastDeal = 0;
				}
				timeSinceLastDeal += FP.elapsed;
				
				//GAME LOGIC LOOP
				
				//Make sure that Bimbos internal state is correct. This is done only when going to a new current or new selected player.
				var curPlayer:Bimbo = getPlayer(currentPlayerNr);
				if (!curPlayer.isCurrentPlayer || !selectedBimbo.isSelected) {
					for each (var player:Bimbo in players) {
						player.isCurrentPlayer = false;
						player.isSelected = false;
					}
					if (curPlayer.money < getMinRaiseAmount(curPlayer)) curPlayer.canRaise = false;
					else curPlayer.canRaise = true;
					
					if (curPlayer.money < IQ_PRICE) curPlayer.canBuyIq = false;
					else curPlayer.canBuyIq = true;
					
					curPlayer.isCurrentPlayer = true;
					selectedBimbo.isSelected = true;
					for each (var player1:Bimbo in players) {
						player1.update();
					}
				}

				//Player updating that should only be done when not dealing and blinds have been paid.
				if (cardsToDeal.length == 0 && pot >= bigBlind + bigBlind/2) {	
					curPlayer.requestMove();
				}
				
			}
			
			//Input loop
			if (Input.pressed(Key.Q) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedBimbo.iq += 50;
				} else {
					selectedBimbo.iq += 5;
				}
				if (cheatmode) cheatmodeUsed = true;
				selectedBimbo.update();
			}
			if (Input.pressed(Key.A) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedBimbo.iq -= 50;
				} else {
					selectedBimbo.iq -= 5;
				}
				if (cheatmode) cheatmodeUsed = true;
				selectedBimbo.update();
			}
			if (Input.pressed(Key.W) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedBimbo.money += 50000;
				} else {
					selectedBimbo.money += 5000;
				}
				if (cheatmode) cheatmodeUsed = true;
				selectedBimbo.update();
			}
			if (Input.pressed(Key.S) && (devmode || cheatmode)) {
				if (Input.check(Key.SHIFT)) {
					selectedBimbo.money -= 50000;
				} else {
					selectedBimbo.money -= 5000;
				}
				if (cheatmode) cheatmodeUsed = true;
				selectedBimbo.update();
			}
			if (Input.pressed(Key.R) && devmode) {
				TrophyWorld.addModel(selectedBimbo.model);
			}
			if (Input.keyString.match(ACTIVATE_DEVMODE_STRING) && Input.check(Key.D) && Input.check(Key.E) && Input.check(Key.V) && runtime - devTime > 0.5) {
				devTime = runtime;
				devmode = !devmode;
				devmodeF.setInvisible(!devmode, 0.15);
			}
			if (Input.keyString.match(TOGGLE_CHEATMODE_STRING) || LoadingWorld.settingsWorld.toggleCheatmode == 1) {
				Input.keyString = Input.keyString.replace(TOGGLE_CHEATMODE_STRING, "");
				LoadingWorld.settingsWorld.setToggleCheatmode(0);
				cheatmode = !cheatmode;
				cheatmodeF.setInvisible(!cheatmode, 0.15);
			}
			if (Input.keyString.match(MASTERTF_EASTER_EGG)) {
				Input.keyString = Input.keyString.replace(MASTERTF_EASTER_EGG, "");
				bimbofyActivate();
			}
			
			
		}
		
		//UTILITY
		private var bimbofyActive:Boolean = false;
		private function bimbofyActivate():void {
			if (!bimbofyActive) {
				bimbofyActive = true;
				players[0].controlSystem.setBimbofyActive(true);
			}
		}
		
		
		/** Returns the pot odds for a player. */
		public function getPotOddsPlayer(player:Bimbo):Number {
			var checkAmount:Number = getCheckAmount(player);
			var winAmount:Number = getWinAmount(player);
			return getPotOdds(checkAmount, winAmount);
		}
		
		public function getWinAmount(player:Bimbo):Number {
			var winAmount:Number = getCheckAmount(player) + pot;
			if (iqPotIsActive) winAmount += iqPot * (IQ_PRICE / IQ_AMOUNT);
			return winAmount;
		}
		
		/** Returns the pot odds for some values. */
		public function getPotOdds(checkAmount:Number, winAmount:Number):Number {
			return (checkAmount / winAmount);
		}
		
		public function getHandStrength(player:Bimbo):Number {
			var handStrength:Number = poker.getHandStrength(Vector.<int>(player.hand.getList()), Vector.<int>(communityCards.getList()), players.length - 1 - foldedPlayers, 200);
			return handStrength;
		}
		
		/**
		 * 
		 * @param	player
		 * @param	rateOfReturn	
		 * @param	targetRR		The Rate of Return player is aiming to have.
		 */
		public function getOptimalRaiseAmount(player:Bimbo, handStrength:Number, targetRR:Number):Number {
			var value:Number = getCheckAmount(player) * (targetRR - handStrength) - pot;
			//trace("Optimal raise: " + value);
			return value;
			
		}
		
		/** Returns the rate of return for a player. 
		 * This is the "on average" proportion of how much you will multiply your bet by, if you stay in the hand.
		 * If handstrength has already been calculated, this value can be entered to skip recalculating it.*/
		public function getRateOfReturn(player:Bimbo, handStrength:Number = -1):Number {
			var hs:Number = handStrength;
			if (hs < 0) hs = getHandStrength(player);
			var potOdds:Number = getPotOddsPlayer(player);
			return handStrength / potOdds;
		}
		
		/**Pauses the game. Sets a delayed unpause to happen if unPauseDelay (seconds) is set.*/
		private function pause(unpauseDelay:Number=0):void {
			paused = true;
			if (unpauseDelay > 0) {
				delay(unpause, null, unpauseDelay*1000);
			}
		}
		
		private function unpause():void {
			paused = false;
		}
		
		/**Returns a number representing the influence on the player from other bimbos.*/
		public function getBimboInfluenceOn(player:Bimbo):Number {
			var p1:Number = 0.31093;
			var p2:Number = 0.54711;
			var p3:Number = -0.21583;
			var value:Number = 0;
			var total:Number = 0;
			for each (var bimbo:Bimbo in players) {
				if (bimbo != player) {
					var f:Number = bimbo.getBimboFactor();
					value = p1 * Math.pow(f, 2) + (p2 * f) + p3
					total += value;
				}
			}
			var result:Number = (total / (players.length - 1)) / 3;
			return result;
		}
		
		public function iqLoss(player:Bimbo, amount:Number):void {
			payPotIq(player, amount, 0.8);
		}
		
		private function payBimboIq(player:Bimbo, amount:Number):void {
			player.iq += amount;
			iqPot -= amount;
			player.speak(player.model.IQ_UP);
			player.update();
		}
		
		/** Transfer iq from a player to the iqPot. Player will lose amount, but pot recieves amount*potFactor. */
		private function payPotIq(player:Bimbo, amount:Number, potFactor:Number = 1):void {
			player.iq -= amount;
			iqPot += amount * potFactor;
			player.update()
		}
		
		/** Transfers money from the specified player to the pot. The value that is actually deducted from the player is multiplied by costFactor. */
		private function payPot(player:Bimbo, amount:Number, costFactor:Number=1):void {
			if (amount > 0) {
				var chips:Vector.<Entity> = new Vector.<Entity>;
				var rand:Number = 0;
				var randX:Number = 0;
				var randY:Number = 0;
				_payBimboChipsLoop(amount, chips, player.x + player.portraitTargetWidth + 150, player.y + 50, 50);
				_payBimboChipsLoop(amount, chips, player.x + player.portraitTargetWidth + 150, player.y + 50, 50);
				
				rand = Math.random();
				for each (var chip:Entity in chips) {
					randX = Math.random() - 0.5;
					randY = Math.random() - 0.5;
					TweenLite.to(chip, 1.5, { x:potX + 50 + 50 * randX, y:potY + 25 + 50 * randY } );
					delay(remove, [chip], 1500);
				}
				pot += amount;
				player.money -= amount*costFactor;
			}
		}
		
		/** Transfers money from the pot to the specified player. */
		private function payBimbo(player:Bimbo, amount:Number):void {
			if (amount > 0) {
				var chips:Vector.<Entity> = new Vector.<Entity>;
				var rand:Number = 0;
				var randX:Number = 0;
				var randY:Number = 0;
				_payBimboChipsLoop(amount, chips, potX + 50, potY + 25);
				_payBimboChipsLoop(amount, chips, potX + 50, potY + 25);
				
				rand = Math.random();
				
				for each (var chip:Entity in chips) {
					randX = Math.random() - 0.5;
					randY = Math.random() - 0.5;
					TweenLite.to(chip, 3, { x:player.x + player.portraitTargetWidth + 150 + 50 * randX, y:player.y + 40 + 50 * randY } );
					delay(remove, [chip], 3000);
				}
				pot -= amount;
				player.money += amount;
				player.speak(player.model.WINNING, Math.round(amount));
			}
		}
		
		private function payBimboFromCasino(player:Bimbo, amount:Number):void {
			if (amount > 0) {
				var chips:Vector.<Entity> = new Vector.<Entity>;
				var rand:Number = 0;
				var randX:Number = 0;
				var randY:Number = 0;
				_payBimboChipsLoop(amount, chips, sw/2, sh);
				_payBimboChipsLoop(amount, chips, sw/2, sh);
				
				rand = Math.random();
				
				for each (var chip:Entity in chips) {
					randX = Math.random() - 0.5;
					randY = Math.random() - 0.5;
					//trace(player.x + " + " + 50 * randX + " Y: " + player.y + " + " + 50 * randY);
					TweenLite.to(chip, 3, { x:player.x + player.portraitTargetWidth + 150 + 50 * randX, y:player.y + 40 + 50 * randY } );
					delay(remove, [chip], 3000);
				}
				player.money += amount;
			}
		}
		
		/** Generate chips and add them to the chips Vector supplied. */
		private function _payBimboChipsLoop(amount:Number, chips:Vector.<Entity>, fromX:Number, fromY:Number, randDist:Number = 100):void {
			var rand:Number = 0;
			var randX:Number = 0;
			var randY:Number = 0;
			var toPay:Number = amount;
			var maxChips:int = 20;
			while ((toPay > bigBlind * 0.4 || toPay > 200) && chips.length < maxChips) {
				rand = Math.random();
				randX = Math.random() - 0.5;
				randY = Math.random() - 0.5;
				if (toPay > bigBlind * 8) {
					chips.push(new Entity(fromX + randDist * randX, fromY + randDist * randY, chipImages[4]));
					toPay -= bigBlind * 8;
				} else if (toPay >= bigBlind * 4) {
					chips.push(new Entity(fromX + randDist * randX, fromY + randDist * randY, chipImages[3]));
					toPay -= bigBlind * 4;
				} else if (toPay >= bigBlind * 2) {
					chips.push(new Entity(fromX + randDist * randX, fromY + randDist * randY, chipImages[2]));
					toPay -= bigBlind * 2;
				} else if (toPay >= bigBlind * 1) {
					chips.push(new Entity(fromX + randDist * randX, fromY + randDist * randY, chipImages[1]));
					toPay -= bigBlind * 1;
				} else {
					chips.push(new Entity(fromX + randDist * randX, fromY + randDist * randY, chipImages[0]));
					toPay -= bigBlind * 0.5;
				}
					add(chips[chips.length - 1]);
				}
		}
		
		/**Returns the player with playerNr, but each player can be refered to as playerNr + k*length*/
		private function getPlayer(playerNr:int):Bimbo {
			playerNr = playerNr % players.length;
			return players[playerNr];
		}
		
		/** Returns the amount that players has to have betted this round.*/
		public function getCurrentBet():Number {
			return currentBet;
		}
		
		/** Returns the minimum amount that player needs to raise if they are to raise this round.*/
		public function getMinRaiseAmount(bimbo:Bimbo):Number {
			return getCheckAmount(bimbo) + lastRaise;
		}
		
		public function getMinRaiseAmountRound(bimbo:Bimbo):Number {
			return Math.round(getMinRaiseAmount(bimbo));
		}
		
		/** Returns the amount player need to bet to continue playing after this turn.*/
		public function getCheckAmount(bimbo:Bimbo):Number {
			return getCurrentBet() - bimbo.betThisRound;
		}
		
		public function getCheckAmountRound(bimbo:Bimbo):Number {
			return Math.round(getCheckAmount(bimbo));
		}
		
		private function unhide(players:Array):void {
			
		}
		
		private function giveCardFromDeck(hand:CardHand, deck:Deck, hidden:Boolean = false):void 
		{
			if (deck.length < 1) {
				deck.reshuffle();
			}
			if (devmode) hidden = false;
			addCard(hand, deck.draw(), hidden);
		}
		
		private function giveCard(woman:Bimbo, card:int, hidden:Boolean = false):void 
		{
			addCard(woman.hand, card, hidden);
		}
		
		private function addCard(hand:CardHand, card:int, hidden:Boolean = false):void {
			cardsToDeal.push( { hand:hand, card:card, hidden:hidden } );
		}
		
		private var dealCount:int = 0;
		private function actuallyAddCard(hand:CardHand, card:int, hidden:Boolean = false):void {
			dealCount++;
			hand.addCard(card);
			
			var xPos:Number = hand.pos.x + (hand.length() - 1) * cardHandOffset;
			var yPos:Number = hand.pos.y;
			var cardEntity:CardEntity = new CardEntity(card, deckLocation.x, deckLocation.y, hidden);
			add(cardEntity);
			TweenLite.to(cardEntity, 1, {x:xPos, y:yPos} );
		}
		
		/**Empties the CardHand and removes corresponding CardEntities.*/
		private function resetHand(hand:CardHand):void {
			var allCards:Array = new Array();
			this.getClass(CardEntity, allCards);
			for each (var cardEntity:CardEntity in allCards) {
				for (var i:int = 0; i < hand.length(); i++) {
					if (cardEntity.card == hand.getList()[i]) {
						this.remove(cardEntity);
					}
				}
			}
			hand.empty();
		}
		
		/**Sets all cardEntities hidden status corresponding to the cards in the hand to the value of hidden.*/
		private function hideHand(hand:CardHand, hidden:Boolean):void {
			var allCards:Array = new Array();
			this.getClass(CardEntity, allCards);
			for each (var cardEntity:CardEntity in allCards) {
				for (var i:int = 0; i < hand.length(); i++) {
					if (cardEntity.card == hand.getList()[i]) {
						cardEntity.hidden = hidden;
					}
				}
			}
		}
		
		/**Updates visuals of of cards in cardhand.*/
		private function updateHandCardBacks(hand:CardHand):void {
			var allCards:Array = new Array();
			this.getClass(CardEntity, allCards);
			for each (var cardEntity:CardEntity in allCards) {
				for (var i:int = 0; i < hand.length(); i++) {
					if (cardEntity.card == hand.getList()[i]) {
						cardEntity.hidden = cardEntity.hidden;
					}
				}
			}
		}
		
		/** Returns an array consisting of bimbo's personal cards + the community cards.*/
		public function getHandCardList(bimbo:Bimbo):Array
		{
			var cards:Array = bimbo.hand.getList();
			cards = cards.concat(communityCards.getList());
			return cards;
		}
		
		public function updateCardBacks():void
		{
			deckEntity.hidden = true;
			for each (var p:Bimbo in players) {
				updateHandCardBacks(p.hand);
			}
		}
		
		public static function delay(func:Function, params:Array, delay:int = 350, repeat:int = 1):void
		{
			var f:Function;
			var timer:Timer = new Timer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, f = function():void
			{
				func.apply(null, params);
				if (timer.currentCount == repeat)
				{
				   timer.removeEventListener(TimerEvent.TIMER, f);
				   timer = null;
				}
			});
			timer.start();
		}
		
		//DEV AND SYSTEM
		
		private function devAddIq(array:Array):void {
			if (devmode) {
				array[0].addIq(array[1]);
			}
		}
		
		private function back():void {
			FP.world = LoadingWorld.mainMenuWorld;
		}
		
		private function save():void {
			Data.load("saved_gamestate");
			Data.writeInt("playerAmount", players.length);
			for (var i:int = 0; i < players.length; i++) {
				Data.writeInt("p" + i + "type", players[i].typeId);
				Data.writeInt("p" + i + "iq", int(players[i].iq));
				Data.writeInt("p" + i + "money", int(players[i].getMoney()));
				Data.writeInt("p" + i + "lust", int(100*players[i].lust));
				Data.writeBool("p" + i + "ai", players[i].isAiControlled);
			}
			Data.writeInt("buttonPlayerNr", buttonPlayerNr);
			Data.writeInt("BLIND_START_VALUE", int(BLIND_START_VALUE));
			Data.writeInt("roundNr", roundNr);
			Data.writeInt("iqPot", iqPot);
			Data.writeInt("ROUNDS_BETWEEN_BLIND_INCREASE", ROUNDS_BETWEEN_BLIND_INCREASE);
			
			Data.writeBool("saveExists", true);
			Data.save("saved_gamestate");
			new BasicTextField(300, 130, 125, 30, {text:"Saved", fontsize:14}).popup(this, 2, 0.2, 0.2);
		}
		
		private function load():void {
			Data.load("saved_gamestate");
			players = new Array();
			var playerAmount:int = Data.readInt("playerAmount", 4);
			var type:int;
			var ai:Boolean;
			for (var i:int = 0; i < playerAmount; i++) {
				type = Data.readInt("p" + i + "type", 0);
				ai = Data.readBool("p" + i + "ai", true);
				var bimbo:Bimbo = new Bimbo(BimboModel.getBimboModelByType(type), this, ai);
				bimbo.iq = Data.readInt("p" + i + "iq", 100);
				bimbo.money = Data.readInt("p" + i + "money", 100);
				bimbo.lust = (Data.readInt("p" + i + "lust", 0) / 100);
				players.push(bimbo);
			}
			buttonPlayerNr = Data.readInt("buttonPlayerNr", 0);
			BLIND_START_VALUE = Data.readInt("BLIND_START_VALUE", 20);
			roundNr = Data.readInt("roundNr", 1);
			iqPot = Data.readInt("iqPot", 0);
			ROUNDS_BETWEEN_BLIND_INCREASE = Data.readInt("ROUNDS_BETWEEN_BLIND_INCREASE", 10);
		}
		
		//GETTERS AND SETTERS
		
		
		
		/**
		 * 
		 * @param	disincludeList A list of Bimbomodels that can not be returned.
		 * @return A Bimbomodel that whose type is not on the list, or the Random model if that is impossible.
		 */
		public static function getRandomBimboModel(disIncludeList:Vector.<BimboModel>):BimboModel {
			var rand:int = int(Math.random() * (GameSetupWorld.chars - 2));
			var randTaken:Boolean = false;
			for (var i:int = 0; i < GameSetupWorld.chars - 2; i++) {
				for each (var model:BimboModel in disIncludeList) {
					if (model != null && model.typeId == rand) {
						randTaken = true;
					}
				}
				if (randTaken == true) {
					rand = warpAddInt(rand, 1, 0, GameSetupWorld.chars - 2);
					randTaken = false;
				} else {
					var m:BimboModel = BimboModel.getBimboModelByType(rand);
					//m.iq = 100 + 30 * Math.random();
					return m;
				}
			}
			return new Random();
		}
		
		/** Adds any int to i. If i is now >= high, it is set to low and if it is < low it is set to high - 1.
		 * Not that thus all "momentum" from the add operation is lust during warp.
		 * 
		 * @param	i Number to warp.
		 * @param	add A positive or negative in to add to i.
		 * @param	low Lower limit (inclusive).
		 * @param	high Upper limit (exclusive).
		 * @return 	i The possibly warped value.
		 */
		public static function warpAddInt(i:int, add:int, low:int, high:int):int {
			i += add;
			if (i >= high) {
				i = low;
			} else if (i < low){
				i = high - 1;
			}
			return i;
		}
		
		public function getPotRound():Number 
		{
			return Math.round(pot);
		}
		
		public function getBetRound():Number 
		{
			return Math.round(currentBet);
		}
		
		public function setSelectedBimbo(bimbo:Bimbo):void {
			selectedBimbo = bimbo;
			selectedBimbo.update();
		}
		
		public function getSelectedBimbo():Bimbo {
			return selectedBimbo;
		}
		
		public function getBuyIqPrice():Number {
			return IQ_PRICE;
		}
		
		public function getBuyIqAmount():Number {
			return IQ_AMOUNT;
		}
		
		public function getCommunityCards():Array {
			return communityCards.getList();
		}
		
		private function getRoundNr():int {
			return roundNr;
		}
		
		private function getBlindForRound(roundNr:int):Number {
			var blind:Number = BLIND_START_VALUE;
			var mult:Vector.<int> = Vector.<int>([1, 2, 3, 5, 10, 15, 20, 40, 80]);
			var i:int = 0;
			var r:int = ROUNDS_BETWEEN_BLIND_INCREASE; //How many rounds between each increase.
			while (roundNr > r && i < mult.length-1) {
				i++;
				roundNr = roundNr - r;
			}
			return blind*mult[i];
		}
		
		public function getBigBlind():Number {
			return bigBlind;
		}
		
		public function getSmallBlind():Number {
			return bigBlind / 2;
		}
		
		private function getIqPot():Number {
			return iqPot;
		}
		
		private function getIqPotRound():Number {
			return Math.round(getIqPot());
		}
		
		/** Returns average IQ in the game excluding the specified player. */
		public function getAverageIq(bimbo:Bimbo):Number {
			var sum:Number = 0;
			for each (var player:Bimbo in players) {
				if (player != bimbo && !player.isOut) {
					sum += player.iq;
				}
			}
			var result:Number = 100; 
			if (players.length - 1 - outPlayers != 0) {
				result = sum / (players.length - 1 - outPlayers);
			}
			return result;
		}
		
		public function getLowestIq():Number {
			var result:Number = Number.MAX_VALUE;
			for each (var player:Bimbo in players) {
				if (!player.isOut && result > player.iq) {
					result = player.iq;
				}
			}
			return result;
		}
		
		public function getHighestIq():Number {
			var result:Number = 0;
			for each (var player:Bimbo in players) {
				if (!player.isOut && result < player.iq) {
					result = player.iq;
				}
			}
			return result;
		}
		
		public function getHighestIqPlayer():Bimbo {
			var result:Bimbo;
			var resultIq:Number = 0;
			for each (var player:Bimbo in players) {
				if (!player.isOut && resultIq < player.iq) {
					resultIq = player.iq;
					result = player;
				}
			}
			return result;
		}
		
		public function getStripteaseCost():Number {
			return STRIPTEASE_COST;
		}
		
		public function getStripteaseCostString():String {
			return Math.round(getStripteaseCost()).toString();
		}
		
	}
}
