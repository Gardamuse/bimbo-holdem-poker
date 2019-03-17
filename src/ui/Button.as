package ui 
{
	import flash.geom.Point;
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Button extends Component
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		protected const DISABLED:int = 3;
		public static const SELECTED:int = 4;
		
		public var clicked:Boolean = false;
		
		protected var text:String;
		public var callback:Function;
		public var params:Object;
		protected var key:int;
		private var keyHeldDown:Boolean = false;
		
		public function Button(x:Number=0, y:Number=0, text:String = "", width:Number = 150, height:Number = 50, callback:Function = null, params:Object = null, keyConstant:int = 1) 
		{
			super(x, y);
			
			key = keyConstant;

			this.callback = callback;
			this.params = params;
			this.text = text;
			
			setHitbox(width, height);
			
		}
		
		override public function update():void 
		{
			super.update();
			if (lastState != SELECTED){
				if (Input.pressed(key)) keyHeldDown = true;
				if (callback != null) {
					//changeState(NORMAL);
				}
				if (lastState != DISABLED && (collidePoint(x, y, world.mouseX, world.mouseY) || keyHeldDown))
				{	
					if(!keyHeldDown)Input.mouseCursor = MouseCursor.BUTTON;
					
					if (Input.mousePressed || keyHeldDown) clicked = true;
					
					if (clicked) changeState(DOWN);
					else changeState(HOVER);
					
					if (clicked && (Input.mouseReleased || Input.released(key))) {
						click();
					}
				}
				else if (lastState != DISABLED)
				{
					if (clicked) changeState(HOVER);
					else changeState(NORMAL);
					
				}

				if (Input.mouseReleased || Input.released(key)) clicked = false;
				if (Input.released(key)) keyHeldDown = false;
				if (callback == null && lastState != DISABLED) {
					changeState(DISABLED);
				}
			}
			
		}
		
		protected var lastState:int = 0;
		
		protected function changeState(state:int = 0):void
		{
			lastState = state;
		}
		
		protected function click():void
		{
			if (callback != null)
			{
				if (params != null) callback(params);
				else callback();
			}
		}
		
		public function disabled(value:Boolean):void {
			if (value) {
				changeState(DISABLED);
			} else {
				changeState(NORMAL);
			}
		}
		
		public function selected(value:Boolean):void {
			if (value) {
				changeState(SELECTED);
			} else {
				changeState(NORMAL);
			}
		}
		
		public function getState():int {
			return lastState;
		}
		
	}
}