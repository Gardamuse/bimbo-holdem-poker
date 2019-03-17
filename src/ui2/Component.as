package ui2 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import com.greensock.TweenLite;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Component extends Entity 
	{		
		protected var sprite:Sprite;
		protected var g:Graphics;
		
		protected var buttonGraphic:Stamp;
		public var alpha:Number = 1.0;
		protected var fading:Boolean = false;
		
		//Normal colors
		public var topColorN:uint = 0x111111;
		public var glowColorN:uint = 0x222222;
		public var glowColor2N:uint = 0x333333;
		public var borderColorN:uint = 0x444444;
		public var fontColorN:uint = 0xffffff;
		
		//Hover colors
		public var topColorH:uint = 0x555555;
		public var glowColorH:uint = 0x666666;
		public var glowColor2H:uint = 0x777777;
		public var borderColorH:uint = 0x888888;
		public var fontColorH:uint = 0xffffff;
		
		//Pressed colors
		public var topColorP:uint = 0x999999;
		public var glowColorP:uint = 0xaaaaaa;
		public var glowColor2P:uint = 0xbbbbbb;
		public static var borderColorP:uint = 0xcccccc;
		
		//Disabled colors
		public var topColorD:uint = 0x777777;
		public var glowColorD:uint = 0x777777;
		public var glowColor2D:uint = 0x777777;
		public var borderColorD:uint = 0x777777;
		
		//Selected colors
		public var topColorS:uint = 0x111111;
		public var glowColorS:uint = 0x222222;
		public var glowColor2S:uint = 0x333333;
		public var borderColorS:uint = 0x888888;
		
		//Starting colors
		public var topColor:uint = topColorN;
		public var glowColor:uint = glowColorN;
		public var glowColor2:uint = glowColor2N;
		public var borderColor:uint = borderColorN;
		
		//States
		public static const NORMAL:int = 0;
		public static const HOVER:int = 1;
		public static const DOWN:int = 2;
		public static const DISABLED:int = 3;
		public static const INVISIBLE:int = 4;
		public static const SELECTED:int = 5;
		
		//Properties
		protected var text:String;
		public var callbacks:Array;
		protected var params:Array; //2D array of objects. First Dimension must have the same length as callbacks.
		protected var fontsize:int = 16;
		
		protected var currentString:String = "";
		
		/**
		 * 
		 * @param	o An Object containing some of the following name-value pairs:
			 * 			x:Number. Will override parameter.
			 * 			y:Number. Will override parameter.
			 * 			width:Number. Will override parameter.
			 * 			height:Number. Will override parameter.
			 * 			text:String. If string contains <var0>, where 0 is the index of the callback, <var0> is replaced by the callback value. Default = "".
			 * 			callbacks:Array. Default = new Array().
			 * 			params:Array. A 2D array of with first index of a length no greater than the callbacks vector. Default = new Array().
			 * 			fontsize:int. Default = 16.
		 */
		public function Component(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, o:Object = null) 
		{
			if (o == null) o = { };
			this.text = "";
			this.callbacks = new Array();
			this.params = new Array();
			
			if (o.hasOwnProperty("x")) x = o.x;
			if (o.hasOwnProperty("y")) y = o.y;
			if (o.hasOwnProperty("width")) width = o.width;
			if (o.hasOwnProperty("height")) height = o.height;
			if (o.hasOwnProperty("text")) text = o.text;
			if (o.hasOwnProperty("callbacks")) callbacks = o.callbacks;
			if (o.hasOwnProperty("params")) params = o.params;
			if (o.hasOwnProperty("fontsize")) fontsize = o.fontsize;
			
			lastCalls = new Array(callbacks.length);
			
			super(x, y);
			
			sprite = new Sprite;
			g = sprite.graphics;
			_m = new Matrix();
			
			setHitbox(width, height);
			currentString = text;
			updateCurrentString();
			drawLabel(currentString);
		}
		
		private var lastCalls:Array;
		override public function update():void {
			super.update();
			
			var calls:Array = new Array(callbacks.length);
			var needsUpdate:Boolean = false;
			for (var i:int = 0; i < callbacks.length; i++) {
				if (params[i] != null) {
					calls[i] = (callbacks[i].apply(null, params[i])); //Function.apply() uses all arguments in the supplied array to call the function.
				} else {
					calls[i] = callbacks[i]();
				}
				if (calls[i] != lastCalls[i]) {
					needsUpdate = true;
					lastCalls[i] = calls[i];
				}
			}
			
			if (needsUpdate) {
				//trace("component update");
				updateCurrentString(calls);
				drawLabel(currentString);
			}
		}
		
		protected var buttonBmp:BitmapData;
		public function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			drawLabel(currentString);
		}
		
		private function updateCurrentString(calls:Array=null):void {
			//if (calls != null && calls[0] != null) trace("String update: " + calls[0]);
			var result:String = text;
			var replace:String;
			if (calls != null){
				for (var j:int = 0; j < calls.length; j++) {
					replace = "<var" + j + ">";
					if (calls != null && calls[j] != null) {
						var call:Object = calls[j];
						if (call is Number) {
							call = MuseLib.thousandDivide(Number(call));
						}
						while (result != result.replace(replace, call)) {
							result = result.replace(replace, call);
						}
					}
				}
			}
			currentString = result;
		}
		
		private var _m:Matrix;
		
		protected function drawStamp(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):Stamp
		{	
			return new Stamp(drawBitmap(width, height, offsetX, offsetY, sprite), -offsetX, -offsetY);
		}
		
		protected function drawImage(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):Image
		{
			var img:Image = new Image(drawBitmap(width, height, offsetX, offsetY, sprite));
			img.x = -offsetX;
			img.y = -offsetY;
			return img;
		}
		
		protected function drawBitmap(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):BitmapData
		{
			if (sprite == null) sprite = this.sprite;
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			_m.tx = offsetX;
			_m.ty = offsetY;
			bd.draw(sprite, _m);
			
			return bd
		}
		
		protected function renderGraphic(graphic:Graphic):void
		{
			if (graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					_point.x = x;
					_point.y = y;
				}
				else _point.x = _point.y = 0;
				_camera.x = world ? world.camera.x : FP.camera.x;
				_camera.y = world ? world.camera.y : FP.camera.y;
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, _camera);
			}
		}
		protected var _point:Point = FP.point;
		protected var _camera:Point = FP.point2;
		
		
		protected function drawLabel(text:String):void
		{
			
		}
		
		protected var glare:Stamp;
		protected var label:Stamp;
		protected var textLabel:Text;
		protected var labelLabel:Text;
		override public function render():void 
		{
			super.render();
			
			renderGraphic(glare);
			renderGraphic(textLabel);
			renderGraphic(labelLabel);
			//renderGraphic(label);
		}
		
		protected var lastState:int = 0;
		public function changeState(state:int = 0, animDuration:Number = 0.0):void
		{
			if (state == lastState) return;
			
			var duration:Number = animDuration;
			//if (lastState == DOWN) duration = 0.05;
			
			fading = true;
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN }, onUpdate: updateGraphic, onComplete: fadingFalse } );
					//if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorH, glowColor: glowColorH, borderColor: borderColorH }, onUpdate: updateGraphic, onComplete: fadingFalse } );
					//if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorP, glowColor: glowColorP, borderColor: borderColorP}, onUpdate: updateGraphic, onComplete: fadingFalse } );
					//new Sfx(Assets.CLICK).play();
					break;
				case DISABLED:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorD, glowColor: glowColorD, borderColor: borderColorD}, onUpdate: updateGraphic, onComplete: fadingFalse } );
					//new Sfx(Assets.CLICK).play();
					break;
				case INVISIBLE:
					TweenLite.to(this, duration, { alpha: 0.0, onUpdate: updateGraphic, onComplete: fadingFalse } );
					break;
				case SELECTED:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorS, glowColor: glowColorS, glowColor2: glowColor2S, borderColor: borderColorS}, onUpdate: updateGraphic, onComplete: fadingFalse } );
					//new Sfx(Assets.CLICK).play();
					break;
			}
			
			lastState = state;
		}
		
		private function fadingFalse():void {
			fading = false;
		}
		
		public function getState():int {
			return lastState;
		}
		
		/** If you want the text to be displayed at once, do not forget to run .updateGraphic()!
		 * 
		 * @param	text
		 */
		public function setText(text:String):void {
			this.text = text;
			currentString = text;
			updateGraphic();
		}
		
		public function getText():String {
			return text;
		}
		
		/** 0x000001 is the nochange color, entering this means the color won't change.
		 * Warning: this method is only hastily implemented. */
		public function setColor(topColor:uint = 0x000001, glowColor:uint = 0x000001, glowColor2:uint = 0x000001, borderColor:uint = 0x000001):void {
			var noChange:uint = 0x000001;
			if (topColor != noChange) {
				this.topColor = topColor;
			}
			if (borderColor != noChange) {
				this.borderColor = borderColor;
				this.borderColorN = borderColor;
			}
			if (glowColor != noChange) {
				this.glowColor = glowColor;
			}
			if (glowColor2 != noChange) {
				this.glowColor2 = glowColor2;
			}
			updateGraphic();
		}
		
		public function addCallback(callback:Function, params:Array = null):void {
			callbacks.push(callback);
			this.params.push(params);
		}
		
		/** Adds the component to the world. Optionally it first fades in from invisible over a duration. As a side effect, state is set to Component.NORMAL.*/
		public function add(world:World, fadeInTime:Number = 0):void {
			changeState(INVISIBLE);
			world.add(this);
			changeState(NORMAL, fadeInTime);
		}
		
		/** Adds component to world and then removes it after a delay. Optionally fades in and out. If you do not know the time you want to display it, use add() instead.*/
		public function popup(world:World, displayTime:Number, fadeInTime:Number = 0, fadeOutTime:Number = 0):void {
			add(world, fadeInTime);
			delay(remove, [fadeOutTime], displayTime);
		}
		
		/** Removes the component (and entity) from the world it has been added to. Optionally it first fades to invisible over a duration.
		 * 	Might not work well with long fade times as it removes the object when 9/10 of the fadetime has passed to avoid the component flickering.*/
		public function remove(fadeOutTime:Number = 0, delayFadeOutTime:Number = 0):void {
			changeState(DISABLED, 0.1);
			delay(changeState, [INVISIBLE, fadeOutTime], delayFadeOutTime); //changeState(INVISIBLE, fadeOutTime);
			if (world != null) delay(world.remove, [this], delayFadeOutTime + fadeOutTime - fadeOutTime/10); //To make sure element is removed before it has a chance to become active again and change state.
		}
		
		/** Calls a function with some parameters after a delay in seconds. Repeats a number of times. */
		public static function delay(func:Function, params:Array, delay:Number = 1, repeat:int = 1):void
		{
			var f:Function;
			var timer:Timer = new Timer(int(delay*1000), repeat);
			timer.addEventListener(TimerEvent.TIMER, f = function():void
			{
				func.apply(null, params);
				if (timer.currentCount == repeat)
				{
				   timer.removeEventListener(TimerEvent.TIMER, f);
				   timer = null;
				}
			});
			timer.start();
		}
		
		//Override
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			
		}
	}
}