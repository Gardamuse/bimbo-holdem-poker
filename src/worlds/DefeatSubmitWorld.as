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
	
	public class DefeatSubmitWorld extends World
	{
		//Screen elements
		private var backB:MilkButton;
		private var textF:MilkTextField;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		/**
		 * 
		 * @param	model
		 * @param	mode 0: player was defeated, 1: room is being accessed from trophyworld
		 */
		public function DefeatSubmitWorld(model:BimboModel, mode:int = 0) 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			
			if (mode == 0) new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, { text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
			if (mode == 1) new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, { text:"Back to trophy room", callbacks: [function():void { FP.world = new TrophyWorld(); } ] }, 1 ).add(this);
			
			var mainT:String = model.getSubmitDefeatEnding();
			new BasicTextField(sw / 2 - 300, sh / 2 - 300, 600, 600, { text:mainT, callbacks:[function():String { return model.getName(0); } ], fontsize:14 } ).add(this);
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
		}
		
		private function back():void {
			FP.world = new MainMenuWorld();
		}
		
	}

}