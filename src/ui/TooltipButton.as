package ui 
{
	import net.flashpunk.World;
	import ui.skins.milk.MilkTextField;
	import net.flashpunk.FP;
	import ui2.basic.BasicTextField;
	import ui2.Component;
	import ui.Button;
	
	public class TooltipButton extends Button
	{
		
		private var tooltip:BasicTextField;
		public function TooltipButton(x:Number = 0, y:Number = 0, text:String = "", width:Number = 150, height:Number = 50,
										callback:Function = null, params:Object = null, keyConstant:int = 1, tooltip:BasicTextField=null) 
		{
			super(x, y, text, width, height, callback, params, keyConstant);
			if (tooltip != null) {
				this.tooltip = tooltip;
				tooltip.changeState(ui2.Component.INVISIBLE);
			}
		}
		
		override public function added():void {
			if (tooltip != null) {
				tooltip.add(world);
			}
		}
		
		private var time0:Number = 0;
		private var time1:Number = 0;
		private var lastX:Number = 0;
		private var lastY:Number = 0;
		private var showTip:Boolean = false;
		override public function update():void {
			super.update();
			
			if (tooltip != null) {
				if (lastState == HOVER) {
					if (lastX == world.mouseX && lastY == world.mouseY || showTip) {
						time1 += FP.elapsed;
					} else {
						lastX = world.mouseX;
						lastY = world.mouseY;
						time1 = 0;
					}
				} else {
					time1 = 0;
					showTip = false;
				}
				if (time1 > 0.5) {
					showTip = true;
					tooltip.x = x + width;
					tooltip.y = y;
					tooltip.changeState(ui2.Component.NORMAL, 0.3);
				} else {
					tooltip.changeState(ui2.Component.INVISIBLE, 0.3);
				}
			}
		}
		
		override protected function changeState(state:int = 0):void 
		{
			super.changeState(state);
		}
		
	}

}