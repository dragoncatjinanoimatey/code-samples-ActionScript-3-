// Project TicTacToe
package t_t.media {
	
	//{ ===== import
	import t_t.LOG;
	//} ===== END OF import
	
	
	/**
	 * add constructor, parse XML
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class Text {
		
		//{ ======= ======= constructor
		
		public function Text(xml:XMLList):void {
			if (xml==null) {return;}
			//process provided xml - store text data then free xml
			//this.xml=xml;
			
			
		}
		//} ======= ======= END OF constructor
		
		private var xml:XMLList;
		
		//{ ======= TEXT
		public function get_TEXT_4STATS(youWon:Boolean, numMarks:int):String {
			return "Победитель: "+ ((youWon)?"Вы":"ИИ")+
			"\r\nЧисло ходов: "+numMarks;
		}
		
		public function get_TEXT(textID:uint):String {
			return TEXT_[textID];
		}
		//{
		private var TEXT_:Array = [
			"Начать игру"
			,"Выйти"
			,"Выйти из игры"
			,"Продложить игру"
			,"Выйти"
			,"Рестарт"
			,"Рестарт игры"
			,"Отмена рестарта"
			,"Начать сначала"
			
		];
		
		
		public function getTextError():String {return TEXT_ERROR;}
		private var TEXT_ERROR:String = 'ошибка:';
		public function getDefaultText():String {return TEXT_NOT_FOUND;}
		private var TEXT_NOT_FOUND:String = 'текст не найден в файле локализации';
		
		
		public static const ID_TEXT_GAME_START:uint=0;
		public static const ID_TEXT_EXIT:uint=1;
		public static const ID_TEXT_EXIT_CONFIRM:uint=2;
		public static const ID_TEXT_EXIT_CANCEL:uint=3;
		public static const ID_TEXT_PAUSE_EXIT:uint=4;

		public static const ID_TEXT_RESTART:uint=5;
		public static const ID_TEXT_RESTART_CONFIRM:uint=6;
		public static const ID_TEXT_RESTART_CANCEL:uint=7;
		
		public static const ID_TEXT_STATS_BACK:uint=8;
		
		
		//}
		
		
		//} ======= END OF TEXT
		
	}
}
