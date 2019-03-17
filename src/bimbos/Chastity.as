package bimbos 
{
	import worlds.PokerWorld;
	public class Chastity extends BimboModel
	{
		
		public function Chastity(iq:Number = 117, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.CHASTITY, 600, 1000, 18),
					new Sequence(Assets.CHASTITY_PORTRAIT, 400, 400, 18));
					
			NAMES = Vector.<String>(["Madame Cherie", "Madame Cherisse", "Cherisse", "Cherise", "Charise", "Charrissa", "Charrise", "Chassie", "Chassy", "Chastity", "Chastitty", "Titty", "Tits"]);
			BIO = Vector.<String>(["Her dream: to become the finest ballerina the world has ever seen. However, she is impatient." +
									" Why practice for years and still possibly fail when other ways exist that promise immediate and certain results?"]);

			ALL_IN = Vector.<String>(["A proper lady must have confidence in herself. All in.", "In live performance, it's all or nothing!",
										"You've left me no choice, all in!", "I can get back this money from tips while I dance. Like, all-in!"]);
			ALREADY_ALL_IN = Vector.<String>(["It takes two to tango, and I'm already doing my part.", "I'm already all in. Maybe it's your turn?",
												"I've already gone all in! Maybe I should put in my clothes next~?"]);
			CALLING = Vector.<String>(["The muse doesn't come without being called. \nNor do the chips.", "It's not over 'till the fat lady sings! Calling!",
										"I've like, been called to a few hotels before. But it was more fun than this!"]);
			RAISING = Vector.<String>(["I raise this bet, but keep my posture steady.", "I think I’m going to raise", "Raising my skirt is part of my job, so like, I have had tons of practice for this."]);
			FOLDING = Vector.<String>(["I must preserve my stamina for the next act. Fold.", "These shoes are hurting my feet like this hand is hurting my head. Fold...",
			 							 "Calling and raising wears me out more than dancing. Fold!", "Ugh...! Fold! All this thinking and stuff is too hard!"]);
			WINNING = Vector.<String>(["Money is not my end-goal. I dance for the art.", "$<var>? That'll pay for a few of my lessons!" ,"$<var>? You guys sure know how to tip your showgirls!"]);

			FONDLING = Vector.<String>(["Massages are important to prevent stiffness, <var>.", "Am I making you dance, <var>?", "My feet are pretty strong <var>, should I use those too?",
										"When you swing around a pole all day, you get good with your hands, <var>!", "Cmon' <var>, this kind of stuff normally costs extra!"]);
			FONDLING_SELF = Vector.<String>(["Self care is important, especially before a dance.", "Y-Yeah, totally just uh... Massaging my chest!",
											 "I do this before each show to help 'prepare'!", "Gawd, I'm horny... Anyone wanna meet after closing?"]);

			RELAXING = Vector.<String>(["Meditating during times of need is a skill everyone should learn.", "I'm winded from all this mental dancing. Gonna take five." ,
										"Like, what's the point of relaxing when getting people horny is part of my job?"]);

			STRIPTEASE = Vector.<String>(["I call this dance 'Lust of the Young Lovers'.", "I'm hardly experienced at dances like this, but I'll give it a shot.",
											"How do you like this? I must admit, this is a bit different than my usual lessons.", "My ass is too big to fit in this leotard anyways.",
											"I'm beginning to think stuff like this is my true calling!", "Don't be shy about staring at me, it's like, part of my job!",
											"Hehehe, they don't call me an 'exotic dancer' for like, nothing!",  "This performance is making me horny too... Wanna fuck after this round?"]);

			CUM = Vector.<String>([ "(...I hope nobody noticed that!)",
									"This is very unprofessional. I apologize.",
									"P-Please, avert your gaze! This was an accident!",
									"Everyone's watching me cum... Why does this feel so good?",
									"Nyaaah~! (I wonder if they'd like it if I put on more of a show?)",
									"Mnf! It's hard enough keeping my hands off myself, especially when the game makes me cum this often!",
									"Nhghh~ I'm not allowed to cum on the job, but it just feels SO GOOD!"]);

			BUY_IN = Vector.<String>(["While mental fortitude is important to me, sometimes a lady has to do what is most needed.",
										"This isn't so bad. I'm sure that as long as I'm good on my feet, I'll know what the right thing to do is.",
										"Ugh, every time this happens it makes memorizing my lessons harder.",
										"Sure I lose both eye-cue and money, but in return I get huge tits. I think it's a good job investment.",
										"Playing this game is like, totally the smartest idea I've ever had! Clubs will have to fight over hiring me!"]);

			SUBMIT_DEFEAT_ENDING = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
													"\n\n<fff><s16>\"Vegas Stripper\"</s16></fff>, best in the country." +
													"\n\nSuch was the fate of \"<var0>\", as she called herself now." +
													" Gone was her dream of becoming a ballerina, as she had other callings to tend to -" +
													" the game had sapped all of her knowledge and love of traditional dance." +
													" Fortunately for her, she decided to pick up another type of 'dance', usually involving a pole." +

													"\n\n Not even a week after leaving the casino her phone started ringing non-stop." +
													" Turns out when you walk down the Vegas strip with barely any clothes on, people start to take notice! Especially strip clubs." +
													" Her newfound charisma gave her a wonderful sales pitch, which mainly involved her tongue and a lot of stamina. She was hired immediately." +

													"\n\nHer lack of smarts made her take the first job she was offered, so the pay ended up being less than amazing." +
													" The tips made up for it though, and she was happy enough to work escort service on the side." +
													" All in all, she loved her new job and wouldn't trade it for the world." +
													" She barely even remembers her real name, but at least swinging on a pole gives her a good workout!" +
													"\n\nBesides, who needs to remember silly things like that when you have a stage name and a smoking hot bod'?"]);	
			
			typeId = 2;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}