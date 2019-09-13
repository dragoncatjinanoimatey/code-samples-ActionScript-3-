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
	 * @created 15.12.2010 18:11
	 */
	public class ToolsPanel extends BasePanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function ToolsPanel (buttonPressedCallback:Function) {
			init(buttonPressedCallback);
			createSimplePanel(
			[
			UIText.TEXT_TOOL_RULER,
			UIText.TEXT_TOOL_CLIPPER,
			UIText.TEXT_TOOL_CHOPPER,
			UIText.TEXT_TOOL_INSECTICIDE,
			UIText.TEXT_TOOL_HAND
			],
			[
			UIEvents.ID_TOOL_RULER,
			UIEvents.ID_TOOL_CLIPPER,
			UIEvents.ID_TOOL_CHOPPER,
			UIEvents.ID_TOOL_INSECTICIDE,
			UIEvents.ID_TOOL_HAND
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