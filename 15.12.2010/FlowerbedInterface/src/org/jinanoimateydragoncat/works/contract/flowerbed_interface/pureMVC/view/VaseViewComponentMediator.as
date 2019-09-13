// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view {
	
	//{ =^_^= import
	import flash.events.Event;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase.GUIVase;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	//} =^_^= END OF import
	
	
	/**
	 * Книга
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:48
	 */
	public class VaseViewComponentMediator extends Mediator {
		
		//{ =^_^= CONSTRUCTOR
		
		function VaseViewComponentMediator (viewComponent_:GUIVase) {
			viewComponent = viewComponent_;
			mediatorName =NAME;
			
			viewComponent_.addEventListener(UIEvents.EVENT_BOUQUET_CREATED, defaultEventsPipe);
			viewComponent_.addEventListener(UIEvents.EVENT_CHANGE_MOUSE_CURSOR, defaultEventsPipe);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * установка данных для списка
		 * @param	displayObject фрагменты растения
		 */
		public function setListData(displayObject:Array):void {
			vc.setListData(displayObject);
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
		
		public function get vc():GUIVase {return viewComponent;}
		
		public static const NAME:String = 'VaseVC';
		
		public static const ACTION_SET_VISIBLE_TRUE:String = NAME+'VisibleTrue';
		public static const ACTION_SET_VISIBLE_FALSE:String = NAME+'VisibleFalse';
		
		public static const EVENT_BOUQUET_CREATED:String = NAME+"event_bouquet_created";
		public static const EVENT_CHANGE_MOUSE_CURSOR:String = NAME+"event_change_mouse_cursor";
		
		//{ EVENTS
		/**
		 * действие в вазе(создание букета)
		 * @param	e {displayObject:DisplayObject, bitmapData:BitmapData}
		 */
		private function defaultEventsPipe(e:UIEvent):void {
			switch (e.type) {
			
			case UIEvents.EVENT_BOUQUET_CREATED:
				facade.sendNotification(EVENT_BOUQUET_CREATED, e.objectValue);
				break;
			
			case UIEvents.EVENT_CHANGE_MOUSE_CURSOR:
				facade.sendNotification(EVENT_CHANGE_MOUSE_CURSOR, e.uintValue);
				break;
			
			
			}
		}
		//} END OF EVENTS
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]