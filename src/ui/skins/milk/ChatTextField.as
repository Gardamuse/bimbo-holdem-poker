package ui.skins.milk 
{
	import com.greensock.TweenLite;
	import flash.automation.AutomationAction;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import ui.Button;
	
	public class ChatTextField extends ui.TextField
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		protected var textLabel:Text;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		
		
		//Normal colors
		public var topColorN:uint = 0xffffff; //1a446b
		public var glowColorN:uint = 0x000000;
		public var borderColorN:uint = 0xdaa520;
		public var fontColorN:uint = 0x000000;
		
		public var alpha:Number = 1.0;
		
		//Hover colors
		public var topColorH:uint = 0x245585;
		public var glowColorH:uint = 0xffffff;
		public var glowColor2H:uint = 0x000000;
		public var borderColorH:uint = 0xE0D1A4;
		
		//Pressed colors
		public var topColorP:uint = 0x094680;
		public var glowColorP:uint = 0xfffffF;
		public var glowColor2P:uint = 0x000000;
		public var borderColorP:uint = 0xBF9D36;
		
		//Disabled colors
		public var topColorD:uint = 0x324B61;
		public var glowColorD:uint = 0xFFFFFF;
		public var glowColor2D:uint = 0x000000;
		public var borderColorD:uint = 0x718dab;
		
		//Starting colors
		public var topColor:uint = topColorN;
		public var glowColor:uint = glowColorN;
		public var borderColor:uint = borderColorN;
		
		public var fontSize:int;
		
		public function ChatTextField(x:Number=0, y:Number=0, prefix:String="", suffix:String="", width:Number=150, fontSize:int=16, callback:Function = null, params:Object=null) 
		{
			var string:String;
			if (callback != null)
			{
				if (params != null) string = prefix + callback(params) + suffix;
				else string = prefix + callback() + suffix;
			} else {
				string = prefix + suffix;
			}
			var height:int = getTextHeight(string, width, fontSize);
			if (height < fontSize) height = fontSize + 2;
			
			super(x, y, prefix, suffix, width, height, callback, params);
			
			this.fontSize = fontSize;
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(new String(prefix + suffix));
			
			drawMask();
		}
		
		override public function update():void {
			super.update();
			if (callback != null)
			{
				if (params != null) drawLabel(new String(prefix + callback(params) + suffix));
				else drawLabel(new String(prefix + callback() + suffix));;
			}
		}
		
		protected function drawMask():void
		{
			g.clear();
			g.beginFill(0x000000);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
		}
		
		protected function drawGlare():void
		{
			var mask:Sprite = new Sprite;
			mask.graphics.copyFrom(g);
			
			sprite.filters = [];
			g.clear();
			g.beginFill(0xFFFFFF, 0.25);
			g.drawEllipse( -width * 0.25, -height * 0.6, width * 1.5, height);
			sprite.mask = mask;
			
			glare = drawStamp(width, height * 0.4);
		}
		
		private var textField:TextField = new TextField();
		protected function drawLabel(text:String):void
		{
			
			//var t:TextField = new TextField();
			textField.replaceText(0, textField.length-1, text);
			
			var tf:TextFormat = new TextFormat("Mytype", fontSize, fontColorN);
			tf.align = "center";
			
			textField.defaultTextFormat = tf;
			
			textField.width = width-10;
			textField.height = height;
			textField.embedFonts = true;
			textField.wordWrap = true;
			textField.text = text;
			textLabel = new Text(text, 0, 0, {font:"Mytype", size:fontSize, align:"center", wordWrap:true, width:width-10, height:height, color:fontColorN, alpha:alpha});
			textLabel.y = height/2 - textLabel.textHeight/2;
			textLabel.x = 5;
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(topColor, alpha);
			g.drawRoundRect(0, 0, width, height, 30, 30);
			g.endFill();
			
			//g.lineStyle(4, borderColor);
			//g.drawRoundRect(2, 2, width - 4, height - 4, 10, 10);
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width, height, 30, 30);
			//g.drawRect(0, 0, width, height / 2);
			//g.drawRect(0, 0, width / 2, height);
			
			//sprite.filters = [new GlowFilter(glowColor, .4, 32, 32, 2, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
		private var _m:Matrix = new Matrix;
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(glare);
			renderGraphic(label);
			renderGraphic(textLabel);
		}
		
		override protected function changeState(state:int = 0, animDuration:Number = 0.0):void 
		{
			if (state == lastState) return;
			
			var duration:Number = animDuration;
			if (lastState == DOWN) duration = 0.05;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN }, onUpdate: updateGraphic } );
					TweenLite.to(this, duration, { alpha:1.0, onUpdate: updateGraphic } );
					//if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { hexColors: { topColor: topColorH, glowColor: glowColorH, borderColor: borderColorH }, onUpdate: updateGraphic } );
					//if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, 0.0, { hexColors: { topColor: topColorP, glowColor: glowColorP, borderColor: borderColorP}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
				case DISABLED:
					TweenLite.to(this, duration, { alpha:0.0} );
					TweenLite.to(this, duration, { hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
			}
			
			super.changeState(state);
		}
		
		protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			if (callback != null)
			{
				if (params != null) drawLabel(new String("Test"));//prefix + callback(params) + suffix
				else drawLabel(new String("Test2"));//prefix + callback() + suffix
			} else {
				drawLabel(new String(prefix + suffix))
			}
			
		}
		
		public function setText(text:String):void {
			this.prefix = text;
			drawLabel(text);
		}
		
		public function disabledSmooth(value:Boolean, duration:Number):void {
			if (value) {
				changeState(DISABLED, duration);
			} else {
				changeState(NORMAL, duration);
			}
		}
		
		private function getTextHeight(string:String, width:int, fontSize:int):int {
			var value:Text = new Text(string, 0, 0, { font:"Mytype", size:fontSize, align:"center", wordWrap:true, width:width - 10 } );
			return value.textHeight;
		}
	}
}