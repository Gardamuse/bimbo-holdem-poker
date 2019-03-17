package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import ui.SelectButton;
	import ui.SelectButtonGroup;
	import ui.skins.milk.MilkTextField;
	import ui.skins.milk.PokerSelectButton;
	import ui.skins.milk.PokerSelectButtonSkin;
	import ui2.basic.BasicTextField;
	public class BimboSetupBox
	{
		private var world:World;
		public var model:BimboModel;
		private var cam:WomanCam;
		private var selectButton:PokerSelectButton;
		private var nameF:BasicTextField;
		private var callback:Function;
		private var params:Object;
		public var allEntities:Array;
		
		private var width:Number;
		private var height:Number;
		private var fieldHeight:Number;
		public var startX:Number;
		public var startY:Number;
		
		/**
		 * 
		 * @param	world entities will be placed here
		 * @param	model the BimboModel
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	fieldHeight How high the text field(s), ex the namefield, should be.
		 * @param	selectButtonGroup If not provided, no selectbutton will be provided and getSelectButton() will return null.
		 * @param	callback
		 * @param	params
		 */
		public function BimboSetupBox(world:World, model:BimboModel, x:Number, y:Number, width:Number = 200, fieldHeight:Number = 50, selectButtonGroup:SelectButtonGroup = null, callback:Function = null, params:Object = null) 
		{
			this.world = world;
			this.model = model;
			this.callback = callback;
			this.params = params;
			this.width = width;
			this.height = width;
			this.fieldHeight = fieldHeight;
			this.startX = x;
			this.startY = y;
			allEntities = new Array();
			
			cam = new WomanCam(model, model.portraitSequence, x, y, width);
			cam.updateFrame();
			world.add(cam);
			if (selectButtonGroup != null) {
				selectButton = new PokerSelectButton(x, y, "", width, height, selected, 16, null, 1, selectButtonGroup);
			} else {
				selectButton = new PokerSelectButtonSkin(x, y, "", width, height, selected, 16, null, 1);
			}
			world.add(selectButton);
			
			if (fieldHeight < 40) {
				nameF = new BasicTextField(x, y + height, width+1, fieldHeight, {text:"<var0>", fontsize:16, callbacks:[model.getShortName]});
			} else {
				nameF = new BasicTextField(x, y + height, width + 1, fieldHeight, { text:"<var0>", fontsize:16, callbacks:[model.getName] } );
			}
			nameF.add(world);
			
			allEntities.push(cam);
			allEntities.push(selectButton);
			allEntities.push(nameF);
		}
		
		public function update():void {
			cam.updateFrame();
		}
		
		private function selected():void {
			if (callback != null) {
				if (params == null) {
					callback(model);
				} else {
					callback(params);
				}
			}
		}
		
		public function setModel(model:BimboModel, sequence:Sequence):void {
			this.model = model;
			cam.setTargetTo(model, sequence);
			if (fieldHeight < 40) {
				nameF.callbacks[0] = model.getShortName;
			} else {
				nameF.callbacks[0] = model.getName;
			}
			update();
		}
		
		public function moveTo(x:Number, y:Number):void {
			cam.moveTo(x, y);
			selectButton.moveTo(x, y);
			nameF.moveTo(x, y + height);
		}
		
		public function getSelectButton():SelectButton {
			return selectButton;
		}
		
		public function set iq(value:Number):void {
			model.iq = value;
		}
		
		public function get iq():Number {
			return model.iq;
		}
		
		public function remove():void {
			world.remove(cam);
			world.remove(selectButton);
			world.remove(nameF);
		}
		
	}

}