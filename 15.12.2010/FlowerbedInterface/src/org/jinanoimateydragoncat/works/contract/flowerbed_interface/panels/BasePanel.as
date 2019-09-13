// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.aswing.*;
	import org.aswing.colorchooser.*;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:05
	 */
	public class BasePanel extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function BasePanel () {
			
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function setButtonEnabled(id:String, enabled:Boolean):void {
			getChildByName(id).setEnabled(enabled);
		}
		
		
		/**
		 * 
		 * @param	buttonPressedCallback
		 */
		protected function init (buttonPressedCallback:Function):void {
			buttonPressedRef = buttonPressedCallback;
			setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
			setBackgroundDecorator(new SolidBackground(ASColor.LIGHT_GRAY));
			
		}
		
		
		/**
		 * for debugging purpose
		 * @param	title String
		 * @param	id Strig 
		 * @param	enabled Boolean
		 */
		protected function createSimplePanel(title:Array, id:Array):void {
			
			for (var i:uint in title) {
				buttons.push(addButton(id[i],title[i],buttonPressedRef,true));
			}
			
			pack();
			validate();
		}
		
		protected function addButton(name:String, label:String, callBack:Function,enabled:Boolean):JButton {
			var button:JButton = new JButton(label);
			button.addActionListener(callBack);
			button.name = name;
			button.setEnabled(enabled);
			append(button);
			return button;
		}
		
		protected var buttonPressedRef:Function;
		protected var buttons:Vector.<JButton> = new Vector.<JButton>();
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]