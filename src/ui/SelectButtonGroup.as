package ui 
{
	import net.flashpunk.Entity;

	public class SelectButtonGroup
	{
		
		private var buttonList:Array = new Array();
		
		public function SelectButtonGroup() 
		{
		}
		
		public function add(button:SelectButton):void {
			buttonList.push(button);
		}
		
		public function selectThisButton(button:SelectButton):void {
			for each (var button1:SelectButton in buttonList) {
				if (button1 == button) {
					button1.selected(true)
				} else {
					button1.selected(false);
				}
			}
		}
		
		public function unSelectAll():void {
			for each (var button1:SelectButton in buttonList) {
				button1.selected(false);
			}
		}
		
	}

}