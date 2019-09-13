// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.main {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.UIApplicationFacade;
	//} =^_^= END OF import
	
	
	/**
	 * класс пользовательского интерфейса(пример использования)
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:04
	 */
	public class UITest extends UI {
		
		//{ =^_^= CONSTRUCTOR
		
		function UITest () {
			super();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public var facade:UIApplicationFacade;
		
		override protected function initialized():void {
			
			facade = new UIApplicationFacade('ui');
			facade.startup(this);
			
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]