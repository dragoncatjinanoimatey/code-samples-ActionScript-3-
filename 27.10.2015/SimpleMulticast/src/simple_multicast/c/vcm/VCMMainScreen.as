// Project SimpleMulticast
package simple_multicast.c.vcm {
	
	//{ ======= import
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.c.ma.MFlashPlatform;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import simple_multicast.APP;
	import simple_multicast.Application;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.media.Text;
	import simple_multicast.v.VCMainScreen;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	/**
	 * display manager - controlls main interface
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCMMainScreen extends AVCM {
		
		//{ ======= CONSTRUCTOR
		
		function VCMMainScreen (app:Application) {
			super(NAME);
			a=app;
		}
		//} ======= END OF CONSTRUCTOR
		
		//{ ======= ======= controll
		
		public override function listen(eventType:String, details:IAM):void {
			switch (eventType) {
			
			case ID_A_REGISTER_SINGLETON_VC:
				vc=(details as JDM).go(0) as VCMainScreen;
				configureVC();
				break;
			case ID_A_POSITION_COMPONENTS:
				vc.positionComponents();
				break;
				
			case ID_A_SET_MAIN_SCREEN_VISIBILITY:
				vc.get_displayObject().visible = (details as JDM).gb(0);
				break;
				
			case ID_A_DISPLAY_INFO_MESSAGE:
				vc.displayText((details as JDM).gs(0));
				break;
			case ID_A_DISPLAY_ERROR_FAILED_TO_SEND:
				vc.displayText('ошибка:' + a.lText().get_TEXT(Text.ID_TEXT_ERROR_FAILED_TO_SEND));
				var sm:JDM = JDM.getInstance();
				sm.si(0, 0);
				e.listen(VCMChat.ID_A_SET_VISIBILITY, sm);
				sm.freeInstance();
				break;
				
			case ID_A_DISPLAY_ERROR_MESSAGE:
				vc.displayText("ошибка:"+(details as JDM).gs(0));
				break;
			case ID_A_ADD_ACTION_BUTTON:
				vc.addActionButton((details as JDM).gi(0),(details as JDM).gs(0));
				break;
			case ID_A_REMOVE_ACTION_BUTTON:
				vc.removeActionButton((details as JDM).gi(0));
				break;
			
				
			}
		}
		
		private function setVisibility(target:DisplayObject, a:Boolean):void {
			if (!target) {return;}target.visible = a;
		}
		
		private function configureVC():void {
			vc.orderLayers();
			vc.setListener(el_vc);
			
			if (!vc.get_displayObject().stage) {vc.get_displayObject().stage.addEventListener(Event.ADDED_TO_STAGE, el_addedToStage);} else {el_addedToStage();};
			
		}
		private function el_addedToStage(e:Event = null):void {
			vc.get_displayObject().stage.removeEventListener(Event.ADDED_TO_STAGE, el_addedToStage);
		}
		
		 
		
		private function el_vc (target:VCMainScreen, eventType:String, details:Object=null):void {
			switch (eventType) {
			
			case VCMainScreen.ID_E_B_ACTION:
				var d:JDM = JDM.getInstance();
				d.si(0, details as int);
				e.listen(ID_E_ACTION_SELECTED, d); d.freeInstance();
				break;
			
			}
		}
		//} ======= ======= END OF controll
		
		
		//{ ======= private 
		private var currentMoodText:String='';
		private var currentReactionText:String='';
		
		private var vc:VCMainScreen;
		//} ======= END OF private
		
		
		//{ ======= ======= id
		/**
		 * data:VCMainScreen
		 */
		public static const ID_A_REGISTER_SINGLETON_VC:String = NAME + '>ID_A_REGISTER_SINGLETON_VC';
		/**
		 * data:Boolean
		 */
		public static const ID_A_SET_MAIN_SCREEN_VISIBILITY:String=NAME+'>ID_A_SET_MAIN_SCREEN_VISIBILITY';
		public static const ID_A_POSITION_COMPONENTS:String=NAME+'>ID_A_POSITION_COMPONENTS';
		public static const ID_A_DISPLAY_INFO_MESSAGE:String=NAME+'>ID_A_DISPLAY_INFO_MESSAGE';
		public static const ID_A_DISPLAY_ERROR_MESSAGE:String = NAME + '>ID_A_DISPLAY_ERROR_MESSAGE';
		public static const ID_A_DISPLAY_ERROR_FAILED_TO_SEND:String = NAME + '>ID_A_DISPLAY_ERROR_FAILED_TO_SEND';
		/**
		 * String:bTitle; int:bId;
		 */
		public static const ID_A_ADD_ACTION_BUTTON:String=NAME+'>ID_A_ADD_ACTION_BUTTON';
		/**
		 * int:bId;
		 */
		public static const ID_A_REMOVE_ACTION_BUTTON:String=NAME+'>ID_A_REMOVE_ACTION_BUTTON';
		
		//{ ======= events
		
		/**
		 * int:id;
		 */
		public static const ID_E_ACTION_SELECTED:String=NAME+'>ID_E_ACTION_SELECTED';
		/**
		 * {visibility:Boolean}
		 */
		public static const ID_E_UI_VISIBILITY:String = NAME+'>ID_E_UI_VISIBILITY';
		
		
		//} ======= END OF events
		
		//} ======= ======= END OF id
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_REGISTER_SINGLETON_VC
				,ID_A_SET_MAIN_SCREEN_VISIBILITY
				,ID_A_POSITION_COMPONENTS
				,ID_A_DISPLAY_ERROR_MESSAGE
				,ID_A_DISPLAY_ERROR_FAILED_TO_SEND
				,ID_A_DISPLAY_INFO_MESSAGE
				,ID_A_ADD_ACTION_BUTTON
				,ID_A_REMOVE_ACTION_BUTTON
				
			];
		}
		
		public static const NAME:String = 'VCMMainScreen';
		
		
		
		
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