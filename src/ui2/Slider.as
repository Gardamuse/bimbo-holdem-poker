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
	
	public class Slider extends Component
	{		
		public var clicked:Boolean = false;
		
		public var minCallback:Function = null;
		public var maxCallback:Function = null;
		public var minParams:Object = null;
		public var maxParams:Object = null;
		public var intervalCallback:Function = null;
		public var intervalParams:Object = null;
		public var fractionCallback:Function = null;
		public var fractionParams:Object = null;
		public var onChangeCallback:Function = null;
		protected var gripWidth:Number = 0;
		
		private var _sliderFraction:Number = 0;
		private var _numberMax:Number = 100;
		private var _numberMin:Number = 0;
		
		private var oldSliderFraction:Number = 0;
		
		/** Get the output value of slider by calling getSliderValue().
		 * 
		 * getSliderValueRound() is automatically added as the first callback function. All other callback functions 
		 * 
		 * @param	o An Object containing some of the following name-value pairs:
			 * 			text:String. If string contains <var0>, where 0 is the index of the callback, <var0> is replaced by the callback value. Default = "".
			 * 			callbacks:Array. Default = new Array().
			 * 			params:Array. A 2D array of with first index of a length no greater than the callbacks vector. Default = new Array([null]).
			 * 			fontsize:int. Default = 16.
			 * 
			 *			minCallback Function for retrieving minimum value
			 *			maxCallback Function for retrieving maximum value
			 *			minParams Arguments for minCallback
			 *			maxParams Arguments for maxCallback
			 *			intervalCallback Function that returns value the slider will stick to. Ex: if value = 20 the slider will stop at: 20, 40, 60...
			 *			intervalParams Arguments for intervalCallback
			 * 			fractionCallback If set, makes slider non-adjustable and instead uses fraction returned by this function.
			 * 			fractionParams Arguments for fractionCallback
			 * 			onChange: Callback for function to run when slider value is changed by dragging. Recommended: Use this with an interval callback.
			 * 			gripWidth How wide in pixels, the grip is. Only applicable if this is a grip slider.
		 */
		public function Slider(x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, o:Object = null) 
		{
			if (o.hasOwnProperty("maxCallback")) this.maxCallback = o.maxCallback;
			if (o.hasOwnProperty("minCallback")) this.minCallback = o.minCallback;
			if (o.hasOwnProperty("minParams")) this.minParams = o.minParams;
			if (o.hasOwnProperty("maxParams")) this.maxParams = o.maxParams;
			if (o.hasOwnProperty("intervalCallback")) this.intervalCallback = o.intervalCallback;
			if (o.hasOwnProperty("intervalParams")) this.intervalParams = o.intervalParams;
			if (o.hasOwnProperty("onChange")) this.onChangeCallback = o.onChange;
			if (o.hasOwnProperty("gripWidth")) this.gripWidth = o.gripWidth;
			
			if (o.hasOwnProperty("fractionCallback")) this.fractionCallback = o.fractionCallback;
			if (o.hasOwnProperty("fractionParams")) this.fractionParams = o.fractionParams;
			
			//Add sliderValueRound as the first callback function.
			if (o.hasOwnProperty("callbacks")) {
				var array:Array = o.callbacks.reverse();
				array.push(getSliderValueRound);
				o.callbacks = array.reverse();
				
				//Make sure that params array fits with callbacks array.
				if (o.hasOwnProperty("params")) {
					var array2:Array = o.params.reverse();
					array2.push(null);
					o.params = array2.reverse();
				} else {
					o.params = [null];
				}
			} else {
				o.callbacks = [getSliderValueRound];
			}
			
			super(x, y, width, height, o);
		}
		
		override public function update():void 
		{
			super.update();
			if (fractionCallback == null) {
				if (collidePoint(x, y, world.mouseX, world.mouseY) && lastState != DISABLED)
				{	
					changeState(HOVER);
					if (Input.mousePressed) clicked = true;
					Input.mouseCursor = MouseCursor.BUTTON;
				}
			
				//Change back to normal state if hovering but mouse no longer over slider.
				if (lastState == HOVER && !collidePoint(x, y, world.mouseX, world.mouseY)) {
					changeState(NORMAL);
				}
				
				//Be able to adjust slider when mouse has been pressed down inside the slider.
				if (clicked && lastState != DISABLED) {
					changeState(DOWN);
				}
				
				//Stop being able to adjust slider when mouse is released.
				if (Input.mouseReleased && lastState != DISABLED) {
					clicked = false;
					changeState(NORMAL);
				}
			
				//While mouse is pressed, adjust slider.
				if (lastState == DOWN) {
					// Slider 
					if (gripWidth > 0) {
						// If slider has a grip. Drag by the middle of the grip.
						sliderFraction = (world.mouseX - x + (gripWidth / 2 * (0 - sliderFraction)) - (gripWidth / 2 * (1 - sliderFraction))) / (width - gripWidth);
					} else {
						// Slider without grip. Instead the edge of the bar is dragged.
						sliderFraction = (world.mouseX - x) / (width);
					}
					// If an interval is set
					if (intervalCallback != null) {
						var min:Number = 0;
						var max:Number = 100;
						var intervalAmount:Number = 1;
						// Set min
						if (minCallback != null)
						{
							if (minParams != null) min = minCallback(minParams);
							else min = minCallback();
						}
						// Set max
						if (maxCallback != null)
						{
							if (maxParams != null) max = maxCallback(maxParams);
							else max = maxCallback();
						}
						// Set interval amount
						if (intervalCallback != null)
						{
							if (intervalParams != null) intervalAmount = intervalCallback(intervalParams);
							else intervalAmount = intervalCallback();
						}
						// Divide total range in bits that are intervalAmount long.
						var intervals:Number = (max - min) / intervalAmount;
						if (intervals <= 0) {
							intervals = 1;
						}
						// Round slider fraction according to interval
						if (sliderFraction < 1) {
							sliderFraction = Math.round(sliderFraction * intervals) / intervals;
						}
					}
					changeState(DOWN);
				}
			} else {
				if (fractionParams != null) {
					sliderFraction = fractionCallback(fractionParams);
				} else {
					sliderFraction = fractionCallback();
				}
			}
			
			if (lastState != DISABLED) {
				updateGraphic();
			}
			
		}
		
		public function set sliderFraction(value:Number):void {
			oldSliderFraction = sliderFraction;
			
			_sliderFraction = value;
			if (_sliderFraction < 0) _sliderFraction = 0;
			else if (_sliderFraction > 1) _sliderFraction = 1;
			
			if (sliderFraction != oldSliderFraction) {
				if (onChangeCallback != null) {
					onChangeCallback();
				}
			}
		}
		
		public function get sliderFraction():Number {
			return _sliderFraction;
		}
		
		public function setSliderValue(value:Number):void {
			var min:Number = 0;
			var max:Number = 100;
			if (minCallback != null)
			{
				if (minParams != null) min = minCallback(minParams);
				else min = minCallback();
			}
			
			if (maxCallback != null)
			{
				if (maxParams != null) max = maxCallback(maxParams);
				else max = maxCallback();
			}
			
			if  (min > max) min = max;
			sliderFraction = (value - min) / (max - min);
			
		}
		
		/**Call this to get the slidervalue!*/
		public function getSliderValue():Number {
			var min:Number = 0;
			var max:Number = 100;
			if (minCallback != null)
			{
				if (minParams != null) min = minCallback(minParams);
				else min = minCallback();
			}
			
			if (maxCallback != null)
			{
				if (maxParams != null) max = maxCallback(maxParams);
				else max = maxCallback();
			}
			
			if  (min > max) min = max;
			var result:Number = min + sliderFraction * (max - min);
			if (result > int.MIN_VALUE && result < int.MAX_VALUE) {
				return result;
			} else {
				return 0;
			}
		}
		
		/**Call this to get the rounded slidervalue!*/
		public function getSliderValueRound():Number {
			return Math.round(getSliderValue());
		}
	}
}