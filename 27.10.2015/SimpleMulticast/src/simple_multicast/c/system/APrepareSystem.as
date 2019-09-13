// Project SimpleMulticast
package simple_multicast.c.system {
	
	//{ ======= import
	import simple_multicast.c.ma.MFlashPlatform;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import simple_multicast.c.ma.MNetGroup;
	import simple_multicast.c.ma.MServer;
	import simple_multicast.c.vcm.VCMChat;
	import simple_multicast.d.a.DUApp;
	import org.aswing.AsWingManager;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgent;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	import simple_multicast.Application;
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.c.ma.MApp;
	import simple_multicast.c.vcm.VCMMainScreen;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.v.VCMainScreen;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	
	/**
	 * Abstract Manager
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class APrepareSystem extends AbstractAgent {
		
		//{ ======= CONSTRUCTOR
		function APrepareSystem (/*listener:Function*/) {
			super(NAME);
		}
		//} ======= END OF CONSTRUCTOR
		
		public override function listen(eventType:String, details:IAM):void {
			switch (eventType) {
			
			case ID_A_START:
				e.listen(ID_A_PREPARE_LOGGING, null);
				e.listen(ID_A_PREPARE_DATA, null);
				e.listen(ID_A_PREPARE_VIEW, null);
				break;
				
			case ID_A_PREPARE_LOGGING:
				break;
				
			case ID_E_PREPARED_VIEW:
				e.listen(ID_A_PREPARE_AGENTS, null);
				break;
				
			case ID_E_PREPARED_AGENTS:
				//prepare view
				var m_:JDM = JDM.getInstance();
				m_.so(0, e.a.get_mainScreen());
				e.a.get_ae().listen(VCMMainScreen.ID_A_REGISTER_SINGLETON_VC, m_);
				
				m_.so(0, e.a.get_Chat());
				e.a.get_ae().listen(VCMChat.ID_A_REGISTER_SINGLETON_VC, null);
				m_.freeInstance();
				
				
				//end
				e.a.get_ae().listen(MApp.ID_A_STARTUP, null);
				e.a.get_ae().unsubscribeALL(this);
			break;
			
			case ID_A_PREPARE_DATA:
				break;
				
				
			case ID_A_PREPARE_AGENTS:
				e.a.set_ae(new AEApp());
				
				e.a.get_ae().placeAgent(new MApp(e.a));
				e.a.get_ae().placeAgent(new MFlashPlatform(e.a));
				e.a.get_ae().placeAgent(new VCMMainScreen(e.a));
				e.a.get_ae().placeAgent(new VCMChat(e.a));
				e.a.get_ae().placeAgent(new MServer());
				e.a.get_ae().placeAgent(new MNetGroup());
				
				
				listen(ID_E_PREPARED_AGENTS, null);
				break;
				
			case ID_A_PREPARE_VIEW:
				var scr:VCMainScreen = e.a.get_mainScreen();
				// prepare main screen
				AsWingManager.setRoot(scr.get_interfaceLayer());
				AsWingManager.initAsStandard(scr.get_interfaceLayer(), false);
				
				listen(ID_E_PREPARED_VIEW, null);
				break;
				
				
			}
		}
		
		
		protected override function placed(env:AbstractAgentEnvironment):void {
			e = env as AEStartup;
			e.listen(ID_A_START, null);
		}
		
		
		private var e:AEStartup;
		
		//{ ======= ======= ACTIONS
		private static const ID_A_START:String = NAME + "ID_A_START";
		private static const ID_A_PREPARE_LOGGING:String = NAME+"ID_A_PREPARE_LOGGING";
		private static const ID_A_PREPARE_DATA:String = NAME+"ID_A_PREPARE_DATA";
		private static const ID_A_PREPARE_AGENTS:String = NAME+"ID_A_PREPARE_AGENTS";
		private static const ID_A_PREPARE_VIEW:String = NAME+"ID_A_PREPARE_VIEW";
		//} ======= ======= END OF ACTIONS
		
		//{ ======= ======= EVENTS
		/**
		 * view prepared
		 */
		private static const ID_E_PREPARED_VIEW:String = NAME+"ID_E_PREPARED_VIEW";
		private static const ID_E_PREPARED_AGENTS:String = NAME+"ID_E_PREPARED_AGENTS";
		//} ======= ======= END OF EVENTS
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_START
				,ID_A_PREPARE_LOGGING
				,ID_A_PREPARE_DATA
				,ID_A_PREPARE_AGENTS
				,ID_A_PREPARE_VIEW
				,ID_E_PREPARED_VIEW
				,ID_E_PREPARED_AGENTS
			];
		}
		
		public static const NAME:String="APrepareSystem";
		
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
		private static function log_(c:uint, m:String, l:uint=0):void {
			LOG(c,'startup>'+m,l);
		}
		
	}
}