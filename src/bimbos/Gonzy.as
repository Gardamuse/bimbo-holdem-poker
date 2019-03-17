package bimbos 
{
	import worlds.PokerWorld;
	public class Gonzy extends BimboModel
	{
		
		public function Gonzy(iq:Number = 102, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.GONZY, 600, 1000, 16),
					new Sequence(Assets.GONZY_PORTRAIT, 400, 400, 16));
					
			SHORT_NAMES = Vector.<String>(["Gonzy", "Gonzy", "Gonzy", "Gonzie", "Goni", "Gigi", "Gigi"]);
			NAMES = Vector.<String>(["Mistress Gonzy Etrina", "Gonzy Etrina", "Gonzy", "Gonzie", "Goni", "Gigi", "Pink Dolly Gigi"]);
			BIO = Vector.<String>(["Not your typical young lady, but the transformation extraordinaire, Gonzy!" +
				" Small, cuddly and with a natural talent for magic, Gonzy always aims to fill anyone she meets with joy and happiness." + 
				" Looking for a bit of gambling fun she could have walked into any old casino, but by chance, she found herself here."]);

			ALL_IN = Vector.<String>(["I think its time to go all-in.", "Okay! Going all-in!", "Hehe! I'm totes going all-in!"]);
			ALREADY_ALL_IN = Vector.<String>(["Already all-in here..."]);
			WINNING = Vector.<String>(["Splendid, I've aquired $<var>.", "$<var> to me! Nice!", "Hehe! Gimme that $<var>!"]);

			FONDLING = Vector.<String>(["Heh, does that feel good <var>?", "I bet that feels nice <var>!", "Ehheh, I wish I could feel what you're feeling <var>!", 
			"Oh my gosh, <var>, please like, do this to me next!"]);

			FONDLING_SELF = Vector.<String>(["Huh...this feels rather pleasant...", "Oh gosh, I feel so s-soft...", "Ooh! G-Getting very horny here...", 
			"Mmmh, please! Someone like, fuck me! I'm so horny that I'm like, on fire down there!"]);

			RELAXING = Vector.<String>(["I require some relaxation, hold on.", "Give me a sec to relax, please!" , "I need to like, relax! Can't always be so tense and horny!."]);

			STRIPTEASE = Vector.<String>(["I don't normally do such an action, but check out this lovely body...",
			"Tell me, how do you like my body?", "Do you like what you see?",
			"You like these curves?", "You know, you just gotta ask if you wanna see my body exposed!",
			"Hehe, come on now! I know you like, wanna feel everything on me!", "Anyone wanna like, fuck someone with a sexy body like me? Hehe!"]);

			CUM = Vector.<String>([ "H-Huh!? Did I just...cum? Oh, deary me...",
			"This is embarrassing...I just came...",
			"Did I j-just...cum during the game?",
			"Eheh, I'm glad nobody is caring about me cumming...",
			"I came again! Oh gosh, this is so weird!",
			"Ooooohh...I so love cumming while playing here...hehe...",
			"Hehe! I-I don't wanna stop cumming! Someone come here and make me cum nonstop!"]);

			BUY_IN = Vector.<String>(["Something doesn't feel right at all...my brain feels like it was altered after they gave me more money...",
			"My head feels lighter...I guess I lost more IQ. Let's try harder so I can regain it!",
			"Feeling quite dumb now...I fear that this might get me into a bad spot if I keep messing up!",
			"Hehe! I keep getting dumber when I lose, but get so sexy as well! But, maybe I should like, start winning now!",
			"I'm so hot now! Maybe I should keep losing and like, let them take all my smartness! I wanna be super sexy!"]);
			
			SUBMIT_DEFEAT_ENDING = Vector.<String>([
				"<sLarge><cBC>Epilogue</cBC></sLarge>" +
				" \n\nThe lovely Gonzy kept on playing, and playing, blissfully unaware of the consequences of losing at this particular Casino." +
				" Although even if she was, she would just had shrug it off due to her IQ dropping at a massive rate." +
				" \n\nThe girl who by chance walked into the Casino is no longer the same, or even really around anymore." +
				" What is left is a shell of her former self, a dumb and plump looking gal with nice and fluffy blonde hair with pink highlights." +
				" Her body now very soft and sensitive and her libido having gone through the roof she now calls herself \"Gigi\"." +
				" True to her former self, Gigi still desires to bring people happiness and joy. She just does it in a... different way." +
				" \n\nYet thinking always gives her such a headache, so she has taken to approach casino patrons she particularly likes and make them her master." +
				" This new master thinks for her, makes decisions for her and please her whenever they feel it appropriate." +
				" Gigi just follows them, sits by their feet or does whatever she is told for as long as her master seems pleased." +
				" \n\nIs this the fate of the young Gonzy Etrina or will her little robo partner find and save her? Until then, Gigi is here to stay."
			]);
			
			typeId = 15;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}