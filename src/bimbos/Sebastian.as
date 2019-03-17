package bimbos 
{
	import worlds.PokerWorld;
	public class Sebastian extends BimboModel
	{
		
		public function Sebastian(iq:Number = 124, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.SEBASTIAN, 600, 1000, 17),
					new Sequence(Assets.SEBASTIAN_PORTRAIT, 400, 400, 17));
			
			SHORT_NAMES = Vector.<String>(["Sebastian", "Sebastian", "Sebastian", "Seb", "Sebba", "Sebba", "Sebbi", "Sebbie", "Sebby", "Subby"]);
			NAMES = Vector.<String>(["Sebastian Frank III", "Sebastian Frank", "Sebastian", "Seb", "Sebba", "Sebba", "Sebbi", "Sebbie", "Sebby", "Subby"]);
			
			BIO = Vector.<String>(["A low tier employee for the super corporation World Gate, Sebastian is paid to test the corporations products and treatments." +
				" He remembers little from any experiments and is pay checks are always good enough to keep him from questioning it." +
				" Having won an all expenses paid vacation in an employees-only lottery, Sebastian finds himself at the main attraction of his getaway: The Casino." +
				" Little does he know that he is just a tool for corporate espionage, and that what might happen to him is of little importance to World Gate." +
			""]);

			ALL_IN = Vector.<String>(["This is everything.", "Here goes nothing!", "Heh heehheh, all my moneys."]);
			WINNING = Vector.<String>(["Another $<var> for me.", "Yes! $<var> goes to me.", "Cool! I won $<var>!"]);

			FONDLING = Vector.<String>(["How's that, <var>?", "How's this feel <var>?", "Hahhaha, you're so cute <var>!",
			 "Oh fuck <var>, you're so awesome!"]);

			RELAXING = Vector.<String>(["I need to pace myself...", "Quick breather..." ,
			 "Slow down... Everything's fine"]);

			STRIPTEASE = Vector.<String>(["Feeling a little hot under the collar?", "How do you like this body?", 
			"How do you like this?", "How do you like my body?", 
			"How do you like these curves?", "Hehe, you all sneak glances at my boobies, all you had to do was ask!", 
			"Ohhhhh.... just like that...",  "Hahahaha... you wanna, like, come over here and fuck me?"]);

			CUM = Vector.<String>([ "Uwww... I hope nobody noticed that...",
			"Jesus! I just came.... What's wrong with me?",
			"Oooh... I can't believe I cum during a poker game...",
			"Heheheh, I came again....",
			"Hahahahhaah... I can't stop coming! ",
			"Aaaahaaahaa... cumming is the best!", 
			"Aaahaaah oooh aaahhhaah... Someone please just fuck me already!"]);

			BUY_IN = Vector.<String>(["You made me trade my intellengence for money? That's impossible!",
			"I don't feel so smart anymore... at least I've got more money...",
			"I'm not feeling that smart... Ugh! If I could just win some I'd get better!",
			"Hahaahah! More money for me! What was, like, the downside again?",
			"I love this game! If I win I get more moneys! And if I lose I get sexier! It's like I can't lose!"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
			"\n\n\"Living Doll\", property of the Casino." +
			"\n\nWorld Gate's previous experiments combined with the Casino's transformatives proved too much for \"<var0>\", as she was called now." +
			" Her brain effectively short-circuited by waves of indescribable lust, nothing of her old self remained." +
	
			"\n\nShe would rise early each morning to the casino staff's loving attention and care." +
			" Her wonderful hair took no less than three hours to make, and she was kept under constant supervision." +

			"\n\nEventually she would ascend a golden throne, where guests could gaze upon her sexually charged radiance every day." +
			" She was a glorified piece of furniture, essentially, and not much smarter than one either." +
			" Those who could afford it would sometimes buy her services: a cute bubbly sex doll that they could play with for hours and hours..." +

			"\n\nDespite the loss of their test subject, World Gate managed to gain some insights. What exactly is unclear, but several high-ups were heard discussing new possibilities with excitement." +
			" The test subject was quickly forgotten about. She would simply have to enjoy her... retirement."]);
			
			typeId = 10;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}