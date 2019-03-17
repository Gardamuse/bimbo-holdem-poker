package 
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import flash.display.BitmapData;

	public class WomanCam extends Entity
	{
		private var frameWidth:int = 500;
		private var frameHeight:int = 1000;
		private var targetWidth:Number = 100;
		
		private var _imageWidth:int;
		private var _imageHeight:int;
		private var _imageScale:Number;
		
		public var woman:BimboModel;
		private var bitmapData:BitmapData = new BitmapData(frameWidth, frameHeight);
		private var spritemap:Spritemap;
		
		private var columns:int = 6;
		private var length:int = 11; //Number of frames
		
		public function WomanCam(woman:BimboModel, sequence:Sequence, x:Number = 0, y:Number = 0, targetWidth:Number = 100)
		{
			super(x, y);
			this.targetWidth = targetWidth;
			setTargetTo(woman, sequence);
		}
		
		public function setTargetTo(woman:BimboModel, sequence:Sequence):void {
			this.woman = woman;
			this.frameWidth = sequence.frameWidth;
			this.frameHeight = sequence.frameHeight;
			spritemap = new Spritemap(sequence.spritesheet, frameWidth, frameHeight);
			
			this.columns = spritemap.columns;
			this.length = sequence.frameAmount;
			
			imageScale = targetWidth / frameWidth;
			imageWidth = frameWidth * imageScale;
			imageHeight = frameHeight * imageScale;
			spritemap.scale = imageScale;
			spritemap.setFrame(0, 0);
			graphic = spritemap;
		}
		
		public function updateFrame():void {
			var frame:int = int(Math.round((length-1) * woman.getBimboFactor()));
			spritemap.setFrame(frame % columns, int(frame / columns));
			//trace("cam update");
		}
		
		public function getRect():Rectangle {
			return new Rectangle(x, y, imageWidth, imageHeight);
		}
		
		public function get imageWidth():int 
		{
			return _imageWidth;
		}
		
		public function set imageWidth(value:int):void 
		{
			_imageWidth = value;
		}
		
		public function get imageHeight():int 
		{
			return _imageHeight;
		}
		
		public function set imageHeight(value:int):void 
		{
			_imageHeight = value;
		}
		
		public function get imageScale():Number 
		{
			return _imageScale;
		}
		
		public function set imageScale(value:Number):void 
		{
			_imageScale = value;
		}
		
	}

}