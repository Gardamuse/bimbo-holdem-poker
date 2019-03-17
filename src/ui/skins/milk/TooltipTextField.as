package ui.skins.milk 
{
	import com.greensock.TweenLite;
	import flash.automation.AutomationAction;
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
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import ui.Button;
	import flash.text.TextFormatAlign;
	
	public class TooltipTextField extends MilkTextField
	{	
		
		public function TooltipTextField(x:Number=0, y:Number=0, prefix:String="", suffix:String="", width:Number=150, height:Number=50, fontSize:int=16, callback:Function = null, params:Object=null) 
		{
			super(x, y, prefix, suffix, width, height, fontSize, callback, params);
			
			//Normal colors
			topColorN = 0x226622;
			glowColorN = 0xFFFFFF;
			glowColor2N = 0x000000;
			borderColorN = 0xdaa520;
			fontColorN = 0xDDDDDD;
			
			//Hover colors
			topColorH = 0x245585;
			glowColorH = 0xffffff;
			glowColor2H = 0x000000;
			borderColorH = 0xE0D1A4;
			
			//Pressed colors
			topColorP = 0x094680;
			glowColorP = 0xfffffF;
			glowColor2P = 0x000000;
			borderColorP = 0xBF9D36;
			
			//Disabled colors
			topColorD = 0x324B31;
			glowColorD = 0xFFFFFF;
			glowColor2D = 0x000000;
			borderColorD = 0x616d4b;
			
			//Starting colors
			topColor = topColorN;
			glowColor = glowColorN;
			glowColor2 = glowColor2N;
			borderColor = borderColorN;
			
			this.fontSize = fontSize;
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(new String(prefix + suffix));
			
			drawMask();
		}
		
		override protected function drawMask():void
		{
			g.clear();
			g.beginFill(0x000000);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
		}
		
		override protected function drawGlare():void
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
		
		override protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			var roundX:int = 0;
			var roundY:int = 0;
			var borderWidth:int = 16;
			
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(topColor, alpha);
			g.drawRoundRect(0, 0, width, height, 1, 1);
			g.endFill();
			
			//g.lineStyle(4, borderColor, alpha);
			//g.drawRoundRect(2, 2, width - 4, height - 4, 1, 1);
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width-1, height-1, 1, 1);
			
			sprite.filters = [/*new GlowFilter(glowColor, .3, 64, 64, 1, 2, true),*/ new GlowFilter(glowColor2, alpha/2.5, 32, 32, 1, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
	}
}