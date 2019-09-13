// Project SimpleMulticast
package simple_multicast.v {
	
	//{ ======= import
	import flash.events.Event;
	import org.aswing.BorderLayout;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCInputTextField extends JPanel {
		
		//{ ======= CONSTRUCTOR
		
		public function VCInputTextField (id_:int, label:String) {
			this.id = id_;
			setLayout(new BorderLayout(1, 1));
			it0 = new JTextField();
			append(it0, BorderLayout.CENTER);
			var l:JLabel = new JLabel(label, null, JLabel.LEFT);
			append(l, BorderLayout.NORTH);
		}
		public function destroy():void {
			it0 = null;
		}
		//} ======= END OF CONSTRUCTOR
		
		
		public function get_id():int {return id;}
		public function get_text():String {return it0.getText();}
		
		private var id:int;
		private var it0:JTextField;
	
	}
}