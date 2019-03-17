package bimbos 
{
	import worlds.PokerWorld;
	public class Rebecca extends BimboModel
	{
		
		public function Rebecca(iq:Number = 139, money:Number = 2000, lust:Number = 0.0)
		{
			super(	new Sequence(Assets.REBECCA, 600, 1000, 17),
					new Sequence(Assets.REBECCA_PORTRAIT, 400, 400, 17));
					
			NAMES = Vector.<String>(["Raymond", "Raygan", "Reagan", "Regan", "Rebecka", "Rebecca", "Becky", "Bessy"]);
			BIO = Vector.<String>(["A rider of the prairies." +
									" Desires to seize control of the trigger happy bandit gang dominating his home." + 
									" Not to save his town or old ranch, but to gain access to the black gold beneath the earth."]);
			
			ALL_IN = Vector.<String>(["All-in! Yeehaw!", "Down to my last penny, all in!", "All-in!", "I'm betting, like, everything!"]);
			CHECKING = Vector.<String>(["Check. Your move, partner.", "Check.", "Checking y'all out!"]);
			RAISING = Vector.<String>(["I'm feelin' lucky. Raise!", "Think I'm bluffin'? Raise!", "Raising the stakes.", "Raise.", "Raise!"]);
			FOLDING = Vector.<String>(["Sometimes you just can't win. Fold.", "I know when my own horse ain't good for nothin'. Fold.", "I could bluff, but why, like, bother? Fold!"]);
			WINNING = Vector.<String>(["Yeehaw, $<var> to me!", "Yippiee! Another $<var>." , "Yeaah! I won $<var>!"]);
			FONDLING_SELF = Vector.<String>(["My skin feels pretty soft today...", "Aaaah... my skin's so soft...", "I'm getting soo horny!", "Oooh... could someone, maybe like, milk me?"]);
			CUM = Vector.<String>([	"Oh my... did I just climax during a poker game! What is going on here?",
									"Oh god! I came right here among people!",
									"Oooh... I can't believe I cum during a poker game...",
									"Eheehe... hopefully no-one noticed I just came...",
									"Eeeh... aaah... no-one seems to notice if I cum anyways... ",
									"Aahaaahaa... cumming is sooo nice!", 
									"Aahaaa... Moooh! I want to cum mooore! Someone please fuck me!"]);
									
			SUBMIT_DEFEAT_ENDING = Vector.<String>([
				"<sLarge><cBC>Epilogue</cBC></sLarge>" +
				"\n\n<fff><s16>Cow girl</s16></fff>, Casino livestock" +
				"\n\n" +
				"Little Bessy quickly lost interest in exploiting her home for its black gold. Instead she found a new passion: the white gold dribbling from her own succulent tits." +
				"\n\n" +
				"The Casino's treatment had turned the former intimidating cowboy into a very shy but affectionate creature." + 
				" Often on all four, her breasts sloshing around too much for her to really walk effectively, she always stayed silently in a corner." +
				" Too afraid to search for someone, her quiet moans grew ever more frequent as her mammaries filled up with milk to the point they started dripping, wetting her and the floor around her." +
				"\n\n" +
				"She didn't take well to new people either. While always sneaking very hungry looks at the bulging pants of many male customers, a fair part of the Casino's clientele were of the rough sort." +
				" Their hard hands and harsch words often caused her pain when they inexperiencedly squeezed her already bursting breasts and sore but sensitive nipples." +
				"\n\n" +
				"Instead Bessy kept to herself and to the few who understood her and handled her with care." +
				" They approached slowly, sat down gently and she leapt into their laps, nuzzling up close against them." +
				" Her mouth would steadily drift towards the crouch of her friend, no matter their gender, eager to convince them in staying as long as possible." + 
				" All the while, soft hands patted her head, stroked her hair and gently massaged her breasts and nipples, releasing oh so much milk, and easing the pressure in her chest." +
				"\n\n" +
				"Needless to say, with her mouth firmly planted in someones crouch, strong arms keeping her warm and the wondrous feeling of being milked, she cummed every time." +
				"\n\n" +
				"So in the end, Bessy had become very happy, all thanks to the Casino."
			]);
			
			typeId = 3;
			this.iq = iq;
			this.money = money;
			this.lust = lust;
		}
		
	}

}