// Project SimpleMulticast
package simple_multicast.c.ma {
	
	//{ ======= import
	import simple_multicast.c.vcm.VCMChat;
	import simple_multicast.d.a.DUApp;
	import simple_multicast.d.a.DUAppAction;
	import simple_multicast.d.n.DUChatGroup;
	import simple_multicast.media.Text;
	import flash.utils.ByteArray;
	import simple_multicast.APP;
	import simple_multicast.Application;
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.c.vcm.VCMMainScreen;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.v.VCMainScreen;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	
	/**
	 * application(game) manager - ctrl ALL
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class MApp extends AM {
		
		//{ ======= CONSTRUCTOR
		
		function MApp (app:Application) {
			super(NAME);
			a=app;
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			var sm:JDM;
			var gi:DUChatGroup;
			switch (eventType) {
			
			case ID_A_STARTUP:
				//Entry point
				
				//since all resourses loaded, use text
				prepareActionsList();
				
				
				// try to connect
				sm = JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_STATE_CONNECTING));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				sm.freeInstance();
				
				e.listen(MServer.ID_A_SETUP_CONNECTION, null);
				break;
				
			case MServer.ID_E_CONNECTION_LOST:
				// reflect state to ui
				sm = JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_STATE_FAILED_TO_CONNECT));
				e.listen(VCMMainScreen.ID_A_DISPLAY_ERROR_MESSAGE, sm); sm.freeInstance();
				// disable group controls
				removeMPActions();
				break;
				
			case MServer.ID_E_CONNECTION_ESTABLISHED:
				sm = JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_STATE_CONNECTED));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_STATE_WAITING_FOR_INCOMING));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm); sm.freeInstance();
				sm.freeInstance();
				
				
				e.listen(MNetGroup.ID_A_CONNECT_SERVICE_GROUP, null);
				
				// enable group controls
				addMPActions();
				
				break;
				
			case MNetGroup.ID_E_SERVICE_GROUP_NEW_MEMBER_CONNECTED:
			case MNetGroup.ID_E_SERVICE_GROUP_CONNECTED:
				// send groups list
				e.listen(MNetGroup.ID_A_DISPATCH_CHAT_GROUPS_LIST, null);
				break;
				
				
			case VCMMainScreen.ID_A_DISPLAY_ERROR_FAILED_TO_SEND:
				removeMPActions();
				break;
				
			case VCMMainScreen.ID_E_ACTION_SELECTED:
				processMainPanelAction((details as JDM).gi(0));
				break;
			
			case MNetGroup.ID_E_CHAT_NEW_GROUP_LIST:
				var gl:Vector.<String> = (details as JDM).go(0) as Vector.<String>;
				for each(var i:String in gl) {
					if (ad.get_chatGroupInfoFor(i) != null) { continue;}
					ad.addChatGroupInfo(new DUChatGroup(i));
				}
				// reflect to ui
				e.listen(VCMChat.ID_A_DISPLAY_GROUPS_LIST, null);
				break;
				
			case MNetGroup.ID_E_SERVICE_GROUP_GROUPS_LIST_IN_REQ:
				e.listen(MNetGroup.ID_A_DISPATCH_CHAT_GROUPS_LIST, null);
				break;
				
			case MNetGroup.ID_E_CHAT_GROUP_ACTIVE:
				sm = JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_INFO_GR_ACTIVE).split('%0').join((details as JDM).gs(0)));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				sm.freeInstance();
				break;
				
			case MNetGroup.ID_E_CHAT_GROUP_CREATED:
				//this client  user has created new group(which is empty so will not post into it)
				gi = new DUChatGroup((details as JDM).gs(0));
				gi.set_state(DUChatGroup.ID_STATE_EMPTY);
				ad.addChatGroupInfo(gi);
				// reflect to ui
				e.listen(VCMChat.ID_A_DISPLAY_GROUPS_LIST, null);
				sm = JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_INFO_CREATE_GR_OK));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				
				if (ad.getChatGroupNum() == 1) {
					sm.ss(0, gi.get_displayName());
					e.listen(VCMChat.ID_SET_CURRENT_GROUP, sm);
				}
				sm.freeInstance();
				break;
				
			case VCMChat.ID_E_GROUP_SELECTED:
				sm = details as JDM;
				gi = ad.get_chatGroupInfoFor(sm.gs(0));
				if (gi.get_state() == DUChatGroup.ID_STATE_NOT_CONNECTED) {
					e.listen(MNetGroup.ID_A_CONNECT_CHAT_GROUP, sm);
				}
				break;
				
				
			}
		}
		
		//{ =====	op processMainPanelAction
		
		private function removeMPActions():void {
			for each(var i:DUAppAction in appActionsList) {
				a.get_mainScreen().removeActionButton(i.get_id());
				a.get_mainScreen().removeInputTextField(i.get_id());
			}
		}
		private function addMPActions():void {
			for each(var i:DUAppAction in appActionsList) {
				if (i.get_itTitle()!=null) {
					a.get_mainScreen().addInputTextField(i.get_id(), i.get_itTitle());
				}
				if (i.get_bTitle()!=null) {
					a.get_mainScreen().addActionButton(i.get_id(), i.get_bTitle());
				}
				
			}
		}
		
		private function prepareActionsList():void {
			var bt:Array = a.lText().get_appActionsBLabels();
			var it:Array = a.lText().get_appActionsItLabels();
			var ids:Array = [
				APP_ID_ACTION_UPDATE_USER_NAME
				,APP_ID_ACTION_CREATE_GROUP
				,APP_ID_ACTION_REFRESH_G_LST
			];
			
			for (var i:int = 0; i < ids.length;i+=1) {
				appActionsList.push(new DUAppAction(i, bt[ids[i]], it[ids[i]]));
			}
		}
		private var appActionsList:Vector.<DUAppAction>=new Vector.<DUAppAction>;
		
		private function processMainPanelAction(id:int):void {
			var sm:JDM;
			switch (id) {
			
			case APP_ID_ACTION_UPDATE_USER_NAME:
				var s:String = a.get_mainScreen().getText(APP_ID_ACTION_UPDATE_USER_NAME);
				sm= JDM.getInstance();
				sm.ss(0, a.lText().get_TEXT((s.length < 3)?Text.ID_TEXT_INFO_SHORT_NAME:Text.ID_TEXT_INFO_NAME_UPDATED));
				e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				sm.freeInstance();
				if (s.length < 3) { break;}
				ad.set_userDisplayName(s);
				break;
				
			case APP_ID_ACTION_REFRESH_G_LST:
				e.listen(MNetGroup.ID_A_REQ_CHAT_GROUPS_LIST, null);
				break;
				
			case APP_ID_ACTION_CREATE_GROUP:
				sm= JDM.getInstance();
				var s1:String = a.get_mainScreen().getText(APP_ID_ACTION_CREATE_GROUP);
				if (s1.length < 5) {
					sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_INFO_SHORT_GR_NAME));
					e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
					sm.freeInstance();
					break;
				}
				sm.ss(0, a.get_mainScreen().getText(APP_ID_ACTION_CREATE_GROUP));
				e.listen(MNetGroup.ID_A_CREATE_CHAT_GROUP, sm);
				if (!sm.gb(0)) {
					e.listen(MNetGroup.ID_A_DISPATCH_CHAT_GROUPS_LIST, null);
				} else {
					sm.ss(0, a.lText().get_TEXT(Text.ID_TEXT_INFO_CANT_CREATE_GR_ALREADY_EXISTS));
					e.listen(VCMMainScreen.ID_A_DISPLAY_INFO_MESSAGE, sm);
				}
				sm.freeInstance();
				break;
			
			}
		}
		
		private static const APP_ID_ACTION_UPDATE_USER_NAME:int=0;
		private static const APP_ID_ACTION_CREATE_GROUP:int=1;
		private static const APP_ID_ACTION_REFRESH_G_LST:int=2;
		//} ===== END OF op processMainPanelAction		
		
		
		//{ ======= private 
		
		//} ======= END OF private
		
		
		//{ ======= id
		public static const ID_A_STARTUP:String = NAME + "ID_A_STARTUP";
		//} ======= END OF id
		
		//{ ======= events
		//} ======= END OF events
		
		public static const NAME:String = 'MApp';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_STARTUP
				,MServer.ID_E_CONNECTION_ESTABLISHED
				,MNetGroup.ID_E_CHAT_GROUP_CREATED
				,MNetGroup.ID_E_SERVICE_GROUP_CONNECTED
				,MNetGroup.ID_E_CHAT_NEW_GROUP_LIST
				,MNetGroup.ID_E_SERVICE_GROUP_NEW_MEMBER_CONNECTED
				,VCMMainScreen.ID_E_ACTION_SELECTED
				,VCMMainScreen.ID_A_DISPLAY_ERROR_FAILED_TO_SEND
				,VCMChat.ID_E_GROUP_SELECTED
				,MNetGroup.ID_E_CHAT_GROUP_ACTIVE
				,MNetGroup.ID_E_SERVICE_GROUP_GROUPS_LIST_IN_REQ
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