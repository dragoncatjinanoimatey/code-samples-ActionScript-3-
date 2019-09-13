// Project SimpleMulticast
package simple_multicast.c.ma {
	
	//{ ======= import
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.c.vcm.VCMChat;
	import simple_multicast.c.vcm.VCMMainScreen;
	import simple_multicast.cfg.SP;
	import simple_multicast.d.n.DUChatGroup;
	import simple_multicast.d.n.DUNetGroupMsg;
	import simple_multicast.d.n.INetGroupMsg;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.n.a.BaseGroupAdaptor;
	import simple_multicast.n.a.IGroupAdaptor;
	import simple_multicast.n.connectors.NetConnector;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	
	/**
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class MNetGroup extends AM {
		
		//{ ======= CONSTRUCTOR
		
		function MNetGroup () {
			super(NAME);
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			var sm:JDM;
			switch (eventType) {
			
			case ID_A_CONNECT_SERVICE_GROUP:
				var sg:BaseGroupAdaptor = new BaseGroupAdaptor(a, SP.METHOD_RTMFP_SERVICE_GROUP_NAME, SP.METHOD_RTMFP_MC_ADDRESS);
				sg.set_listener(el_srvg);
				ad.set_serviceGroup(sg);
				// add listener
				break;
				
			case VCMChat.IS_E_CHAT_SEND_MESSAGE:
				sm =details as JDM;
				if (sm.gs(1).length < 1) { log(3, 'wont send empty msg', 0); break; }
				var gr:BaseGroupAdaptor = ad.getChatGroup(sm.gs(0)) as BaseGroupAdaptor;
				if (gr == null) { break; }
				gr.sendMessage(ad.get_userDisplayName(), sm.gs(1));
				break;
				
			case ID_A_REQ_CHAT_GROUPS_LIST:
				ad.get_serviceGroup().sendMessage(SP.METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST_REQ, "");
				break;
			case ID_A_DISPATCH_CHAT_GROUPS_LIST:
				ad.get_serviceGroup().sendMessage(SP.METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST, groupNameList.join(','));

				break;
				
			case ID_A_CONNECT_CHAT_GROUP:
				sm = details as JDM;
				var gn__:String = sm.gs(0);
				if (ad.getChatGroup(gn__) != null) {
					sm.sb(0, true);
					log(2, 'group\'s already connected', 0);
					break;
				}
				
				var g1:BaseGroupAdaptor = new BaseGroupAdaptor(a, gn__, SP.METHOD_RTMFP_MC_ADDRESS);
				g1.set_listener(el_cg);
				ad.addChatGroup(g1);
				ad.get_chatGroupInfoFor(gn__).set_state(DUChatGroup.ID_STATE_ACTIVE);
				
				e.listen(ID_E_CHAT_GROUP_CONNECTED, sm);
				break;
				
			case ID_A_CREATE_CHAT_GROUP:
				sm = details as JDM;
				var gn_:String = sm.gs(0).split(',').join('');
				if ((groupNameList.indexOf(gn_) != -1) || (ad.getChatGroup(gn_) != null)) {
					sm.sb(0, true);
					log(2, 'group\'s already exist in list', 0);
					break;
				}
				groupNameList.push(gn_);
					
				var g:BaseGroupAdaptor = new BaseGroupAdaptor(a, gn_, SP.METHOD_RTMFP_MC_ADDRESS);
				g.set_listener(el_cg);
				ad.addChatGroup(g);
				
				sm.ss(0, gn_);
				e.listen(ID_E_CHAT_GROUP_CREATED, sm);
				break;
				
			}
		}
		
		private function el_cg(target:IGroupAdaptor, type:String, details:Object):void {
			var am:JDM;
			switch (type) {
			
			case BaseGroupAdaptor.ID_E_FAILED_TO_SEND_MESSAGE:
				e.listen(VCMMainScreen.ID_A_DISPLAY_ERROR_FAILED_TO_SEND, null);
				break;
				
			case BaseGroupAdaptor.ID_E_INCOMING_MESSAGE:
				// add to history
				ad.get_chatGroupInfoFor(target.get_name()).addToChatHistory(details as INetGroupMsg);
				am = JDM.getInstance();
				am.so(0, details);
				am.so(1, target);
				e.listen(ID_E_CHAT_MESSAGE, am);
				am.freeInstance();
			case BaseGroupAdaptor.ID_E_MEMBER_CONNECTED:
			case BaseGroupAdaptor.ID_E_CONNECTED:
				var gr:DUChatGroup = ad.get_chatGroupInfoFor(target.get_name());
				if (gr.get_state()==DUChatGroup.ID_STATE_ACTIVE ) { break; }
				gr.set_state(DUChatGroup.ID_STATE_ACTIVE);
				// reflect to ui
				var sm:JDM = JDM.getInstance();
				sm.ss(0, target.get_name());
				e.listen(ID_E_CHAT_GROUP_ACTIVE, sm);
				sm.freeInstance();
				break;
				
			
			}
		}
		
		
		private function el_srvg(target:IGroupAdaptor, type:String, details:Object):void {
			switch (type) {
			
			case BaseGroupAdaptor.ID_E_FAILED_TO_SEND_MESSAGE:
				e.listen(VCMMainScreen.ID_A_DISPLAY_ERROR_FAILED_TO_SEND, null);
				break;
				
			case BaseGroupAdaptor.ID_E_INCOMING_MESSAGE:
				var m:DUNetGroupMsg = details as DUNetGroupMsg;
				switch (m.get_senderDisplayName()) {
				
				case SP.METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST_REQ:
					e.listen(ID_E_SERVICE_GROUP_GROUPS_LIST_IN_REQ, null);
					break;
					
				case SP.METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST:
					//log(6,'IN: new groups list:'+m.get_message());
					processIncomingGroupsList(m.get_message().split(','));
					break;
				
				}
				break;
			case BaseGroupAdaptor.ID_E_INCOMING_MESSAGE_INVALID:
				log(5, 'invalid srv msg', 1);
				break;
				
			case BaseGroupAdaptor.ID_E_MEMBER_CONNECTED:
				e.listen(ID_E_SERVICE_GROUP_NEW_MEMBER_CONNECTED, null);
				break;
			case BaseGroupAdaptor.ID_E_CONNECTED:
				e.listen(ID_E_SERVICE_GROUP_CONNECTED, null);
				break;
			
			}
		}
		
		
		//{ ======= private 
		private function processIncomingGroupsList(list:Array):void {
			var nl:Boolean;

			for each(var i:String in list) {
				if ((groupNameList.indexOf(i) != -1) ||(i.length<1)) { continue;}
				groupNameList.push(i); nl = true;
			}
			if (nl) {
				var am:JDM = JDM.getInstance();
				am.so(0, groupNameList.slice());
				e.listen(ID_E_CHAT_NEW_GROUP_LIST, am);
				am.freeInstance();
			}
		}
		
		public var groupNameList:Vector.<String>=new Vector.<String>;
		
		
		//} ======= END OF private
		
		
		//{ ======= id
		public static const ID_A_CONNECT_SERVICE_GROUP:String = NAME + 'ID_A_CONNECT_SERVICE_GROUP';
		/**
		 * String:groupName
		 * @return Boolean:group already created
		 */
		public static const ID_A_CONNECT_CHAT_GROUP:String=NAME+'ID_A_CONNECT_CHAT_GROUP';
		/**
		 * String:groupName
		 * @return Boolean:group already connected
		 */
		public static const ID_A_CREATE_CHAT_GROUP:String=NAME+'ID_A_CREATE_CHAT_GROUP';
		public static const ID_A_DISPATCH_CHAT_GROUPS_LIST:String=NAME+'ID_A_DISPATCH_CHAT_GROUPS_LIST';
		public static const ID_A_REQ_CHAT_GROUPS_LIST:String=NAME+'ID_A_REQ_CHAT_GROUPS_LIST';
		//} ======= END OF id
		
		//{ ======= events
		/**
		 * Object:DUNetGroupMsg, IGroupAdaptor 
		 */
		public static const ID_E_CHAT_MESSAGE:String=NAME+'ID_E_CHAT_MESSAGE';
		/**
		 * String:group name;
		 */
		public static const ID_E_CHAT_GROUP_CREATED:String = NAME + 'ID_E_CHAT_GROUP_CREATED';
		/**
		 * String:group name;
		 */
		public static const ID_E_CHAT_GROUP_CONNECTED:String = NAME + 'ID_E_CHAT_GROUP_CONNECTED';
		/**
		 * String:group name;
		 */
		public static const ID_E_CHAT_GROUP_ACTIVE:String = NAME + 'ID_E_CHAT_GROUP_ACTIVE';
		/**
		 * Object:Vector.<String>;
		 */
		public static const ID_E_CHAT_NEW_GROUP_LIST:String=NAME+'ID_E_CHAT_NEW_GROUP_LIST';
		public static const ID_E_SERVICE_GROUP_CONNECTED:String=NAME+'ID_E_SERVICE_GROUP_CONNECTED';
		public static const ID_E_SERVICE_GROUP_NEW_MEMBER_CONNECTED:String=NAME+'ID_E_SERVICE_GROUP_NEW_MEMBER_CONNECTED';
		public static const ID_E_SERVICE_GROUP_GROUPS_LIST_IN_REQ:String=NAME+'ID_E_SERVICE_GROUP_GROUPS_LIST_IN_REQ';
		//public static const ID_E_CHAT_GROUP_REMOVED:String=NAME+'ID_E_CHAT_GROUP_REMOVED';
		//} ======= END OF events
		
		public static const NAME:String = 'MNetGroup';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_CONNECT_SERVICE_GROUP
				,ID_A_CREATE_CHAT_GROUP
				,ID_A_CONNECT_CHAT_GROUP
				,ID_A_REQ_CHAT_GROUPS_LIST
				,ID_A_DISPATCH_CHAT_GROUPS_LIST
				,VCMChat.IS_E_CHAT_SEND_MESSAGE
			];
		}
		
		
		/**
		* @param	c channel id(see LOGGER)
			0-"R"
			1-"DT"
			2-"DS"
			3-"V"
			4-"OP"
			5-"NET"
			6-"AG"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log(c:uint, m:String, l:uint=0):void {
			LOG(c,NAME+'>'+m,l);
		}
		
		
	}
}
