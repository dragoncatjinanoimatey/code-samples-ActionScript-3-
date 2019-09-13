// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.aswing.BoxLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollBar;
	import org.aswing.JScrollPane;
	import org.aswing.JViewport;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:57
	 */
	public class VaseInterfaceElementsList extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	eventsPipe сылка на метод для приема сообщений от элементов(например при нажатии на кнопку "купить")
		 */
		function VaseInterfaceElementsList (eventsPipe:Function) {
			defaultEventsPipe = eventsPipe;
			super(new BoxLayout(BoxLayout.Y_AXIS,5));
			setOpaque(true);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * 
		 * @param	displayObject фрагмент цветка
		 * @param	checked используется для составления букета
		 * @param	id идентификатор
		 */
		public function setContent(displayObject:Vector.<DisplayObject>, checked:Vector.<Boolean>, id:Vector.<uint>):void {
			var item:VaseInterfaceElement;
			for (var i:uint in displayObject) {
				item = new VaseInterfaceElement(displayObject[i], id[i], defaultEventsPipe);
				itemsList.push(item);
				append(item);
			}
		}
		
		public function clearContent():void {
			for each(var i:VaseInterfaceElement in itemsList) {
				remove(i);
			}
		}
		
		private var itemsList:Array = [];
		private var defaultEventsPipe:Function;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]