// Project SimpleMulticast
package simple_multicast.c.ma {
	
	//{ ======= import
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.cfg.SP;
	import simple_multicast.LOG;
	import simple_multicast.LOGGER;
	import simple_multicast.n.connectors.NetConnector;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDM;
	//} ======= END OF import
	
	
	/**
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class MServer extends AM {
		
		//{ ======= CONSTRUCTOR
		
		function MServer () {
			super(NAME);
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			switch (eventType) {
			
			case ID_A_CLOSE_CONNECTION:
				a.setNetConnector(null);
				if (nc) { nc.destroy(); }
				//e.listen(ID_E_CONNECTION_LOST, eventType);
				break;
				
			case ID_A_SETUP_CONNECTION:
				connect();
				break;
				
			}
		}
		
		//{ ======= ID_A_SETUP_CONNECTION
		private function connect():void {
			connected=false;
			
			nc = new NetConnector;
			a.setNetConnector(nc);
			nc.constuct(el_nc);
			log(5, 'connecting to'+SP.METHOD_RTMFP_CMD,0);
			
			nc.connect(
				SP.SERVER_SETTING_CONNECTION_TIMEOUT
				,SP.METHOD_RTMFP_CMD
			);
		}
		
		private function el_nc(target:NetConnector, eventType:String, eventData:Object):void {
			switch (eventType) {
			
			case NetConnector.ID_E_SUCCESS:
				connected=true;
				e.listen(ID_E_CONNECTION_ESTABLISHED, null);
				break;
				
			case NetConnector.ID_E_CLOSED:
			case NetConnector.ID_E_ER_FAILED:
			case NetConnector.ID_E_ER_REJECTED:
			case NetConnector.ID_E_ER_TIMED_OUT:
				if (!connected) {
					connected=true;
					connect();
					break;
				}
				var sm:JDM = JDM.getInstance();
				sm.ss(0, eventType);
				e.listen(ID_E_CONNECTION_LOST, sm);
				sm.freeInstance();
				break;
			
			
			}
			//log(4, 'el_nc>'+eventType+'/'+eventData,1);
		}
		//} ======= END OF ID_A_SETUP_CONNECTION
		
		
		//{ ======= private 
		private var timeout:int;
		private var connected:Boolean;
		private var nc:NetConnector;
		
		//} ======= END OF private
		
		
		//{ ======= id
		public static const ID_A_SETUP_CONNECTION:String=NAME+'ID_A_SETUP_CONNECTION';
		public static const ID_A_CLOSE_CONNECTION:String=NAME+'ID_A_CLOSE_CONNECTION';
		//} ======= END OF id
		
		//{ ======= events
		/**
		 * data:see NetConnector events
		 */
		public static const ID_E_CONNECTION_LOST:String=NAME+'ID_E_CONNECTION_LOST';
		public static const ID_E_CONNECTION_ESTABLISHED:String=NAME+'ID_E_CONNECTION_ESTABLISHED';
		//} ======= END OF events
		
		public static const NAME:String = 'MServer';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				ID_A_SETUP_CONNECTION
				,ID_A_CLOSE_CONNECTION
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
