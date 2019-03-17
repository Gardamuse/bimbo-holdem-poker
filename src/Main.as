package
{
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.LoadingWorld;
	import worlds.MainMenuWorld;
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	
	public class Main extends Engine
	{
		[Embed(source = "../assets/fonts/Titania-Regular.ttf", fontFamily = "Mytype", embedAsCFF = "false")] private var MYTYPE:Class;
		[Embed(source = "../assets/fonts/Titania-Regular.ttf", fontFamily = "FontOne", embedAsCFF = "false")] private var FONT_ONE:Class;
		[Embed(source = "../assets/fonts/MODENINE.TTF", fontFamily = "fuyumi-font", embedAsCFF = "false")] private var FUYUMI_FONT:Class;

		public function Main():void 
		{
			super(1280, 720);
		}
		
		override public function init():void 
		{
			super.init();
			
			TweenPlugin.activate([HexColorsPlugin]);
			var cd:Date = new Date();
			//if (cd.getFullYear() <= 2016 && cd.getMonth() <= 1 && cd.getDate() <= 12) {
				FP.world = new LoadingWorld();
			//}
			
		}
	}
	
}