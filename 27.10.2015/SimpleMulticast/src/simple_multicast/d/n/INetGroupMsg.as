// Project SimpleMulticast
package simple_multicast.d.n {
	
	//{ ===== import
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public interface INetGroupMsg {
		
		
		function get_senderID():String;
		function get_senderDisplayName():String;
		function get_time():String;
		
		function toObject():Object;
		
	}
}
