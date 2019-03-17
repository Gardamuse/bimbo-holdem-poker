package 
{
	import net.flashpunk.FP;
	import worlds.LoadingWorld;
	import worlds.MainMenuWorld;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	public class Preloader extends MovieClip 
	{	
		public function Preloader()
		{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(e:Event):void
		{
			if (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal)
			{
				// If all bytes are loaded, start the game.
				startup();
			}
			else
			{
				// Update your screen to display whatever you'd like.
				FP.world = new LoadingWorld();
			}
		}
		
		private function startup():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			var mainClass:Class = getDefinitionByName("MainMenuWorld") as Class;
			parent.addChild(new mainClass as DisplayObject);
			parent.removeChild(this);
		}
	}
}