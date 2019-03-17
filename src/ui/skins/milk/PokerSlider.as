package ui.skins.milk 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import ui.Button;
	import ui.Slider;
	
	public class PokerSlider extends Slider
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		//Normal colors
		public var topColorN:uint = 0x226622;
		public var glowColorN:uint = 0xFFFFFF;
		public var glowColor2N:uint = 0x000000;
		public var borderColorN:uint = 0xdaa520;
		public var barColorN:uint = 0x772222;
		
		//Hover colors
		public var topColorH:uint = 0x225522;
		public var glowColorH:uint = 0xffffff;
		public var glowColor2H:uint = 0x000000;
		public var borderColorH:uint = 0xE0D1A4;
		public var barColorH:uint = 0x772222;
		
		//Pressed colors
		public var topColorP:uint = 0x337733;
		public var glowColorP:uint = 0xfffffF;
		public var glowColor2P:uint = 0x000000;
		public var borderColorP:uint = 0xBF9D36;
		public var barColorP:uint = 0x772222;
		
		//Disabled colors
		public var topColorD:uint = 0x324B31;
		public var glowColorD:uint = 0xFFFFFF;
		public var glowColor2D:uint = 0x000000;
		public var borderColorD:uint = 0x616d4b;
		public var barColorD:uint = 0x443333;
		
		//Starting colors
		public var topColor:uint = topColorN;
		public var glowColor:uint = glowColorN;
		public var glowColor2:uint = glowColor2N;
		public var borderColor:uint = borderColorN;
		public var barColor:uint = barColorN;
		
		
		
		public var fontSize:int;
		
		public function PokerSlider(x:Number = 0, y:Number = 0, prefix:String = "", suffix:String = "", width:Number = 150, height:Number = 50,
									minCallback:Function = null, maxCallback:Function = null, minParams:Object = null, maxParams:Object = null, fontSize:int = 16,
									intervalCallback:Function = null, intervalParams:Object = null, keyConstant:int = 1) 
		{
			super(x, y, prefix, suffix, width, height, minCallback, maxCallback, minParams, maxParams, intervalCallback, intervalParams, keyConstant);
			
			this.fontSize = fontSize;
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(prefix + getSliderValueRound() + suffix);
			
			drawMask();
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
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Mytype", fontSize, 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true;
			t.text = text;
			t.filters = [new GlowFilter(0x6ACFFF, 0.0, 7, 7, 2, 3)];
			
			label = drawStamp(width + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			var roundX:int = 0;
			var roundY:int = 0;
			var borderWidth:int = 16;
			
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(topColor);
			g.drawRoundRect(0, 0, width, height, 1, 1);
			g.endFill();
			
			g.beginFill(barColor)
			g.drawRoundRect(0, 0, width*sliderFraction, height-1, 1, 1);
			g.endFill();
			
			g.lineStyle(0, 0x00000);
			g.drawRoundRect(0, 0, width*sliderFraction, height-1, 1, 1);
			
			g.lineStyle(4, borderColor);
			g.drawRoundRect(2, 2, width - 4, height - 4, 1, 1);
			
			g.lineStyle(0, 0x00000);
			g.drawRoundRect(0, 0, width-1, height-1, 1, 1);
			
			sprite.filters = [/*new GlowFilter(glowColor, .3, 64, 64, 1, 2, true),*/ new GlowFilter(glowColor2, .4, 32, 32, 2, 2, true)];
			
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
		}
		
		override protected function changeState(state:int = 0):void 
		{

			if (state == lastState) return;
			
			var duration:Number = 0.15;
			if (lastState == DOWN) duration = 0.0;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN, barColor: barColorN }, onUpdate: updateGraphic } );
					break;
				case HOVER:
					TweenLite.to(this, duration, { hexColors: { topColor: topColorH, glowColor: glowColorH, borderColor: borderColorH, barColor: barColorH }, onUpdate: updateGraphic } );
					break;
				case DOWN:
					TweenLite.to(this, 0.0, { hexColors: { topColor: topColorP, glowColor: glowColorP, borderColor: borderColorP, barColor: barColorP }, onUpdate: updateGraphic } );
					break;
				case DISABLED:
					TweenLite.to(this, 0.0, { hexColors: { topColor: topColorD, glowColor: glowColorD, borderColor: borderColorD, barColor: barColorD }, onUpdate: updateGraphic } );
					break;
			}
			
			super.changeState(state);
		}
		
		override protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			drawLabel(prefix + getSliderValueRound() + suffix);
		}
	}
}