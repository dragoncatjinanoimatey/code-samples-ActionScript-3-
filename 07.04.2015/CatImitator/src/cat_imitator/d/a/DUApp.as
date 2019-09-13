// Project CatImitator
package cat_imitator.d.a {
	
	//{ ======= import
	import cat_imitator.d.app.DUAction;
	import cat_imitator.d.app.DUMood;
	import cat_imitator.d.app.DUMoodTransition;
	import cat_imitator.d.app.DUReaction;
	import cat_imitator.LOG;
	//} ======= END OF import
	
	
	/**
	 * contains main application data storeroom
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DUApp {
		
		//{ ======= CONSTRUCTOR
		
		public function DUApp (list_reaction:Vector.<DUReaction>, list_action:Vector.<DUAction>, list_mood:Vector.<DUMood>, list_moodTransition:Vector.<DUMoodTransition>, defaultMoodId:int) {
			this.list_reaction = list_reaction;
			this.list_action = list_action;
			this.list_mood = list_mood;
			this.list_moodTransition = list_moodTransition;
			this.defaultMoodId = defaultMoodId;
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public function getNextMood(currentActionId:int, currentMoodId:int):DUMood {
			for each(var i:DUMoodTransition in list_moodTransition) {
				if (i.get_currentMoodId() == currentMoodId && i.get_actionId() == currentActionId) {
					return getMood(i.get_nextMoodId());
				}
			}
			//not found
			return null;
		}
		
		
		public function getMood(id:int):DUMood {
			for each(var i:DUMood in list_mood) {
				if (i.get_id() == id) { return i;}
			}
			
			return null;
		}
		
		public function getDefaultMood():DUMood {
			return getMood(defaultMoodId);
		}
		
		
		public function getReaction(actionId:int, moodId:int):DUReaction {
			for each(var i:DUReaction in list_reaction) {
				if (i.get_actionId() == actionId && i.get_moodId() == moodId) {
					return i;
				}
			}
			//not found
			return null;
		}
		
		
		//public static const ID_REACTION_NONE:int=int.MAX_VALUE;
		
		public function get_list_reaction():Vector.<DUReaction> {return list_reaction;}
		public function get_list_action():Vector.<DUAction> {return list_action;}
		public function get_list_mood():Vector.<DUMood> {return list_mood;}
		public function get_list_moodTransition():Vector.<DUMoodTransition> {return list_moodTransition;}
		public function get_defaultMoodId():int {return defaultMoodId;}
		
		private var list_reaction:Vector.<DUReaction>;
		private var list_action:Vector.<DUAction>;
		private var list_mood:Vector.<DUMood>;
		private var list_moodTransition:Vector.<DUMoodTransition>;		
		private var defaultMoodId:int;		
		
	}
}