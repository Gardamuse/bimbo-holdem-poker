package worlds 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.skins.milk.MilkButton;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import ui.skins.milk.MilkTextField;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import ui2.basic.BasicButton;
	import ui2.basic.BasicTextField;
	
	public class BackstoryWorld extends World
	{
		//Screen elements
		private var backB:MilkButton;
		private var textF:MilkTextField;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		public function BackstoryWorld() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
			
			new BasicTextField(sw / 2 - 300, 100, 600, 400, 
				{ text: "<sLarge><cBC>Backstory</cBC></sLarge>" + 
						"\n\n\nThe Casino was a large and luxurious, but outwards inconspicous building." +
						" Officially, the Casino was part casino, part escort agency, employing young (and always very hot) girls as escort for the men and women who wanted some company on their yachts," +
						" in their expensive apartments or to their fancy parties." +
						"\n\nHowever, unofficially, they were also a major force behind Bimnocorp equipment and products," +
						" inviting those who wanted more than what they could achieve on their own to secret games behind locked doors." +
						" They promised that the winners would recieve the neural capacity they needed to solve all of their problems and unlock great potential within themselves." + 
						" Never did they tell them that the losers would be drained of their intelligence to become airheaded bimbos," +
						" losing all desire for anything but sex and then be force-recruited to expand the casino's escort staff." +
						"\n\nThose who did win would learn this secret, of course, but none would ever tell and reveal the secrets behind their quickly enhanced intelligence and capabilities." +
						" Nor would anyone ever risk the wrath of the Casino."
			, fontsize:14 } ).add(this);
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
		}
		
		private function back():void {
			FP.world = LoadingWorld.mainMenuWorld;
		}
		
	}

}