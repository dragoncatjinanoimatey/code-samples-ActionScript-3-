// Project SimpleMulticast
package simple_multicast.c.vcm {
	
	//{ ======= import
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import simple_multicast.APP;
	import simple_multicast.Application;
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.c.ma.MNetGroup;
	import simple_multicast.d.n.DUChatGroup;
	import simple_multicast.d.n.DUNetGroupMsg;
	import simple_multicast.d.n.INetGroupMsg;
	import simple_multicast.d.v.DUChatMessage;
	import simple_multicast.lib.Library;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.media.Text;
	import simple_multicast.n.a.IGroupAdaptor;
	import simple_multicast.v.VCChat;
	import simple_multicast.v.VCChatChannelsList;
	import simple_multicast.v.VCChatChannelsListElement;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	/**
	 * display manager
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCMChat extends AVCM {
		
		//{ ======= CONSTRUCTOR
		
		function VCMChat (a:Application) {
			super(NAME);
			this.a=a;
			cl = new VCChatChannelsList();
			cl.setListener(el_channel);
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			var sm:JDM;
			var am:JDM;
			
			switch (eventType) {
			
			case ID_A_RUN_SELF_TEST:
				vc.runSelfTest();
				break;
				
			case ID_A_SET_REQUIRED_DATA:
				clientUserName=(details as JDM).gs(0);
				break;
				
			case ID_A_DISPLAY_GROUPS_LIST:
				groupsList=ad.get_chatGroupInfo();
				//processGList();
				displayGList();
				break;
				
			case ID_A_REGISTER_SINGLETON_VC:
				configureVC();
				break;
				
			case ID_A_SET_VISIBILITY:
				var i0:int = (details as JDM).gi(0);
				vc.set_visible((i0<2)?Boolean(i0):!vc.get_visible());
				break;
				
			case ID_A_SET_TEXT_INPUT:
				var s0:String = (details as JDM).gs(0);
				if (s0==null) {s0='';}
				vc.setTextInput(VCChat.ID_TEXT_IN_0, s0);
				break;
				
			case MNetGroup.ID_E_CHAT_MESSAGE:
				am = details as JDM;
				var msg:DUNetGroupMsg = am.go(0) as DUNetGroupMsg;
				var gra:IGroupAdaptor = am.go(1) as IGroupAdaptor;

				if (currentGroupId != gra.get_name()) { break; }
				vc.addToOutText(createChatMessage(
					msg.get_senderID()
					,msg.get_senderDisplayName()
					,msg.get_time()
					,msg.get_message()
				) + "\n");
				vc.scrollMsgDTToBottom();
				break;
				
			case ID_SET_CURRENT_GROUP:
				selectGroup((details as JDM).gs(0));
				break;
				
			case ID_A_CLEAR_TEXT_OUTPUT:
				vc.setOutText('');
				break;
				
			case MNetGroup.ID_E_CHAT_GROUP_ACTIVE:
			case MNetGroup.ID_E_CHAT_GROUP_CONNECTED:
				if (currentGroupId != (details as JDM).gs(0)) { break;}
				vc.setOutText(getHistoryText(ad.get_chatGroupInfoFor((details as JDM).gs(0)).get_chatHistory()));
				break;
			//case MUserData.ID_E_USER_CHANNEL_ACTIVE_ON:
			//case MUserData.ID_E_USER_CHANNEL_ACTIVE_OFF:
			//	var element:VCChatChannelsListElement=cl.getElementById(DUChatGroupMessage(details).get_active());
			//	if (element!=null) {element.set_selected(details);}
			//	break;
				
			}
		}
		
		private function processGList():void {
			for each(var u:DUChatGroup in groupsList) {
			}
		}
		
		private function displayGList():void {
			cl.clearContent();
			for each(var j:DUChatGroup in groupsList) {
				cl.addElement(j.get_displayName(), j.get_displayName(), true);
			}
			vc.redraw();
		}
		
		private function createChatMessage(i:String, d:String, t:String, m:String):String {
			return "[" + t + "] " + d + "" + " > " + m;
		}
		
		private function setVisibility(target:DisplayObject, a:Boolean):void {
			if (!target) {return;}target.visible = a;
		}
		
		private function configureVC():void {
			vc = new VCChat();
			var st:Stage = a.get_mainScreen().get_displayObject().stage;
			vc.construct(
				a.lText().get_TEXT(Text.ID_TEXT_LABEL_WND_TITLE_CHAT)
				,a.lText().get_TEXT(Text.ID_TEXT_LABEL_LABEL_CHANNELS_LIST)
				,new Bitmap(Library.im_list_png.clone())
				,new Bitmap(Library.im_enter_png.clone())
				,cl
				,st.stageWidth / 2
				,st.stageHeight*.75
				,st.stageWidth / 4
			);
			vc.get_displayObject().x = st.stageWidth / 2;
			vc.setListener(el_chat);
			a.set_Chat(vc);

		}
		
		
		private function el_chat (target:VCChat, eventType:String):void {
			switch (eventType) {
			
				
			case VCChat.ID_E_BUTTON_SEND:
				var gi:DUChatGroup = ad.get_chatGroupInfoFor(currentGroupId);
				if ((gi==null) || (currentGroupId == NO_GROUP)) {
					vc.setOutText(a.lText().get_TEXT(Text.ID_TEXT_INFO_CHAT_NO_GROUPS));
					break;	
				}
				
				if (gi.get_state() == DUChatGroup.ID_STATE_EMPTY) {
					vc.setOutText(a.lText().get_TEXT(Text.ID_TEXT_INFO_CHAT_EMPTY_GROUP));
					break;
				}
				var sm:JDM = JDM.getInstance();
				sm.ss(0, currentGroupId);
				sm.ss(1, vc.getTextInput(VCChat.ID_TEXT_IN_0));
				e.listen(IS_E_CHAT_SEND_MESSAGE, sm);
				sm.freeInstance();
				vc.setTextInput(VCChat.ID_TEXT_IN_0,'');
				break;
			
			
			}
			
		}
		
		private function el_channel (target:VCChatChannelsListElement, eventType:String):void {
			
			switch (eventType) {
			
			case VCChatChannelsListElement.EVENT_ELEMENT_SELECTED:
				var sm:JDM = JDM.getInstance(); sm.ss(0, target.get_id());
				selectGroup(target.get_id());
				e.listen(ID_E_GROUP_SELECTED, sm);
				sm.freeInstance();
				break;
			
			}
		}
		
		private function selectGroup(name:String):void {
			currentGroupId = name;
			vc.setOutText(getHistoryText(ad.get_chatGroupInfoFor(name).get_chatHistory()));
			vc.scrollMsgDTToBottom();
		}
		
		private function getHistoryText(a:Vector.<INetGroupMsg>):String {
			
			var s:String="";
			for each(var i:DUNetGroupMsg in a) {
				s=s.concat(
					createChatMessage(
						i.get_senderID()
						,i.get_senderDisplayName()
						,i.get_time()
						,i.get_message()
					)
					,'\n'
				);
			}
			return s;
		}
		
		/*private function getChannelById(id:String):DUChatGroup {
			for each(var i:DUChatGroup in groupsList) {
				if (i.get_id() == id) { return i;}
			}
			return null;
		}*/
		
		//{ ======= private 
		private var vc:VCChat;
		// contacts list
		private var cl:VCChatChannelsList;	
		
		private var groupsList:Vector.<DUChatGroup>;
		private var clientUserName:String;
		private var currentGroupId:String = NO_GROUP;
		//} ======= END OF private
		
		private static const NO_GROUP:String = "NO_GROUP";
		
		
		//{ ======= id
		public static const ID_A_DISPLAY_GROUPS_LIST:String = NAME + '>ID_A_DISPLAY_GROUPS_LIST';
		/**
		 * data:String
		 */
		public static const ID_A_SET_TEXT_INPUT:String = NAME + '>ID_A_SET_TEXT_INPUT';
		public static const ID_A_CLEAR_TEXT_OUTPUT:String = NAME + '>ID_A_CLEAR_TEXT_OUTPUT';
		/**
		 * data:VCChat
		 */
		public static const ID_A_REGISTER_SINGLETON_VC:String = NAME + '>ID_A_REGISTER_SINGLETON_VC';
		/**
		 * data:uint
		 * 0 false, 1 true, 2 toggle
		 */
		public static const ID_A_SET_VISIBILITY:String=NAME+'>ID_A_SET_VISIBILITY';
		/**
		 * data:[x,y,w,h]
		 */
		public static const ID_A_SET_WINDOW_XYWH:String=NAME+'>ID_A_SET_WINDOW_XYWH';
		/**
		 * data:String//userName(id)
		 */
		public static const ID_A_SET_REQUIRED_DATA:String=NAME+'>ID_A_SET_REQUIRED_DATA';
		public static const ID_A_RUN_SELF_TEST:String=NAME+'>ID_A_RUN_SELF_TEST';
		/**
		 * String:group name;
		 */
		public static const ID_SET_CURRENT_GROUP:String=NAME+'>ID_SET_CURRENT_GROUP';
		
		/**
		 * String:groupName, messageText;
		 */
		public static const IS_E_CHAT_SEND_MESSAGE:String = NAME + '>IS_E_CHAT_SEND_MESSAGE';
		/**
		 * data:Boolean
		 */
		public static const ID_E_IT_FOCUS:String = NAME + '>ID_E_IT_FOCUS';
		/**
		 * String:group name
		 */
		public static const ID_E_GROUP_SELECTED:String = NAME + '>ID_E_GROUP_SELECTED';
		//} ======= END OF id
		
		
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_REGISTER_SINGLETON_VC
				,ID_A_SET_VISIBILITY
				,ID_A_SET_WINDOW_XYWH
				,ID_A_SET_REQUIRED_DATA
				,ID_A_RUN_SELF_TEST
				,ID_A_DISPLAY_GROUPS_LIST
				,ID_A_SET_TEXT_INPUT
				,ID_A_CLEAR_TEXT_OUTPUT
				,ID_SET_CURRENT_GROUP
				,MNetGroup.ID_E_CHAT_MESSAGE
				,MNetGroup.ID_E_CHAT_GROUP_CONNECTED
				,MNetGroup.ID_E_CHAT_GROUP_ACTIVE
				//,MUserData.ID_E_USER_CHANNEL_ACTIVE_OFF
				//,MUserData.ID_E_USER_CHANNEL_ACTIVE_ON
			];
		}
		
		public static const NAME:String = 'VCMChat';
		
		
		
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
