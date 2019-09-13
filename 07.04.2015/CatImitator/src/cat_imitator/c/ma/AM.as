// Project CatImitator
package cat_imitator.c.ma {
	
	//{ ======= import
	import cat_imitator.Application;
	import cat_imitator.c.ae.AEApp;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgent;
	import cat_imitator.LOG;
	//} ======= END OF import
	
	
	/**
	 * Abstract Manager
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class AM extends AbstractAgent {
		
		//{ ======= CONSTRUCTOR
		function AM (name:String) {
			super(name);
		}
		//} ======= END OF CONSTRUCTOR
		
		public function getAppRef():Application {
			return AEApp(get_envRef()).get_appRef();
		}
		
	}
}