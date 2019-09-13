// Project SimpleMulticast
package simple_multicast.d.a {
	
	//{ ======= import
	import simple_multicast.d.n.DUChatGroup;
	import simple_multicast.LOG;
	import simple_multicast.n.a.IGroupAdaptor;
	//} ======= END OF import
	
	
	/**
	 * contains main application data storeroom
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUApp {
		
		//{ ======= CONSTRUCTOR
		
		public function DUApp () {
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_serviceGroup():IGroupAdaptor {return serviceGroup;}
		public function set_serviceGroup(a:IGroupAdaptor):void {serviceGroup = a;}
		
		public function addChatGroup(g:IGroupAdaptor):void {
			chatGroups.push(g);
		}
		
		public function getChatGroupNum():int { return chatGroups.length;}
		public function getChatGroup(groupName:String):IGroupAdaptor {
			for each (var i:IGroupAdaptor in chatGroups) {
				if (i.get_name() == groupName) { return i;}
			}
			return null;
		}
		
		public function get_chatGroupInfoFor(name:String):DUChatGroup {
			for each(var i:DUChatGroup in chatGroupInfo) {
				if (name == i.get_displayName()) { return i;}
			}
			return null;
		}
		public function get_chatGroupInfo():Vector.<DUChatGroup> {return chatGroupInfo.slice();}
		public function addChatGroupInfo(a:DUChatGroup):void { chatGroupInfo.push(a);}

		public function get_userDisplayName():String {return userDisplayName;}
		public function set_userDisplayName(a:String):void {userDisplayName = a;}
		
		private var userDisplayName:String='default user name';
		private var chatGroupInfo:Vector.<DUChatGroup>=new Vector.<DUChatGroup>;
		private var serviceGroup:IGroupAdaptor;
		private var chatGroups:Vector.<IGroupAdaptor>=new Vector.<IGroupAdaptor>;
		
		
	}
}