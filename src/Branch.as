package 
{
	
	public class Branch 
	{
		private var startFrame:int;
		private var endFrame:int;
		private var nextBranch:Array;
		//private var currentFrame:int;
		private var name:String;
		
		public function Branch(startFrame:int, endFrame:int, name:String, nextBranch:Array=null)
		{
			this.startFrame = startFrame;
			this.endFrame = endFrame;
			this.nextBranch = nextBranch;
			this.name = name;
			
			//currentFrame = startFrame;
		}
		
		/*public function hasNextFrame():Boolean
		{
			if (currentFrame < endFrame) {
				return true;
			}
			return false;
		}*/
		
		/*public function nextFrame():void
		{
			//trace("Before: " + currentFrame);
			if (hasNextFrame()) {
				currentFrame += 1;
			}
			//trace("After: " + currentFrame);
		}*/
			
		public function getNextBranch():Array
		{
			return nextBranch;

		}
		
		/*public function getCurrentFrame():int
		{
			return currentFrame;
		}*/
		
		public function getStartFrame():int
		{
			return startFrame;
		}
		
		public function getEndFrame():int
		{
			return endFrame;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function toString():String
		{
			return "Startframe: " + startFrame.toString();
		}
	}	
}
