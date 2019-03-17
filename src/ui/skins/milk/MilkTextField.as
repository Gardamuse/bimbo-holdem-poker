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
	
	public class MilkTextField extends ui.TextField
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		protected var textLabel:Text;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		public var alpha:Number = 1.0;
		
		//Normal colors
		public var topColorN:uint = 0x226622;
		public var glowColorN:uint = 0xFFFFFF;
		public var glowColor2N:uint = 0x000000;
		public var borderColorN:uint = 0xdaa520;
		public var fontColorN:uint = 0xDDDDDD;
		
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
		public var topColorD:uint = 0x324B31;
		public var glowColorD:uint = 0xFFFFFF;
		public var glowColor2D:uint = 0x000000;
		public var borderColorD:uint = 0x616d4b;
		
		//Starting colors
		public var topColor:uint = topColorN;
		public var glowColor:uint = glowColorN;
		public var glowColor2:uint = glowColor2N;
		public var borderColor:uint = borderColorN;
		
		public var fontSize:int;
		
		public function MilkTextField(x:Number=0, y:Number=0, prefix:String="", suffix:String="", width:Number=150, height:Number=50, fontSize:int=16, callback:Function = null, params:Object=null) 
		{
			super(x, y, prefix, suffix, width, height, callback, params);
			
			this.fontSize = fontSize;
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(new String(prefix + suffix));
			
			drawMask();
		}
		
		private var storedCallback:Object;
		override public function update():void {
			super.update();
			if (callback != null)
			{
				if (params != null && storedCallback != callback(params)) {
					drawLabel(new String(prefix + callback(params) + suffix));
				}
				else if (storedCallback != callback()){
					drawLabel(new String(prefix + callback() + suffix));;
				}
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
			textField.replaceText(0, textField.length-1, text);
			
			var tf:TextFormat = new TextFormat("Mytype", fontSize, fontColorN);
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
			textLabel = new Text(text, 0, 0, { font:"Mytype", size:fontSize, align:"center", wordWrap:true, width:width - 10, height:height, color:fontColorN, alpha:alpha } );
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
			if (height * 0.75 < textLabel.textHeight) {
				//textLabel.text += " ";
				textLabel.richText = textLabel.richText + " ";
			}
			//Remove characters if the text would need more space than waht exists inside the box.
			if (height < textLabel.textHeight) {
				while (height < textLabel.textHeight) {
					textLabel.text = textLabel.text.substr(0, textLabel.text.length - 1);
				}
				for (var i:int = 0; i < 2; i++) {
					textLabel.text = textLabel.text.substr(0, textLabel.text.length - 1);
				}
				textLabel.text += "..";
			}
			
			
			//textLabel.y = (height - (label.height - 5)) * 0.5;
			textLabel.y = (height - textLabel.textHeight)/2;
			//trace(text + ": " + height + " " + textLabel.textHeight + " " + textLabel.scaledHeight + " | " + textField.height + " " + textField.textHeight + " | " + label.height);
			textLabel.x = 5;
			//trace("milk textfield label redraw: " + text);
			
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
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
			
			g.lineStyle(0, 0x00000, alpha);
			g.drawRoundRect(0, 0, width-1, height-1, 1, 1);
			
			sprite.filters = [/*new GlowFilter(glowColor, .3, 64, 64, 1, 2, true),*/ new GlowFilter(glowColor2, alpha/2.5, 32, 32, 2, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
		protected var _m:Matrix = new Matrix;
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(glare);
			//renderGraphic(label);
			renderGraphic(textLabel);
		}
		
		override protected function changeState(state:int = 0, animDuration:Number = 0.15):void 
		{
			if (state == lastState) return;
			
			var duration:Number = animDuration;
			if (lastState == DOWN) duration = 0.05;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorN, glowColor: glowColorN, borderColor: borderColorN }, onUpdate: updateGraphic } );
					//if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorH, glowColor: glowColorH, borderColor: borderColorH }, onUpdate: updateGraphic } );
					//if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorP, glowColor: glowColorP, borderColor: borderColorP}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
				case DISABLED:
					TweenLite.to(this, duration, { alpha: 1.0, hexColors: { topColor: topColorD, glowColor: glowColorD, borderColor: borderColorD}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
				case INVISIBLE:
					TweenLite.to(this, duration, { alpha: 0.0, onUpdate: updateGraphic } );
					break;
			}
			
			super.changeState(state);
		}
		
		public function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			if (callback != null)
			{
				if (params != null) drawLabel(prefix + callback(params) + suffix);//prefix + callback(params) + suffix
				else drawLabel(prefix + callback() + suffix);//prefix + callback() + suffix
			} else {
				drawLabel(new String(prefix + suffix))
			}
			
		}
		
		public function setPrefix(text:String):void {
			this.prefix = text;
			drawLabel(text);
		}
		
		public function setSuffix(text:String):void {
			this.suffix = text;
			drawLabel(text);
		}
		
		public function setInvisible(value:Boolean, duration:Number = 0):void {
			if (value && lastState != INVISIBLE) {
				changeState(INVISIBLE, duration);
				updateGraphic();
			} else if (!value){
				changeState(NORMAL, duration);
			}
		}
		
		public function disabledSmooth(value:Boolean, duration:Number):void {
			if (value) {
				changeState(DISABLED, duration);
			} else {
				changeState(NORMAL, duration);
			}
		}
	}
}