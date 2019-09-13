// Project CatImitator
package cat_imitator.c.ma.app.animal {
	
	//{ ======= import
	import cat_imitator.Application;
	import cat_imitator.c.ae.AEApp;
	import cat_imitator.c.ma.AM;
	import cat_imitator.c.vcm.VCMMainScreen;
	import cat_imitator.d.a.ARO;
	import cat_imitator.d.a.DUApp;
	import cat_imitator.d.app.DUMood;
	import cat_imitator.d.app.DUReaction;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import tk.jinanoimateydragoncat.utils.flow.agents.AbstractAgentEnvironment;
	import tk.jinanoimateydragoncat.utils.flow.data.IAM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDSM;
	import tk.jinanoimateydragoncat.utils.flow.data.JDSM;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class AnimalCat extends AM {
		
		//{ ======= CONSTRUCTOR
		
		function AnimalCat (app:Application) {
			super(NAME);
			a=app;
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public override function listen(eventType:String, details:IAM):void {
			var r:ARO;
			switch (eventType) {
			
			case VCMMainScreen.ID_E_ACTION_SELECTED:
				var aid:int = (details as JDSM).get_intV(0);
				var reaction:DUReaction = a.get_appData().getReaction(aid, currentMoodId);
				
				if (reaction != null) {
					
					var m_:JDSM = JDSM.getInstance();
					
					//display reaction
					m_.set_stringV(0, reaction.get_text());
					get_envRef().listen(VCMMainScreen.ID_A_SET_CURRENT_REACTION, m_);
					
					//if mood needs to be changed, new will be found for current actionId and moodId
					var nextMood:DUMood = a.get_appData().getNextMood(aid, currentMoodId);
					if (nextMood != null) {
						//change current mood id
						currentMoodId = nextMood.get_id();
						m_.set_stringV(0, nextMood.get_label());
						get_envRef().listen(VCMMainScreen.ID_A_SET_CURRENT_MOOD, m_);
					}
					m_.freeInstance();
					
					//mood not found. do nothing
					break;
					
				} else {
					log(LOGGER.C_DS, 'reaction with id='+aid+' not found',1);
				}
				break;
				
				
			case ID_A_SET_CURRENT_MOOD:
					//change current mood id
					currentMoodId = (details as JDSM).get_intV(0);
					//reflect to view
					var m_:JDSM = JDSM.getInstance();
					m_.set_stringV(0, (details as JDSM).get_stringV(0));
					get_envRef().listen(VCMMainScreen.ID_A_SET_CURRENT_MOOD, m_);m_.freeInstance();
					break;
				
			}
		}
		
		
		//{ ======= private 
		private var currentMoodId:int;
		
		private function get e():AEApp {return get_envRef() as AEApp;}
		private var a:Application;
		//} ======= END OF private
		
		
		//{ ======= id
		public static const ID_A_SET_CURRENT_MOOD:String = 'ID_A_SET_CURRENT_MOOD';
		//} ======= END OF id
		
		//{ ======= events
		public static const ID_E_DISPLAY_REACTION:String = NAME + "ID_E_DISPLAY_REACTION";
		//} ======= END OF events
		
		public static const NAME:String = 'AnimalCat';
		
		public override function autoSubscribeEvents(envName:String):Array {
			return [
				VCMMainScreen.ID_E_ACTION_SELECTED
				,ID_A_SET_CURRENT_MOOD
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
			7-"AF"
		* @param	m msg
		* @param	l level
			0-INFO
			1-WARNING
			2-ERROR
		*/
		private static function log(c:uint, m:String, l:uint=0):void {
			LOG(c,'AnimalCat:>'+m,l);
		}
		
	}
}