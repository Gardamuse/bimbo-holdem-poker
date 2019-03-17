package bimbos 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import worlds.PokerWorld;
	public class Kristyna extends BimboModel
	{
		
		public function Kristyna(iq:Number = 114, money:Number = 2000, lust:Number = 0)
		{
			super(new Sequence(Assets.KRISTYNA, 600, 1000, 18), new Sequence(Assets.KRISTYNA_PORTRAIT, 400, 400, 18));
					
			NAMES = Vector.<String>(["Krisinue Astari", "Krisinue", "Kristine", "Christine", "Christyna", "Christy", "Chrissy", "Krissy", "Kissy", "Kissie"]);
			BIO = Vector.<String>(["A regular city girl, but with aspirations to join and rise through the Ninja Order." +
									" Few however, have the capacity of learning, yet more so mastering, the art of the Ninja." +
									" Now she is here to acquire such capacity."]);
			
			//Voice Lines
			ALL_IN = Vector.<String>(["...Everything In.", "Hm...All in.", "Uhh... All in!", "Ooh, let's see... All in!", "Like, is it my turn? Oh, it totally is! Silly me. Lemme see... All in!"]);
			ALREADY_ALL_IN = Vector.<String>(["...All Out.", "All out, Sorry!", "Sorry, but I'm already totally in, down to like, the last bit."]);
			CHECKING = Vector.<String>(["...", "Check.", "Oooh, is it, like, my turn? Let me see... Okay, I've totally chosen! Check."]);
			CALLING = Vector.<String>(["...Call...", "Calling...", "Oh! Calling!", "Hee, Calling that!",
										"You want me to like, spend my money? Yay! Call!" /*Oh, that's a lot of money! And you want me to, like, spend some back? I'm, like, totally cool with that. I call!*/]);
			RAISING = Vector.<String>(["More...", "Let's up the ante.", "Time for some more! Raise!", "More money, please!",
										"Ooh, so I can like, add more money? Here goes!"/*"Ooh, so I can, like, put more money in and stuff, right? Heehee, then let's totally do that!"*/]);
			FOLDING = Vector.<String>(["...No...", "Fold.", "Oof! Too much for me! Fold.", "Oooh, no, that's too much. Fold!",
										"Wow, you guys sure are super rich! I can't like, afford this... fold!"/*"Wow, you guys sure are super rich, throwing in all that money and junk! I need to like, totally fold."*/]);
			WINNING = Vector.<String>(["...Good", "That's $<var> to me.", "So I won that, or something? Okay, guess I'll, like, take this $<var>, then!"]);

			FONDLING = Vector.<String>(["<var>...how's that?", "How's that, <var>?", "How do you like THIS, <var>?", "Betcha like THIS <var>!",
										"Ooh, your skin feels super nice, <var>! You use like, lotion or something?"]);

			FONDLING_SELF = Vector.<String>(["why do I feel...", "This feels...good?", "Oh wow! My body feels really sensitive!",
											"Wow, my body feels super sensa-- sensi-- super feely!",
											"Ooh, I love how my boobies jiggle when I, like, grope 'em like this."]);

			RELAXING = Vector.<String>(["Quiet...", "Come on, focus...", "Alright, quiet up! Need to focus!", "Alright, time to... what was I doing, again?",
									"Okay, folks, everybody quiet! I'm trying to, like, calm down here...", "Stop talking everyone! Let me not think and junk, okay? I need silence to relax!"]);

			STRIPTEASE = Vector.<String>(["Bare the silence.", "Bet you weren't expecting me to show off this", "Bet you weren't expecting me to do THIS!",
										"Hee, look at me! Don't these curves look great?",
										"Heyyy, everybody look at me, and stuff! Don't I look, like, so totally hot? I think so too!"]);

			CUM = Vector.<String>([ "!!!", "Umph!", "Oooooh! Did I just cum... oh.", "Omigawd, did I just cum? That feels GOOD.",
								"Oh gawd, yes! I love this, love this, love this! Cumming is like, the absolute best ever!"]);

			BUY_IN = Vector.<String>(["...Fine, I'll pay", "I'm paying with my mind?", "I'm paying with my WHAT?!", "Hee, Guess I'm losing smarts again!", 
									"It's super weird, you know? Cuz everything is getting all fuzzy, but atleast I keep getting hotter!"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n<fff><s16>The ultimate attention whore</s16></fff>" +
			"\n\n Christine the aspirant ninja is no more. In her place is \"<var0>\", a voluptious, vapid airhead that will babble on for hours without saying a thing." +
			" In her new life, <var0> was born the child of the Ninja Order's grandmaster." +
			" Despite her heritage, <var0> quickly proved to be one of the worst ninjas the order had ever seen." +
			" She was clumsy and distractable, but worse than that, she simply had no interest in remaining unseen and unheard." +
			" From an early age, <var0> was desperate to be seen and always twaddling on about nothing at all." +
			" As the young ninja grew to womanhood, the problem only grew worse, as her ditzy mind came to fixate on the pleasures of the flesh." +

			"\n\nAfter more than one mission was blown by <var0>'s desire for attention, even the grandmaster was forced to see reason." +
			" <var0> was quietly sent off to a place far beyond the order's reach, where she could chatter and bumble and please herself all she wanted without causing the order any harm." +
			" Not that <var0> minded the exile. Quite the contrary, a life of indulging in pleasure and being leered at all day by others was nothing short of idyllic for her." +
			" And so <var0> willingly, even eagerly, joined the ranks of the casino's \"escorts\", revelling in every day of her new servitude." +
			" Of course, that could all just be a story babbling out <var0>'s pouty lips as she goes about her duties, but for her at least it had become truth." +

			"\n\nNow, there was nothing left of the old Christine. It had all been washed away by wave after wave of incredible lust." +
			" Now there is only <var0>: a total airhead, but one much happier than Christine ever was, and one who fulfilled her simple ambitions every day." +
			" The casino took care of her and gave her all she needed. They assigned her nice masters, joy and lust dominated her life" +
			" Best of all, she spent every night being seen by hundreds of the casino's patrons, all eyes leering over ever curve of her body. <var0> was finally the center of attention, and nothing made her little mind happier."]);
			
			typeId = 0;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}