// Project TicTacToe
package t_t.c.vcm {
	
	//{ ======= import
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import t_t.APP;
	import t_t.Application;
	import t_t.c.ae.AEApp;
	import t_t.d.app.IDUAction;
	import t_t.lib.Library;
	import t_t.LOG;
	import t_t.LOGGER;
	import t_t.media.Text;
	import t_t.v.VCChat;
	import t_t.v.VCChatChannelsList;
	import t_t.v.VCChatChannelsListElement;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	/**
	 * display manager
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCMActions extends AVCM {
		
		//{ ======= CONSTRUCTOR
		
		function VCMActions (a:Application) {
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
				
			case ID_A_DISPLAY_ACTIONS_LIST:
				displayGList(ad.get_conditionsData().get_list_actions());
				break;
				
			case ID_A_REGISTER_SINGLETON_VC:
				configureVC();
				break;
				
			case ID_A_SET_VISIBILITY:
				var i0:int = (details as JDM).gi(0);
				vc.set_visible((i0<2)?Boolean(i0):!vc.get_visible());
				break;
				
				
			}
		}
		
		private function displayGList(l:Vector.<IDUAction>):void {
			cl.clearContent();
			//log(0, 'total:' + l.length);
			for each(var j:IDUAction in l) {
				cl.addElement(
					a.lText().getTitleForAction(j.get_displayTextId())
					, j.get_id(), true);
			}
			vc.redraw();
		}
		
		private function setVisibility(target:DisplayObject, a:Boolean):void {
			if (!target) {return;}target.visible = a;
		}
		
		private function configureVC():void {
			vc = new VCChat();
			var st:Stage = a.get_mainScreen().get_displayObject().stage;
			vc.construct(
				a.lText().get_TEXT(Text.ID_TEXT_LABEL_WND_TITLE_CHAT)
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
		}
		
		private function el_channel (target:VCChatChannelsListElement, eventType:String):void {
			
			switch (eventType) {
			
			case VCChatChannelsListElement.EVENT_ELEMENT_SELECTED:
				var sm:JDM = JDM.getInstance(); sm.ss(0, target.get_id());
				selectGroup(target.get_id());
				e.listen(ID_E_ACTION_SELECTED, sm);
				sm.freeInstance();
				break;
			
			}
		}
		
		private function selectGroup(name:String):void {
		}
		
		
		//{ ======= private 
		private var vc:VCChat;
		// contacts list
		private var cl:VCChatChannelsList;	
		
		private var clientUserName:String;
		//} ======= END OF private
		
		
		
		//{ ======= id
		public static const ID_A_DISPLAY_ACTIONS_LIST:String = NAME + '>ID_A_DISPLAY_ACTIONS_LIST';
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
		 * String:group name
		 */
		public static const ID_E_ACTION_SELECTED:String = NAME + '>ID_E_ACTION_SELECTED';
		//} ======= END OF id
		
		
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_REGISTER_SINGLETON_VC
				,ID_A_SET_VISIBILITY
				,ID_A_SET_WINDOW_XYWH
				,ID_A_SET_REQUIRED_DATA
				,ID_A_RUN_SELF_TEST
				,ID_A_DISPLAY_ACTIONS_LIST
			];
		}
		
		public static const NAME:String = 'VCMActions';
		
		
		
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
