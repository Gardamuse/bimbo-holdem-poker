package worlds 
{
	import flash.utils.ByteArray;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.skins.milk.MilkButton;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import ui.skins.milk.MilkTextField;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import ui2.basic.BasicButton;
	import ui2.basic.BasicSlider;
	import ui2.basic.BasicTextField;
	import net.flashpunk.utils.Data;
	import flash.net.FileReference;
	import flash.events.Event;
	
	public class LoadingWorld extends World
	{
		//Global constans
		public static const backBH:int = 40;
		
		//Screen elements
		private var loadingBar:BasicSlider;
		
		//Properties
		public static var mainMenuWorld:MainMenuWorld;
		public static var tutorialWorld:TutorialWorld;
		public static var creditsWorld:CreditsWorld;
		public static var backstoryWorld:BackstoryWorld;
		public static var patchNotesWorld:PatchNotesWorld;
		public static var settingsWorld:SettingsWorld;
		
		public static var patchNotesWorld10:PatchNotesWorld10;
		public static var pokerWorld:PokerWorld;
		
		private var i:int;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		private static const loadItems:Number = 7; //How many items are to be loaded
		
		public function LoadingWorld() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(Assets.BACKGROUND);
			add(new Entity(0, 0, backdrop));
			
			loadingBar = new BasicSlider(sw/2 - 100, sh/2 - 25, 200, 50, { text:"<var0>%" } );
			loadingBar.add(this);
			
			i = 0;
			
			Data.id = "bhp";
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
			if (i == 1) {
				settingsWorld = new SettingsWorld();
				loadingBar.sliderFraction = 1/loadItems;
			}
			if (i == 2) {
				mainMenuWorld = new MainMenuWorld();
				loadingBar.sliderFraction = 1.5/loadItems;
			}
			if (i == 3) {
				creditsWorld = new CreditsWorld();
				loadingBar.sliderFraction = 2.5/loadItems;
			}
			if (i == 4) {
				tutorialWorld = new TutorialWorld();
				loadingBar.sliderFraction = 5/loadItems;
			}
			if (i == 5) {
				backstoryWorld = new BackstoryWorld();
				loadingBar.sliderFraction = 5.5/loadItems;
			}
			if (i == 6) {
				patchNotesWorld = new PatchNotesWorld();
				loadingBar.sliderFraction = 6.5/loadItems;
			}
			if (i == 7) {
				loadingBar.sliderFraction = 1;
			}
			if (i == 8) {
				FP.world = mainMenuWorld;
			}
			i++;
			
		}
		
		// Loading and saving
		
		private static var fileRef:FileReference;
		
		/**
		 * Sets current Data to data from a user specified file.
		 */
		public static function loadFile():void {
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onFileSelected );
			fileRef.addEventListener(Event.COMPLETE, onLoadComplete );
			fileRef.browse(/*[new FileFilter("BHP Save File", ".bhp")]*/);
		}
		
		private static function onFileSelected(evt:Event):void 
        { 
            //fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress); 
            fileRef.addEventListener(Event.COMPLETE, onLoadComplete); 
            fileRef.load();
        }
		
		private static function onLoadComplete(evt:Event):void {
			var bytes:ByteArray = fileRef.data;
			var obj:Object = bytes.readObject();
			
			Data.load("bhp_save");
			Data.setData("bhp_save", obj);
			settingsWorld.load();
		}
		
		/**
		 * Saves current Data to a location specified by the user.
		 * 
		 * Changes that are to be saved need to already be saved to the Data object.
		 */
		public static function saveFile():void {
			fileRef = new FileReference();
			Data.load("bhp_save");
			var obj:Object = Data.loadData("bhp_save");
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeObject(obj);
			fileRef.save(bytes, "save.bhp");
			
		}
		
	}

}