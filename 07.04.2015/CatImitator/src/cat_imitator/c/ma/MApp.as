// Project CatImitator
package cat_imitator.c.ma {
	
	//{ ======= import
	import cat_imitator.c.ma.app.animal.AnimalCat;
	import cat_imitator.d.a.DUApp;
	import cat_imitator.d.dp.DPAppData;
	import cat_imitator.media.Text;
	import flash.utils.ByteArray;
	import cat_imitator.APP;
	import cat_imitator.Application;
	import cat_imitator.c.ae.AEApp;
	import cat_imitator.c.vcm.VCMMainScreen;
	import cat_imitator.d.a.ARO;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDSM;
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
			var r:ARO;
			switch (eventType) {
			
			case ID_A_STARTUP:
				//Entry point
				
				a.get_mainScreen().repositionComponents();
				listen(ID_A_PREPARE_INTERFACE, null);
				break;
				
			case MFlashPlatform.ID_E_APP_DATA_LOADED:
				var ad:DUApp = DPAppData.processJSON((details as JDSM).get_stringV(0));
				if (ad == null) {
					var d:JDSM = JDSM.getInstance();
					d.set_stringV(0, APP.lText().get_TEXT(Text.ID_TEXT_MSG_ERR_INVALID_JSON));
					get_envRef().listen(VCMMainScreen.ID_A_DISPLAY_ERROR_MESSAGE, d); d.freeInstance();
					break;
				}
				a.set_appData(ad);
				log(LOGGER.C_DS, 'json file loaded and parsed successfully');
				get_envRef().listen(VCMMainScreen.ID_A_HIDE_LOAD_DB_BUTTON, null);
				
				var dd:JDAM = JDAM.getInstance();
				dd.set_objectV(0, a.get_appData().get_list_action());
				get_envRef().listen(VCMMainScreen.ID_A_DISPLAY_ACTIONS, dd); //dd.freeInstance
				
				dd.set_intV(0, a.get_appData().getDefaultMood().get_id());
				dd.set_stringV(0, a.get_appData().getDefaultMood().get_label());
				get_envRef().listen(AnimalCat.ID_A_SET_CURRENT_MOOD, dd); dd.freeInstance();
				
				
				break;
				
			}
		}
		
		
		//{ ======= private 
		private function get e():AEApp {return get_envRef() as AEApp;}
		private var a:Application;
		//} ======= END OF private
		
		
		//{ ======= id
		public static const ID_A_STARTUP:String = NAME + "ID_A_STARTUP";
		public static const ID_A_PREPARE_INTERFACE:String = NAME + "ID_A_PREPARE_INTERFACE";
		//} ======= END OF id
		
		//{ ======= events
		//} ======= END OF events
		
		public static const NAME:String = 'MApp';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_STARTUP
				,ID_A_PREPARE_INTERFACE
				,MFlashPlatform.ID_E_APP_DATA_LOADED
				
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
			7-"AF"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log(c:uint, m:String, l:uint=0):void {
			LOG(c,'MApp:>'+m,l);
		}
		
	}
}