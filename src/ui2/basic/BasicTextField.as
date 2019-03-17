package ui2.basic 
{
	import com.greensock.TweenLite;
	import flash.automation.AutomationAction;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import flash.text.TextFormatAlign;
	import ui2.*;
	import flash.display.BlendMode;
	import flash.text.AntiAliasType;
	
	public class BasicTextField extends ui2.TextField
	{	
		/**
		 * 
		 * @param	o An Object containing some of the following name-value pairs:
			 * 			x:Number. Default = 0.
			 * 			y:Number. Default = 0.
			 * 			width:Number. Default = 100.
			 * 			height:Number. Default = 100.
			 * 			text:String. If string contains &lt; var0 >, where 0 is the index of the callback, &lt; var0 > is replaced by the callback value. Default = "".
			 * 			callbacks:Vector.&lt; Function >. Default = Vector.&lt; Function >([]).
			 * 			params:Array. A 2D array of with first index of a length no greater than the callbacks vector. Default = new Array([null]).
			 * 			fontsize:int. Default = 16.
		 */
		public function BasicTextField(x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, o:Object = null) 
		{
			super(x, y, width, height, o);
			
			//Normal colors
			topColorN = 0x226622;
			//topColorN = 0x262626
			glowColorN = 0xFFFFFF;
			glowColor2N = 0x000000;
			borderColorN = 0xdaa520;
			fontColorN = 0xDDDDDD;
			
			//Hover colors
			topColorH = 0x225522;
			glowColorH = 0xffffff;
			glowColor2H = 0x000000;
			borderColorH = 0xE0D1A4;
			fontColorH = 0xAABBAA;
			
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
			//textField.replaceText(0, textField.length-1, text);
			
			var tf:TextFormat = new TextFormat("FontOne", fontsize, fontColorN);
			tf.align = "center";
			
			var st:StyleSheet = new StyleSheet();
			st.setStyle("gold", { color:(0xf0d000) } );
			
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
			
			textLabel = new Text(text, 10 + labelWidth, labelHeight, { font:"FontOne", size:fontsize, align:"center", 
				wordWrap:false, resizable:false, width:width - 20 - labelWidth, height:height - labelHeight, color:fontColorN, alpha:alpha } );
			
			textLabel.setStyle("sGiant", { size:36 } );
			textLabel.setStyle("sLarge", { size:26 } );
			textLabel.setStyle("sMedium", { size:18 } );
			textLabel.setStyle("s16", { size:16 } );
			textLabel.setStyle("sSmall", { size:12 } );
			textLabel.setStyle("fff", { color:0xffffff } );
			textLabel.setStyle("cBC", { color:(borderColor) } );
			textLabel.setStyle("gold", { color:(0xf0d000) } );
			textLabel.setStyle("silver", { color:(0xd0d0ff) } );
			textLabel.setStyle("copper", { color:(0xef9f4f) } );
			textLabel.setStyle("red", { color:(0xf22222) } );
			textLabel.setStyle("green", { color:(0x22f222) } );
			
			
			textLabel.setStyle("fuyumi-highIQ", { color:(0x99c6ff) } );
			textLabel.setStyle("fuyumi-midIQ", { color:(0xdba3ff) } );
			textLabel.setStyle("fuyumi-lowIQ", { color:(0xf97feb) } );
			
			textLabel.setStyle("fuyumi-font", { font: "fuyumi-font", size: 14} );
			
			textLabel.setStyle("left", {align:"left"} );
			textLabel.setStyle("c", { align:"center" } );
			
			textLabel.richText = textLabel.text;
			
			/*At certain textWidths or character counts or whatever, textHeight gets almost doubled so that vertical centering doesn't work.
			 * In those cases, add a space to the end of the string.
			*/
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
			textLabel.y = (height - textLabel.textHeight + labelHeight)/2;
			//trace(text + ":\t " + height + " " + textLabel.textHeight + " " + textLabel.scaledHeight + " | " + textField.height + " " + textField.textHeight + " | " + label.height + 
			//		"\n\t\t" + width + " " + textLabel.textWidth + " " + textLabel.scaledWidth + " | " + textLabel.leading + " " + textLabel.height + " ");
			
			var lw:Number = labelWidth;
			var lh:Number = labelHeight;
			if (labelWidth > 0) {
				lh = height;
			} else if (labelHeight > 0) {
				lw = width;
			}
			
			if (lw > 0 && lh > 0) {
				labelLabel = new Text(labelText, 10, 0, { font:"FontOne", size:fontsize, align:"center", wordWrap:false, resizable:false, width:lw - 20, height:lh, color:fontColorH, alpha:alpha } );
				
				labelLabel.setStyle("sGiant", { size:36 } );
				labelLabel.setStyle("sLarge", { size:26 } );
				labelLabel.setStyle("sMedium", { size:18 } );
				labelLabel.setStyle("sSmall", { size:12 } );
				labelLabel.setStyle("fff", { color:0xffffff } );
				labelLabel.setStyle("cBC", { color:(borderColor) } );
				labelLabel.setStyle("gold", { color:(0xf0d000) } );
				labelLabel.setStyle("silver", { color:(0xd0d0ff) } );
				labelLabel.setStyle("copper", { color:(0xef9f4f) } );
				labelLabel.setStyle("red", { color:(0xf22222) } );
				labelLabel.setStyle("green", { color:(0x22f222) } );
				labelLabel.setStyle("left", {align:"left"} );
				labelLabel.setStyle("c", {align:"center"} );
				labelLabel.richText = labelLabel.text;
				
				labelLabel.y = (lh - labelLabel.textHeight)/2;
			}
			
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
			
			g.lineStyle(4, borderColor, alpha);
			g.drawRoundRect(2, 2, width - 4, height - 4, 1, 1);
			if (labelWidth > 0) {
				g.moveTo(labelWidth, 0);
				g.lineTo(labelWidth, height);
			} else if (labelHeight > 0) {
				g.moveTo(0, labelHeight);
				g.lineTo(width, labelHeight);
			}
			
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width - 1, height - 1, 1, 1);
			if (labelWidth > 0) {
				g.moveTo(labelWidth - 2, 4);
				g.lineTo(labelWidth - 2, height - 4);
				g.moveTo(labelWidth + 2, 4);
				g.lineTo(labelWidth + 2, height - 4);
			} else if (labelHeight > 0) {
				g.moveTo(4, labelHeight - 2);
				g.lineTo(width - 4, labelHeight - 2);
				g.moveTo(4, labelHeight + 2);
				g.lineTo(width - 4, labelHeight + 2);
			}
			
			
			sprite.filters = [/*new GlowFilter(glowColor, .3, 64, 64, 1, 2, true),*/ new GlowFilter(glowColor2, alpha/2.5, 32, 32, 2, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
		protected var _m:Matrix = new Matrix;
		
	}
}