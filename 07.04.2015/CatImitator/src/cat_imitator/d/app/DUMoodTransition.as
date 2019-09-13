// Project CatImitator
package  cat_imitator.d.app {
	
	//{ ======= import
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUMoodTransition {
		
		//{ ======= CONSTRUCTOR
		public function DUMoodTransition (actionId:int, currentMoodId:int, nextMoodId:int) {
		
			this.actionId = actionId;
			this.currentMoodId = currentMoodId;
			this.nextMoodId = nextMoodId;
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_actionId():int {return actionId;}
		public function set_actionId(a:int):void {actionId = a;}
		public function get_currentMoodId():int {return currentMoodId;}
		public function set_currentMoodId(a:int):void {currentMoodId = a;}
		public function get_nextMoodId():int {return nextMoodId;}
		public function set_nextMoodId(a:int):void {nextMoodId = a;}
		
		private var actionId:int;
		private var currentMoodId:int;
		private var nextMoodId:int;
		
	}
}