// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_shop {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.aswing.BorderLayout;
	import org.aswing.FlowLayout;
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
	 * @created 15.12.2010 17:32
	 */
	public class ShopInterfaceBaseTab extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	eventsPipe сылка на метод для приема сообщений от элементов(например при нажатии на кнопку "купить")
		 */
		function ShopInterfaceBaseTab (eventsPipe:Function) {
			buttonPressed = eventsPipe;
			super(new BorderLayout());
			setOpaque(true);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * заполнение контентом
		 * @param	title название
		 * @param	image создается и добавляется Bitmap
		 * @param	price цена
		 * @param	id идентификатор
		 */
		public function setContent(title:Vector.<String>, image:Vector.<BitmapData>, price:Vector.<Number>, id:Vector.<uint>):void {
			var item:ShopInterfaceElement;
			for (var i:uint in title) {
				item = new ShopInterfaceElement(title[i]+':'+price[i], image[i],id[i],buttonPressed);
				scrollContentPane.append(item);
			}
			
			scrollPane = new JScrollPane(scrollContentPane,JScrollPane.SCROLLBAR_NEVER,JScrollPane.SCROLLBAR_AS_NEEDED);
			scrollPane.setHorizontalScrollBar(scrollBar);
			
			append(scrollPane,BorderLayout.CENTER);
		}
		
		
		private var buttonPressed:Function;
		
		private var scrollContentPane:JPanel= new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 5));
		
		private var scrollPane:JScrollPane;
		private var scrollBar:JScrollBar = new JScrollBar(JScrollBar.HORIZONTAL)
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]