package 
{
	import net.flashpunk.World;
	import ui.skins.milk.MilkButton;
	import ui.skins.milk.MilkTextField;
	import ui.skins.milk.PokerSlider;
	import net.flashpunk.FP;
	import ui.skins.milk.PokerTooltipButton;
	import ui.skins.milk.TooltipTextField;
	import ui2.basic.BasicTextField;
	import ui2.Component;
	import worlds.PokerWorld;
	import ui2.basic.BasicButton;

	public class ManualControl extends ControlSystem
	{
		private var checkB:BasicButton;
		private var checkF:BasicTextField;
		private var raiseB:BasicButton;
		private var raiseS:PokerSlider;
		private var foldB:BasicButton;
		
		private var bimbofyB:BasicButton;
		private var fondleB:PokerTooltipButton;
		private var stripteaseB:PokerTooltipButton;
		//private var buyIqB:MilkButton;
		//private var buyIqF:MilkTextField;
		//private var buyIqAmountF:MilkTextField;
		private var relaxB:PokerTooltipButton;
		
		private var targetCam:WomanCam;
				
		public function ManualControl(world:worlds.PokerWorld, bimbo:Bimbo) 
		{
			super(world, bimbo);
		}
		
		override public function init():void {
			super.init();
			var x:Number = bimbo.x;
			var y:Number = bimbo.y;
			var pw:Number = bimbo.getDisplayPortraitWidth(); //Portrait Width
			var fw:Number = bimbo.getDisplayFieldWidth(); //Field Width
			var w:Number = pw + fw; //Total Width
			var sh:Number = FP.screen.height;
			var buttonWidth:Number = fw / 3;
			var bbw:Number = 140; //Bimbo Button Width
			var buttonWidth2:Number = 60;

			checkB = new BasicButton(x + w, y, buttonWidth, 50, { text:"Check", callbacks:[check] }, 1 );
			//checkB.disabled(true);
			//world.add(checkB);
			checkB.add(world);
			checkB.changeState(Component.DISABLED);
			
			checkF = new BasicTextField(x + w, y + 50, buttonWidth, 50, {text:"<var0>", fontsize:16, callbacks:[world.getCheckAmountRound], params:[[bimbo]]});
			checkF.add(world);
			checkF.changeState(Component.DISABLED); //If this is done before adding to world, it doesn't work for some reason.
			
			raiseB = new BasicButton(x + w + buttonWidth, y, buttonWidth, 50, { text:"Raise", callbacks:[raise] }, 1 );
			//raiseB.disabled(true);
			//world.add(raiseB);
			raiseB.add(world);
			raiseB.changeState(Component.DISABLED);
			
			raiseS = new PokerSlider(x + w + buttonWidth, y + 50, "", "", buttonWidth, 50, world.getMinRaiseAmount, bimbo.getMoney, bimbo, null, 16, world.getSmallBlind);
			raiseS.disabled(true);
			world.add(raiseS);
			
			foldB = new BasicButton(x + w + buttonWidth*2, y, buttonWidth, 50, { text:"Fold", callbacks:[fold] }, 1 );
			//foldB.disabled(true);
			//world.add(foldB);
			foldB.add(world);
			foldB.changeState(Component.DISABLED);
			
			//Bimbo moves
			fondleB = new PokerTooltipButton(300, 500 - 100, "Fondle", bbw, 50, fondle, 16, null, 1, 
				new BasicTextField(0, 0, 200, 50, {text:"<left><cBC>Cost:</cBC> +Your Lust\n<cBC>Effect:</cBC> +Target Lust\nMore effective for bimbos.</left>", fontsize:13}));
			fondleB.disabled(true);
			world.add(fondleB);
			
			stripteaseB = new PokerTooltipButton(300, 500 - 150, "Striptease", bbw, 50, striptease, 16, null, 1,
				new BasicTextField(0, 0, 275, 50, 
				{text:"<left><cBC>Cost:</cBC> <var0> IQ\n<cBC>Effect:</cBC> +All Opponents Lust, -Your Lust\nMore effective for bimbos and high lust.</left>", fontsize:13, callbacks:[world.getStripteaseCostString]}));
			stripteaseB.disabled(true);
			world.add(stripteaseB);
			
			//buyIqB = new MilkButton(300, 500-100, "Buy IQ", bbw, 50, bimbofy);
			//buyIqB.disabled(true);
			//world.add(buyIqB);
			
			/*buyIqF = new MilkTextField(300+bbw, 500-100, "", " $", buttonWidth2, 50, 14, world.getBuyIqPrice);
			buyIqF.disabled(true);*/
			//world.add(buyIqF);
			
			/*buyIqAmountF = new MilkTextField(300+bbw+buttonWidth2, 500-100, "+", " IQ", buttonWidth2, 50, 14, world.getBuyIqAmount);
			buyIqAmountF.disabled(true);*/
			//world.add(buyIqAmountF);
			
			relaxB = new PokerTooltipButton(300, 500 - 50, "Relax", bbw, 50, relax, 16, null, 1,
				new BasicTextField(0, 0, 150, 50, {text:"<left><cBC>Cost:</cBC> None\n<cBC>Effect:</cBC> -Your Lust\nFlat efficiency.</left>", fontsize:14}));
			relaxB.disabled(true);
			world.add(relaxB);
			
			
			
		}
		
		override protected function decideMove():void {
			super.decideMove();
			//checkB.disabled(false);
			checkB.changeState(Component.NORMAL);
			checkF.changeState(Component.NORMAL);
			if (bimbo.canRaise) {
				//raiseB.disabled(false);
				raiseB.changeState(Component.NORMAL);
				raiseS.disabled(false);
			}
			//foldB.disabled(false);
			foldB.changeState(Component.NORMAL);
			
			if (world.getCheckAmount(bimbo) < 0.5) {
				checkB.setText("Check");
			} else {
				checkB.setText("Call");
			}
		}
		
		override protected function decideBimboMove():void {
			fondleB.disabled(false);
			stripteaseB.disabled(false);
			if (bimbofyB != null) {
				//bimbofyB.disabled(false);
				bimbofyB.changeState(Component.NORMAL);
			}
			/*if (bimbo.canBuyIq) {
				buyIqB.disabled(false);
				buyIqF.disabled(false);
				buyIqAmountF.disabled(false);
			}*/
			relaxB.disabled(false);
		}
		
		override protected function check():void {
			super.check();
			onEveryButton();
		}
		
		override protected function raise():void {
			betAmount = raiseS.getSliderValue();
			super.raise();
			onEveryButton();
		}
		
		override protected function fold():void {
			super.fold();
			onEveryButton();
		}
		
		override protected function fondle():void {
			super.fondle();
			onEveryBimboButton();
		}
		
		override protected function striptease():void {
			super.striptease();
			onEveryBimboButton();
		}
		
		override protected function bimbofy():void {
			super.bimbofy();
			onEveryBimboButton();
		}
		
		override protected function relax():void {
			super.relax();
			onEveryBimboButton();
		}
		
		//Clicking any button should disable all other buttons
		private function onEveryButton():void {
			checkB.changeState(Component.DISABLED);
			checkF.changeState(Component.DISABLED);
			raiseB.changeState(Component.DISABLED);
			raiseS.disabled(true);
			raiseB.changeState(Component.DISABLED);
			foldB.changeState(Component.DISABLED);
			onEveryBimboButton();
		}
		
		//Clicking any bimbo action button should disable all other such buttons
		private function onEveryBimboButton():void {
			fondleB.disabled(true);
			stripteaseB.disabled(true);
			//buyIqB.disabled(true);
			//buyIqF.disabled(true);
			//buyIqAmountF.disabled(true);
			relaxB.disabled(true);
			if (bimbofyB != null) {
				//bimbofyB.disabled(true);
				bimbofyB.changeState(Component.DISABLED);
			}
			selectedBimbo = world.getSelectedBimbo();
		}
		
		override public function setBimbofyActive(bool:Boolean):void {
			if (bool) {
				bimbofyB = new BasicButton(300, 500 - 200, 140, 50, { text:"Bimbofy", callbacks:[bimbofy] }, 1 );
				//bimbofyB.disabled(!bimbo.isCurrentPlayer);
				//world.add(bimbofyB);
				bimbofyB.add(world);
				if (!bimbo.isCurrentPlayer) {
					bimbofyB.changeState(Component.DISABLED);
				} else {
					bimbofyB.changeState(Component.NORMAL);
				}
			} else {
				world.remove(bimbofyB);
				bimbofyB = null;
			}
		}
	}

}