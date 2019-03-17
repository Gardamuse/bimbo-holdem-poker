package bimbos 
{
	import worlds.PokerWorld;
	public class Dionysus extends BimboModel
	{
		
		public function Dionysus(iq:Number = 117, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.DIONYSUS, 600, 1000, 17),
					new Sequence(Assets.DIONYSUS_PORTRAIT, 400, 400, 17));
					
			SHORT_NAMES = Vector.<String>(["Dionysus", "Dionysus", "Dionysus", "Dionysus", "Dionysas", "Dionys", "Diona", "Dia", "Dea"]);
			NAMES = Vector.<String>(["Arch Bishop Dionysus", "High Priestess Dionysus", "Ascendant Dionysus", "Dionysus", "Dionysas", "Dionys", "Diona", "Dia", "Dea"]);
			BIO = Vector.<String>([
			" Her psychic powers having manifested themselves at a very young age, Dionysus knew she was destined for great things." +
			" Now a high ranking member of the 'Cult of the Six Stars'," +
			" and at the cusp of her ascension, she faced one last test before she could lead her congregation: obtain power only thought possible by gods, or die trying."]);

			
			FOLDING = Vector.<String>(["I don't live in darkness, darkness lives in me. Fold.", "Fold."]);
			WINNING = Vector.<String>(["This will fund the church.", "$<var> for my troubles.", "How much is $<var> worth again?"]);

			FONDLING = Vector.<String>(["It's better with more hands. Right, <var>?", "How's this <var>?", "You're so soft<var>! I wish I could touch you all the time!", 
			"You're so sexy <var>! Please play with me..."]);

			FONDLING_SELF = Vector.<String>(["Wow I'm looking great today!", "My skin is as smooth as silk.", "Oh Gods, it's so hot in here!", "Ooooh, so good..."]); 

			RELAXING = Vector.<String>(["David entered the valley of oblivion, and he saw the first of the one thousand eyes...", "Calm." , "Mmmmm... Much better."]);

			STRIPTEASE = Vector.<String>(["My beauty rivals that of the Goddess! ", "How do you like this?",
			"Incredible, right?", "Where do you think you're looking?",
			"How do you like these curves?", "Hehehehhe... go away hands, let them see",
			"Would anyone like a massage? I'm really good at it trust me!", "Ahahahahhaaa... I'm so horny, just fuck me already!"]);

			CUM = Vector.<String>([ "What am I doing? This is unsightly!",
			"Gods... That was weird...",
			"It's just a game, why am I cumming like this?",
			"Gods, why does it feel so good when I come?",
			"Ehehehehheeehhh... I came again.... ",
			"When didn't it feel this good before? I can't even stop myself!", 
			"Please stop teasing me! Just fuck me already!"]);

			BUY_IN = Vector.<String>(["You can't take my powers! I didn't agree to this!",
			"I feel... weird... At least I can keep playing",
			"Twenty plus twenty is.... is... FORTY! Ugh... why was that so hard?",
			"You bastards are definitely making me dumber! When I get out of here... I'm gonna do something!",
			"...where am I? Oh... the game... play game. That's what I was doing..."]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n\"Whore-shipper\", property of the Casino." +
			"\n\nSuch was the fate of <var0>, as she called herself now." +
			" No longer was she anything but a bumbling moron, about as smart as a six year old." +
			" Each day was an adventure for the sweet girl. All kinds of interesting people and things surrounded her." +
			" And people where fasinated by her as well. Objects moving at random, doors opening and closing," +
			" phantom fondles. Some wondered if the casino was haunted, but staff assured guests that is was just <var0> playing around." +
			" There she was, giggling like an idiot every time it happened." + 

			"\n\nNot much was expected out of <var0> besides the usual 'entertain'. But she was able to provide more... exotic experiences" +
			" to the more daring customers. You can use six extra floating hands in all kinds of ways after all. For one, her massages gained renown far and wide." +
			" Again, six hands massaging you while you rest on her breasts like giant pillows. It's easy to see why her services where in high demand." +

			"\n\n<var0> did not remember much from her past life. Something about whorshipping a monster or something." +
			" The pink haze in her mind rarely cleared. And when it did, her dark mistress was rarely thought of. " +
			" Besides, she had found a calling in life far better than being a nun, or whatever."
			]);

			typeId = 13;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}