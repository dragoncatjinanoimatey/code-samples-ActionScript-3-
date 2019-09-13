// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.model.UITestProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:39
	 */
	public class ModelPrepCommand extends SimpleCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		override public function execute(note:INotification):void {
			facade.registerProxy(new UITestProxy());
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]