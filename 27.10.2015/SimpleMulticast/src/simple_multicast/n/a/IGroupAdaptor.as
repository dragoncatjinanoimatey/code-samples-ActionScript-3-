// Project SimpleMulticast
package simple_multicast.n.a {
	
	//{ ===== import
	//} ===== END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public interface IGroupAdaptor {
		
		function sendMessage(senderDisplayName:String, msg:String):Boolean;
		function get_name():String;
		
	}
}
