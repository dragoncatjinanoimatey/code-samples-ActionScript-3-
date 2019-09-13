// Project CatImitator
package cat_imitator.c.vcm {
	
	//{ ======= import
	import cat_imitator.c.ae.AEApp;
	import cat_imitator.c.ma.MFlashPlatform;
	import cat_imitator.d.app.DUAction;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import cat_imitator.APP;
	import cat_imitator.Application;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import cat_imitator.media.Text;
	import cat_imitator.v.VCMainScreen;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDSM;
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
				vc=(details as JDAM).get_objectV(0) as VCMainScreen;
				configureVC();
				break;
			case ID_A_POSITION_COMPONENTS:
				vc.positionComponents();
				break;
				
			case ID_A_SET_MAIN_SCREEN_VISIBILITY:
				vc.get_displayObject().visible = (details as JDSM).get_booleanV(0);
				break;
				
			case ID_A_HIDE_LOAD_DB_BUTTON:
				vc.hideLoadButton();
				break;
			
			case ID_A_DISPLAY_ERROR_MESSAGE:
				vc.displayText((details as JDSM).get_stringV(0));
				break;
			
			case ID_A_SET_CURRENT_MOOD:
				currentMoodText = (details as JDSM).get_stringV(0);
				vc.displayText('текущее настроение:\n'+currentMoodText+'\n\nреакция:\n'+currentReactionText);
				break;
				
			case ID_A_SET_CURRENT_REACTION:
				currentReactionText = (details as JDSM).get_stringV(0);
				vc.displayText('текущее настроение:\n'+currentMoodText+'\n\nреакция:\n'+currentReactionText);
				break;
				
			case ID_A_DISPLAY_ACTIONS:
				var al:Vector.<DUAction> = ((details as JDAM).get_objectV(0) as Vector.<DUAction>);
				
				for each(var i:DUAction in al) {
					vc.addActionButton(i);
				}
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
			
			case VCMainScreen.ID_E_B_LOAD_APP_DB:
				if (a.get_appData()==null) {
					get_envRef().listen(MFlashPlatform.ID_A_LOAD_FILE, null);
				}
				break;
				
			case VCMainScreen.ID_E_B_ACTION:
				var d:JDSM = JDSM.getInstance();
				d.set_intV(0, details as int);
				get_envRef().listen(ID_E_ACTION_SELECTED, d); d.freeInstance();
				break;
			
			}
		}
		//} ======= ======= END OF controll
		
		
		//{ ======= private 
		private var currentMoodText:String='';
		private var currentReactionText:String='';
		
		private var a:Application;
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
		public static const ID_A_DISPLAY_ERROR_MESSAGE:String=NAME+'>ID_A_DISPLAY_ERROR_MESSAGE';
		public static const ID_A_SET_CURRENT_MOOD:String=NAME+'>ID_A_SET_CURRENT_MOOD';
		public static const ID_A_SET_CURRENT_REACTION:String=NAME+'>ID_A_SET_CURRENT_REACTION';
		public static const ID_A_HIDE_LOAD_DB_BUTTON:String=NAME+'>ID_A_HIDE_LOAD_DB_BUTTON';
		/**
		 * AIM.Vector.<DUAction>
		 */
		public static const ID_A_DISPLAY_ACTIONS:String=NAME+'>ID_A_DISPLAY_ACTIONS';

		//{ ======= events
		
		/**
		 * {visibility:Boolean}
		 */
		public static const ID_E_UI_VISIBILITY:String = NAME+'>ID_E_UI_VISIBILITY';
		
		public static const ID_E_ACTION_SELECTED:String = NAME+'>ID_E_ACTION_SELECTED';
		
		//} ======= END OF events
		
		//} ======= ======= END OF id
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_REGISTER_SINGLETON_VC
				,ID_A_SET_MAIN_SCREEN_VISIBILITY
				,ID_A_POSITION_COMPONENTS
				,ID_A_DISPLAY_ERROR_MESSAGE
				,ID_A_SET_CURRENT_REACTION
				,ID_A_SET_CURRENT_MOOD
				,ID_A_DISPLAY_ACTIONS
				,ID_A_HIDE_LOAD_DB_BUTTON
				
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
			7-"AF"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log(c:uint, m:String, l:uint=0):void {
			LOG(LOGGER.C_V,m,l);
		}
		
		
	}
}