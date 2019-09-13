// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.ShopViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.StoreroomViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.VaseViewComponentMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	//} =^_^= END OF import
	
	
	/**
	 * Create and register Mediators with the View.
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:36
	 */
	public class ControllerPrepCommand extends SimpleCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		function ControllerPrepCommand () {
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override public function execute(note:INotification):void {
			facade.registerCommand(ShopViewComponentMediator.EVENT_ACTIVATE_ITEM, UIActionCommand);
			facade.registerCommand(StoreroomViewComponentMediator.EVENT_ACTIVATE_ITEM, UIActionCommand);
			facade.registerCommand(VaseViewComponentMediator.EVENT_BOUQUET_CREATED, UIActionCommand);
			facade.registerCommand(VaseViewComponentMediator.EVENT_CHANGE_MOUSE_CURSOR, UIActionCommand);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]