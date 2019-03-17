package 
{
	import com.greensock.loading.data.ImageLoaderVars;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import worlds.SettingsWorld;
	import worlds.LoadingWorld;
	import worlds.PokerWorld;
	
	public class CardEntity extends Entity
	{
		public static const cardWidth:int = 140;
		public static const cardHeight:int = 190;
		public var cardScale:Number = 0.53;
		
		public var card:int;
		private var bitmapData:BitmapData = new BitmapData(cardWidth, cardHeight);
		private var spritemap:Spritemap;
		private var sprite:Sprite;
		private var _hidden:Boolean;
		
		
		public function CardEntity(card:int, x:Number = 0, y:Number = 0, hidden:Boolean = false, cardScale:Number = 0.53) 
		{
			super(x, y);
			this.card = card;
			this.cardScale = cardScale;
			
			this.hidden = hidden; // Run last to make sure it uses right cardscale.
		}
		
		public function get hidden():Boolean 
		{
			return _hidden;
		}
		
		public function set hidden(value:Boolean):void 
		{
			_hidden = value;
			var rank:int = Poker2.rankOf(card);
			var color:int = Poker2.colorOf(card);
			if (value && !PokerWorld.devmode) {
				//bitmapData.copyPixels(FP.getBitmap(Assets.DECK), new Rectangle(cardWidth * 0, cardHeight * 4, cardWidth, cardHeight), new Point(0, 0));
				bitmapData.copyPixels(FP.getBitmap(LoadingWorld.settingsWorld.getCardBack().asset), new Rectangle(cardWidth*0, cardHeight*0, cardWidth, cardHeight), new Point(0, 0));
			} else {
				bitmapData.copyPixels(FP.getBitmap(Assets.DECK), new Rectangle(cardWidth*(rank), cardHeight*color, cardWidth, cardHeight), new Point(0, 0));
			}
			var image:Image = new Image(bitmapData);
			image.scale = cardScale;
			graphic = image;
		}
		
		
		

		
	}

}