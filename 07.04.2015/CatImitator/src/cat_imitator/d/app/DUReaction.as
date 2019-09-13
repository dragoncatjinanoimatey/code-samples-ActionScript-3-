// Project CatImitator
package  cat_imitator.d.app {
	
	//{ ======= import
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUReaction {
		
		//{ ======= CONSTRUCTOR
		public function DUReaction (moodId:int, actionId:int, text:String) {
			this.moodId = moodId;
			this.actionId = actionId;
			this.text = text;
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_moodId():int {return moodId;}
		public function get_actionId():int {return actionId;}
		public function get_text():String {return text;}
		
		private var moodId:int;
		private var actionId:int;
		private var text:String;		
	}
}