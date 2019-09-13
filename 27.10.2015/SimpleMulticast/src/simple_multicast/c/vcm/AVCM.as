// Project SimpleMulticast
package simple_multicast.c.vcm {
	
	//{ ======= import
	import simple_multicast.Application;
	import simple_multicast.c.ae.AEApp;
	import simple_multicast.d.a.DUApp;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgent;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	//} ======= END OF import
	
	
	/**
	 * Abstract Manager
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class AVCM extends AbstractAgent {
		
		//{ ======= CONSTRUCTOR
		
		function AVCM (name:String) {
			super(name);
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get ad():DUApp { return a.get_appData(); }
		
		public function get e():AbstractAgentEnvironment {return get_envRef();}
		
		public function set a(a:Application):void {if (_a) { return;}_a = a;}
		public function get a():Application {
			if (_a == null) {_a = AEApp(get_envRef()).get_appRef();}
			return _a;
		}
		private var _a:Application;
		
	}
}