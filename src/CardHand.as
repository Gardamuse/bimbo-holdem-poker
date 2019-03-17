package 
{
	import flash.geom.Point;

	public class CardHand 
	{
		private var list:Array;
		public var pos:Point;
		
		public function CardHand(x:Number = 0, y:Number = 0) 
		{
			pos = new Point(x, y);
			this.list = new Array();
		}
		
		public function addCard(card:int):void {
			list.push(card);
		}
		
		public function empty():void {
			list = new Array();
		}
		
		public function length():uint {
			return list.length;
		}
		
		public function getLastCard():int {
			return list[list.length - 1];
		}
		
		public function getList():Array {
			return list.concat();
		}
		
		public function toString():String 
		{
			var string:String = new String();
			for each (var card:Card in list) {
				string.concat(card + " ");
			}
			return string;
		}
		
		public function traceList():void {
			var s:String = "";
			for each (var card:int in list) {
				s = s.concat(Poker2.stringOf(card)) + ", ";
			}
			trace(s);
		}
	}

}