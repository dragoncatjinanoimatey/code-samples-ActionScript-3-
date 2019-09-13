// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.GUIStoreroom;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	//} =^_^= END OF import
	
	
	/**
	 * Склад
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:45
	 */
	public class StoreroomViewComponentMediator extends Mediator {
		
		//{ =^_^= CONSTRUCTOR
		
		function StoreroomViewComponentMediator (viewComponent_:GUIStoreroom) {
			viewComponent = viewComponent_;
			mediatorName = NAME;
			viewComponent_.addEventListener(GUIStoreroom.EVENT_ACTIVATE_ITEM, defaultEventsPipe);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * удобрения
		 * @param	title название
		 * @param	image создается и добавляется Bitmap
		 * @param	price цена
		 * @param	id идентификатор
		 */
		public function setFertilizersContent(title:Vector.<String>, image:Vector.<BitmapData>, price:Vector.<Number>, id:Vector.<uint>):void {
			vc.tabFertilizers.setContent(title,img,price,id);
		}
		
		/**
		 * подкормки
		 * @param	title название
		 * @param	image создается и добавляется Bitmap
		 * @param	price цена
		 * @param	id идентификатор
		 */
		public function setAdditionalForagesContent(title:Vector.<String>, image:Vector.<BitmapData>, price:Vector.<Number>, id:Vector.<uint>):void {
			vc.tabAdditionalForages.setContent(title,img,price,id);
		}
		
		/**
		 * украшения
		 * @param	title название
		 * @param	image создается и добавляется Bitmap
		 * @param	price цена
		 * @param	id идентификатор
		 */
		public function setDecorationsContent(title:Vector.<String>, image:Vector.<BitmapData>, price:Vector.<Number>, id:Vector.<uint>):void {
			vc.tabDecorations.setContent(title,img,price,id);
		}
		
		/**
		 * семена
		 * @param	title название
		 * @param	image создается и добавляется Bitmap
		 * @param	price цена
		 * @param	id идентификатор
		 */
		public function setSeedsContent(title:Vector.<String>, image:Vector.<BitmapData>, price:Vector.<Number>, id:Vector.<uint>):void {
			vc.tabSeeds.setContent(title,img,price,id);
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
		
		public function get vc():GUIStoreroom {return viewComponent;}
		
		
		public static const NAME:String = 'StoreroomVC';
		
		public static const ACTION_SET_VISIBLE_TRUE:String = NAME+'VisibleTrue';
		public static const ACTION_SET_VISIBLE_FALSE:String = NAME+ 'VisibleFalse';
		public static const EVENT_ACTIVATE_ITEM:String = NAME+ 'event_activate_item';
		
		
		/**
		 * действие на складе(активация)
		 * @param	e
		 */
		private function defaultEventsPipe(e:UIEvent):void {
			facade.sendNotification(EVENT_ACTIVATE_ITEM, e.uintValue);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]