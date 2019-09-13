package {
	//{ import
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	//} END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class SimpleButton0 extends Sprite {
		
		//{ CONSTRUCTOR
		
		function SimpleButton0 (text:String = "label", action:Function = null) {
			getChildByName('label').mouseEnabled = false;
			ref = action;
			setText(text);
			addEventListener(MouseEvent.MOUSE_DOWN, action())
		}
		//} END OF CONSTRUCTOR
		
		public function setText(a:String):void {
			getChildByName('label').text = a;
		}
		public function setAction(a:Function):void {
			ref = action;
		}
		
		private function action():void {
			if (ref != null) {
				ref();
			}
		}
		
		private var ref:Function;
		
	}
}