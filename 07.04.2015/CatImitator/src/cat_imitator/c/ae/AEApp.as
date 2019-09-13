// Project CatImitator
package cat_imitator.c.ae {
	
	//{ ======= import
	import cat_imitator.Application;
	//} ======= END OF import
	
	
	/**
	 * Abstract Agent Environment
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * 
	 */
	public class AEApp extends AE {
		
		//{ ======= CONSTRUCTOR
		
		function AEApp () {
			super(NAME);
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_appRef():Application {return appRef;}
		public function set_appRef(a:Application):void {appRef = a;}
		private var appRef:Application;
		
		public static const NAME:String ='AEApp';
		
	}
}