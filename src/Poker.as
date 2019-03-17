package 
{
	public class Poker 
	{
		public static const STRAIGHT_FLUSH:int = 8e8;
		public static const FOUR_OF_A_KIND:int = 7e8;
		public static const FULL_HOUSE:int = 6e8;
		public static const FLUSH:int = 5e8;
		public static const STRAIGHT:int = 4e8;
		public static const THREE_OF_A_KIND:int = 3e8;
		public static const TWO_PAIRS:int = 2e8;
		public static const ONE_PAIR:int = 1e8;
		
		public static const RANK_STRAIGHT_FLUSH:int = 8e8;
		public static const RANK_FOUR_OF_A_KIND:int = 7e8;
		public static const RANK_FULL_HOUSE:int = 6e8;
		public static const RANK_FLUSH:int = 5e8;
		public static const RANK_STRAIGHT:int = 4e8;
		public static const RANK_THREE_OF_A_KIND:int = 3e8;
		public static const RANK_TWO_PAIRS:int = 2e8;
		public static const RANK_ONE_PAIR:int = 1e8;
		
		public function Poker() 
		{
			
		}
		
		 /**
		  * @param	players - an array of players whose hands should be judged (not folded players)
		  * @param	communityCards - the array of cards shared by all players
		  * @return an array of name-value pairs: {player: x, handValue: y, potPart: z} 
		  * 
		  * player - a player object
		  * handValue - the players best handValue
		  * potPart - How large part of the pot the player should recieved. This is dependant on order and the pot must be decreased simultaneously as the money is given to the player.
		  * 
		  * Note that this function those not handle pot split for players who have gone all in. All players given as input will be judged equally.
		  */
		public static function getPotWinners(players:Array, communityCards:Array):Array {
			var result:Array = new Array();
			
			//Create a list and sort in descending order based on handValue. I.e. best hands first.
			for (var i:int = 0; i < players.length; i++) {
				var handValue:Number = getBest5HandValue(communityCards);
				var namePair:Object = { player: players[i], handValue: handValue, potPart: 0};
				result.push(namePair);
			}
			result.sort(_potWinSort);
			result[0]["potPart"] = 1;
			
			//Winners - how many players have the same handValue
			var winners:int = 1;
			for (var j:int = 1; j < players.length; j++) {
				if ( result[0]["handValue"] == result[0 + j]["handValue"]) {
					winners += 1;
				}
			}
			
			//Set the potPart, that is, how large part of the pot every player should get.
			for (var k:int = 0; k < winners; k++) {
				result[k]["potPart"] = 1 / ((winners-k));
				//if (winners > 1) trace("Winners = " + winners + ": " + result[k]["player"].id + " " + result[k]["potPart"] + " " + result[k]["handValue"]);
			}
			
			return result;
		}
		
		//Helper funtion for sorting in descending order based on handValue. I.e. "winners first".
		public static function _potWinSort(a:Object, b:Object):int {
			return b["handValue"] - a["handValue"];
		}
		
		/**Gets the best 5-card-hand value of a 5+ card-hand. */
		public static function getBest5HandValue(array:Array):int {
			var lastValue:int = 0;
			var bestValue:int = 0;
			var output:Array = new Array();
			handCombinations(array, 5, 0, new Array(5), output);
			for (var i:int = 0; i < output.length; i++) {
				var hand:Array = output[i];
				var value:int = valueOfHand(hand);
				if (value > lastValue) {
					lastValue = value;
					bestValue = value;
				}
			}
			return bestValue;
		}
		
		/** Writes all possible combinations to the output array*/
		public static function handCombinations(array:Array, len:int, start:int, result:Array, output:Array):void {
			if (len == 0) {
				output.push(new Array(result[0], result[1], result[2], result[3], result[4]));
				return;
			}
			for (var i:int = start; i <= array.length - len; i++) {
				result[result.length - len] = array[i];
				handCombinations(array, len - 1, i + 1, result, output);
			}
		}
		
		/** @return an int that is higher the better the hand is. */
		public static function valueOfHand(h:Array):int {
			if ( isFlush(h) && isStraight(h) ) {
				trace("Straight flush");
				sortByRank(h);
				var highAce:Boolean = true;
				if (h[1].rank == 2) highAce = false;
				return STRAIGHT_FLUSH + getHighestRank(h, highAce);
			}else if ( isFourOfAKind(h) ) {
				trace("Four of a kind");
				var kicker:Array = removeCards(genCards(-1, h[2].rank), h);
				return FOUR_OF_A_KIND + h[2].rank*1e4 + getHighestRank(kicker, true);
			}else if ( isFullHouse(h) ) {
				trace("Full house");
				sortByRank(h);
				var pairRank:int = 0;
				if (h[2].rank != h[0].rank) {
					pairRank = getHighestRank([h[0]], true);
				} else {
					pairRank = getHighestRank([h[4]], true);
				}
				return FULL_HOUSE +  + h[2].rank*1e4 + pairRank;
			}else if ( isFlush(h) ) {
				trace("Flush");
				return FLUSH + getHighestRank(h, true);
			}else if ( isStraight(h) ) {
				trace("Straight");
				sortByRank(h);
				highAce = true;
				if (h[1].rank == 2) highAce = false;
				return STRAIGHT + getHighestRank(h, highAce);
			}else if ( isThreeOfAKind(h) ) {
				trace("Three of a kind");
				sortByRank(h);
				kicker = removeCards(genCards( -1, h[2].rank), h);
				return THREE_OF_A_KIND + getHighestRank(h.slice(2,3), true) * 1e4 + getHighestRank(kicker, true)*1e2 + getLowestRank(kicker, true);
			}else if ( isTwoPairs(h) ) {
				trace("Two pair");
				kicker = removeCards(getLowestPair(h), h);
				kicker = removeCards(getLowestPair(kicker), kicker);
				return TWO_PAIRS + getHighestPairRank(h)*1e4 + getLowestPairRank(h)*1e2 + getHighestRank(kicker, true);
			}else if ( isOnePair(h) ) {
				trace("One pair");
				kicker = removeCards(getLowestPair(h), h);
				sortByRank(kicker, true);
				var kickerRankHigh:int = getHighestRank(kicker, true);
				kicker.pop();
				var kickerRankMedium:int = getHighestRank(kicker, true);
				kicker.pop();
				var kickerRankLow:int = getHighestRank(kicker, true);
				return ONE_PAIR + getLowestPairRank(h)*1e6 + kickerRankHigh*1e4 + kickerRankMedium*1e2 + kickerRankLow;
			}else {
				trace("Highcard");
				var valueHighCard:int = 0;
				var smallHand:Array = h;
				for (var i:int = 0; i < h.length; i++) {
					//trace(h);
					valueHighCard += getHighestRank(h, true) * 14 ^ (4 - i);
					
				}
			}
				return valueHighCard;
		}
		
		public static function isFlush(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByColor(hand);
			if (hand[0].color == hand[4].color) {
				return true;
			}
			return false;
		}
		
		public static function isStraight(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByRank(hand, false);
			var lastRank:int = hand[0].rank;
			var falseCounter:int = 0;

			for (var j:int = 1; j < 4; j++) {
				if (getHighestRank([hand[j]]) != lastRank + 1) falseCounter += 1;
				lastRank = getHighestRank([hand[j]]);
			}
			if (hand[0].rank == 1 && falseCounter != 0) {
				sortByRank(hand, true);
				falseCounter = 0;
				lastRank = hand[0].rank;
				for (var k:int = 1; k < 4; k++) {
					if (getHighestRank([hand[k]], true) != lastRank + 1) falseCounter += 1;
					lastRank = getHighestRank([hand[k]], true);
				}
			}
			if (falseCounter == 0) {
				return true;
			} else {
				return false;
			}
		}
		
		public static function isFourOfAKind(hand:Array):Boolean {
			if (hand.length != 5) return false;
			if (highestNumberOfSameValue(hand) == 4) return true;
			return false;
		}
		
		public static function isFullHouse(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByRank(hand);
			if (highestNumberOfSameValue(hand) == 3 && lowestNumberOfSameValue(hand) == 2) {
				return true;
			}
			return false;
		}
		
		public static function isThreeOfAKind(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByRank(hand);
			if (highestNumberOfSameValue(hand) == 3 && lowestNumberOfSameValue(hand) == 1) {
				return true;
			}
			return false;
		}
		
		public static function isTwoPairs(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByRank(hand);
			if (highestNumberOfSameValue(hand) == 2 && lowestNumberOfSameValue(hand) == 1) {
				var smallHand:Array = removeCards(highestNumberOfSameColorCards(hand), hand);
				if (hasOnePair(smallHand)) {
					return true;
				}
			}
			return false;
		}
		
		public static function isOnePair(hand:Array):Boolean {
			if (hand.length != 5) return false;
			sortByRank(hand);
			if (hasOnePair(hand) && !isTwoPairs(hand)) {
				return true;
			}
			return false;
		}
		
		public static function hasOnePair(hand:Array):Boolean {
			if (hand.length < 2) return false;
			sortByRank(hand);
			if (highestNumberOfSameValue(hand) == 2 && lowestNumberOfSameValue(hand) == 1) {
				return true;
			}
			return false;
		}
		
		/**Hand must contain two pairs.*/
		public static function getHighestPairRank(hand:Array):int {
			var shortHand:Array = removeCards(getLowestPair(hand), hand);
			return getLowestPairRank(shortHand);
		}
		
		public static function getLowestPairRank(hand:Array):int {
			var pair:Array = getLowestPair(hand);
			if (pair.length == 2) {
				return getHighestRank(pair.slice(0,1), true);
			}
			return -1;
		}
		
		public static function getLowestPair(hand:Array):Array {
			sortByRank(hand, true);
			if (highestNumberOfSameValue(hand) == 2 && lowestNumberOfSameValue(hand) == 1) {
				var lastRank:int = 0;
				for (var i:int = 0; i < hand.length; i++) {
					if (lastRank == getHighestRank(hand.slice(i, i + 1), true)) return hand.slice(i - 1, i + 1);
					lastRank = getHighestRank(hand.slice(i, i + 1), true);
				}
			}
			return [];
		}
		
		/** Sorts card array by value in ascending order */
		public static function sortByRank(array:Array, highAce:Boolean=false):void {
			if (highAce) {
				array.sort(_valueSortHigh);
			} else {
				array.sort(_valueSortLow);
			}
		}
		
		/** Helper function. Aces Low */
		private static function _valueSortLow(card1:Card, card2:Card):int {
			return getHighestRank([card1], false) - getHighestRank([card2], false);
		}
		
		/** Helper function. Aces High */
		private static function _valueSortHigh(card1:Card, card2:Card, highAce:Boolean = false):int {
			return getHighestRank([card1], true) - getHighestRank([card2], true);
		}
		
		private static function sortByColor(array:Array):void {
			array.sort(_colorSort);
		}
		
		private static function _colorSort(card1:Card, card2:Card):int {
			return card1.color - card2.color;
		}
		
		public static function getHighestRank(array:Array, highAce:Boolean=false):int {
			var HighestRank:int = -1;
			for each (var card:Card in array) {
				if (card.rank > HighestRank) {
						HighestRank = card.rank;
					}
				if (highAce && card.rank == 1) {
					HighestRank = 14
					return HighestRank;
				}
				
			}
			return HighestRank;
		}
		
		public static function getLowestRank(array:Array, highAce:Boolean=false):int {
			var LowestRank:int = int.MAX_VALUE;
			for each (var card:Card in array) {
				if (getHighestRank([card],highAce) < LowestRank) {
					LowestRank = getHighestRank([card],highAce);
				}
			}
			return LowestRank;
		}
		
		private static function highestNumberOfSameColor(array:Array):int {
			var highestNumber:int = 0;
			for (var i:int = 0; i < 4; i++) {
				var sameColorCards:Array = cardsWithColor(array, i);
				if (sameColorCards.length > highestNumber) {
					highestNumber = sameColorCards.length;
				}
			}
			return highestNumber;
		}
		
		private static function highestNumberOfSameColorCards(array:Array):Array {
			var highestNumberColor:int = 0;
			var highestColorCards:Array = [];
			for (var i:int = 0; i < 4; i++) {
				var sameColorCards:Array = cardsWithColor(array, i);
				if (sameColorCards.length > highestNumberColor) {
					highestNumberColor = sameColorCards[0].color;
					highestColorCards = sameColorCards;
				}
			}
			return highestColorCards;
		}
		
		private static function highestNumberOfSameValue(array:Array):int {
			var highestNumber:int = 0;
			for (var i:int = 1; i <= 13; i++) {
				var sameValueCards:Array = cardsWithValue(array, i);
				if (sameValueCards.length > highestNumber) {
					highestNumber = sameValueCards.length;
				}
			}
			return highestNumber;
		}
		
		private static function highestNumberOfSameValueCards(array:Array):Array {
			var highestNumberValue:int = 0;
			var highestValueCards:Array = [];
			for (var i:int = 1; i <= 13; i++) {
				var sameValueCards:Array = cardsWithValue(array, i);
				if (sameValueCards.length > highestNumberValue) {
					highestNumberValue = sameValueCards[0].value;
					highestValueCards = sameValueCards;
				}
			}
			return highestValueCards;
		}
		
		private static function lowestNumberOfSameValue(array:Array):int {
			var lowestNumber:int = int.MAX_VALUE;
			for (var i:int = 1; i <= 13; i++) {
				var sameValueCards:Array = cardsWithValue(array, i);
				if (sameValueCards.length > 0 && sameValueCards.length < lowestNumber) {
					lowestNumber = sameValueCards.length;
				}
			}
			return lowestNumber;
		}
		
		/**Returns a new array with the specified cards removed.*/
		private static function removeCards(cards:Array, hand:Array):Array {
			var newHand:Array = hand.concat();
			var obj:Object = new Object();
			var removeCardsFunction:Function = function(card:Card, index:int, array:Array):Boolean {
				if (card.color == this.color && card.rank == this.rank) return false;
				return true;
			}
			for (var i:int = 0; i < cards.length; i++) {
				obj.color = cards[i].color;
				obj.rank = cards[i].rank;
				newHand = newHand.filter(removeCardsFunction, obj);
			}
			return newHand;
		}
		
		private static function cardsWithColor(array:Array, color:int):Array {
			var out:Array = [];
			for each (var card:Card in array) {
				if (card.color == color) {
					out.push(card);
				}
			}
			return out;
		}
		
		private static function cardsWithValue(array:Array, value:int):Array {
			var out:Array = [];
			for each (var card:Card in array) {
				if (card.rank == value) {
					out.push(card);
				}
			}
			return out;
		}
		
		/** -1 to vary over value. 0 to 3 for color or 1 to 13 for rank to get all cards with one of those constant.*/
		private static function genCards(color:int = -1, rank:int = -1):Array {
			var array:Array = [];
			if (color != -1) {
				for (var i:int = 1; i <= 13; i++) {
					array.push(new Card(color, i))
				}
			} 
			if (rank != -1) {
				for (var j:int = 0; j < 4; j++) {
					array.push(new Card(j, rank))
				}
			}
			return array;
		}
		
		
	}

}