// Project CatImitator
package  cat_imitator.d.app {
	
	//{ ======= import
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUMood {
		
		//{ ======= CONSTRUCTOR
		public function DUMood (id:int, label:String) {
			this.id = id;
			this.label = label;
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_id():int {return id;}
		public function get_label():String {return label;}
		
		
		private var id:int;
		private var label:String;
		
	}
}