package 
{
	import net.flashpunk.FP;
	
	public class Deck 
	{
		private var deckVector:Vector.<int>;
		
		public function Deck() 
		{
			deckVector = genDeck();
		}
		
		private function genDeck():Vector.<int> {
			var generated:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < 52; i++) {
				generated.push(i);
			}
			return generated;
		}
		
		public function shuffle():void
		{
			var i:int = deckVector.length, j:int, t:Number;
			while (-- i)
			{
				t = deckVector[i];
				j = Math.random() * (i + 1);
				deckVector[i] = deckVector[j];
				deckVector[j] = t;
			}
		}
		
		/**Creates a new complete deck and shuffles.*/
		public function reshuffle():void {
			deckVector = genDeck();
			shuffle();
		}
		
		public function draw():int {
			var drawn:int = deckVector.shift();
			return drawn;
		}
		
		public function get length():int {
			return deckVector.length;
		}
		
		/** Removes a card from the deck specified by its index and returns that card.
		 * 
		 * @param	index
		 * @return the card at the specified index in the deck vector
		 */
		public function drawCard(index:int):int {
			return deckVector.splice(index, 1)[0];
		}
		
		/** Removes all cards on specified indexes from the deck.
		 * If the deck contains all 52 cards and has not been shuffled, index will be equal to cardnumber for every card.*/
		public function removeCardsByIndex(indexes:Vector.<int>):void {
			for each (var card:int in indexes) {
				deckVector[card] = -2;
			}
			for (var i:int = deckVector.length-1; i >= 0; i--) {
				if (deckVector[i] == -2) {
					deckVector.splice(i, 1);
				}
			}
		}
		
		public function putCardOnTop(card:int):void {
			deckVector.unshift(card);
		}
		
	}

}