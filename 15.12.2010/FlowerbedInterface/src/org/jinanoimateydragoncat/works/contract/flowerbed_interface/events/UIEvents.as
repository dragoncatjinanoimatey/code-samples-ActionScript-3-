// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.events {
	
	//{ =^_^= import
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:28
	 */
	public class UIEvents {
		
		//{ =^_^= CONSTRUCTOR
		
		function UIEvents () {
			throw(new ArgumentError('static container only'));
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public static const EVENT_BUTTON_ACTION:String = 'event_button_action';
		public static const EVENT_CHECKBOX_STATE_CHANGED:String = 'event_checkbox_state_changed';
		public static const EVENT_BUY:String = 'event_buy';
		/**
		 * body = {displayObject:DisplayObject, bitmapData:BitmapData}
		 */
		public static const EVENT_BOUQUET_CREATED:String = 'event_bouquet_created';
		/**
		 * при выполнении операций(перемещение, вращение) в приложении необходимо сменить курсор
		 * UIEvent {type:"event_change_mouse_cursor", uintValue:cursorType)
		 */
		public static const EVENT_CHANGE_MOUSE_CURSOR:String = 'ui_event_change_mouse_cursor';
		
		/**
		 * обычный курсор
		 */
		public static const ID_CURSOR_TYPE_DEFAULT:uint = 0;
		/**
		 * курсор при перемещении
		 */
		public static const ID_CURSOR_TYPE_MOVE:uint = 1;
		/**
		 * курсор при вращении
		 */
		public static const ID_CURSOR_TYPE_ROTATE:uint = 2;
		
		public static const ID_FULLSCREEN:String = "misc_fullscreen";
		public static const ID_SOUND:String = "misc_sound";
		public static const ID_MUSIC:String = "misc_music";
		
		public static const ID_SHOP:String = "interface_shop";
		public static const ID_VASE:String = "interface_vase";
		public static const ID_BOOK:String = "interface_book";
		public static const ID_STOREROOM:String = "interface_storeroom";
		
		public static const ID_TOOL_RULER:String = "tool_ruler";
		public static const ID_TOOL_CLIPPER:String = "tool_clipper";
		public static const ID_TOOL_CHOPPER:String = "tool_chopper";
		public static const ID_TOOL_INSECTICIDE:String = "tool_insecticide";
		public static const ID_TOOL_HAND:String = "tool_hand";
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]