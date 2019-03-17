package 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ui.RadioButton;
	import ui.skins.milk.PokerSelectButton;
	import worlds.PokerWorld;
	import worlds.LoadingWorld;
	
	public class Bimbo
	{
		//Under the hood vars
		private var _hand:CardHand;
		public var model:BimboModel;
		
		public var controlSystem:ControlSystem;
		public var display:BimboDisplay;
		public var x:Number;
		public var y:Number;
		private var world:worlds.PokerWorld;
		public var isAiControlled:Boolean;
		public var camTargetWidth:Number;
		public var portraitTargetWidth:Number;
		
		public var id:int = -1;
		
		public static var idCounter:int = 0;
		
		//Game Logic vars
		public var hasFolded:Boolean = false;
		public var canRaise:Boolean = false;
		public var canBuyIq:Boolean = false;
		public var betThisRound:Number = 0;
		public var isCurrentPlayer:Boolean = false;
		public var isButton:Boolean = false;
		public var isBigBlind:Boolean = false;
		public var isSmallBlind:Boolean = false;
		private var _isSelected:Boolean = false;
		public var isAllIn:Boolean = false;
		public var isOut:Boolean = false;
		
		public function Bimbo(model:BimboModel, world:worlds.PokerWorld, aiControlled:Boolean = true) 
		{
			this.model = model;
			
			//Under the hood vars
			id = idCounter;
			idCounter++;
			if (id == 0) {
				this.x = 00;
				this.y = 500;
				this.portraitTargetWidth = 200;
			} else if (id > 0) {
				this.x = PokerWorld.sw - (340 + PokerWorld.cardHandOffset * 5)
				this.y = 160 * (id-1);
				this.portraitTargetWidth = 100;
			}
			
			this.world = world;
			this.hand = new CardHand(x, y);
			
			display = new BimboDisplay(world);
			display.init(this);
			
			if (aiControlled) {
				controlSystem = new AiControl(world, this);
				isAiControlled = true;
			} else {
				controlSystem = new ManualControl(world, this);
				isAiControlled = false;
			}
			controlSystem.init();
			
		}
		
		/** Should be called once every time a player makes a move.*/
		public function turnUpdate():void {
			//Lust increases each turn. When reaching 100% it is lowered, but iq is lost. Iq lost is IQ=40:1, IQ=120:5 , IQ=180:12
			if (lust >= 0.995) {
				lust -= 1;
				var value:Number = getIqLossOnCum();
				world.iqLoss(this, value);
				speak(model.CUM);
			} else {
				addLust(world.getBimboInfluenceOn(this));
			}
				
		}
		
		public function getIqLossOnCum():Number {
			var p1:Number = 0.00017857;
			var p2:Number = -0.0035714;
			var p3:Number = 0.85714;
			var value:Number = p1 * Math.pow(iq, 2) + (p2 * iq) + p3;
			return value;
		}
		
		
		
		/** Adds a certain amount of lust to the player but first adjusts for player lust-resistance.*/
		public function addLust(value:Number):void {
			lust += value * getLustResistanceFactor();
			if (model.getBimboFactor() == 1 && model.lust >= 1) model.lust = 1;
		}
		
		private function getLustResistanceFactor():Number {
			var bimbo:Number = model.getBimboFactor();
			return ((1+0.3*(1-lust)-0.8*bimbo)*(1-0.1*model.lust+bimbo*0.5))-0.25;
		}
		
		public function giveCard(card:int):void {
			hand.addCard(card);
		}
		
		public function say(string:String, displayTimeInSeconds:Number = 3):void {
			display.say(string, displayTimeInSeconds);
		}
		
		public function sayAuto(string:String):void {
			var spaces:int = string.split(" ").length;
			var displayTime:Number = (0.9 + spaces * 0.4) * LoadingWorld.settingsWorld.chatDelayMult;
			display.say(string, displayTime);
		}
		
		public function speak(speechVector:Vector.<String>, variable:Object = null):void {
			if (PokerWorld.quickmode || PokerWorld.devmode) return;
			var string:String = speechVector[Math.round(getBimboFactor() * (speechVector.length - 1))];
			if (variable != null) {
				string = string.replace("<var>", variable);
			}
			sayAuto(string);
		}
		
		public function update():void {
			display.update();
		}
		
		public function updateChatQueue():void {
			display.updateChatQueue();
		}
		
		public function useBigChat(bool:Boolean):void {
			display.useBigChat(bool);
		}
		
		public function requestMove():void {
			controlSystem.requestMove();
		}
		
		public function setHasFolded(value:Boolean):void {
			hasFolded = value;
		}
		
		public function getHasFolded():Boolean {
			return hasFolded;
		}
		
		public function get hand():CardHand
		{
			return _hand;
		}
		
		public function set hand(value:CardHand):void 
		{
			_hand = value;
		}
		
		public function getIq():Number 
		{
			return model.iq;
		}
		
		public function getIqRound():Number 
		{
			return Math.round(getIq());
		}
		
		public function getLustFValue():Number
		{
			return lust;
		}
		
		public function get isSelected():Boolean 
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void 
		{
			if (value) {
				getSelectButton().externalClick();
			}
			_isSelected = value;
		}
		
		public function getMoneyRound():Number {
			return Math.round(money);
		}
		
		public function getMoney():Number {
			return model.money;
		}
		
		public function getDisplayX():Number {
			return display.x;
		}
		
		public function getDisplayY():Number {
			return display.y;
		}
		
		public function getDisplayPortraitWidth():Number {
			return display.w;
		}
		
		public function getDisplayPortraitHeight():Number {
			return display.h;
		}
		
		public function getDisplayFieldWidth():Number {
			return display.fieldWidth;
		}
		
		public function getSelectButton():PokerSelectButton {
			return display.portraitB;
		}
		
		public function getRateOfReturn():Number {
			return controlSystem.getRateOfReturn();
		}
		
		public function getRateOfReturnRound():Number {
			return int(100*getRateOfReturn())/100;
		}
		
		public function getHandStrength():Number {
			return controlSystem.getHandStrength();
		}
		
		public function getHandStrengthString():String {
			return int(100*getHandStrength()) + "%";
		}
		
		public function get iq():Number 
		{
			return model.iq;
		}
		
		public function set iq(value:Number):void 
		{
			model.iq = value;
		}
		
		public function get lust():Number 
		{
			return model.lust;
		}
		
		public function set lust(value:Number):void 
		{
			model.lust = value;
		}
		
		public function get money():Number 
		{
			return model.money;
		}
		
		public function set money(value:Number):void 
		{
			model.money = value;
		}
		
		public function get debt():Number 
		{
			return model.debt;
		}
		
		public function set debt(value:Number):void 
		{
			model.debt = value;
		}
		
		public function getName():String {
			return model.getName();
		}
		
		public function getShortName():String {
			return model.getShortName();
		}
		
		public function getBimboFactor():Number {
			return model.getBimboFactor();
		}
		
		public function get typeId():int {
			return model.typeId;
		}
	}

}