// Project SimpleMulticast
package simple_multicast.d.n {
	
	//{ ======= import
	import simple_multicast.d.n.INetGroupMsg;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUChatGroup {
		
		//{ ======= CONSTRUCTOR
		function DUChatGroup (displayName:String):void {
			state = ID_STATE_NOT_CONNECTED;
			this.displayName = displayName;
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public static const ID_STATE_ACTIVE:String='ID_STATE_ACTIVE';
		public static const ID_STATE_EMPTY:String='ID_STATE_EMPTY';
		public static const ID_STATE_NOT_CONNECTED:String = 'ID_STATE_NOT_CONNECTED';
		
		
		public function get_displayName():String {return displayName;}
		public function set_displayName(a:String):void {displayName = a;}
		public function get_state():String {return state;}
		public function set_state(a:String):void {state= a;}
		
		
		
		public function get_chatHistory():Vector.<INetGroupMsg> {return chatHistory.slice();}
		public function addToChatHistory(a:INetGroupMsg):void { chatHistory.push(a);}
		
		private var chatHistory:Vector.<INetGroupMsg>=new Vector.<INetGroupMsg>;
		private var displayName:String;
		private var state:String;
		
	}		
}
