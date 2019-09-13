// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.events.Event
	import flash.display.DisplayObject;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.data.UISettings;
	
	import org.aswing.BorderLayout;
	import org.aswing.AssetIcon;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.AssetIcon;
	import org.aswing.JPanel;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:55
	 */
	public class VaseInterfaceElement extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	displayObject фрагмент цветка
		 * @param	id_
		 * @param	eventsPipe see events section for more details
		 */
		function VaseInterfaceElement (displayObject:DisplayObject, id_:uint, eventsPipe:Function) {
			if (eventsPipe == null) {throw new ArgumentError('ref must be non-null', 3);}
			defaultEventsPipe = eventsPipe;
			id = id_;
			setLayout(new BorderLayout(0,1));
			
			//resize:
			var pw:Number = UISettings.XMLData.GUIVase.rightBlock.elementsList.element.@setPreferredHeight;
			var ph:Number = UISettings.XMLData.GUIVase.rightBlock.elementsList.element.@setPreferredHeight;
			var s0:Number;
			if (displayObject.width > pw) {
				displayObject.scaleX = displayObject.scaleY = pw/displayObject.width;
			}
			if (displayObject.height > ph) {
				s0 = ph/displayObject.height;
				if (displayObject.scaleX > s0) {
					displayObject.scaleX = displayObject.scaleY = s0;
				}
			}
			
			var img:JButton = new JButton('',new AssetIcon(displayObject));
			//img.setPreferredHeight(UISettings.XMLData.GUIVase.rightBlock.elementsList.element.@setPreferredHeight);
			//img.setPreferredWidth(UISettings.XMLData.GUIVase.rightBlock.elementsList.element.@setPreferredWidth);
			img.setToolTipText(UIText.TEXT_VASE_TIP_SELECT);
			img.addActionListener(imageButtonPressed);
			append(img,BorderLayout.CENTER);
			
			button0.setPreferredWidth(UISettings.XMLData.GUIVase.rightBlock.elementsList.element.button.@setPreferredWidth);
			button0.setPreferredHeight(UISettings.XMLData.GUIVase.rightBlock.elementsList.element.button.@setPreferredHeight);
			button0.addActionListener(buttonPressed);
			append(button0, BorderLayout.SOUTH);
			updateStateDisplay();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function get_id():uint {
			return id;
		}
		
		private function updateStateDisplay():void {
			if (state) {
				button0.setText(UIText.TEXT_VASE_USING);
				button0.setIcon(icon);
			} else {
				button0.setText(UIText.TEXT_VASE_NOT_USING);
				button0.setIcon(null);
			}
		}
		
		//{ EVENTS
		public static const EVENT_ELEMENT_SELECTED:String = 'event_element_selected';
		public static const EVENT_ELEMENT_STATE_CHANGED:String = 'event_element_state_changed';
		
		private function buttonPressed(e:Event=null):void {
			state = !state;
			updateStateDisplay();
			defaultEventsPipe(new UIEvent(EVENT_ELEMENT_STATE_CHANGED, uint(state),null,this));
			
		}
		
		private function imageButtonPressed(e:Event):void {
			state  = true;
			updateStateDisplay();
			defaultEventsPipe(new UIEvent(EVENT_ELEMENT_SELECTED,0,null,this));
		}
		//} END OF EVENTS
		
		private var icon:AssetIcon = new AssetIcon(new Bitmap(UILibrary.add));
		private var state:Boolean = false;
		private var button0:JButton = new JButton('');
		private var id:uint;
		private var defaultEventsPipe:Function;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]