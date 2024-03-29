// Project TicTacToe
package t_t {
	
	//{ ======= import
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * 
	 */
	public class LOGGER {
		
		/**
		* @param	m msg
		* @param	c channel id
		* @param	l level
		*/
		public static function log(c:uint, m:String, l:uint=0):void {
			i(c, m, l);
		}
		
		/**
		 * function (c:uint, m:String, l:uint=0):void//channel_id, message, level
		 */
		public static function setL(a:Function):void {i=a;}
		/**
		 * logger method ref
		 */
		private static var i:Function;
		public static const LEVEL_INFO:uint = 0;
		public static const LEVEL_WARNING:uint = 1;
		public static const LEVEL_ERROR:uint = 2;
		
		
		/**
		 * channel realtime
		 */
		public static const C_R:uint=0;
		/**
		 * channel data trace
		 */
		public static const C_DT:uint=1;
		/**
		 * channel data state and integrity
		 */
		public static const C_DS:uint=2;
		/**
		 * channel view
		 */
		public static const C_V:uint=3;
		/**
		 * channel operations
		 */
		public static const C_OP:uint=4;
		/**
		 * channel network
		 */
		public static const C_NET:uint=5;
		/**
		 * channel agents
		 */
		public static const C_A:uint=6;
		
		
		public static const _CHANNEL_DISPLAY_NAMES:Array=[
			"R"
			,"DT"
			,"DS"
			,"V"
			,"OP"
			,"NET"
			,"AG"
		];
		
		
		public static function traceObject(a:Object, callMethods:Boolean=false):String {
			return JSON.stringify(a);
		}
		
		
		
	}
}