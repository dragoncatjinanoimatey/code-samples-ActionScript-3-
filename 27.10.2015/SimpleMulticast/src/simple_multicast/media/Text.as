// Project SimpleMulticast
package simple_multicast.media {
	
	//{ ===== import
	import simple_multicast.LOG;
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
		
		
		public function get_appActionsItLabels():Array {return appActionsItLabels;}
		public function get_appActionsBLabels():Array {return appActionsBLabels;}
		private var appActionsBLabels:Array = [
			"установить имя"
			,"создать группу"
			,"обновить список\r\nгрупп"
		];
		private var appActionsItLabels:Array = [
			"имя юзера:"
			,"имя группы:"
			,null
		];
		//{ ======= TEXT
		public function get_TEXT(textID:uint):String {
			return TEXT_[textID];
		}
		//{
		private var TEXT_:Array = [
			"состояние:"
			,"Чат"
			,"Список групп:"
			,'попытка подключения...'
			,'ожидание входящих подключений'
			,'не удалось подключиться, проверьте соедниение и настройки фаервола'
			,'подключено.'
			,'нет смысла постить в группу в которой никого нет'
			,'некуда постить: создайте группу и дождитесь новых собеседников, либо выберите существующую группу'
			,'группа с таким именем уже существует'
			,'группа создана'
			,'название группы должно иметь длину не менее 5 символов'
			,'имя должно иметь длину не менее 3 символов'
			,'имя юзера установлено'
			,'группа %0 доступна для постинга'
			,'не удалось отправить сообщение. разрешите пиринговые сети в настройках плеера и проверьте настройки сети'
		];
	
		
		public static const ID_TEXT_WND_APP_STATE:uint=0;
		public static const ID_TEXT_LABEL_WND_TITLE_CHAT:uint=1;
		public static const ID_TEXT_LABEL_LABEL_CHANNELS_LIST:uint=2;
		public static const ID_TEXT_STATE_CONNECTING:uint=3;
		public static const ID_TEXT_STATE_WAITING_FOR_INCOMING:uint=4;
		public static const ID_TEXT_STATE_FAILED_TO_CONNECT:uint=5;
		public static const ID_TEXT_STATE_CONNECTED:uint=6;
		public static const ID_TEXT_INFO_CHAT_EMPTY_GROUP:uint=7;
		public static const ID_TEXT_INFO_CHAT_NO_GROUPS:uint=8;
		public static const ID_TEXT_INFO_CANT_CREATE_GR_ALREADY_EXISTS:uint=9;
		public static const ID_TEXT_INFO_CREATE_GR_OK:uint=10;
		public static const ID_TEXT_INFO_SHORT_GR_NAME:uint=11;
		public static const ID_TEXT_INFO_SHORT_NAME:uint=12;
		public static const ID_TEXT_INFO_NAME_UPDATED:uint=13;
		public static const ID_TEXT_INFO_GR_ACTIVE:uint=14;
		
		public static const ID_TEXT_ERROR_FAILED_TO_SEND:uint=15;
		//}
		
		
		//} ======= END OF TEXT
		
	}
}
