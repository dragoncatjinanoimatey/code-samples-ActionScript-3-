// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.events {
	
	//{ =^_^= import
	import flash.events.Event;
	import flash.events.EventDispatcher;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:26
	 */
	public class UIEvent extends Event {
		
		//{ =^_^= CONSTRUCTOR
		
		function UIEvent (type:String, uintValue:uint=0, objectValue:Object=null, from:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.uintValue = uintValue;
			this.objectValue = objectValue;
			this.from = from;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		override public function get target():Object {
			return super.target || from;
		}
		
		public var uintValue:uint;
		public var objectValue:Object;
		
		private var from:Object;
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]