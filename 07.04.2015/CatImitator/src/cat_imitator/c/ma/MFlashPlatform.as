// Project CatImitator
package cat_imitator.c.ma {
	
	//{ ======= import
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import cat_imitator.Application;
	import cat_imitator.c.ae.AEApp;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDSM;
	//} ======= END OF import
	
	
	/**
	 * provides access to specific non-essential flash platform functionality
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class MFlashPlatform extends AM {
		
		//{ ======= CONSTRUCTOR
		
		function MFlashPlatform (app:Application) {
			super(NAME);
			a = app;
			
			a.get_mainScreen().get_displayObject().stage.addEventListener(Event.FULLSCREEN, ev_FULLSCREEN);
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			switch (eventType) {
			
			case ID_A_TOGGLE_FULLSCREEN:
				var s:Stage=a.get_mainScreen().get_displayObject().stage;
				if (!s) {log(3, 'ID_A_TOGGLE_FULLSCREEN>stage is null',1);break;}
				try {
					s.displayState = ((s.displayState == StageDisplayState.NORMAL)?StageDisplayState.FULL_SCREEN:StageDisplayState.NORMAL);
				} catch (e:Error) {}
				break;
			case ID_A_LOAD_FILE:
				loadJsonFile();
				break;
			
			}
		}
		
		private function ev_FULLSCREEN(e:Event):void {
			a.get_ae().listen((a.get_mainScreen().get_displayObject().stage.displayState == StageDisplayState.NORMAL)?ID_E_NORMALSCREEN:ID_E_FULLSCREEN, null);
		}
		
		private function loadJsonFile():void {
			log(LOGGER.C_NET, 'Load file>select file with app DB data');
			var fr:FileReference=new FileReference();
			fr.addEventListener(Event.SELECT, function(e:Object):void {
				log(LOGGER.C_NET, 'Load file>Loading');
				fr.load();
			});
			fr.addEventListener(Event.CANCEL, function(e:Object):void {log(LOGGER.C_NET,'cancel button pressed');});
			fr.addEventListener(Event.COMPLETE, function(e:Object):void {
					log(5, 'Load file>Loaded');
					var m:JDSM = JDSM.getInstance();
					m.set_stringV(0, fr.data.toString());
					get_envRef().listen(ID_E_APP_DATA_LOADED, m);
					m.freeInstance();
				}
			);
			fr.browse([new FileFilter('json', '*.json')]);	
		}
		
		
		//{ ======= actions
		public static const ID_A_LOAD_FILE:String=NAME+'ID_A_LOAD_FILE';
		public static const ID_A_TOGGLE_FULLSCREEN:String=NAME+'ID_A_TOGGLE_FULLSCREEN';
		//} ======= END OF actions
		
		//{ ======= events
		public static const ID_E_FULLSCREEN:String = NAME+"ID_E_FULLSCREEN";
		public static const ID_E_NORMALSCREEN:String = NAME + "ID_E_NORMALSCREEN";
		/**
		 * data IAM.String 0
		 */
		public static const ID_E_APP_DATA_LOADED:String = NAME+"ID_E_APP_DATA_LOADED";
		//} ======= END OF events
		
		private function get e():AEApp {return get_envRef() as AEApp;}
		private var a:Application;
		
		public static const NAME:String = 'MFlashPlatform';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_LOAD_FILE
				,ID_A_TOGGLE_FULLSCREEN
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
			LOG(c,'flash platform:>'+m,l);
		}
		
	}
}