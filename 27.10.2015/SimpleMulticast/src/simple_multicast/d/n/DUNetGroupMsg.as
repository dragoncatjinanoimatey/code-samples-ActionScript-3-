// Project SimpleMulticast
package simple_multicast.d.n {
	
	//{ ===== import
	import simple_multicast.d.i.ISerializable;
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUNetGroupMsg implements ISerializable, INetGroupMsg {
		
		//{ ===== CONSTRUCTOR
		function DUNetGroupMsg (senderID:String, senderDisplayName:String, time:String, message:String):void {
			this.t = time;
			this.i = senderID;
			this.d = senderDisplayName;
			this.m = message;
		}
		//} ===== END OF CONSTRUCTOR
		
		
		
		public function get_senderID():String {return i;}
		//public function set_senderID(a:String):void {senderID = a;}
		public function get_senderDisplayName():String {return d;}
		//public function set_senderDisplayName(a:String):void {senderDisplayName = a;}
		public function get_message():String {return m;}
		//public function set_message(a:String):void {message = a;}
		public function get_time():String {return t;}
		//public function set_time(a:String):void {time = a;}
		
		private var i:String;
		private var d:String;
		private var m:String;
		private var t:String;

		public function toObject():Object {
			return {
				i:i
				, d:d
				, m:m
				, t:t
			};
		}
		
		public static function fromObject(a:Object):DUNetGroupMsg {
			return new DUNetGroupMsg (a.i, a.d, a.t, a.m);
		}
	
		
		public function toString():String {
			return [
				"senderDisplayName:", d
				,";senderID=", i
				,";message=", m
				,";time=", t
				].join('');
		}
		
	}
}
