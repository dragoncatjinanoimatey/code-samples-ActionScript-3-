// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view {
	
	//{ =^_^= import
	import flash.events.Event;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.GUIBook;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	//} =^_^= END OF import
	
	
	/**
	 * Книга
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:42
	 */
	public class BookViewComponentMediator extends Mediator {
		
		//{ =^_^= CONSTRUCTOR
		
		function BookViewComponentMediator (viewComponent_:GUIBook) {
			viewComponent = viewComponent_;
			mediatorName =NAME;
			//configure listeners
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * установка данных для списка
		 * @param	title элемента
		 * @param	description описание
		 * @param	bitmapData картинка
		 */
		public function setListData(title:Array, description:Array, bitmapData:Array):void {
			vc.setListData(title, description, bitmapData);
		}
		
		override public function listNotificationInterests():Array {
			return [ACTION_SET_VISIBLE_FALSE, ACTION_SET_VISIBLE_TRUE];
		}
		
		override public function handleNotification(note:INotification):void {
			switch (note.getName()){
				case ACTION_SET_VISIBLE_TRUE:
					vc.setVisible(true);
				break;
				
				case ACTION_SET_VISIBLE_FALSE:
					vc.setVisible(false);
				break;
				
			}
		}
		
		public function get vc():GUIBook {return viewComponent;}
		
		public static const NAME:String = 'BookVC';
		
		public static const ACTION_SET_VISIBLE_TRUE:String = NAME+'VisibleTrue';
		public static const ACTION_SET_VISIBLE_FALSE:String = NAME+ 'VisibleFalse';
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]