// Project CatImitator
package cat_imitator.c.system {
	
	//{ ======= import
	import cat_imitator.c.ma.app.animal.AnimalCat;
	import cat_imitator.c.ma.MFlashPlatform;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import cat_imitator.d.a.DUApp;
	import org.aswing.AsWingManager;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgent;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	import cat_imitator.Application;
	import cat_imitator.c.ae.AEApp;
	import cat_imitator.c.ma.MApp;
	import cat_imitator.c.vcm.VCMMainScreen;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import cat_imitator.v.VCMainScreen;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDAM;
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
				var m_:JDAM = JDAM.getInstance();
				m_.set_objectV(0, e.get_a().get_mainScreen());
				e.get_a().get_ae().listen(VCMMainScreen.ID_A_REGISTER_SINGLETON_VC, m_);
				m_.freeInstance();
				
				//end
				e.get_a().get_ae().listen(MApp.ID_A_STARTUP, null);
				e.get_a().get_ae().unsubscribeALL(this);
			break;
			
			case ID_A_PREPARE_DATA:
				break;
				
				
			case ID_A_PREPARE_AGENTS:
				e.get_a().set_ae(new AEApp());
				//app platform
				e.get_a().get_ae().placeAgent(new MApp(e.get_a()));
				e.get_a().get_ae().placeAgent(new MFlashPlatform(e.get_a()));
				e.get_a().get_ae().placeAgent(new VCMMainScreen(e.get_a()));
				
				e.get_a().get_ae().placeAgent(new AnimalCat(e.get_a()));
				
				
				listen(ID_E_PREPARED_AGENTS, null);
				break;
				
			case ID_A_PREPARE_VIEW:
				var scr:VCMainScreen = e.get_a().get_mainScreen();
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
			7-"AF"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log_(c:uint, m:String, l:uint=0):void {
			LOG(c,'startup:> '+m,l);
		}
		
	}
}