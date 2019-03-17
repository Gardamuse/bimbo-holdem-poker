package bimbos 
{
	import worlds.PokerWorld;
	public class Miller extends BimboModel
	{
		
		public function Miller(iq:Number = 121, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.MILLER, 600, 1000, 19),
					new Sequence(Assets.MILLER_PORTRAIT, 400, 400, 19));
			SHORT_NAMES = Vector.<String>(["Millerton", "Millerton", "Millerton", "Miller", "John", "Jon", "Jon", "Jona", "Jo", "Josie", "Jolie", "Jolie", "Julie", "Julie", "July", "July", "July", "Juicy", "Juicy"]);

			NAMES = Vector.<String>(["General J.H. Millerton", "Brigadier J.H. Millerton", "Colonel John Millerton", "Major John Miller", "Captain John Miller", "1st Lieutenant Jon Miller", "Sergeant Jon Mills", "Corporal Jona Mills", "Specialist Jo Mills", "Private Josie Mills", "Jolie Mills", "Jolie Mills", "Julie Mils", "Julie Mils", "July M", "July M", "July", "Juicy", "Juicy"]);
			BIO = Vector.<String>(["A senator's son who turned to the military when all other doors closed due to his poor scores (and his mother did nothing to help), but did poorly at even that, receiving several reprimands and coming dangerously close to a dishonourable discharge on two separate occasions. Stationed at a nowhere base with no prospects, in or out of the military, he throws all in."]);

			ALL_IN = Vector.<String>(["A cornered tiger fights the fiercest. I'm all in.", "Damn. All or nothing, I guess.", "Aw, shucks. I'm all out of chips.", "Like, all in, right?"]);
			ALREADY_ALL_IN = Vector.<String>(["You sure your faculties are all in order? I'm already fresh out.", "I'm already all-in.", "I don't have anything left, silly!"]);
			CHECKING = Vector.<String>(["No more moves to make. I check.", "Check.", "Like...uh....Check."]);
			CALLING = Vector.<String>(["You can't outfox a fox, son. Call.", "I call.", "Uh, how do you, like, Call?"]);
			RAISING = Vector.<String>(["No victory comes without risk. Raise $<var>.", "I raise with $<var>.", "I think I'll put $<var> in."]);
			FOLDING = Vector.<String>(["A Golden Bridge to retreat across...Fold.", "Son of a... I Fold.", "Eek! I, so totally fold."]);
			WINNING = Vector.<String>(["Victory is mine. A solid $<var> to the coffers.", "Ha-ha! $<var> for me!" ,"Yay! I got $<var>!"]);

			FONDLING = Vector.<String>(["This is purely tactical, <var>.", "How do you like this, <var>?", "Ooh, how's that feel, <var>?", "Come on, <var>, let's fuck!"]);

			FONDLING_SELF = Vector.<String>(["I think I made a strategic miscalculation...", "Oof, nothing like a bit of self-service.", "I'm getting soo horny!", "Oooh... could someone like, just fuck me right now?"]);

			RELAXING = Vector.<String>(["Just Breath, John. Don't let the enemy get in your head.", "Yeesh, it's getting hot in here.  Better take a breather." , "Mmh. That's better."]);

			STRIPTEASE = Vector.<String>(["This is hardly professional, but needs must.", "Everyone likes a person in uniform. But how about out, eh?", 
			"How do you like me now?", "How do you like this body?", 
			"How do you like my curves?", "Hehe, you all sneak glances at my boobs, take a good look now!", 
			"Hihihi... one of you should like, come here and touch me all over!",  "Aaah, hahahaaa... someone want to, like, come fuck me?"]);

			CUM = Vector.<String>([ "Shit, bombs away!",
			"Oof. That was rather...public",
			"Ack! In the middle of everyone, too!",
			"I sure hope no one noticed that.",
			"No one cares if I cum, anyway.",
			"Aaaahaaahaa... that feels so yummy.", 
			"Aaahaaah oooh... I want to cum again! Someone please fuck me!"]);

			BUY_IN = Vector.<String>(["Oh, dear, my mind seems to be growing clouded. Brains for chips--that's not a fair bargain at all!",
			"Ooh, I don't feel so hot. At least I can keep going.",
			"If I play well enough, maybe they'll give me my brains back!",
			"Brains aren't that important anyway, right? And I can get 'em back if I need to!",
			"Ohmygawd this game is amaaaazing! If I win, I get moneys and if I lose I get to be hot!"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n<fff><s16>\"Barracks Babe\"</s16></fff>, property of the Casino." +
			"\n\nSuch was the fate of \"<var0>\", as she called herself now." +
			" No longer was she anything but an airhead bimbo, never to again care for the troubles of the world." +
			" Each morning she would rise late after a long night of drinks and sex." +
			" Though she spent a good deal of time in the Casino, she was also often loaned out to Military bases as a 'stress reliever' for the troops." +

			"\n\n She would be passed from one soldier to the next, with officers getting first dibs. Despite it all, she was treated quite gently, with any soldier who harmed her" +
			" being chewed out hard enough to make their head spin. She rarely wore much at all, and when she did it was short, low-cut, revealing, to better please her masters." +
			" Even the thought of so many strong men(and some women--she was too dumb and too horny to be picky about which soldiers she went after," +
			" even if, were she able to think straight, she wouldn't consider herself bisexual). Still, that same her would agree that it wasn't such a terrible life." +
			" Every step made her tingle, every slight bounce of her butt cheeks excited her and every jiggle of her gigantic breasts sent shivers throughout her entire body." +

			"\n\nNothing of her old self remained. It had all been washed away by wave after wave of incredible lust." +
			" Every so often a clear thought broke through, and she thought about how lucky she was that no one at that table had decided to take her home." +
			" The casino took care of her and gave her all she needed. They assigned her nice masters, joy and lust dominated her life" +
			" and she could spend everyday doing what she loved doing the most: fuck."]);


			
			
			typeId = 6;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}