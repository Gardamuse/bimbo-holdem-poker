package ui.skins.player 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
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
	
	public class PlayerButton extends Button 
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		//Normal colors
		public var topColorN:uint = 0x13508A;
		public var glowColorN:uint = 0xFFFFFF;
		public var glowColor2N:uint = 0x000000;
		public var borderColorN:uint = 0x79AEE8;
		
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
		
		//Other variables
		public var fontType:String = "percent";
		public var fontSize:int;
		protected var buttonGlow:GlowFilter;
		public var flipped:Boolean = false;
		
		//Starting colors
		public var topColor:uint = topColorN;
		public var glowColor:uint = glowColorN;
		public var glowColor2:uint = glowColor2N;
		public var borderColor:uint = borderColorN;
		
		
		
		
		
		public function PlayerButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, fontSize:int=16, params:Object=null, keyConstant:int = 1, flipped:Boolean = false) 
		{
			super(x, y, text, width, height, callback, params, keyConstant);
			
			this.fontSize = fontSize;
			this.flipped = flipped;
			
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(text);
			drawMask();
		}
		
		public function renew(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, fontSize:int=16, params:Object=null, keyConstant:int = 1):void 
		{
			
			this.x = x;
			this.y = y;
			
			setHitbox(width, height);
			key = keyConstant;

			this.callback = callback;
			this.params = params;
			this.text = text;
			
			this.fontSize = fontSize;
			
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(text);
			drawMask();
		}
		
		protected function drawMask():void
		{
			/*g.clear();
			g.beginFill(glowColor2);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);*/
		}
		
		protected function drawGlare():void
		{
			/*var mask:Sprite = new Sprite;
			mask.graphics.copyFrom(g);
			
			sprite.filters = [];
			g.clear();
			g.beginFill(glowColor, 0.25);
			g.drawEllipse( -width * 0.25, -height * 0.6, width * 1.5, height);
			sprite.mask = mask;
			
			glare = drawStamp(width, height * 0.4);*/
		}
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat(fontType, fontSize, 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true;
			t.text = text;
			t.filters = [new GlowFilter(glowColor, 0.0, 7, 7, 2, 3)];
			
			label = drawStamp(width + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
		}
		
		private var m:Matrix = new Matrix;
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			var roundX:int = 20;
			var roundY:int = 0;
			var borderWidth:int = 8;
			
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			
			if (!flipped) {
				g.beginFill(topColor);
				g.drawRoundRectComplex(0, 0, width, height, roundX, roundX, 0, 0);
				g.endFill();
				
				g.lineStyle(borderWidth, borderColor);
				g.drawRoundRectComplex(borderWidth / 2, borderWidth / 2, width - borderWidth, height - borderWidth, roundX, roundX, 0, 0);
				
				g.lineStyle(1, 0x000000);
				g.drawRoundRectComplex(0, 0, width-1, height-1, roundX+1, roundX+1, 0, 0);
			} else {
				g.beginFill(topColor);
				g.drawRoundRectComplex(0, 0, width, height, 0, 0, roundX, roundX);
				g.endFill();
				
				g.lineStyle(borderWidth, borderColor);
				g.drawRoundRectComplex(borderWidth / 2, borderWidth / 2, width - borderWidth, height - borderWidth, 0, 0, roundX, roundX);
				
				g.lineStyle(1, 0x000000);
				g.drawRoundRectComplex(0, 0, width-1, height-1, 0, 0, roundX+1, roundX+1);
			}
			
			
			
			sprite.filters = [new GlowFilter(glowColor, .3, 64, 64, 1, 2, true), new GlowFilter(glowColor2, .4, 32, 32, 2, 2, true)];
			
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
					TweenLite.to(this, duration, { hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN }, onUpdate: updateGraphic } );
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
					TweenLite.to(this, 0.0, { hexColors: { topColor: topColorD, glowColor: glowColorD, borderColor: borderColorD}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
			}
			
			super.changeState(state);
		}
		
		protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
		}
	}
}