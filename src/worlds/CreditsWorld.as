package worlds 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.skins.milk.MilkButton;
	import ui.skins.milk.MilkTextField;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import ui2.basic.BasicButton;
	import ui2.basic.BasicTextField;
	
	public class CreditsWorld extends World
	{
		//Screen elements
		private var backB:MilkButton;
		private var softwareF:BasicTextField;
		private var peopleF:BasicTextField;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		public function CreditsWorld() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
			
			peopleF = new BasicTextField( 200, -10, 500, sh + 25, {text:
				"<sGiant><cBC>Credits</sGiant></cBC>" +
				"\n\n\n<sLarge><cBC>Development</sLarge></cBC>" +
				"\n<fff>Gardamuse</fff><sSmall> | Design, Programming, Writing, Art</sSmall>" + 
				"\n<fff>Zeitgeist1234</fff><sSmall> | Writing</sSmall>" +
				"\n<fff>Chickenchaos</fff><sSmall> | Writing</sSmall>" +
				"\n<fff>Araten</fff><sSmall> | Writing, Character: Fuyumi</sSmall>" +
				"\n<fff>SwedishCheetah</fff><sSmall> | Characters: Nathan, Barry</sSmall>" +
				"\n<fff>Useful89</fff><sSmall> | Character: Miller</sSmall>" +
				"\n<fff>SimpleKisekaeGuy</fff><sSmall> | Character: Rosa</sSmall>" +
				"\n<fff>MythicalCreatureBone</fff><sSmall> | Characters: Sebastian, Maxwell, Dionysus, Anthony</sSmall>" +
				"\n<fff>Mistress-Gonzy</fff><sSmall> | Character: Gonzy</sSmall>" +
				"\n<fff>Tfgame</fff><sSmall> | Character: Elena</sSmall>" +
				
				"\n\n\n<sMedium><cBC>With extra thanks to...</sMedium></cBC>" +
				"\n<fff>Goldwyn11</fff><sSmall> | For ideas and testing</sSmall>" +
				"\n<fff>GrapplerOfBooty</fff><sSmall> | For ideas and testing</sSmall>" +
				"\n<fff>CycloneSamurai</fff><sSmall> | For his Bimbo Poker series</sSmall>" +
				"\n<fff>Master-TF</fff><sSmall> | For inspiration and support</sSmall>" +
				"\n<fff>Marioland1</fff><sSmall> | For his in-depth gameplay insights</sSmall>" +
				"\n<fff>All who comment</fff><sSmall> | For feedback and great inspiration</sSmall>"
			});
			peopleF.add(this);
			
			softwareF = new BasicTextField(sw / 2 + 150, -10, 400, 500, { text:
				"\n\n\n<sLarge><cBC>Resources</sLarge> (Non-affiliated)</cBC>" +
				"\n<fff>Dieter Steffmann</fff><sSmall> | Titania Regular, via dafont.com</sSmall>" +
				"\n<fff>Graham H. Freeman</fff><sSmall> | ModeNine, via dafont.com</sSmall>" +
				"\n<fff>Andrew C. Bulhak</fff><sSmall> | ModeNine, via dafont.com</sSmall>" +
				"\n<fff>Adimetro00</fff><sSmall> | Background Images</sSmall>" +
				"\n<fff>Kanbeikurodasamurai7</fff><sSmall> | Background Images</sSmall>" +
				"\n<fff>www.kenney.nl</fff><sSmall> | Card and chip sprites</sSmall>" + 
				"\n<fff>www.yoambulante.com</fff><sSmall> | Poker evaluation algorithm</sSmall>" +
				"\n<fff>www.cowboyprogramming.com</fff><sSmall> | Poker AI theory</sSmall>" +
				
				"\n\n\n<sLarge><cBC>Software and Tools</sLarge></cBC>" +
				"\n<fff>FlashDevelop</fff><sSmall> | IDE</sSmall>" + 
				"\n<fff>FlashPunk</fff><sSmall> | ActionScript 3 games library</sSmall>" + 
				"\n<fff>Kisekae 2</fff><sSmall> | Image sequence creation</sSmall>" +
				"\n<fff>ImageMagick</fff><sSmall> | Spritesheet generation</sSmall>" +
				"\n<fff>PngQuant</fff><sSmall> | PNG compression</sSmall>" +
				"\n<fff>Photoshop CS2</fff><sSmall> | Image manipulation</sSmall>"
			});
			softwareF.add(this);
			
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