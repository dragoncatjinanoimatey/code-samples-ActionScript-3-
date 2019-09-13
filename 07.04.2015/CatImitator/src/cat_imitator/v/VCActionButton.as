// Project CatImitator
package cat_imitator.v {
	
	//{ ======= import
	import flash.events.Event;
	import org.aswing.BorderLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import cat_imitator.v.Lib;
	//} ======= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCActionButton extends JPanel {
		
		//{ ======= CONSTRUCTOR
		
		public function VCActionButton (id_:int, eventsPipe:Function, displayName:String) {
			this.id = id_;
			this.eventsPipe = eventsPipe;
			setLayout(new BorderLayout(35, 1));
			button0 = Lib.createSimpleButton('actionB_' + id_, el_b, displayName, true, true);
			append(button0, BorderLayout.CENTER);
		}
		//} ======= END OF CONSTRUCTOR
		
		
		private function el_b(e:Event):void {
			eventsPipe(id);
		}
		
		private var eventsPipe:Function;
		private var id:int;
		private var button0:JButton;
	
	}
}