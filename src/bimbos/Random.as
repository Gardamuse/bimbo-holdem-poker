package bimbos 
{
	import worlds.PokerWorld;
	public class Random extends BimboModel
	{
		
		public function Random(iq:Number = -1, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.REBECCA, 600, 1000, 1),
					new Sequence(Assets.RANDOM_PORTRAIT, 400, 400, 1));
					
			NAMES = Vector.<String>(["Random"]);
			BIO = Vector.<String>(["Unknown person."]);
			
			typeId = -1;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}