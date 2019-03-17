package bimbos 
{
	import worlds.PokerWorld;
	public class Barry extends BimboModel
	{
		
		public function Barry(iq:Number = 123, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.BARRY, 600, 1000, 19),
					new Sequence(Assets.BARRY_PORTRAIT, 400, 400, 19));
					
			SHORT_NAMES = Vector.<String>(["Bartholomau", "Bartholemew", "Barroth", "Bairre", "Barry", "Barrie", "Carrie",
									"Caren", "Karen", "Katlyn", "Katlune", "Kitsune", "Kitsune", "Kitti"]);

			NAMES = Vector.<String>(["Collector Bartholomau", "Bartholemew", "Barroth", "Bairre", "Barry", "Barrie", "Carrie",
									"Caren", "Karen", "Katlyn", "Katlune", "Kitsune", "Kitsune the Fox Spirit", "Kitti the Fuck Spirit"]);
			BIO = Vector.<String>(["An avid collector of trinkets and oddities, Barry recently bought a strange statue in an auction." +
			" The item was said to be cursed by an ancient fox spirit, but Barry was skeptical to the rumours." + 
			" Trying to push his luck, Barry joined the game looking to obtain a bit more spending money for his collection." +
			" Little did he know of the strange effects this curse would have when combined with methods of the Casino..."]);
			
			ALL_IN = Vector.<String>(["Going once, going twice... All in!", "All in! Money is no object!", "All in. Exciting!",
										"My like, fox instincts are telling me to go all in!"]);
			ALREADY_ALL_IN = Vector.<String>(["Already all in. Care to outbid me?", "I told you, I'm all in!", "Still all in.",
												"All i- wait, I'm like, already all in. Duh!"]);
			CHECKING = Vector.<String>(["Check. It's not worth betting more.", "Check. Your turn!", "Checking.", "Pass- er, I mean, check.",
										"Uhm... Like, check?", "Check. Like, can't one of my slaves do this for me?"]);
			CALLING = Vector.<String>(["Calling! Where's my bidding paddle?", "Calling, Eyuuuup!", "I call.",
										 "Like, totally calling!", "Calling? The only thing I call is like, my servants."]);
			RAISING = Vector.<String>(["The thrill of a good bid! $<var> raise.", "Raising up to $<var>!", "Raising! $<var>!",
										 "Like, who cares about money anyways? $<var> raise!", "Like, my fox senses are tingling! Totally raising with $<var>!", "Is my hand even good? Like, fuck it- raising $<var>."]);
			FOLDING = Vector.<String>(["Folding. Don't worry, I'll hit hard next bid.", "Fold! Trying to save money for my collection.",
										 "Gotta fold, something feels wrong with my body...", "Uhm, Fold!", "Fold. Now that I'm out, can somebody like, come over here and fuck me?"]);
			WINNING = Vector.<String>(["$<var>? That should buy me a lot of trinkets!", "$<var>! To the victor goes the spoils!", "$<var>, that's like... a lot!",
										"$<var>, I won it all! Time to send my servants out shopping!", "$<var>? Money is like, totally no object. I just hypnotize people instead of paying them!" ]);

			//Three last lines unique, first ones generic.
			FONDLING = Vector.<String>(["Feeling good, <var>?", "How does this feel <var>?", "Ah, I wish you would hold me like this <var>!",
										"<var>, look deep into my eyes and surrender your mind to me...", "Hey <var>, have you ever had a tailjob before?",
										"<var>, like, look deep into my tits and think bubbly thoughts with me!"]);

			FONDLING_SELF = Vector.<String>(["Now where did I put my wallet, it's got to be here somewhere...",
											 "Mnf, why am I touching myself? My hands are out of control!", "Must resist curse... but I can't keep my hands off myself...",
											 "Ngh, fuck! I think I'm totally in heat."]);

			//[0] is unique, rest filled with generics
			RELAXING = Vector.<String>(["Polishing off my trinkets always helps me relax in a bind.",
										"I just need to relax a bit..." , "Deep, slow breaths... so calming."]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n<fff><s16>\Wandering Fox Spirit</s16></fff>, Corrupted by Lust." +
			"\n\nFully taken over by the statue's curse, the once eccentric Barry was now a well endowed foxgirl." +
			" Under normal circumstances, the spirit would have taken over his mind, allowing a rebirth of a long dead goddess." +
			" However, the strange interaction with the intense mental perversion by Bimbo Holdem Poker caused some... abnormalities." +
			" The spirit lost control of it's own mind as well, and ended up focusing purely on it's heat and breeding instincts." +
			" Truly a dangerous mix when combined with the more modern bimbo love of fashion and narcissism." +

			"\n\n In a small farmtown not too far from the casino, stories were spreading of men disappearing during the night." +
			" She would directly control their minds through her powers, and lead them into her mansion to have intense sex for hours straight." +
			" If she liked them enough, she would intensify the spell to keep them around long-term. They would be slaves to her every whim, doing sexual favours for days straight until she grew bored of them." +
			" When she felt like getting new clothes or other girly things, she sent a servant out to buy them for her- much less risky than going out alone." +
			" She searched high and low for the perfect mate to help continue her lineage. Despite her new lack of intelligence, she is still determined and horny enough to keep this goal in mind." +

			"\n\n Underneath the huge cup size and waving tail, parts of Barry still remained." +
			" Kitti still loved collecting things, however the nature of the items had changed a bit." +
			" She now holds one of the most large-scale collections of sex toys and fertility idols from nearly every place and time period." +
			" Her love for sex and cum is only rivaled by her love of collecting. So why not combine the two?"]);
			
			
			typeId = 8;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}