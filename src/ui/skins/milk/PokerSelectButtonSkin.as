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
	import ui.SelectButton;
	import ui.SelectButtonGroup;
	
	public class PokerSelectButtonSkin extends PokerSelectButton 
	{	
		
		
		public function PokerSelectButtonSkin(x:Number = 0, y:Number = 0, text:String = "", width:Number = 150, height:Number = 50,
												callback:Function=null, fontSize:int=16, params:Object=null, keyConstant:int = 1, buttonGroup:SelectButtonGroup = null) 
		{
			super(x, y, text, width, height, callback, fontSize, params, keyConstant, buttonGroup);
			
			glowColor2D = glowColor2N;
			borderColorD = borderColorN;
		}
	}
}