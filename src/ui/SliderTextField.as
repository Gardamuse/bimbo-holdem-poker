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
	
	public class SliderTextField extends Component
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		protected const DISABLED:int = 3;
		protected const INVISIBLE:int = 4;
		
		protected var _prefix:String;
		protected var _suffix:String;
		public var callback:Function;
		public var params:Object;
		private var _sliderFraction:Number = 0;
		protected var scale:Number;
		
		public function SliderTextField(x:Number = 0, y:Number = 0, prefix:String = "", suffix:String = "", width:Number = 150, height:Number = 50, 
										callback:Function = null, params:Object = null, scale:Number = 1) 
		{
			super(x, y);
			
			this.callback = callback;
			this.params = params;
			this.prefix = prefix;
			this.suffix = suffix;
			this.scale = scale;
			
			setHitbox(width, height);
		}
		
		override public function update():void 
		{
			super.update();
			if (callback != null)
			{
				if (params != null) sliderFraction = callback(params);
				else sliderFraction = callback();
			}
		}
		
		protected var lastState:int = 0;
		
		protected function changeState(state:int = 0, animDuration:Number = 0.0):void
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
		
		public function get prefix():String 
		{
			return _prefix;
		}
		
		public function set prefix(value:String):void 
		{
			_prefix = value;
		}
		
		public function get suffix():String 
		{
			return _suffix;
		}
		
		public function set suffix(value:String):void 
		{
			_suffix = value;
		}
		
		protected function set sliderFraction(value:Number):void {
			_sliderFraction = value;
			if (_sliderFraction < 0) _sliderFraction = 0;
			else if (_sliderFraction > 1) _sliderFraction = 1;
		}
		
		protected function get sliderFraction():Number {
			return _sliderFraction;
		}
		
		public function disabled(value:Boolean):void {
			if (value) {
				changeState(DISABLED);
			} else {
				changeState(NORMAL);
			}
		}
		
	}
}