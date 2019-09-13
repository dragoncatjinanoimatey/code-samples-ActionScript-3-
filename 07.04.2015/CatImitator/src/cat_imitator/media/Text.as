// Project CatImitator
package cat_imitator.media {
	
	//{ ===== import
	import cat_imitator.LOG;
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
			
			this.xml=xml;
			
			
		}
		//} ======= ======= END OF constructor
		
		private var xml:XMLList;
		
		
		private static function processText(text:String, args:Array):String {
			if (args.length) {
				for (var i:String in args) {
					text = text.split('%' + i).join(args[int(i)]);
				}
			}
			return text;
		}
		
		//{ ======= TEXT
		public function get_TEXT(textID:uint):String {
			return TEXT_[textID];
		}
		//{
		private var TEXT_:Array = [
			"JSON.parse error. проверьте json файл и попробуйте еще раз"
			,"Открыть json файл с данными приложения"
			,"имитатор кошки"
			,"действие: "
		];
		
		public static const ID_TEXT_MSG_ERR_INVALID_JSON:uint=0;
		public static const ID_TEXT_LABEL_B_OPEN_DB:uint=1;
		public static const ID_TEXT_LABEL_APP_NAME:uint=2;
		public static const ID_TEXT_B_ACTION:uint=3;
		//}
		
		
		//} ======= END OF TEXT
		
	}
}
