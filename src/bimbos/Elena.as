package bimbos 
{
	import worlds.PokerWorld;
	public class Elena extends BimboModel
	{
		
		public function Elena(iq:Number = 102, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.ELENA, 600, 1000, 17),
					new Sequence(Assets.ELENA_PORTRAIT, 400, 400, 17));
			
			SHORT_NAMES = Vector.<String>(["Eadwynn", "Edelgard", "Edeline", "Elona", "Elaine", "Elena", "Laney", "Lammy", "Lumi", "Lacie", "Laika"]);
			NAMES = Vector.<String>(["Overseer Eadwynn", "Edelgard", "Edeline", "Elona", "Elaine", "Elena", "Laney", "Lammy", "Secretary Lumi", "'Sexretary' Lacie", "Test Subject Laika"]);
			BIO = Vector.<String>(["Part of a government agency developing secret technology and weaponry, Elena works as a lower level field researcher both on and off site." +
									" Hearing about the rumoured effects of the poker game, she was assigned to personally investigate the IQ lowering effect."]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
												"\n\nElena did the government a huge favour, but not in the way the agency was expecting." +
												
												"\n\nWhen she came back to the institute, she had somehow acquired a new wardrobe, and was covered head to toe in cum." +
												" It was honestly even a surprise that she managed to find her way back to where she used to work. At first nobody knew what" +
												" to do with her and she was quarantined in a cell in case the effects were contagious. That didn't stop her from distracting the" +
												" research staff though, as her idealistic bimbo body made even the coldest of libidos snap like cheap linoleum." +

												"\n\nEventually, a breakthrough was had in the lab. Analyzing her genetic changes led to rapid understanding of how" +
												" the transformation worked. It was nothing sort of science fiction, and only a basic understanding of the process was grasped." +
												" In just five years, they had invented a serum that rapidly degraded a subject's IQ, changed their gender if applicable, and" +
												" changed their body to be more... compatible for sex. It took a lot of trial and error, but the results were staggering- sometimes" +
												" producing even better results than 'Subject L.A.I.K.A.'. They never did find a way to reverse these effects, and it was deemed impossible with" +
												" the current state of technology. Not like Laika cared, she got her own special room full of any sex toy she could possibly imagine." +

												"\n\nBut in the end, they tangled too close to the fire. A building of thirty-three interns were accidentally bimbofied during the development" +
												" of a gaseous form of the serum. Informants were notified, and suddenly the entire world was well aware of plans to use these new chemical weapons." +
												" Dubbed 'Agent Pink', the idea was to turn soldiers or civilians into sex hungry sluts, distracting up to thousands of enemies at a time." +
												" Many other countries started work on their own variations of this same idea." +

												"\n\nIncidentally, World War Three was the first ever war to end with an overall <i>increase</i> in population." ]);
				
			
			typeId = 11;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}