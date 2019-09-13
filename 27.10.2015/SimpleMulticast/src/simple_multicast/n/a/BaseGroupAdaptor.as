// Project SimpleMulticast
package simple_multicast.n.a {
	
	//{ ===== import
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetGroup;
	import simple_multicast.Application;
	import simple_multicast.d.n.DUNetGroupMsg;
	import simple_multicast.LOG;
	import simple_multicast.n.connectors.NetConnector;
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class BaseGroupAdaptor implements IGroupAdaptor {
		
		//{ ===== CONSTRUCTOR
		function BaseGroupAdaptor(a:Application, name:String, address:String):void {
			gn = name;
			this.nc = a.getNetConnector();
			gs = new GroupSpecifier(gn);
            gs.postingEnabled = true;
            gs.ipMulticastMemberUpdatesEnabled = true;
            gs.addIPMulticastAddress(address);
			
			g = nc.createNetGroup(gs);
			
			g.addEventListener(NetStatusEvent.NET_STATUS, el_ns);
		}
		public function destruct():void {
		}
		//} ===== END OF CONSTRUCTOR
		
		//{ ===== USER INTERFACE
		
		/**
		 * 
		 * @param	senderDisplayName
		 * @param	text
		 * @return error occured
		 */
		public function sendMessage(senderDisplayName:String, text:String):Boolean {
			//if (!_c) { return; }//collect messages to list and send later?
			
			var du:DUNetGroupMsg = new DUNetGroupMsg(g.convertPeerIDToGroupAddress(nc.nearID), senderDisplayName, getTime(), text);
            try {
				g.post(du.toObject());
				receiveMessage(du.toObject());
			} catch (e:Error) {
				el(ID_E_FAILED_TO_SEND_MESSAGE, null);
				return true;
			}
			return false;
        }
		
		public function get_name():String {return gn;}
		//} ===== END OF USER INTERFACE
		
		
		private function el_ns(event:NetStatusEvent):void {
			//LOG(5, 'el_gr:' + event.info.code, 1);
			switch(event.info.code){
                case "NetGroup.Neighbor.Connect":
					el(ID_E_MEMBER_CONNECTED, null);
					break;
                case "NetGroup.Connect.Success":
				_c = true;
				el(ID_E_CONNECTED, null);
                break;
			case "NetGroup.Posting.Notify":
				receiveMessage(event.info.message)
				break;
            }
		}
		
		
		private function receiveMessage(a:Object):void {
			var m:DUNetGroupMsg = DUNetGroupMsg.fromObject(a);
			el((m == null)?ID_E_INCOMING_MESSAGE_INVALID:ID_E_INCOMING_MESSAGE, m);
		}
		
		private function getTime():String {
			var d:Date = new Date();
			return d.getDate() + '/' + d.getMonth() + '/' + d.getFullYear() + ' ' + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();
		}
		
		
		/**
		 * connected
		 */
		private var _c:Boolean;
		private var gs:GroupSpecifier;
		private var g:NetGroup;
		private var nc:NetConnector;
		private var gn:String;
		
		
		public static const ID_E_MEMBER_CONNECTED:String = "ID_E_MEMBER_CONNECTED";
		public static const ID_E_CONNECTED:String = "ID_E_CONNECTED";
		/**
		 * INetGroupMsg
		 */
		public static const ID_E_INCOMING_MESSAGE:String="ID_E_INCOMING_MESSAGE";
		/**
		 * INetGroupMsg
		 */
		public static const ID_E_INCOMING_MESSAGE_INVALID:String="ID_E_INCOMING_MESSAGE_INVALID";
		public static const ID_E_FAILED_TO_SEND_MESSAGE:String="ID_E_FAILED_TO_SEND_MESSAGE";
		
		
		/**
		 * @param	a function(target:IGroupAdaptor, type:String, details:Object):void;
		 */
		public function set_listener(a:Function):void {el_ref = a;}
		private function el(type:String, details:Object):void {
			if (el_ref!=null) {el_ref(this,type,details);}
		}
		
		private var el_ref:Function;
		
		
	}
}
