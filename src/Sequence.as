package 
{
	public class Sequence 
	{
		public var spritesheet:Class;
		public var frameWidth:int;
		public var frameHeight:int;
		public var frameAmount:int;
		
		public function Sequence(spritesheet:Class, frameWidth:int, frameHeight:int, frameAmount:int) 
		{
			this.spritesheet = spritesheet;
			this.frameWidth = frameWidth;
			this.frameHeight = frameHeight;
			this.frameAmount = frameAmount;
			
		}
		
	}

}