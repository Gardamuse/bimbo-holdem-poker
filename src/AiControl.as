package 
{
	import worlds.PokerWorld;
	
	public class AiControl extends ControlSystem
	{
		private var delayTime:Number = 0;
		private var localBetAmount:Number = 0;
		
		private var hand:Array;
		
		public function AiControl(world:PokerWorld, bimbo:Bimbo) 
		{
			super(world, bimbo);
			hand = bimbo.hand.getList();
		}
		
		override public function init():void {
			super.init();
		}
		
		override protected function decideMove():void {
			super.decideMove();
			delayTime = delayTime * 1.75;
			var foldC:Number = 1;
			var callC:Number = 0;
			var raiseC:Number = 0;
			
			//trace(rateOfReturn);
			//Set probabilities
			if (rateOfReturn < 0.8) {
				foldC = 0.95;
				callC = 0;
				raiseC = 0.05;
			} else if (rateOfReturn < 1) {
				foldC = 0.85;
				callC = 0.05;
				raiseC = 0.1;
			} else if (rateOfReturn < 1.3) {
				foldC = 0;
				callC = 0.8;
				raiseC = 0.2;
			} else { //if rr >= 1.3
				foldC = 0;
				callC = 0.4;
				raiseC = 0.6;
				//trace(bimbo.getName() + ": " + world.getMaxRaiseAmount(bimbo, handStrength, 1.3));
			}
			
			//Generate a move
			var rand:Number = Math.random();
			if (world.getCheckAmount(bimbo) < 0.5) {
				check();
			} else if (rand < foldC) {
				fold();
			} else if ( rand < foldC + callC) {
				check();
			} else if (bimbo.canRaise) {
				localBetAmount = world.getMinRaiseAmount(bimbo);
				world.getOptimalRaiseAmount(bimbo, handStrength, 1)
				raise();
			} else { //If player want to raise but is not allowed to, check instead.
				check();
			}
			//fold();
		}

		
		override protected function decideBimboMove():void {
			delayTime = getDelayTime();
			
			var averageIq:Number = world.getAverageIq(bimbo);
			var lowestIq:Number = world.getLowestIq();
			var highestIq:Number = world.getHighestIq();
			
			if (bimbo.iq > averageIq * 1.2 && bimbo.lust > 0.2) { //Bimbo on high relative iq
				selectedBimbo = bimbo;
				relax();
			} else if (bimbo.iq > averageIq * 1.2) {
				noBimboMove();
			} else if (bimbo.iq > averageIq && bimbo.lust > 0.5) {
				relax();
			} else if (bimbo.iq > averageIq * 0.8) { //Bimbo on average relative iq
				selectHighIqBimbo();
				fondle();
			} else if (bimbo.iq < averageIq * 0.8) { //Bimbo on low relative iq
				selectHighIqBimbo();
				fondle();
			} else if (bimbo.iq < averageIq * 0.7 && bimbo.lust > 0.5 && bimbo.iq > 42) { 
				striptease();
			} else if (bimbo.iq < averageIq) {
				selectedBimbo = bimbo;
				relax();
			} else {
				noBimboMove();
			}
		}
		
		private function selectHighIqBimbo():void {
			selectedBimbo = world.getHighestIqPlayer();
			if (Math.random() > 0.5 || selectedBimbo == bimbo) {
				var i:int = int(Math.random() * world.players.length);
				if (!world.players[i].isOut && !world.players[i].hasFolded && world.players[i] != bimbo) {
					selectedBimbo = world.players[i];
				}
			}
		}
		
		//Returns a slightly randomized delayTime in seconds.
		private function getDelayTime():Number {
			if (PokerWorld.devmode) return 0.2;
			if (PokerWorld.quickmode) return 0.2;
			return 1.8+Math.random()*0.3;
		}
		
		//MOVES
		override protected function check():void {
			PokerWorld.delay(super.check, null, delayTime * 1000);
		}
		
		override protected function raise():void {
			betAmount = localBetAmount;
			PokerWorld.delay(super.raise, null, delayTime * 1000);
		}
		
		override protected function fold():void {
			PokerWorld.delay(super.fold, null, delayTime * 1000);
		}
		
		override protected function fondle():void {
			PokerWorld.delay(super.fondle, null, delayTime * 1000);
		}
		
		override protected function striptease():void {
			PokerWorld.delay(super.striptease, null, delayTime * 1000);
		}
		
		override protected function bimbofy():void {
			PokerWorld.delay(super.bimbofy, null, delayTime * 1000);
		}
		
		override protected function relax():void {
			PokerWorld.delay(super.relax, null, delayTime * 1000);
		}
		
		//To make it easier for AiControl to choose not to make a move. A manual control could use this as well, but it is not necessarry.
		override protected function noBimboMove():void {
			PokerWorld.delay(super.noBimboMove, null, delayTime * 1000);
		}
		
	}

}