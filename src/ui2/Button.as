package ui2 
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
	import net.flashpunk.World;
	
	public class Button extends Component
	{
		public var clicked:Boolean = false;
		protected var key:int;
		private var keyHeldDown:Boolean = false;
		private var buttonCallbacks:Array;
		private var buttonParams:Array;
		private var justCheckIndex:int = -1;
		private var clickOnRelease:Boolean = true;
		
		/**
		 * 
		 * @param	o An Object containing some of the following name-value pairs:
			 * 			text:String. If string contains <var0>, where 0 is the index of the callback, <var0> is replaced by the callback value. Default = "".
			 * 			callbacks:Vector.&lt; Function >. Default = Vector.&lt; Function >([]).
			 * 			params:Array. A 2D array of with first index of a length no greater than the callbacks vector. Default = new Array([null]).
			 * 			fontsize:int. Default = 16.
			 * 			enabledCallback. A Callback returning true or false for wheter or not the button should be enabled.
			 * 			jci. JustCheckIndex - An int representing the index of the "justCheck" argument in the first clickCallback parameter array. This enables automatic enable/disable of button.
			 * 			clickOnRelease. True if click should happen on button release, false if click should happen on button pressed. Default: true.
		* @param	clickCallbacks The number of callback functions that will be used on buttonpress. (Callbacks[0] to Callbacks[clickCallbacks-1] will be used for buttonpress, the rest for updating text.
		* @param	keyConstant The net.flashpunk.utils.Key.LETTER (ex: Key.A) value for the key that can be pressed to press the button.
		* 
		*/
		public function Button(x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, o:Object = null, clickCallbacks:int = 0, keyConstant:int = 1) 
		{
			if (o == null) o = { };
			//Intercept and extract the callbacks and corresponding parameters meant for the button functionality and not the text update one.
			if (o.hasOwnProperty("callbacks")) {
				buttonCallbacks = o.callbacks.slice(0, clickCallbacks);
				o.callbacks = o.callbacks.slice(clickCallbacks, o.callbacks.length);
				
				if (o.hasOwnProperty("params")) {
					var buttonParamsAmount:int = 0;
					if (o.params.length > clickCallbacks) {
						buttonParamsAmount = clickCallbacks;
					} else {
						buttonParamsAmount = o.params.length;
					}
					buttonParams = o.params.slice(0, buttonParamsAmount);
					o.params = o.params.slice(buttonParamsAmount, o.params.length);
				}
			}
			if (o.hasOwnProperty("jci")) justCheckIndex = o.jci;
			if (o.hasOwnProperty("clickOnRelease")) clickOnRelease = o.clickOnRelease;
			
			super(x, y, width, height, o);
			
			key = keyConstant;
		}
		
		override public function update():void 
		{
			super.update();
			if (!fading && lastState != SELECTED){
				if (Input.pressed(key)) keyHeldDown = true;
				//if (callback != null) {
					//changeState(NORMAL);
				//}
				if (lastState != DISABLED && (collidePoint(x, y, world.mouseX, world.mouseY) || keyHeldDown))
				{	
					if(!keyHeldDown)Input.mouseCursor = MouseCursor.BUTTON;
					
					if (Input.mousePressed || keyHeldDown) clicked = true;
					
					if (clicked) changeState(DOWN);
					else changeState(HOVER);
					
					if (clicked && (Input.mouseReleased || ((Input.released(key) && clickOnRelease)) || (Input.pressed(key) && !clickOnRelease))) {
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
				/*if (callback == null && lastState != DISABLED) {
					changeState(DISABLED);
				}*/
			}
			
			//Automatically enable button if the first buttonCallback returns true and vice versa.
			if (justCheckIndex >= 0 && buttonCallbacks != null && buttonParams != null && buttonParams[0] != null) {
				buttonParams[0][justCheckIndex] = true;
				
				if (buttonCallbacks[0].apply(null, buttonParams[0]) == false && lastState != DISABLED) {
					changeState(DISABLED, 0.1);
				
				//Enable button if the first clickCallback returns true, that is, that the method will accept input.
				} else if (buttonCallbacks[0].apply(null, buttonParams[0]) == true && lastState == DISABLED) {
					changeState(NORMAL, 0.1);
					keyHeldDown = false;
				}
				
				buttonParams[0][justCheckIndex] = false;
			}
			
		}
		
		protected function click():void
		{
			if (buttonCallbacks != null) {
				for (var i:int = 0; i < buttonCallbacks.length; i++) {
					if (buttonParams != null && buttonParams[i] != null) {
						buttonCallbacks[i].apply(null, buttonParams[i]);
					} else if (buttonCallbacks[i] != null) {
						buttonCallbacks[i]();
					}
				}
			}
		}
		
		public function addForOneClick(world:World, fadeInTime:Number = 0, fadeOutTime:Number = 0, delayFadeOutTime:Number = 0):void {
			add(world, fadeInTime);
			addButtonCallback(function():void { remove(fadeOutTime, delayFadeOutTime); });
		}
		
		public function addButtonCallback(callback:Function):void {
			buttonCallbacks.push(callback);
		}
		
		public function removeLastCallback():void {
			buttonCallbacks.pop();
		}
		
	}
}