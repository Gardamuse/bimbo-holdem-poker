package ui2.basic 
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
	import flash.text.TextFormatAlign;
	import ui2.*;
	
	public class BasicSlider extends ui2.Slider
	{	
		//Normal colors
		public var barColorN:uint = 0x772222;
		
		//Hover colors
		public var barColorH:uint = 0x772222;
		
		//Pressed colors
		public var barColorP:uint = 0x772222;
		
		//Disabled colors
		public var barColorD:uint = 0x443333;
		
		//Starting colors
		public var barColor:uint = barColorN;
		
		
		/** Get the output value of slider by calling getSliderValue();
		 * 
		 * @param	o An Object containing some of the following name-value pairs:
			* 			text:String. If string contains <var0>, where 0 is the index of the callback, <var0> is replaced by the callback value. Default = "".
			* 			callbacks:Vector.&lt; Function >. Default = Vector.&lt; Function >([]).
			* 			params:Array. A 2D array of with first index of a length no greater than the callbacks vector. Default = new Array([null]).
			* 			fontsize:int. Default = 16.
			* 
			* 			minCallback Function for retrieving minimum value
			* 			maxCallback Function for retrieving maximum value
			* 			minParams Arguments for minCallback
			* 			maxParams Arguments for maxCallback
			* 			intervalCallback Function that returns value the slider will stick to. Ex: if value = 20 the slider will stop at: 20, 40, 60...
			* 			intervalParams Arguments for intervalCallback
			*			fractionCallback If set, makes slider non-adjustable and instead uses fraction returned by this function.
			* 			fractionParams Arguments for fractionCallback
			* 
			* 			barColorN Sets the color of the loading bar. Ex: 0xFFFFFF would set it to white.
			*/
		public function BasicSlider(x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, o:Object = null) 
		{
			super(x, y, width, height, o);
			
			//Normal colors
			topColorN = 0x226622;
			glowColorN = 0xFFFFFF;
			glowColor2N = 0x000000;
			borderColorN = 0xdaa520;
			fontColorN = 0xDDDDDD;
			
			//Hover colors
			topColorH = 0x225522;
			glowColorH = 0xffffff;
			glowColor2H = 0x000000;
			borderColorH = 0xE0D1A4;
			
			//Pressed colors
			topColorP = 0x337733;
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
			
			if (o.hasOwnProperty("barColorN")) barColorN = o.barColorN;
			
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
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
		
		private var textField:flash.text.TextField = new flash.text.TextField();
		override protected function drawLabel(text:String):void
		{
			textField.replaceText(0, textField.length-1, text);
			
			var tf:TextFormat = new TextFormat("FontOne", fontsize, fontColorN);
			tf.align = "center";
			
			textField.defaultTextFormat = tf;
			textField.width = width-10;
			textField.height = height;
			textField.embedFonts = true;
			textField.wordWrap = true;
			textField.text = text;
			textField.filters = [new GlowFilter(0x6ACFFF, 0.0, 7, 7, 2, 3)];
			
			label = drawStamp(width + 10, textField.textHeight + 10, 5, 5, textField);
			label.y = (height - textField.textHeight) * 0.5 - 8;
			label.x = 0;
			
			//
			textLabel = new Text(text, 0, 0, { font:"FontOne", size:fontsize, align:"center", wordWrap:false, resizable:false, width:width - 10, height:height, color:fontColorN, alpha:alpha } );
			textLabel.setStyle("sGiant", { size:36 } );
			textLabel.setStyle("sLarge", { size:26 } );
			textLabel.setStyle("sMedium", { size:18 } );
			textLabel.setStyle("sSmall", { size:12 } );
			textLabel.setStyle("fff", { color:0xffffff } );
			textLabel.setStyle("cBC", { color:(borderColor) } );
			textLabel.setStyle("left", {align:"left"} );
			textLabel.setStyle("c", {align:"center"} );
			textLabel.richText = textLabel.text;
			
			/*At certain textWidths or character counts or whatever, textHeight gets almost doubled so that vertical centering doesn't work.
			 * In those cases, add a space to the end of the string.*/
			if (textLabel.textHeight > textField.textHeight + 10) {
				//textLabel.text += " ";
				textLabel.richText = textLabel.richText + " ";
			}
			//Remove characters if the text would need more space than what exists inside the box.
			if (height < textLabel.textHeight) {
				while (height < textLabel.textHeight) {
					textLabel.text = textLabel.text.substr(0, textLabel.text.length - 1);
				}
				for (var i:int = 0; i < 2; i++) {
					textLabel.text = textLabel.text.substr(0, textLabel.text.length - 1);
				}
				textLabel.text += "..";
			}
			
			if (textLabel.textWidth > width - 20) {
				textLabel.wordWrap = true;
			}	
			
			//textLabel.y = (height - (label.height - 5)) * 0.5;
			textLabel.y = (height - textLabel.textHeight)/2;
			//trace(text + ":\t " + height + " " + textLabel.textHeight + " " + textLabel.scaledHeight + " | " + textField.height + " " + textField.textHeight + " | " + label.height + 
			//		"\n\t\t" + width + " " + textLabel.textWidth + " " + textLabel.scaledHeight);
			textLabel.x = 5;
			
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
			
			g.beginFill(barColor, alpha)
			g.drawRoundRect(0, 0, width*sliderFraction, height-1, 1, 1);
			g.endFill();
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width*sliderFraction, height-1, 1, 1);
			
			g.lineStyle(4, borderColor, alpha);
			g.drawRoundRect(2, 2, width - 4, height - 4, 1, 1);
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width-1, height-1, 1, 1);
			
			sprite.filters = [/*new GlowFilter(glowColor, .3, 64, 64, 1, 2, true),*/ new GlowFilter(glowColor2, alpha/2.5, 32, 32, 2, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
		protected var _m:Matrix = new Matrix;
		
		override public function changeState(state:int = 0, animDuration:Number = 0.0):void
		{
			if (state == lastState) return;
			
			var duration:Number = animDuration;
			if (lastState == DOWN) duration = 0.05;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { barColor: barColorN}, onUpdate: updateGraphic } );
					//if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { barColor: barColorH}, onUpdate: updateGraphic } );
					//if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { barColor: barColorP}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
				case DISABLED:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { barColor: barColorD}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
			}
			super.changeState(state, animDuration);
		}
	}
}