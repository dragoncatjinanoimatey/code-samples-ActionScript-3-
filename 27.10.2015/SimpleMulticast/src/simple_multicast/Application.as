// Project SimpleMulticast
package simple_multicast {
	
	//{ ======= import
	import simple_multicast.c.vcm.VCMMainScreen;
	import simple_multicast.main.SimpleMulticast;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import simple_multicast.c.system.AEStartup;
	import simple_multicast.c.system.APrepareSystem;
	import simple_multicast.d.a.DUApp;
	import simple_multicast.data.ApplicationConstants;
	import simple_multicast.main.SimpleMulticast;
	import simple_multicast.media.Text;
	import simple_multicast.n.connectors.NetConnector;
	import simple_multicast.v.VCChat;
	import simple_multicast.v.VCMainScreen;
	import com.junkbyte.console.Console;
	import com.junkbyte.console.ConsoleChannel;
	import com.junkbyte.console.ConsoleConfig;
	import flash.display.DisplayObjectContainer;
	
	import simple_multicast.c.ae.AE;
	import simple_multicast.c.ae.AEApp;
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
			ac = appContainer as SimpleMulticast;
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
			prepareVCChat();
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
		private var ac:SimpleMulticast;
		
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
		private var appData:DUApp = new DUApp();
		//} ======= END OF Data
		
		//{ ======= VC VCCha
		private function prepareVCChat():void {
			ch = new VCChat();
		}
		//} ======= VC v
		
		public function getNetConnector():NetConnector {return nc;}
		public function setNetConnector(a:NetConnector):void {nc=a;}
		private var nc:NetConnector;
		
		
		//{ ======= VC MainScreen
		private function prepareVCMainScreen():void {
			ms = new VCMainScreen(ac.stage.stageWidth/2, ac.stage.stageHeight*.75);
			ac.addChild(ms.get_displayObject());
		}
		public function get_mainScreen():VCMainScreen {return ms;}
		private var ms:VCMainScreen;
		public function get_Chat():VCChat {return ch;}
		public function set_Chat(a:VCChat):void {ch = a;}
		private var ch:VCChat;
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
		private static const APP_NAME:String = "SimpleMulticast";
		
		
		
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
			LOG(c,"Application>"+m,l);
		}
		
		
	}
}