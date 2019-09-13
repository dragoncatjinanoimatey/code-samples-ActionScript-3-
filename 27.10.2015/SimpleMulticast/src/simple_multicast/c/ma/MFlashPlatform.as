// Project SimpleMulticast
package simple_multicast.c.ma {
	
	//{ ======= import
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import simple_multicast.Application;
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
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
			
			}
		}
		
		private function ev_FULLSCREEN(e:Event):void {
			a.get_ae().listen((a.get_mainScreen().get_displayObject().stage.displayState == StageDisplayState.NORMAL)?ID_E_NORMALSCREEN:ID_E_FULLSCREEN, null);
		}
		
		//{ ======= actions
		public static const ID_A_TOGGLE_FULLSCREEN:String=NAME+'ID_A_TOGGLE_FULLSCREEN';
		//} ======= END OF actions
		
		//{ ======= events
		public static const ID_E_FULLSCREEN:String = NAME+"ID_E_FULLSCREEN";
		public static const ID_E_NORMALSCREEN:String = NAME + "ID_E_NORMALSCREEN";
		//} ======= END OF events
		
		
		
		public static const NAME:String = 'MFlashPlatform';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_TOGGLE_FULLSCREEN
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