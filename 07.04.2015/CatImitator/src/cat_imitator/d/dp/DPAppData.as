// Project CatImitator
package cat_imitator.d.dp {
	
	//{ ======= import
	import cat_imitator.d.a.DUApp;
	import cat_imitator.d.app.DUAction;
	import cat_imitator.d.app.DUMood;
	import cat_imitator.d.app.DUMoodTransition;
	import cat_imitator.d.app.DUReaction;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class DPAppData {
		
		/**
		 * 
		 * @param	jsonString
		 * @return null if error
		 */
		public static function processJSON(jsonString:String):DUApp {
			
			try {
				
				var o:Object = JSON.parse(jsonString);
				
				if (o == null) {
					log(LOGGER.C_DS, 'failed to parse json file. check file and try again', LOGGER.LEVEL_ERROR);
					return null;
				}
				
				var i:Object;
				
				var list_action:Vector.<DUAction> = new Vector.<DUAction>;
				for each(i in o['action']) {
					list_action.push(new DUAction(parseInt(i['id']), i['label']));
				}
				
				var list_mood:Vector.<DUMood> = new Vector.<DUMood>;
				for each(i in o['mood']) {
					list_mood.push(new DUMood(parseInt(i['id']), i['label']));
				}
				
				var list_moodTransition:Vector.<DUMoodTransition> = new Vector.<DUMoodTransition>;
				for each(i in o['moodTransition']) {
					list_moodTransition.push(new DUMoodTransition(parseInt(i['actionId']), parseInt(i['currentId']), parseInt(i['nextId'])));
				}
				
				var list_reaction:Vector.<DUReaction> = new Vector.<DUReaction>;
				for each(i in o['reaction']) {
					list_reaction.push(new DUReaction(parseInt(i['moodId']), parseInt(i['actionId']), i['text']));
				}
			} catch (e:Error) {
				log(LOGGER.C_DS, 'failed to parse json file. check file and try again', LOGGER.LEVEL_ERROR);
				return null;
			}
			
			return new DUApp(
				list_reaction
				,list_action
				,list_mood
				,list_moodTransition
				,parseInt(o['defaultMoodId'])
			);
			
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
			7-"AF"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log(c:uint, m:String, l:uint=0):void {
			LOG(LOGGER.C_DS,m,l);
		}
		
		
	}
}