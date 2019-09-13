// Project SimpleMulticast
package simple_multicast.v {
	
	//{ ===== import
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	import org.aswing.BorderLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCChatChannelsListElement extends JPanel {
		
		//{ ===== CONSTRUCTOR
		
		/**
		 * 
		 * @param	id_
		 * @param	eventsPipe function (target:VCChatChannelsListElement, eventType:String):void; see events section for more details
		 */
		function VCChatChannelsListElement (id_:String, eventsPipe:Function, w:uint, h:uint, displayName:String, selected:Boolean) {
			setSizeWH(w,h);
			defaultEventsPipe = eventsPipe;
			id = id_;
			setLayout(new BorderLayout(0,1));
			
			button0=new JButton(displayName);
			button0.setToolTipText(displayName);
			
			button0.addActionListener(buttonPressed);
			append(button0, BorderLayout.CENTER);
			state=selected;
			updateStateDisplay();
		}
		//} ===== END OF CONSTRUCTOR
		
		public function get_id():String {return id;}
		public function get_selected():Boolean {return state;}
		public function set_selected(a:Boolean):void {
			state = a;
			updateStateDisplay();
		}
		
		private function updateStateDisplay():void {
			button0.setAlpha((state)?1:0.5);
		}
		
		//{ EVENTS
		public static const EVENT_ELEMENT_SELECTED:String = 'event_element_selected';
		
		private function buttonPressed(e:Event=null):void {
			defaultEventsPipe(this, EVENT_ELEMENT_SELECTED);
		}
		
		//} END OF EVENTS
		
		private var state:Boolean = false;
		private var button0:JButton;
		private var id:String;
		private var defaultEventsPipe:Function;
		
	}
}
