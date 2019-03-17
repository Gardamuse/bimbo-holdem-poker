package bimbos 
{
	import worlds.PokerWorld;
	public class EmptyModel extends BimboModel
	{
		
		public function EmptyModel(iq:Number = 100, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.BACKGROUND, 600, 1000, 1),
					new Sequence(Assets.EMPTY_PORTRAIT, 400, 400, 1));
					
			NAMES = Vector.<String>(["Empty"]);
			BIO = Vector.<String>(["No target found."]);
			
			typeId = -2;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}