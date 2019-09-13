// Project SimpleMulticast
package simple_multicast.v {
	
	//{ ===== import
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.aswing.BoxLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollBar;
	import org.aswing.JScrollPane;
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCChatChannelsList extends JPanel {
		
		//{ ===== CONSTRUCTOR
		
		function VCChatChannelsList (elementWidth:uint=40, elementHeight:uint=10) {
			eW=elementWidth;
			eH=elementHeight;
			super(new BoxLayout(BoxLayout.Y_AXIS,0));
			//setOpaque(true);
		}
		//} ===== END OF CONSTRUCTOR
		
		public function addElement(displayName:String, id:String, selected:Boolean):void {
			var item:VCChatChannelsListElement = new VCChatChannelsListElement(id, defaultEventsPipe, eW, eH, displayName, selected);
			itemsList.push(item);
			append(item);
		}
		
		public function setContent(displayName:Vector.<String>, id:Vector.<String>, selected:Vector.<Boolean>):void {
			var item:VCChatChannelsListElement;
			for (var i:String in displayName) {
				item = new VCChatChannelsListElement(id[i], defaultEventsPipe, eW, eH, displayName[i], selected[i]);
				itemsList.push(item);
				append(item);
			}
		}
		
		public function clearContent():void {
			for each(var i:VCChatChannelsListElement in itemsList) {
				remove(i);
			}
		}
		
		public function getElementById(id:String):VCChatChannelsListElement {
			for each(var i:VCChatChannelsListElement in itemsList) {
				if (i.get_id() == id) { return i;}
			}
			return null;
		}
		
		private var itemsList:Array = [];
		
		//{ ===== events
		/**
		 * @param	listener function (target:VCChatChannelsListElement, eventType:String):void; see events section for more details
		 */
		public function setListener(listener:Function):void {
			this.defaultEventsPipe = listener;
		}
		private var defaultEventsPipe:Function;
		//} ===== END OF events
		
		
		/**
		 * element width
		 */
		private var eW:uint;
		/**
		 * element height
		 */
		private var eH:uint;
		
	}
}
