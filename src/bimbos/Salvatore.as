package bimbos 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import worlds.PokerWorld;
	public class Salvatore extends BimboModel
	{
		
		public function Salvatore(iq:Number = 121, money:Number = 2000, lust:Number = 0)
		{
			super(	new Sequence(Assets.MAFIOSO, 600, 1000, 16),
					new Sequence(Assets.MAFIOSO_PORTRAIT, 400, 400, 16));
					
			NAMES = Vector.<String>(["Don Salvatore", "Capo Salvatore", "Salvatore", "Salvor", "Sal", "Sally", "Sallie", "Sassie", "Sissie"]);
			BIO = Vector.<String>(["Born into the mafia, but not into the ruling family, he longs to see himself rule the streets." +
									" To go against the Don however, is something only the most brilliant mind could succeed in."]);
			
			ALL_IN = Vector.<String>(["An offer you can't refuse. All in.", "Going all-in!", "Screw it, it's the don's money, all in!", "Geez, guess I'm going for broke. All in!",
									"Shucks, fellas, way to back a gal against a wall. All in!", "Guess it's time ta blow Donnie's cash. All in!"]);
			CHECKING = Vector.<String>(["That's all. Check.", "Check.", "Huh? Oh yea, sure, check."]);
			CALLING = Vector.<String>(["I see what you're up to. Call.", "Think you're clever, eh? Call!", "That the way of it? Alright, I call!",
									"Ooh, don't you got moxie? I like it. Call!", "Ya bluffin' or somethin', mista? Hee, well I call!"]);
			RAISING = Vector.<String>(["Time to turn up the heat. Raise it $<var>.", "Raise! Whatchu looking at?", "Let's make things more interesting. Raise!",
										"Let's make things more interesting, darling. Raise!", "Wanna have some fun? Howabout $<var> wortha fun?"]);
			FOLDING = Vector.<String>(["No sense in bleeding chips. I fold.", "Augh... I'll Fold.", "Yeesh, tough round. I fold.",
										"Sorry, hun, but I think I need to sit this one out. Fold.", "Yikes! Count me out, mista. Fold!"]);
			WINNING = Vector.<String>(["Another $<var> for the coffers.", "Now we're talking! $<var> to me!" , "$<var>, for me? Shucks, ya shouldn't have."]);
			
			FONDLING = Vector.<String>(["Aren't you a pretty thing, <var>? Don't worry, you will be.", "How do you like a touch of ol' Sal, <var>?", "Oh, my hands are so small... how do they feel, <var>?", "How'd you like some attention from little ol' me, <var>?", "Gee, mista, ya look stiff. Let me help with that!"]);

			FONDLING_SELF = Vector.<String>(["Something about this casino makes my body feel strange...", "Huh? Why's my body feel so soft... and so good...", "When'd I get these curves? They feel... nice.", "Ooh, I just love getting in a little \"me\" time, don't you?", "Heehee, wonda when donnie will get back? I'm getting sooo horny..."]);

			RELAXING = Vector.<String>(["Just think back and think of the money, Salvatore", "Jeez, things are getting pretty hot in here. Need to focus.", "Woah, easy now. Need to calm down.", "Woah now. Let's take things slow, fellas.", "Whew! Wait, what was I talkin' about?"]);

			STRIPTEASE = Vector.<String>(["How'd you like a look at the body of a powerful man?",
			"Like what you see, ladies?", "Like what you see, gu-er, ladies?", "How you like this for a show, fellas?", 
			"Wanna see somethin' fun? Howwabout me?"]);

			CUM = Vector.<String>([ "Oh my... well that was unprofessional",
									"Hot damn! Never thought I woulda gotten my rocks off at a poker game!",
									"Oh! I... I hope nobody was watching that.",
									"Ooh, that feels nice... And there's plenty more where that came from.",
									"Mmm... oh donnie. Oh donnie.. Ooooooh oh gawd yes, Donnieeeee!"]);

			BUY_IN = Vector.<String>(["Pretty high price, to get back in the game. Here's hoping it's worth it.",
									"Wait, I'm paying in what now? Guess I don't have a choice...",
									"I can feel my mind slipping away! That's bad... right?",
									"Take as much brains as ya want, boys. Don't need much with a body like this.",
									"Hee, that tickles! Wonda if donnie likes me more like this?"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n\<fff><s16><var0>, the Don's favorite moll.</s16></fff>" +
			"\n\n Gone is the ambitious young Mafioso, bent on overthrowing the don and coming to power in the underworld." +
			" In his place is a empty headed little vixen, with little thought in her head than indulging herself and her don's ever whim." +
			" Seems the don had caught wind of Salvatore's little scheme, and as a major shareholder in the casino it was easy to rig the game against Sal." +
			" Now the young upstart had been remade into the don's latest plaything: the perfect punishment, the perfect example, and the perfect toy all in one." +

			"\n\n After the game was done, it wasn't long before the don himself arrived to pick up his new squeeze." +
			" There's still just enough of the old Sal left in <var0>'s vacuous head to spill the beans on all her old pals," +
			" and after eagerly ratting on every one of her friends, <var0> is taken upstairs by the don himself and rewarded personally." +
			" The first time her don enters inside her, all thoughts of <var0>'s old life are forgotten. Now she was just <var0>. The don's <var0>." +


			"\n\n In due time <var0> became the don's favorite of a extensive collection of mistresses, always quick to laugh and quicker to please, particularly if it was with her shapely form." +
			" As the don's personal moll, she lives better than Salvatore could have imagined in his wildest dreams, her days full of indulgence and pleasure." +
			" When not spending time with her don or spending her don's money, <var0> spent much of her time providing similar pleasures to winners of the casino or the don's personal friends." +
			" The don was a generous man after all, and <var0> was too good not to share." +
			" <var0> has become everything Salvatore hated in life: stupid, subservient, nothing more than a pretty piece of eye candy." +
			" But she was also happier than Salvatore ever was, and her empty little mind couldn't imagine a life any better than her own."]);
			
			typeId = 1;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}