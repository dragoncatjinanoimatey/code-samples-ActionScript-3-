// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	
	import org.aswing.BoxLayout;
	import org.aswing.JButton;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:10
	 */
	public class MiscControlsPanel extends BasePanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function MiscControlsPanel (buttonPressedCallback:Function) {
			buttonPressedRef = buttonPressedCallback;
			setLayout(new BoxLayout(BoxLayout.X_AXIS));
			
			createSimplePanel(
			[
			UIText.TEXT_FULLSCREEN,
			UIText.TEXT_SOUND,
			UIText.TEXT_MUSIC
			],
			[
			UIEvents.ID_FULLSCREEN,
			UIEvents.ID_SOUND,
			UIEvents.ID_MUSIC
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