package bimbos 
{
	import worlds.PokerWorld;
	public class Rosa extends BimboModel
	{
		
		public function Rosa(iq:Number = 111, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.ROSA, 600, 1000, 16),
					new Sequence(Assets.ROSA_PORTRAIT, 400, 400, 16));
			SHORT_NAMES = Vector.<String>(["Rosalinda", "Rosalia", "Rosa", "Rosa", "Rose", "Rosie", "Rosi", "Ruby", "Rubi", "Ru-Ru"]);

			NAMES = Vector.<String>(["CLO Rosalinda Ramirez", "DA Rosalia Ramirez", "Advocate Rosa", "Rosa", "Rose", "Rosie", "Rosi", "Ruby", "Rubi", "Ru-Ru"]);
			BIO = Vector.<String>(["An ambitious young lawyer, Rosa is talented, driven and independent. However her circumstances (and personal arrogance) prevent her from reaching the top of the legal world." +
			" To Rosa, the Casino is her opportunity to obtain everything in life that she has never had, but always deserved."]);

			ALL_IN = Vector.<String>(["All or nothing. Lady Justice shall decide my fate!", "No bluffing here! All in!", "Have, like, all my moneys!"]);
			ALREADY_ALL_IN = Vector.<String>(["I'm already all-in."]);
			CHECKING = Vector.<String>(["Checks and balances, but right now: check.", "Check!", "Let's see the cards already!"]);
			CALLING = Vector.<String>(["I call the cards to the stand!", "HOLD IT! I call!", "Call.", "Call! But, like, where's the phone?"]);
			RAISING = Vector.<String>(["TAKE THAT! I raise with $<var>!", "Justice is on my side! I raise $<var>!", "I raise with $<var>!"]);
			FOLDING = Vector.<String>(["The defence withdraws its claim.", "Fold.", "Fold! But there's, like, no paper!"]);
			WINNING = Vector.<String>(["Looks like I'm guilty... OF WINNING $<var>!", "Case closed! $<var> more to me!", "Yay! I won $<var>!", "I won $<var>? That's, like, more than I can count!"]);

			FONDLING = Vector.<String>(["Feel my brilliance, <var>.", "The defence wonders if <var> would like some more?", "Like how I serve you, <var>?", "Oh fuck <var>, you're so hot!"]);
			RELAXING = Vector.<String>(["The defence calls for a recess!", "C'mon... keep it together." , "I've gotta stay calm! My mind is like, slipping away!", "I gotta relax, I can always cum later!"]);
			STRIPTEASE = Vector.<String>(["You're all so lucky to see this flawless body...You can thank me later.", "How do you like this body?",
			"How do you like this body?", "How do you like this body?",
			"How do you like my curves?", "Hehe, you all sneak glances at my boobs, take a good look now!",
			"Hihihi... one of you should like, come here and touch me all over!",  "Aaahw, hahahaaa... someone want to, like, come fuck me?"]);
			
			SUBMIT_DEFEAT_ENDING = Vector.<String>([
				"<sLarge><cBC>Epilogue</cBC></sLarge>" +
				"\n\n<fff><s16>Casino Maid</s16></fff>" +
				"\n\nSuch was the official title of the airhead bimbo, \"<var0>\"." +
				" Her duties were to clean and to please, tasks which she eagerly performed." +
				" Endlessly she would walk from room to room in the Casino, cleaning, and tending to all who wanted it." +
				
				"\n\nThe cleaning aspect of her job was not exactly her strongest suit however; as it took all the concentration she could muster to simply mop the floors." +
				"\n Her difficulties were not helped by her uncovered snatch, from which her juices flowed freely. Many rooms were left smelling more deeply of her sex than of any cleaning agent." +
				
				"\n\nOn the other hand, Ru-Ru excelled in tending to the Casino Patrons. So eager was she, that she would often beg a player to be allowed tend to them," +
				" promising to sit under their table so quietly they would never notice, if she was just allowed to taste them." +
				" Usually of course, little begging was really required. Most were quite pleased to have her, and she was very happy." +
				
				"\n\nHer new life was perfect." +
				""]);
			
			typeId = 7;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}