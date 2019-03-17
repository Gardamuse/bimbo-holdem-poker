package 
{
	import bimbos.*;
	public class BimboModel 
	{
		
		//Model vars
		protected var _iq:Number;
		protected var _lust:Number;
		protected var _money:Number;
		protected var _debt:Number = 0;
		
		public var typeId:int = -1;
		
		public var camSequence:Sequence;
		public var portraitSequence:Sequence;
		
		//Default text
		public var SHORT_NAMES:Vector.<String> = Vector.<String>([]);
		public var NAMES:Vector.<String> = Vector.<String>(["Bimbo"]);
		public var BIO:Vector.<String> = Vector.<String>(["A mysterious character, not much was known about this person."]);
		public var SUBMIT_DEFEAT_ENDING:Vector.<String> = Vector.<String>(["<sLarge><cBC>Epilogue</cBC></sLarge>" +
								"\n\n<fff><s16>Escort girl</s16></fff>, property of the Casino." +
								"\n\nSuch was the fate of \"<var0>\", as she called herself now." +
								" No longer was she anything but an airhead bimbo, never to again care for the troubles of the world." +
								" Each morning she would rise late after a long night of drinks and sex." +
								" Sometimes her current master wanted a little bit of \"morning cuddle\", in which case she would gladly stay in bed for as long as was required." +
								
								"\n\nEventually she might get dressed, putting on whatever would please her master the most, usually something very petite," +
								" something like those miniskirts, for instance, those that so well would both accentuate her wide hips and put her panties on display, did she happen to wear any." +
								" She would always giggle then, just the thought of showing off her huge breasts, ass and gorgeous thighs to anyone who would watch would always make her wet." +
								" And wet she always was too, wet and pleasantly full of cum, for her every thought drove her towards sex:" +
								" Every step made her tingle, every slight bounce of her butt cheeks excited her and every jiggle of her gigantic breasts sent shivers throughout her entire body." +
								
								"\n\nNothing of her old self remained. It had all been washed away by wave after wave of incredible lust." +
								" She would never have chosen this way by free will, but after all, it was not so bad, she would have thought, had she been able." +
								" The casino took care of her and gave her all she needed. They assigned her nice masters, joy and lust dominated her life" +
								" and she could spend everyday doing what she loved doing the most: fuck."]);
		
		public var ALL_IN:Vector.<String> = Vector.<String>(["Time to go all in.", "Going all-in!", "All in!", "I'm putting like, everything on this! All in!"]);
		public var ALREADY_ALL_IN:Vector.<String> = Vector.<String>(["I'm already all in."]);
		public var CHECKING:Vector.<String> = Vector.<String>(["Check.", "Check.", "Yay, check!"]);
		public var CALLING:Vector.<String> = Vector.<String>(["Gonna call this.", "Call.", "Wohoo! Calling!"]);
		public var RAISING:Vector.<String> = Vector.<String>(["I raise with $<var>."]);
		public var FOLDING:Vector.<String> = Vector.<String>(["Fold.", "Fold.", "Aww... fold."]);
		public var WINNING:Vector.<String> = Vector.<String>(["I have acquired another $<var>.", "Yes! $<var> to me." ,"Yay! I won $<var>!"]);
		
		public var FONDLING:Vector.<String> = Vector.<String>(["Feeling good, <var>?", "How does this feel <var>?", "Ah, I wish you would hold me like this <var>!", "Oh fuck <var>, you're so hot!"]);
		public var FONDLING_SELF:Vector.<String> = Vector.<String>(["My skin feels pretty soft today...", "Aaaah... my skin's so soft...", "I'm getting soo horny!", "Oooh... could someone like, just fuck me right now?"]);
		public var IQ_UP:Vector.<String> = Vector.<String>(["Intelligence enhancements... interesting.", "My mind feels sharper.", "I'm feeling smarter already.",
															"I feel like... smarter!", "I'm like, getting more brainy!"]);
		public var RELAXING:Vector.<String> = Vector.<String>(["My mind palace calms me...", "I just need to relax a bit..." , "Deep, slow breaths... so calming."]);
		public var STRIPTEASE:Vector.<String> = Vector.<String>(["Intelligence is the hottest trait, so I bet you all love me!", "How do you like this body?", 
																"How do you like this body?", "How do you like this body?", 
																"How do you like my curves?", "Hehe, you all sneak glances at my boobs, take a good look now!", 
																"Hihihi... one of you should like, come here and touch me all over!",  "Aaahw, hahahaaa... someone want to, like, come fuck me?"]);
		public var CUM:Vector.<String> = Vector.<String>([	"Oh my... did I just climax during a poker game! What is going on here?",
															"Oh god! I came right here among people!",
															"Oooh... I can't believe I cum during a poker game...",
															"Eheehe... hopefully noone noticed I just cummed...",
															"Eeeh...aaah... noone seems to notice if I cum anyways... ",
															"Aaaahaaahaa... cumming is sooo nice!", 
															"Aaahaaah oooh... I want to cum again! Someone please fuck me!"]);
		public var BIMBOFY:Vector.<String> = Vector.<String>(["What's happening to me?", "Oh my, what's happening?", "I'm starting to feel a bit... dumb.", "I feel all bubbly!",
															"I feel like sooo great! And horny!", "Ooh... I like, just want someone to fuck me right now! Pleeeease?"]);
		public var BUY_IN:Vector.<String> = Vector.<String>(["Did they just drain my intelligence but gave me money so I can stay in the game? I didn't agree to this!",
															"I don't feel so smart anymore... atleast I got some more money so I can stay in the game.",
															"I'm starting to feel a bit dumb. Oh well, I got cash enough to win my smarts back!",
															"Hihi, I feel, like, a bit dumb now but, as long as I got cash that doesn't, like, matter!",
															"I like sooo love this game! When I win I get moneys and when I lose I get so much hotter!"]);
		
		public function BimboModel(camSequence:Sequence, portraitSequence:Sequence)
		{
			this.camSequence = camSequence;
			this.portraitSequence = portraitSequence;
		}
		
		/** Returns a number between 0 and 1, inclusive. 0 means not at all a bimbo, 1 means fully bimbofied.*/
		public function getBimboFactor():Number {
			//Max IQ: 180. Min IQ: 40. Average IQ: 120.
			//Max BF: 1.0. Min BF: 0.0. Average BF: 0.5.
			var value:Number;
			if (iq > 180) {
				value = 0;
			} else if (iq < 40) {
				value = 1;
			} else {
				var p1:Number = 2.6786e-05;
				var p2:Number = -0.013036;
				var p3:Number = 1.4786;
				value = p1 * Math.pow(iq, 2) + (p2 * iq) + p3;
				if (value > 1) value = 1;
				else if (value < 0) value = 0;
			}
			return value;
		}
		
		public function getName(bimboFactor:Number = -1):String {
			return getString(NAMES, bimboFactor);
		}
		
		/**If character seems to be using a short name vector, return names from there instead of normal name vector.
		 * 
		 * @return A short name if character uses them, otherwise the same as getName().
		 */
		public function getShortName():String {
			if (SHORT_NAMES.length > 0) {
				return getString(SHORT_NAMES);
			} else {
				return getName();
			}
		}
		
		private function getString(listVector:Vector.<String>, bimboFactor:Number = -1):String {
			var i:int = Math.round((listVector.length - 1) * bimboFactor);
			if ( i < 0) {
				i = Math.round((listVector.length - 1) * getBimboFactor());
				if (i > listVector.length - 1) {
					i = listVector.length - 1;
				}
			} else {
				i = listVector.length - 1;
			}
			return listVector[i];
		}
		
		/** Returns the current line of a certain type depending on current IQ. A variable must be given to lines that require it. */
		public function getLine(listVector:Vector.<String>, variable:Object = null):String {
			var line:String = getString(listVector);
			if (variable != null) {
				line = line.replace("<var>", variable);
			}
			return line;
		}
		
		public function get iq():Number 
		{
			return _iq;
		}
		
		public function set iq(value:Number):void 
		{
			_iq = value;
			if (_iq < 30) _iq = 30;
		}
		
		public function getIqString():String {
			var iq:Number = Math.round(iq);
			var string:String;
			if (typeId == -1) {
				string = "???";
			} else if (typeId == -2) {
				string = "";
			} else {
				string = iq.toString();
			}
			return string;
		}
		
		public function get lust():Number 
		{
			return _lust;
		}
		
		public function set lust(value:Number):void 
		{
			_lust = value;
			if (_lust < 0.001) {
				_lust = 0.001;
			} else if (_lust > 2) {
				_lust = 2;
			}
		}
		
		public function get money():Number 
		{
			return _money;
		}
		
		public function set money(value:Number):void 
		{
			_money = value;
			if (_money < 0) {
				debt = debt - money;
				_money = 0;
			}
		}
		
		public function get debt():Number 
		{
			return _debt;
		}
		
		public function set debt(value:Number):void 
		{
			_debt = value;
			if (_debt < 0) {
				_debt = 0;
			}
		}
		
		public function getBio():String {
			var string:String = BIO[Math.round(getBimboFactor() * (BIO.length - 1))];
			return string;
		}
		
		public function getSubmitDefeatEnding():String {
			var string:String = SUBMIT_DEFEAT_ENDING[Math.round(getBimboFactor() * (SUBMIT_DEFEAT_ENDING.length - 1))];
			return string;
		}
		
		public static function getCopy(model:BimboModel):BimboModel {
			var copy:BimboModel = getBimboModelByType(model.typeId);
			copy.iq = model.iq;
			copy.money = model.money;
			copy.lust = model.lust;
			return copy;
		}
		
		public static function getBimboModelByType(type:int):BimboModel {
			// SETUP Add all characters to get them by id
			if (type == 0) {
				return new Kristyna();
			}else if (type == 1) {
				return new Salvatore();
			} else if (type == 2) {
				return new Chastity();
			} else if (type == 3) {
				return new Rebecca();
			} else if (type == 4) {
				return new Stephanie();
			} else if (type == 5) {
				return new Nathaniel();
			} else if (type == 6) {
				return new Miller();
			}else if (type == 7) {
				return new Rosa();
			}else if (type == 8) {
				return new Barry();
			}else if (type == 9) {
				return new Fuyumi();
			}else if (type == 10) {
				return new Sebastian();
			}else if (type == 11) {
				return new Elena();
			}else if (type == 12) {
				return new Maxwell();
			}else if (type == 13) {
				return new Dionysus();
			}else if (type == 14) {
				return new Anthony();
			}else if (type == 15) {
				return new Gonzy();
			}else if (type == 16) {
				return new Vanessa();
			}
			else {
				return new Random();
			}
		}
		
	}

}