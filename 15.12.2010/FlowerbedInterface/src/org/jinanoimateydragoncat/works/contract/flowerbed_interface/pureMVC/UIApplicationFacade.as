// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC {
	
	//{ =^_^= import
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.main.UI;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller.StartupCommand;
	//} =^_^= END OF import
	
	
	/**
	 * фасад pureMVC
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:32
	 */
	public class UIApplicationFacade extends Facade {
		
		//{ =^_^= CONSTRUCTOR
		
		function UIApplicationFacade (key:String) {
			super(key);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function startup(app:UI):void {
			UIApplicationFacade.app = app;//ссылка на приложение
			sendNotification(STARTUP, app);
		}
		
		public static function get application():UI {
			return UIApplicationFacade.app;
		}
		
		public static const STARTUP:String = "startup";
		
		
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}
		
		private static var app:UI;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]