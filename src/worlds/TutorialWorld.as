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
	
	public class TutorialWorld extends World
	{
		//Screen elements
		private var backB:MilkButton;
		private var textF:MilkTextField;
		
		//UI constants
		private static const sw:Number = FP.screen.width; //Screen Width
		private static const sh:Number = FP.screen.height; //Screen Height
		
		public function TutorialWorld() 
		{
			super();
			FP.screen.color = 0x003300;
			var backdrop:Backdrop = new Backdrop(LoadingWorld.settingsWorld.getBackground().asset);
			add(new Entity(0, 0, backdrop));
			
			new BasicButton( sw - 200, sh - LoadingWorld.backBH, 200, LoadingWorld.backBH, {text:"Back to main menu", callbacks: [back] }, 1 ).add(this);
			
			
			var inbs:Number = -1; //In-between Space
			var inbsh:Number = -1; //In-between Space Horizontal
			
			var gpx:Number = 50;
			var gpy:Number = 205;
			var gpw:Number = 950;
			
			var mpx:Number = 50;
			var mpy:Number = 20;
			var mpw:Number = 950;
			
			new BasicTextField(mpx, mpy, mpw, 50, { text: "<sLarge><cBC>Menu</cBC></sLarge>", fontsize:14 } ).add(this);
			
			new BasicTextField(gpx + gpw + 20, gpy, gpw * (2.5/10), 50, { text: "<sMedium><fff>Cheatmode</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw + 20, gpy + 50, gpw * (2.5 / 10), 150, 
				{ text: "<left>Write \"cheatmode\" while in game to activate." +
						"\n\n<cBC>Q</cBC>/<cBC>A</cBC> - Adjust target IQ." +
						"\n\n<cBC>W</cBC>/<cBC>S</cBC> - Adjust target money." +
						"\n\n<cBC>SHIFT</cBC> to adjust faster.", fontsize:14 } ).add(this);
						
			new BasicTextField(gpx + gpw + 20, gpy+inbs*3+225, gpw * (2.5/10), 50, { text: "<sMedium><fff>Quickmode</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw + 20, gpy+inbs*3+225 + 50, gpw * (2.5 / 10), 150, 
				{ text: "<left>Click the \"<cBC>Quick</cBC>\" button while in game to toggle." +
						"\n\nWhile quickmode is on..." +
						"\n\n...speech will be hidden." +
						"\n\n...AI will act much faster.", fontsize:14 } ).add(this);
			
			new BasicTextField(mpx, mpy, mpw, 50, 
				{ text: "\n\n<left><sMedium><fff>Start New Game</fff></sMedium> - Setup and start a new game. Choose who to play as and against." +
						"\n\n<sMedium><fff>Continue Game</fff></sMedium> - Continue from your last save. Saving is done automatically each turn." +
						"<sSmall>\n<fff>Warning:</fff> If you reach the victory screen and click anything, your save is cleared.</sSmall>" +
						"\n\n<sMedium><fff>Trophy Room</fff></sMedium> - Enjoy the sight of the opponents, money and IQ you have brought home from winning games.</left>"
			, fontsize:14 } );
			
			new BasicTextField(mpx, mpy+inbs+50, mpw * (2/10), 40, { text: "<sMedium><fff>Start New Game</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(mpx + mpw * (2 / 10) + inbsh, mpy + inbs + 50, mpw * (8 / 10) - inbsh, 40, { text: "<left>Setup and start a new game. Choose who to play as and against.", fontsize:14 } ).add(this);
			
			new BasicTextField(mpx, mpy+inbs+90, mpw * (2/10), 40, { text: "<sMedium><fff>Continue Game</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(mpx + mpw * (2 / 10) + inbsh, mpy + inbs + 90, mpw * (8 / 10) - inbsh, 40, { text: "<left>Continue from your last save. Saving is done automatically each turn." +
					"<sSmall>\n<fff>Warning:</fff> If you reach the victory screen and click anything, your save is cleared.</sSmall>", fontsize:14 } ).add(this);
					
			new BasicTextField(mpx, mpy+inbs+130, mpw * (2/10), 40, { text: "<sMedium><fff>Trophy Room</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(mpx + mpw * (2 / 10) + inbsh, mpy + inbs + 130, mpw * (8 / 10) - inbsh, 40, 
				{ text: "<left>Enjoy the sight of the opponents, money and IQ you have brought home from winning games.", fontsize:14 } ).add(this);
			
			new BasicTextField(gpx, gpy, gpw, 50, { text: "<sLarge><cBC>Gameplay</cBC></sLarge>", fontsize:14 } ).add(this);
			
			new BasicTextField(gpx, gpy+inbs+50, gpw * (1/10), 50, { text: "<sMedium><fff>Basics</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw * (1 / 10) + inbsh, gpy + inbs + 50, gpw * (9 / 10) - inbsh, 50, 
				{ text: "<left>No limit Texas Holdem. The game itself plays as regular holdem." +
						" Select your move when it's your turn by pressing the buttons next to your portrait. Adjust raise amount by clicking the slider beneath the raise button.", fontsize:14 } ).add(this);
			
			new BasicTextField(gpx, gpy+inbs*2+100, gpw * (1/10), 125, { text: "<sMedium><fff>Lust\nand IQ</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw * (1 / 10) + inbsh, gpy + inbs*2 + 100, gpw * (9 / 10) - inbsh, 125, 
				{ text: "<left>Each player has a lust meter. When this passes 100%, they come, losing IQ, more the higher their IQ is." +
						"\n\nLust increases passively. More the lower your opponents IQ levels are. The lower your own IQ however, the more resistant are you against reaching 100% lust." +
						" Lust can also be affected by active abilities." +
						"\n\nMost of lost IQ will be added to the IQ pot. This pot will come into play after reaching a certain treshhold, granting the round winner all of its IQ.", fontsize:14 } ).add(this);
			
			new BasicTextField(gpx, gpy+inbs*3+225, gpw * (1/10), 100, { text: "<sMedium><fff>Money and IQ</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw * (1 / 10) + inbsh, gpy + inbs*3 + 225, gpw * (9 / 10) - inbsh, 100, 
				{ text: "<left>A player uses money to bet on their cards. When a player has to bet more than their stack size" +
						"(the amount of money the currently have) to stay in the round, they go all in, betting their entire stack." +
						" If they win the hand, they get the entire pot." +
						" If they lose, their IQ is force sold both to cover their debt (the amount they went all-in for, but didn't have to pay because they had no money) and to re-buy them into the game." +
						" Most of IQ lost here will also be added to the IQ pot.", fontsize:14 } ).add(this);
						
			new BasicTextField(gpx, gpy+inbs*4+325, gpw * (1/10), 175, { text: "<sMedium><fff>Abilities</fff></sMedium>", fontsize:14 } ).add(this);
			new BasicTextField(gpx + gpw * (1 / 10) + inbsh, gpy + inbs*4 + 325, gpw * (9 / 10) - inbsh, 175, 
				{ text: "<left>There are three abilities: Fondle, Relax and Striptease. One of these can be used each time it's your turn." +
						"\n\n<cBC>Fondle:</cBC> Always used on the targeted player. It increases their lust, but also your own to some extent." +
						"\n\n<cBC>Relax:</cBC> Self-targeted only. It reduces your own lust." +
						"\n\n<cBC>Striptease:</cBC> targets all opponents. It massively increases their lust, but costs you IQ and lust to use." +
						"\n\nAbility details can be seen on the tooltips that will appear if you hover over their buttons with your mouse." +
						" Also note that abilities are more effective depending on different factors. The tooltips reflects this.", fontsize:14 } ).add(this);
		}
		
		/*
		 * "<sLarge><cBC>Gameplay</cBC></sLarge>" + 
						"\n\n<left><sMedium><fff>Basics</fff></sMedium> - No limit Texas Holdem, standard rules. Read more about the twists below." +
						"\n\n<sMedium><fff>Lust and IQ</fff></sMedium> - Each player has a lust meter. When this passes 100%, they come, losing IQ, more the higher their IQ is." +
							"\nLust increases passively. More the lower your opponents IQ levels are. The lower your own IQ however, the more resistant are you against reaching 100% lust." +
							"\nLust can also be affected by active abilities." +
							"\nMost of lost IQ will be added to the IQ pot. This pot will come into play after reaching a certain treshhold, granting the round winner all of its IQ." +
						"\n\n<sMedium><fff>Money and IQ</fff></sMedium> - A player uses money to bet on their cards. When a player has to bet more than their stack size" +
							"(the amount of money the currently have) to stay in the round, they go all in, betting their entire stack." +
							" If they win the hand, they get the entire pot." +
							" If they lose, their IQ is force sold both to cover their debt (the amount they went all-in for, but didn't have to pay) and to re-buy them into the game." +
							" Most of IQ lost here will also be added to the IQ pot." +
						"\n\n<sMedium><fff>Target</fff></sMedium> - In-game, the player shown in full body view on screen is your current target. Set a target by clicking on the player's portrait." +
						"\n\n<sMedium><fff>Abilities</fff></sMedium> - There are three abilities: Fondle, Relax and Striptease. One of these can be used each time it's your turn." +
							"\n<fff>Fondle:</fff> Always used on the targeted player. It increases their lust, but also your own to some extent." +
							"\n<fff>Relax:</fff> Self-targeted only. It reduces your own lust." +
							"\n<fff>Striptease:</fff> targets all opponents. It massively increases their lust, but costs you IQ and lust to use." +
							"\nAbility details can be seen on the tooltips that will appear if you hover over their buttons with your mouse." +
							"\nAlso note that abilities are more effective depending on different factors. The tooltips reflects this."
							*/
		
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