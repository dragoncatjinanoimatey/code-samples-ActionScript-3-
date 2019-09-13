// Project CatImitator
package cat_imitator {
	
	//{ ======= import
	import cat_imitator.main.CatImitator;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import cat_imitator.c.system.AEStartup;
	import cat_imitator.c.system.APrepareSystem;
	import cat_imitator.d.a.DUApp;
	import cat_imitator.data.ApplicationConstants;
	import cat_imitator.main.CatImitator;
	import cat_imitator.media.Text;
	import cat_imitator.v.VCMainScreen;
	import com.junkbyte.console.Console;
	import com.junkbyte.console.ConsoleChannel;
	import com.junkbyte.console.ConsoleConfig;
	import flash.display.DisplayObjectContainer;
	
	import cat_imitator.c.ae.AE;
	import cat_imitator.c.ae.AEApp;
	//} ======= END OF import
	
	
	/**
	 * Main Application Class
	 * contains refs to view objects, data storage
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class Application implements IApplication {
		
		//{ ======= CONSTRUCTOR
		function Application (appContainer:DisplayObjectContainer) {
			ac = appContainer as CatImitator;
		}
		//} ======= END OF CONSTRUCTOR
		
		/**
		 * seconds
		 * @return
		 */
		public function getCurrentTime():int {
			return getTimer()/1000;
		}
		
		
		public function run():void {
			prepareVCMainScreen();
			log(0,'starting Application name:"'+APP_NAME+'"');
			startup();
		}
		
		private function startup():void {
			log(0,APP_NAME);
			var sse:AEStartup = new AEStartup(this);
			sse.setL(log_systemStartupAgentEnv);
			sse.logMessages = true;
			var ssa:APrepareSystem = new APrepareSystem();
			sse.placeAgent(ssa);
			
		}
		private var ac:CatImitator;
		
		//{ ======= locale
		public function lText():Text {return localeText;}
		
		public function set_localeId(a:uint):void {
			//will be loaded from xml
			localeText=new Text(null);
			APP.setlText(localeText);
		}
		private var localeText:Text;
		//} ======= END OF locale		
		
		//{ ======= Agents
		/**
		 * Main Agent Environment
		 */
		public function get_ae():AEApp {return ae;}
		public function set_ae(a:AEApp):void {
			ae = a;
			ae.set_appRef(this);
			ae.logMessages=ae_logMessages;
			ae.setL(log_agentEnv);
		}
		private var ae:AEApp;
		//} ======= END OF Agents
		
		//{ ======= Data
		public function get_appData():DUApp {return appData;}
		public function set_appData(a:DUApp):void {appData = a;}
		private var appData:DUApp;
		//} ======= END OF Data
		
		//{ ======= VC MainScreen
		private function prepareVCMainScreen():void {
			ms = new VCMainScreen(ac.stage.stageWidth, ac.stage.stageHeight);
			ac.addChild(ms.get_displayObject());
		}
		public function get_mainScreen():VCMainScreen {return ms;}
		private var ms:VCMainScreen;
		//} ======= END OF VC MainScreen
		
		//{ ======= logging
		private function log_systemStartupAgentEnv(m:String, l:uint):void {
			logMessage(LOGGER.C_A, "app startup>"+m, l);
		}
		private function log_agentEnv(m:String, l:uint):void {
			logMessage(LOGGER.C_A, m, l);
		}
		
		/**
		 * @param componentID
		 * @param	c channel id
		 * @param	a message
		 * @param	b level
		 */
		public function logMessage(c:uint, a:String, b:uint=0):void {
			ac.logMessage(c, a, b);
		}
		
		
		private var ae_logMessages:Boolean=Boolean(1);
		//} ======= END OF logging
		
		public function getAppLoadedPath():String {
			return ac.loaderInfo.url.substring(0,ac.loaderInfo.url.lastIndexOf('/'));
		}
		
		/**
		 * for app's logger
		 */
		private static const APP_NAME:String = "CatImitator";
		
		
		
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
			LOG(c,"APP>"+m,l);
		}
		
		
	}
}