// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels.BasePanel;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:09
	 */
	public class InterfacesPanel extends BasePanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function InterfacesPanel (buttonPressedCallback:Function) {
			init(buttonPressedCallback);
			createSimplePanel(
			[
			UIText.TEXT_VASE,
			UIText.TEXT_SHOP,
			UIText.TEXT_BOOK,
			UIText.TEXT_STOREROOM
			],
			[
			UIEvents.ID_VASE,
			UIEvents.ID_SHOP,
			UIEvents.ID_BOOK,
			UIEvents.ID_STOREROOM
			]);
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