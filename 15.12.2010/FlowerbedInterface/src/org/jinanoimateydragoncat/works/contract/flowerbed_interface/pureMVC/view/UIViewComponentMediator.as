// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view {
	
	//{ =^_^= import
	import flash.events.Event;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.main.UI;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:47
	 */
	public class UIViewComponentMediator extends Mediator {
		
		//{ =^_^= CONSTRUCTOR
		
		function UIViewComponentMediator (viewComponent_:UI) {
			viewComponent = viewComponent_;
			mediatorName =NAME;
			//viewComponent_.addEventListener(Scene3DViewComponent.ACTION_SHOW_ELEMENT_INFO, showInfoListener);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override public function listNotificationInterests():Array {
			return [];
		}
		
		override public function handleNotification(note:INotification):void {
			/*switch (note.getName()){
			}*/
		}
		
		public function get vc():UI {
			return viewComponent;
		}
		
		public static const NAME:String = 'UIViewComponentMediator';
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]