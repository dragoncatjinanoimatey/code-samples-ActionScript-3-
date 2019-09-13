// Project SimpleMulticast
package simple_multicast.cfg {
	
	//{ ===== import
	//} ===== END OF import
	
	
	/**
	 * server protocol
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class SP {
		
		/**
		 * максимальное количество повторов при неудачной попытке запроса
		 */
		public static const SERVER_SETTING_MAX_RETRY_COUNT:uint = 5;
		public static const SERVER_SETTING_CONNECTION_TIMEOUT:uint = 5;
		
		
		//{ ===== ===== methods and arguments
		
		//{ ===== template
		/**
		 * METHOD_ARGUMENT_NAME0, METHOD_ARGUMENT_NAME1
		 */
		//public static const METHOD_NAME:String = 'method.name';
		//public static const METHOD_ARGUMENT_NAME0:String = 'argument';
		//public static const METHOD_ARGUMENT_NAME1:String = 'argument1';
		//} ===== END OF template
		
		public static const METHOD_RTMFP_CMD:String = 'rtmfp:';
		public static const METHOD_RTMFP_MC_ADDRESS:String = '225.225.0.1:20002';
		public static const METHOD_RTMFP_SERVICE_GROUP_NAME:String = 'lan_text_chat/service';
		public static const METHOD_RTMFP_CHAT_GROUP_NAME_PREFIX:String = 'lan_text_chat/chat_';
		/**
		 * out:[group_name]
		 * in:nothing
		 */
		public static const METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_ADDED:String = 'new_group';
		public static const METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST:String = 'groups';
		public static const METHOD_RTMFP_SRV_ACTION_TYPE_CHAT_GROUP_LIST_REQ:String = 'reqGroups';
		
		
	}
}
