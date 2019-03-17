package 
{
	import net.flashpunk.World;
	import worlds.PokerWorld;

	public class ControlSystem 
	{
		protected var world:worlds.PokerWorld;
		protected var bimbo:Bimbo;
		
		//Internal Logic Vars
		private var moving:Boolean = false;
		protected var moveDecided:Boolean = false;
		protected var move:String;
		protected var betAmount:Number = 0;
		protected var rateOfReturn:Number = 0;
		protected var handStrength:Number = 0;
		
		private var bimboMoving:Boolean = false;
		protected var bimboMoveDecided:Boolean = false;
		protected var bimboMove:String;
		
		public var selectedBimbo:Bimbo;
		
		//Game state vars

		public function ControlSystem(world:worlds.PokerWorld, bimbo:Bimbo) 
		{
			this.world = world;
			this.bimbo = bimbo;
		}
		
		public function init():void {
			
		}
		
		public function requestMove():void {
			if (bimboMoveDecided == true && bimboMoving == true) {
				bimboMoving = false;
				makeMove(bimboMove);
			} else if (bimboMoveDecided == false && bimboMoving == false) {
				bimboMoving = true;
				decideBimboMove();
			}
			
			if (moveDecided == true) {
				moveDecided = false;
				moving = false;
				bimboMoveDecided = false;
				bimboMoving = false;
				makeMove(move);
			} else if (moving == false) {
				moving = true;
				decideMove();
			}
		}
		
		private function makeMove(move:String):void {
			if (move == "CHECK") {
				world.check(bimbo);
			}
			else if (move == "RAISE") {
				world.raise(bimbo, betAmount);
			}
			else if (move == "FOLD") {
				world.fold(bimbo);
			} 
			else if (move == "FONDLE") {
				world.fondle(bimbo, selectedBimbo);
			} else if (move == "STRIPTEASE") {
				world.striptease(bimbo);
			} else if (move == "BIMBOFY") {
				world.bimbofy(bimbo, selectedBimbo);
			} else if (move == "RELAX") {
				world.relax(bimbo, selectedBimbo);
			}
		}
		
		//Logic for determining which move to use.
		protected function decideMove():void {
			handStrength = world.getHandStrength(bimbo);
			rateOfReturn = world.getRateOfReturn(bimbo, handStrength);
		}
		
		protected function decideBimboMove():void {
		}
		
		//MOVES
		protected function check():void {
			move = "CHECK";
			moveDecided = true;
		}
		
		//Overrides must set betAmount.
		protected function raise():void {
			move = "RAISE";
			moveDecided = true;
		}
		
		protected function fold():void {
			move = "FOLD";
			moveDecided = true;
		}
		
		//BIMBO MOVES
		
		//Raise lust
		protected function fondle():void {
			bimboMove = "FONDLE";
			bimboMoveDecided = true;
		}
		protected function striptease():void {
			bimboMove = "STRIPTEASE";
			bimboMoveDecided = true;
		}
		//Raise IQ
		protected function bimbofy():void {
			bimboMove = "BIMBOFY";
			bimboMoveDecided = true;
		}
		//Lower lust
		protected function relax():void {
			bimboMove = "RELAX";
			bimboMoveDecided = true;
		}
		
		//To make it easier for AiControl to choose not to make a move. A manual control could use this as well, but it is not necessarry.
		protected function noBimboMove():void {
			bimboMove = "NO_BIMBO_MOVE";
			bimboMoveDecided = true;
		}
		
		public function getRateOfReturn():Number {
			return rateOfReturn;
		}
		
		public function getHandStrength():Number {
			return handStrength;
		}
		
		public function setBimbofyActive(bool:Boolean):void {
			
		}
	}

}