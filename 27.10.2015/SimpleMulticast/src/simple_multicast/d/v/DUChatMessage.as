// Project SimpleMulticast
package simple_multicast.d.v {
	
	//{ ======= import
	import simple_multicast.d.i.ISerializable;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUChatMessage implements ISerializable {
		
		//{ ======= CONSTRUCTOR
		function DUChatMessage (userID:String, userDisplayName:String, time:String, text:String):void {
			this.userDisplayName = userDisplayName;
			this.userID = userID;
			this.time = time;
			this.text = text;
		}
		//} ======= END OF CONSTRUCTOR
		public function get_userID():String {return userID;}
		public function set_userID(a:String):void {userID = a;}
		public function get_text():String {return text;}
		public function set_text(a:String):void {text = a;}
		public function get_userDisplayName():String {return userDisplayName;}
		public function set_userDisplayName(a:String):void {userDisplayName = a;}
		public function get_time():String {return time;}
		public function set_time(a:String):void {time = a;}
		
		private var userID:String;
		private var userDisplayName:String;
		private var text:String;
		private var time:String;
		
		public function toObject():Object {
			return {
				userID:userID
				, userDisplayName:userDisplayName
				, text:text
				, time:time
			};
		}
		
		public static function fromObject(a:Object):DUChatMessage {
			return new DUChatMessage(
				a.userID
				, a.userDisplayName
				, a.time
				, a.text
			);
		}
	
		
		public function toString():String {
			var s:String='';
			var f:Array=["time", "userID", "userDisplayName", "text"];
			for each(var i:String in f) {
				s=s.concat(i+'='+this[i]+', ');
			}
			return s;
		}
		
	}
}
