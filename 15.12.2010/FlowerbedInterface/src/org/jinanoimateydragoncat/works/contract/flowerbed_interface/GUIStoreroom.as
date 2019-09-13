// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.data.UISettings;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_shop.ShopInterfaceBaseTab;
	
	import org.aswing.AssetIcon;
	import org.aswing.AssetIcon;
	import org.aswing.JLabel;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.BorderLayout;
	import org.aswing.colorchooser.ColorRectIcon;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JTabbedPane;
	//} =^_^= END OF import
	
	
	/**
	 * интерфейс "склад"
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:16
	 */
	public class GUIStoreroom extends JFrame {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	eventsPipe сылка на метод для приема сообщений от элементов(например при нажатии на кнопку "купить") null= use Events(when using PureMVC)
		 */
		function GUIStoreroom (eventsPipe:Function = null) {
			super(null, UIText.TEXT_STOREROOM);
			setResizeDirectly(true);
			
			tabbedPane = new JTabbedPane();
			tabbedPane.setTabPlacement(JTabbedPane.TOP);
			tabbedPane.setForeground(ASColor.GRAY);
			//tabbedPane.setFont(new ASFont("Verdana", 15));
			getContentPane().append(tabbedPane, BorderLayout.CENTER);
			
			tabFertilizers = new ShopInterfaceBaseTab((eventsPipe==null)?defaultEventsPipe:eventsPipe);
			tabAdditionalForages = new ShopInterfaceBaseTab((eventsPipe==null)?defaultEventsPipe:eventsPipe);
			tabDecorations = new ShopInterfaceBaseTab((eventsPipe==null)?defaultEventsPipe:eventsPipe);
			tabSeeds = new ShopInterfaceBaseTab((eventsPipe==null)?defaultEventsPipe:eventsPipe);
			
			tabbedPane.appendTab(tabFertilizers,
				UIText.TEXT_FERTILIZERS,
				new AssetIcon(new Bitmap(UILibrary.fet)), 
				UIText.TEXT_TIP_STORE_FERTILIZERS);
			
			tabbedPane.appendTab(tabAdditionalForages,
				UIText.TEXT_ADDITIONALFORAGES,
				new AssetIcon(new Bitmap(UILibrary.add)), 
				UIText.TEXT_TIP_STOREROOM_ADDITIONALFORAGES);
			
			tabbedPane.appendTab(tabDecorations,
				UIText.TEXT_DECORATIONS,
				new AssetIcon(new Bitmap(UILibrary.deco)), 
				UIText.TEXT_TIP_STOREROOM_DECORATIONS);
			
			tabbedPane.appendTab(tabSeeds,
				UIText.TEXT_SEEDS,
				new AssetIcon(new Bitmap(UILibrary.seeds)), 
				UIText.TEXT_TIP_STOREROOM_SEEDS);
			pack();
			
			//setContent();
			
			setHeight(UISettings.XMLData.GUIShop.@setHeight);
			//show();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public var tabbedPane:JTabbedPane;
		
		/**
		 * удобрения
		 */
		public var tabFertilizers:ShopInterfaceBaseTab;
		/**
		 * подкормки
		 */
		public var tabAdditionalForages:ShopInterfaceBaseTab;
		/**
		 * украшения
		 */
		public var tabDecorations:ShopInterfaceBaseTab;
		/**
		 * семена
		 */
		public var tabSeeds:ShopInterfaceBaseTab;
		
		public static const EVENT_ACTIVATE_ITEM:String = "event_item_activate";
		
		/**
		 * действие в магазине(покупка)
		 * @param	e
		 */
		private function defaultEventsPipe(e:UIEvent):void {
			dispatchEvent(new UIEvent(EVENT_ACTIVATE_ITEM, e.uintValue));
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]