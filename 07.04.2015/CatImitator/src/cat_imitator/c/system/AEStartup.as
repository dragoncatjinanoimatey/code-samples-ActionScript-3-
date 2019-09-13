// Project CatImitator
package cat_imitator.c.system {
	
	//{ ======= import
	import cat_imitator.Application;
	import cat_imitator.c.ae.AE;
	//} ======= END OF import
	
	
	/**
	 * Abstract Agent Environment
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class AEStartup extends AE {
		
		//{ ======= CONSTRUCTOR
		
		function AEStartup (a:Application) {
			this.a = a;
			super(NAME);
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_a():Application {return a;}
		public function set_a(a:Application):void {a = a;}
		private var a:Application;
		
		public static const NAME:String ='AEStartup';
		
	}
}