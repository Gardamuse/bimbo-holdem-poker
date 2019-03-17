package 
{
	
	public class MuseLib 
	{
		
		public function MuseLib() 
		{
			
		}
		
		/** Returns a string representing the number with thousand dividers inserted. Ex: thousandDivide(10000) will return something like "10,000".*/
		public static function thousandDivide(nr:Number):String {
			var s:String = nr.toString();
			s.substr(s.length - 3, 3);
			for (var i:int = s.length - 3; i > 0; i -= 3) {
				s = s.substring(0, i) + "," + s.substring(i);
			}
			return s;
		}
		
		/** @return a random number between base - minus and base + plus. If minus is not specified, plus will be used for both sides. Plus and minus should both be > 0.*/
		public static function plusminus(base:Number, plus:Number, minus:Number = -1):Number {
			if (minus < 0) minus = plus;
			
			return base - minus + Math.random() * (minus + plus);
		}
	}

}