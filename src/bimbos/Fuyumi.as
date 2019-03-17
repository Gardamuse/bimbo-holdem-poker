package bimbos 
{
	import worlds.PokerWorld;
	public class Fuyumi extends BimboModel
	{
		
		public function Fuyumi(iq:Number = 115, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.FUYUMI, 600, 1000, 17),
					new Sequence(Assets.FUYUMI_PORTRAIT, 400, 400, 17));
					
			
			SHORT_NAMES = Vector.<String>(["Solstice", "Destiny", "Frigid", "IceQueen", "ColdCutie", "FumiFumi", "Fuyummy", "Upskirt", "Totaltfslut", "Yumi"]);
			NAMES = Vector.<String>(["Fuyumi, <fuyumi-highIQ><fuyumi-font>WinterSolstice</fuyumi-font></fuyumi-highIQ>", "Fuyumi, <fuyumi-highIQ><fuyumi-font>XxColdDestinyxX</fuyumi-font></fuyumi-highIQ>", "Fuyumi, <fuyumi-highIQ><fuyumi-font>Frigid__</fuyumi-font></fuyumi-highIQ>", "Fuyumi, <fuyumi-midIQ><fuyumi-font>IceQueen23</fuyumi-font></fuyumi-midIQ>", "Fuyumi, <fuyumi-midIQ><fuyumi-font>ColdCutie</fuyumi-font></fuyumi-midIQ>", "Fuyumi, <fuyumi-midIQ><fuyumi-font>Fumi^_^Fumi</fuyumi-font></fuyumi-midIQ>", "Fuyumi, <fuyumi-lowIQ><fuyumi-font>Fuyummy!</fuyumi-font></fuyumi-lowIQ>", "Fuyumi, <fuyumi-lowIQ><fuyumi-font>upskirtbreeze</fuyumi-font></fuyumi-lowIQ>", "Fuyumi, <fuyumi-lowIQ><fuyumi-font>totalTFslut</fuyumi-font></fuyumi-lowIQ>", "Fuyumi, <fuyumi-lowIQ><fuyumi-font>yumiwh0re69</fuyumi-font></fuyumi-lowIQ>"]);
			BIO = Vector.<String>(["Drawn to the game through an online poker tournament, Fuyumi is a reserved NEET who primarily plays video-games for a living (or at least tries). " +
			   "Shy and quiet in real life, but loud and crude online, will Fuyumi come out with enough money to secure her future? Or will the game \"teach\" her how to get past her social anxiety?"]);

			ALL_IN = Vector.<String>(["All in. Don't act so surprised.", "It's all about the mindgames. Going all in!", "A-All in! Sorry, but I'm kinda nervous...",
										"All in! My smarts are on the line, so like, be gentle ok?"]);
			ALREADY_ALL_IN = Vector.<String>(["Hey dumbass, pay attention to the game. I'm already all in.", "I'm still all in. Just like last turn.", "Still all in.",
												"Like, still all in! Maybe you should go all in too, just for me...", "All in! Like besides, I can just sell my panties online if I lose."]);
			CHECKING = Vector.<String>(["Checking. Just how many times are we going to go around the table?", "Checking this shit out.", "Check check.", "Check!",
										  "Like, check me out!", "Checking? Is that like, checking somebody out?"]);
			CALLING = Vector.<String>(["Calling you out for being a shit poker player.", "You bastard, quit raising! I call.", "I call. T-This is getting intense...",
										 "Like, totally calling!", "Calling! Like, you can call me later too, if you want..."]);
			RAISING = Vector.<String>(["Raising with $<var>. I bet you don't even have that much, heh.", "Raise: $<var>. Can you keep up?", "Raising the stakes with $<var>.",
									   "Raising with, uhh... $<var>? S-Sorry, I'm kinda bad at this...", "Like, putting up an extra $<var> into the pot!", "Gotta win my smarts back! Like, raising with $<var>!",
									   "I'll raise with $<var> and a private fuck session after the game."]);
			FOLDING = Vector.<String>(["The game screwed me over with RNG. I'm calling that this is rigged.", "Folding. Some things are uncontrollable in life, like a bad hand or terrible teammates.",
									   "I won't fall for the sunk cost fallacy! Fold!", "F-Fuck! Gotta fold, I guess.", "Like, why is it called folding when you're not supposed to bend the cards?"]);
			WINNING = Vector.<String>(["$<var>? Better payout than most terrible esports tourneys.", "$<var>, not bad. Beats minimum wage.", "W-Wow, did I really just make $<var>?",
									  "Ohmygod! I can't believe I won $<var>!", "Did I really like, just make $<var>? Time to totally go shopping!" ]);

			FONDLING = Vector.<String>(["I'm doing this so you can't concentrate, <var>. The fact that you don't realize this means it's working.",
										"Maybe if I do this to you <var>, you'll play the game better.", "A-Am I doing this right, <var>?", "<var>, I've always w-wanted to try this after seeing it on forums...",
										"How do you like being my player 2, <var>?", "For somebody so terrible at poker, you sure have a smokin' hot bod, <var>!",
										"I may be a virgin, <var>, but I know how to work a joystick..!", "Maybe you and me can ERP after this, <var>?", "Cmon, cum for me, <var>! Maybe if I cosplay for you..?"]);

			FONDLING_SELF = Vector.<String>(["I don't know if there's a metagame to touching myself, but I might as well try.",
											 "Hey, even a girl like me has needs sometimes.", "Ngh... Anyone have a phone with wifi I could use? N-No reason...",
											 "Gawd, I can't fucking keep my hands off myself! That's like, why I stopped playing games competitively."]);

			RELAXING = Vector.<String>(["It's hard to relax when the people around you are turning into fetish stereotypes. It's like I'm on deviantart or something.",
										"Deep breaths. Just pretend everyone around you are your stupid teammates.", "Staying calm is important during intense games like this.",
										"W-Weh... Just gotta relax and do my b-best...",
										"Relaxing doesn't seem to do much anymore. It's hard to just STOP thinking about fucked up hentai.",
										"I'm like, totally trying to relax, but somehow my dumb girly brain keeps going back to tentacles."]);

			STRIPTEASE = Vector.<String>(["Do you losers get horny even at the slightest hint of any skin?", "I don't know why you're excited, it's not like there's anything to show off anyways.",
			"W-Well, I'm flattered you like me, but I shouldn't be doing this...", "G-Gosh, am I doing this right? Stripping is harder than I thought.",
			"I've heard doing kinky stuff like this nets you more popularity online.", "This one goes out to all of my subscribers!",
			"I learned this one from an eroge I totally LOVE. Like, what do you think?",  "Hope this makes good beat-off material! You like, learn some things when you run a camshow as a job.."]);

			CUM = Vector.<String>([ "I only orgasm when absolutely necessary. Climaxing during a game like this just seems like a distraction.",
			"Jokes on you, I'm only pretending to have an orgasm. I'm serious!",
			"Cumming is a natural thing everyone has to deal with. D-Don't look at me like that!",
			"F-Fuck... Do I really get d-dumber every time I cum like this?",
			"Gawd... Why does cumming during this game have to feel so good?",
			"Eeee, every time I cum I feel my brain get all bubbly. It feels sooooo good!",
			"I cum while playing games all the time! But usually they're like, more kinky than this.",
			"Nggghh... Does anyone like, wanna make a guest appearance on my 'show'..?",
			"Ugghhh... Somebody get over here and fuck me right now! My subscribers will love it..!"]);

			BUY_IN = Vector.<String>(["I've wondered how your clothes change whenever you lose IQ. I'm narrowing it down to magic or an unknown law of the universe.",
			"I'm starting to doubt the game balance of trading part of your brain for only $1000.",
			"Ugh, losing part of your mental capacity really makes you feel gross all over. Can't they patch this?",
			"Well, as long as I can still understand my favourite games I should be fine...",
			"There's something quite addicting and pleasurable to how losing your IQ feels. Is this like, ASMR?",
			"Like, maybe this buy in isn't so bad after all- I totally feel more pink and bubbly than ever! Besides, this is probably making me good waifu material.",
			"Nyahhh..! Losing your smarts like this feels soooooo fucking good! They should like, make a H-Game about this or somethin'."]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n100k Subscribers! The slut the internet loves." +
			"\n\nFuyumi didn't know what to do after being kicked off her favourite streaming site for pornographic material." +
			" She used to play in competitive tournaments, but after the poker game her stream was mainly filled with lets-plays of hentai games." +
			" However, through being much more confident thanks to her... enhanced charisma, she managed to make a lot of connections with" +
			" girls in similar situations. One friend told her about Porntreon, the new 18+ subscription site, and that marked the start of her new career." +

			"\n\nMoving to an 18+ site gave her a lot of opportunities, as she could do or wear almost anything." +
			" She used her quickly growing interest in fashion and porn to acquire a large fanbase extremely fast!" +
			" Her show became a variety act of playing dressup in various cosplay, reviewing pornographic video games, and sometimes masturbating on camera." +
			" While fairly generic in terms of content for the site, her large breasts, bubbly but nerdy personality, and high knowledge of all types of fetishes made her stand out." +
			" Ironically, she is huge into the TF kink scene, even if she has trouble understanding the concept of irony in her current state." +

			"\n\nShe looked so different after the game that the only thing linking to her past life was rumours." +
			" Before the game she would have scoffed at her slutty display. But now she revels in her complete depravity." +
			" Besides, her new lifestyle gets her tons of money. She might be spending a lot of it on slutty clothes, but it's better than nothing!" +
			" And while she lost a large majority of her intellect and got a completely new personality, one thing remained constant: her harsh criticism of video games." +
			"\n\n\"4/10. There's like, too much build up and you don't even get to see her tits get huge. Totally lame!\""]);
			
			
			typeId = 9; // SETUP This needs to be unique for each character
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}