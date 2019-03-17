package bimbos 
{
	import worlds.PokerWorld;
	public class Nathaniel extends BimboModel
	{
		
		public function Nathaniel(iq:Number = 123, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.NATHANIEL, 600, 1000, 16),
					new Sequence(Assets.NATHANIEL_PORTRAIT, 400, 400, 16));
					
			NAMES = Vector.<String>(["Sir Nathaniel Ash", "Nathaniel Ash", "Nathaniel", "Nathan", "Nat", "Nathalie", "Natalie", "Nellie", "Nelly", "Ninni"]);
			BIO = Vector.<String>(["His father was an incredibly influential businessman but sadly neither the social talent nor the business sense was inherited." 
								+ " He has always been expected to do great things but never has he been able to live up to expectation."
								+ " Now it's all or nothing, win and become respected by your father or lose and only god knows what will happen."]);

			ALL_IN = Vector.<String>(["I'm 100% sure I'll win this.", "All or nothing!", "I'm totally going all in!"]);
			ALREADY_ALL_IN = Vector.<String>(["All my money is already on the table", "I don't have anything more to bet.", "I'm already all in baby!"]);
			CHECKING = Vector.<String>(["I'll match you on that.", "Check.", "Is this how you check?"]);
			CALLING = Vector.<String>(["I'll call.", "Call.", "Imma call!"]);
			RAISING = Vector.<String>(["I raise with $<var>.", "$<var> Raise.", "Raise!"]);
			FOLDING = Vector.<String>(["Tactical fold.", "Hmm, I'll fold.", "Damn, fold.", "Aww, I'm gonna fold."]);
			WINNING = Vector.<String>(["I have acquired another $<var>.", "Things are looking up! $<var> to me." ,"Wooo! I won $<var>!"]);

			FONDLING = Vector.<String>(["Feeling hot, <var>?", "How does this feel <var>?", "Oh, I know you like it <var>!", "Oh fuck <var>, wanna go backstage later?"]);

			FONDLING_SELF = Vector.<String>(["It's getting hot in here...", "Aaaah... my skin's so soft...", "I'm getting soo horny!", "Can't someone just fuck me soon?"]);

			RELAXING = Vector.<String>(["Calm calculated thoughts...", "I need to focus..." , "just chill for a bit okay."]);

			STRIPTEASE = Vector.<String>(["Brains over breasts, right?", "How do you like this body?", 
			"How do you like this body?", "Am I not hot?", 
			"How do you like my curves?", "Wanna look under my shirt hun?", 
			"I know you want this!",  "Aaahw, hahahaaa... someone want to, like, come fuck me?"]);

			CUM = Vector.<String>([ "I sincerely hope nobody saw that.",
			"Oh god! I came right here among people!",
			"Oooh... I can't believe I cum during a poker game...",
			"Woah...that felt kinda good...",
			"Eeeh...aaah... nobody seems to notice if I cum anyways... ",
			"Aaaahaaahaa... cumming is sooo nice!", 
			"Can someone just fuck me please!"]);

			BUY_IN = Vector.<String>(["I don't like that they're draining my IQ but I need the money to finish this!",
			"It's getting harder to think by the round, I have to finish this quickly.",
			"I'm starting to feel a bit dumb. Oh well, I got cash enough so I can win my smarts back!",
			"Hihi, I feel kinda funny… woah, 1000$ for a little IQ, that's soooo worth it!",
			"I either get money or I feel super nice! I can't lose!"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n<fff><s16>Personal service</s16></fff>, property of the Casino." +
			"\n\nSuch was the fate of \"<var0>\", as she called herself now." +
			" Once meant for greatness, now only meant for pleasure." +
			" Every night was now a party and every morning belonged to the highest bidder." +
			" Most of her clients wanted the company of her beauty during the evenings varying festivities and wanted her body for a sleepless night." +
			" And <var0> was more than happy to comply." +

			"\n\nMany mornings was spent naked but if her client wished for it she would wear just about anything, although it was sure to be tiny." +
			" Even though <var0> was incapable of most things that didn't involve anything sexual, the casino had been considerate enough to give her some basic household skills." +
			" That meant that if her master wished for it, he or she could have something close to a personal slave for the duration which the client had paid for." +
			" Even though her rates weres quite high, <var0> had a solid stream of customers for almost every day of the week." +
			" After some time, she had completely paid off her debt to the casino but given the choice of regaining some of her previous intelligence, she denied." +

			"\n\nBecause, why would she want it back now when she had so much fun with parties and sex every night? Life could not be better."]);
			
			typeId = 5;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}