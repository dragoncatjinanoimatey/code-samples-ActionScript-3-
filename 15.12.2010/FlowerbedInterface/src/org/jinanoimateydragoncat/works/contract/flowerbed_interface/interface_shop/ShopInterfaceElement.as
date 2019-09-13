// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_shop {
	
	//{ =^_^= import
	import flash.events.Event
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	
	import org.aswing.AssetPane;
	import org.aswing.BorderLayout;
	import org.aswing.GridLayout;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:38
	 */
	public class ShopInterfaceElement extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function ShopInterfaceElement (title:String, image:BitmapData, id_:uint, buttonPressedRef:Function) {
			if (buttonPressedRef == null) {throw new ArgumentError('ref must be non null', 3);}
			pressRef = buttonPressedRef;
			id = id_;
			setLayout(new BorderLayout());
			
			var titleLabel:JLabel = new JLabel(title);
			append(titleLabel, BorderLayout.NORTH);
			
			var img:AssetPane = new AssetPane(new Bitmap(image));
			append(img, BorderLayout.CENTER);
			
			var buyButton:JButton = new JButton(UIText.TEXT_BUY);
			buyButton.addActionListener(buttonPressed);
			append(buyButton, BorderLayout.SOUTH);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		private function buttonPressed(e:Event):void {
			pressRef(new UIEvent(UIEvents.EVENT_BUY, id));
		}
		
		private var id:uint;
		private var pressRef:Function;
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]