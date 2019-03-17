package ui2 
{
	import flash.geom.Point;
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class TextField extends Component
	{
		protected var labelText:String = "";
		protected var labelWidth:Number = 0;
		protected var labelHeight:Number = 0;
		
		public function TextField(x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, o:Object = null) 
		{
			super(x, y, width, height, o);
			
			if (o != null) {
				if (o.hasOwnProperty("labelText")) labelText = o.labelText;
				if (o.hasOwnProperty("labelWidth")) labelWidth = o.labelWidth;
				if (o.hasOwnProperty("labelHeight")) labelHeight = o.labelHeight;
			}
			
		}
		
		override public function update():void {
			super.update();
		}
		
		public function setLabelText(labelText:String):void  {
			this.labelText = labelText;
		}
		
		public function getLabelText():String  {
			return labelText;
		}
		
	}
}