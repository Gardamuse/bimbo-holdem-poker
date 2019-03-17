package ui2 
{
	import net.flashpunk.World;
	
	public class ComponentList 
	{
		private var list:Array;
		
		/** Base class for grouping several components. */
		public function ComponentList(list:Array = null) 
		{
			if (list == null) {
				list = new Array();
			}
			this.list = list;
		}
		
		public function addComponent(comp:Component):void {
			list.push(comp);
		}
		
		public function add(world:World, fadeInTime:Number = 0):void {
			for each (var comp:Component in list) {
				comp.add(world, fadeInTime);
			}
		}
		
		public function popup(world:World, displayDuration:Number = 0, fadeInTime:Number = 0, fadeOutTime:Number = 0):void {
			for each (var comp:Component in list) {
				comp.popup(world, fadeInTime, fadeInTime, fadeOutTime);
			}
		}
		
		public function remove(fadeOutTime:Number = 0, delayFadeOutTime:Number = 0):void {
			for each (var comp:Component in list) {
				comp.remove(fadeOutTime, delayFadeOutTime);
			}
		}
		
		public function setColor(topColor:uint = 0x000001, glowColor:uint = 0x000001, glowColor2:uint = 0x000001, borderColor:uint = 0x000001):void {
			for each (var comp:Component in list) {
				comp.setColor(topColor, glowColor, glowColor2, borderColor);
			}
		}
		
	}

}