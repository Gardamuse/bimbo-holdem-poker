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
	
	public class Slider extends Component
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		protected const DISABLED:int = 3;
		
		public var clicked:Boolean = false;
		
		protected var prefix:String;
		protected var suffix:String;
		public var minCallback:Function;
		public var maxCallback:Function;
		public var minParams:Object;
		public var maxParams:Object;
		public var intervalCallback:Function;
		public var intervalParams:Object;
		protected var key:int;
		private var keyHeldDown:Boolean = false;
		private var _sliderFraction:Number = 0;
		private var _numberMax:Number = 100;
		private var _numberMin:Number = 0;
		
		/** Get the output value of slider by calling getSliderValue();
		 * 
		 * @param	x location coordinate
		 * @param	y location coordinate
		 * @param	prefix text before number
		 * @param	suffix text efter number
		 * @param	width box dimension
		 * @param	height box dimension
		 * @param	minCallback function for retrieving minimum value
		 * @param	maxCallback function for retrieving maximum value
		 * @param	minParams arguments for minCallback
		 * @param	maxParams arguments for maxCallback
		 * @param	intervalAmount what values slider will stick to. Ex: intervalAmount = 20 will have the slider stop at: 20, 40, 60...
		 * @param	keyConstant
		 */
		public function Slider(x:Number = 0, y:Number = 0, prefix:String = "", suffix:String = "", width:Number = 150, height:Number = 50,
								minCallback:Function = null, maxCallback:Function = null, minParams:Object = null, maxParams:Object = null, 
								intervalCallback:Function = null, intervalParams:Object = null, keyConstant:int = 1) 
		{
			super(x, y);
			
			key = keyConstant;

			this.maxCallback = maxCallback;
			this.minCallback = minCallback;
			this.minParams = minParams;
			this.maxParams = maxParams;
			this.prefix = prefix;
			this.suffix = suffix;
			this.intervalCallback = intervalCallback;
			this.intervalParams = intervalParams;
			
			setHitbox(width, height);
			
		}
		
		override public function update():void 
		{
			super.update();
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
				sliderFraction = (world.mouseX - x) / (width);
				if (intervalCallback != null) {
					var min:Number = 0;
					var max:Number = 100;
					var intervalAmount:Number = 1;
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
					if (intervalCallback != null)
					{
						if (intervalParams != null) intervalAmount = intervalCallback(intervalParams);
						else intervalAmount = intervalCallback();
					}
					
					var intervals:Number = (max - min) / intervalAmount;
					if (sliderFraction < 1) {
						sliderFraction = int(sliderFraction * intervals) / intervals;
					}
				}
				changeState(DOWN);
			}
			
			if (lastState != DISABLED) {
				updateGraphic();
			}
			
		}
		
		protected var lastState:int = 0;
		
		protected function changeState(state:int = 0):void
		{
			lastState = state;
		}
		
		//Has to be overridden in child slider. See PokerSlider for an example.
		protected function updateGraphic():void {
			
		}
		
		public function disabled(value:Boolean):void {
			if (value) {
				changeState(DISABLED);
			} else {
				changeState(NORMAL);
			}
		}
		
		public function set sliderFraction(value:Number):void {
			_sliderFraction = value;
			if (_sliderFraction < 0) _sliderFraction = 0;
			else if (_sliderFraction > 1) _sliderFraction = 1;
		}
		
		public function get sliderFraction():Number {
			return _sliderFraction;
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