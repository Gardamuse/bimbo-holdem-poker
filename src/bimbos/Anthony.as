package bimbos 
{
	import worlds.PokerWorld;
	public class Anthony extends BimboModel
	{
		
		public function Anthony(iq:Number = 103, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.ANTHONY, 600, 1000, 17),
					new Sequence(Assets.ANTHONY_PORTRAIT, 400, 400, 17));
					
			SHORT_NAMES = Vector.<String>(["A. Young",   "DJ Young",         "Anthony",       "AJ", "Ajay", "AJ", "Ava J", "Ava", "Ave"]);
			NAMES = Vector.<String>(["DJ Anthony Young", "DJ Anthony Young", "Anthony Young", "AJ", "Ajay", "AJ", "Ava J", "Ava", "Ave"]);
			BIO = Vector.<String>(["From a long line of musicians, and despite his best effort, AJ's dreams of becoming a famous rapper" +
									" grew more distant every day. He realized too late that English was the most important class in school and couldn't write a rhyme" +
									" to save his life. But AJ's got a plan: to become a lyrical genius, he just needs to become an actual genius."]);
									
			ALL_IN = Vector.<String>(["Got the confidence and the mad skills, to beat all you sorry shills! All in!",
										"Dropping the beat!", "All the way, man.", "Hummmph! Can you match this, boys? Alllll in!"]);
			ALREADY_ALL_IN = Vector.<String>(["I'm already all in, so why you playin' man?"]);
			CHECKING = Vector.<String>(["Yo yo yo check it out, I'm checkin', to make sure it's YOUR face I'm deckin'!",
										"Check this out! Shit's HOT!", "Check check, my man!", "Ooooh, check ME out! I can do this!"]);
			CALLING = Vector.<String>(["Risin' up, and hope I don't fall, so to play it safe, I'm gonna call.",
										"Callin' this like I called your GIRLFRIEND last night!",
										"Calling... Like, what's that even mean? I don't get this game.", "Calling? Like, I don't even have my phone on me! Hehe!"]);
			RAISING = Vector.<String>(["Raisin' the stakes, so I'm gonna lock it, to drain $<var> right outta yall pocket!", "Turn it up! $<var>!", "This is my jam! Raisin' $<var>!"]);
			FOLDING = Vector.<String>(["Take a look here, my hand's all wack, foldin' right now to get my money back.",
										"Man, this shit sucks. Folding.", "I barely even know how to play this and I know my hand's a bummer.",
										 "You meanies keep betting too high. Foldies!"]);
			WINNING = Vector.<String>(["$<var>... I'm gonna be stackin' those papers so high!", "$<var> in the bank.",
										 "$<var> goes to me.", "Yay, more green stuff! Uhh, like $<var>, I think?"]);
			FONDLING = Vector.<String>(["Like my rhythm <var>?", "You like this <var>?",
										"Aren't you going to return the favor <var>?", "I hope you're ready for me to blow you away."]);
			FONDLING_SELF = Vector.<String>(["Hard as iron. Damn I'm looking good today!", "Toned up! Looking good!",
											"Hehheheheheh... when did I get so blush?", "Guys it's sooo hot in here! Or is it just me?! Hahahah!"]);
			RELAXING = Vector.<String>(["Just gotta get back in the rhythm.", "Maybe I should listen to something smoother...", "Just need to relax a second."]);
			STRIPTEASE = Vector.<String>(["Too good to be true, I know.", "Want to have a look see?",
										"How's this everybody?", "Are you feeling it now?",
										"Holy shit, I'm so curvy, guys, look!", "What do you mean I have to keep my clothes on? No I don't; see?",
										"If anyone wants a feel all you have to do is ask!",  "Heheheheh... does this mean we can fuck now?"]);
			BUY_IN = Vector.<String>(["What the...?! Fuck you, I didn't agree to this!",
									"Shit. Well this isn't going according to plan. At least I can keep playing.",
									"Ugh! Damnit! Did these guys slip me something? I can't think straight.",
									"What was I worried about... Well it's probably not, like, important or anything.",
									"Wow this game is awesome! I can't lose! What do you mean I'm losing? Not in my book!"]);
			CUM = Vector.<String>(["Aw shit man, feelin my brain go numb, why's this gotta happen when I cum?",
									"Shit man, feels like I got a mad hangover or something.",
									"Ah fuck! Nobody saw that, right?", "Hehee, I feel really woozy but... It also feels great!",
									"Whenever I cum my boobs totally get bigger! Nff, gotta keep at it!",
									"Heheheee, wow, did I like, really just cum again? I'm so easy, gawd!" ]);
														 
			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n\"BJ DJ\", property of the Casino." +
			"\n\nSuch was the fate of <var0>, as she called herself now." +
			" A shell of her former self, <var0> at least retained the spunk of her former life. Though not much of the wit." +
			" Every day at the casino was a party, and DJ <var0> catered to every event. Much like her orginal goal," +
			" she did actually become very good at both singing and rapping. But unlike her orginal plans, she only found" +
			" inspiration in sex. She just couldn't think of anything else to make music about." +

			"\n\nHer beautiful, voluptuous body and amazing voice added even more to her act. Though the casino staff thought that" +
			" they might have gone a little overboard with her breasts. She couldn't stand up for more than twenty minutes at a time." +
			" But <var0> didn't mind that at all." +
			" In fact she couldn't be happier! She had achieved her dream of becoming a famous rapper and DJ! She had all the" +
			" drugs and sex she could possibly want, a huge suite with personal attendants, and she got to play to a full house every night!"
			]);

			typeId = 14;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}