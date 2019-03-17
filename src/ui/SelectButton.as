package ui 
{
	public class SelectButton extends Button
	{
		private var buttonGroup:SelectButtonGroup;
		
		public function SelectButton(x:Number = 0, y:Number = 0, text:String = "", width:Number = 150, height:Number = 50,
												callback:Function=null, fontSize:int=16, params:Object=null, keyConstant:int = 1, buttonGroup:SelectButtonGroup=null)
		{
			super(x, y, text, width, height, callback, params, keyConstant);
			this.buttonGroup = buttonGroup;
		}
		
		override protected function click():void
		{
			if (buttonGroup != null) {
				buttonGroup.selectThisButton(this);
			}
			if (callback != null)
			{
				if (params != null) callback(params);
				else callback();
			}
			
		}
		
		public function externalClick():void {
			click();
		}
		
		
	}

}