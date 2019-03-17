package 
{
	public class Card 
	{
		private var _color:int; //0 = hearts, 1 = clubs, 3 = diamonds, 4 = spades
		private var _rank:int; //0 = 2 (deuce), 1 = 3, 11 = King, 12 = Ace
		private var nr:int;	
		
		public function Card(color:int, value:int) 
		{
			this.color = color;
			this.rank = value;
			nr = color*13 + rank;
		}
		
		public function equals(card:Card):Boolean {
			if (card.rank == rank && card.color == color) {
				return true;
			} else {
				return false;
			}
		}
		
		public function toString():String 
		{
			return "|" + color + " " + rank + "|";
		}
		
		public function get color():int 
		{
			return _color;
		}
		
		public function set color(value:int):void 
		{
			_color = value;
		}
		
		public function get rank():int 
		{
			return _rank;
		}
		
		public function set rank(value:int):void 
		{
			_rank = value;
		}
		
	}

}