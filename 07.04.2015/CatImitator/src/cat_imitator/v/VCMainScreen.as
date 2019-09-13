// Project CatImitator
package cat_imitator.v {
	
	//{ ===== import
	import cat_imitator.APP;
	import cat_imitator.d.app.DUAction;
	import cat_imitator.media.Text;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import flash.text.TextFormat;
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.BorderLayout;
	import org.aswing.BoxLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.SolidBackground;
	//} ===== END OF import
	
	
	
	/**
	 * main app window
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCMainScreen extends AVC {
		
		//{ ===== CONSTRUCTOR
		
		function VCMainScreen (w:uint, h:uint) {
			this.w = w;
			this.h = h;
			prepareContainer();
			
			//add test buttons
			addSomeInterface();
		}
		
		private function addSomeInterface():void {
			
			vc=new JFrame(interfaceLayer, APP.lText().get_TEXT(Text.ID_TEXT_LABEL_APP_NAME));
			vc.getContentPane().setLayout(new BorderLayout(0,0));
			var titlebarH:uint=vc.getTitleBar().getSelf().getInsets().getMarginHeight();
			vc.setSizeWH(w,h/1.8+titlebarH);
			
			
			var leftPanel:JPanel = new JPanel(new BorderLayout(10,10));
			
			tb0 = Lib.createSimpleButton(P_ID_B_LOAD_DB, el_testButtons, APP.lText().get_TEXT(Text.ID_TEXT_LABEL_B_OPEN_DB), true, true);
			tb0.pack();
			
			
			dtReactionText = new JTextArea();
			dtReactionText.setEditable(false);dtReactionText.setWordWrap(true);
			dtReactionText.setHeight(h/1.8-tb0.getHeight()*2);
			dtReactionText.setWidth(w/2);
			
			
			leftPanel.append(tb0, BorderLayout.SOUTH);
			leftPanel.append(new JScrollPane(dtReactionText, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER), BorderLayout.CENTER);
			
			leftPanel.pack();
			vc.getContentPane().append(leftPanel, BorderLayout.WEST);
			
			actionsList = new JPanel(new BoxLayout(BoxLayout.Y_AXIS, 10));
			var cnt_actionsList:JPanel = new JPanel(new BorderLayout());
			cnt_actionsList.append(actionsList, BorderLayout.NORTH);
			vc.getContentPane().append(new JScrollPane(cnt_actionsList, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER), BorderLayout.EAST);
			
			vc.show();
		}
		
		private function el_actionButtons(targetID:int):void {
			listener(this, ID_E_B_ACTION, targetID);
		}		
		
		private function el_testButtons(e:Event):void {
			switch (e.target.name) {
			
			case P_ID_B_LOAD_DB:
				listener(this, ID_E_B_LOAD_APP_DB, null);
				break;
			
			}
		}
		//} ===== END OF CONSTRUCTOR
		

		//{ ======= ======= view
		
		public function hideLoadButton():void {
			(tb0.parent as JPanel).remove(tb0);
		}
		
		public function displayText(a:String):void {
			dtReactionText.setText(a);
		}
		
		public function addActionButton(du:DUAction):void {
			var l:String = APP.lText().get_TEXT(Text.ID_TEXT_B_ACTION);
			var ab0:VCActionButton = new VCActionButton(du.get_id(), el_actionButtons, l+du.get_label());
			actionsList.append(ab0);
			vc.repaintAndRevalidate();
		}
		
		public function addInterface(a:DisplayObject):DisplayObject {
			return interfaceLayer.addChild(a);
		}		
		
		public function removeInterface(a:DisplayObject):void {
			if (interfaceLayer.contains(a)) {interfaceLayer.removeChild(a);}
		}
		
		public function orderLayers():void {
			container.addChild(interfaceLayer);
		}
		
		public function centerOnScreen(target:DisplayObject, ignoreObjectSize:Boolean = false):DisplayObject {
			if (!target) {return target;}
			if (ignoreObjectSize) {target.x = w/2;target.y = h/2;
			} else {target.x = w/2- target.width/2;target.y = h/2- target.height/2;}
			return target;
		}
		
		public function repositionComponents():void {
			container.stage.addEventListener(Event.ENTER_FRAME, function (e:Event):void {
				//container.removeEventListener(e.type, arguments.callee);
				positionComponents();
			} );
		}
		
		public function positionComponents():void {
			if (!container || !container.stage) {return;}
		}
		
		public function setEnabled(a:Boolean):void {
			container.mouseEnabled = a; container.mouseChildren = a;
		}
		
		
		/**
		 * dialog widows, other popups
		 */
		private var interfaceLayer:Sprite=new Sprite();
		public function get_interfaceLayer():Sprite {return interfaceLayer;}
		public function set_interfaceLayer(a:Sprite):void {interfaceLayer = a;}

		/**
		 * cursors
		 */
		private var mouseCursorLayer:Sprite=new Sprite();
		/**
		 * width
		 */
		private var w:uint;
		/**
		 * height
		 */
		private var h:uint;
		
		private var vc:JFrame;
		private var tb0:JButton;
		private var dtReactionText:JTextArea;
		private var actionsList:JPanel;
		
		//{ ======= container
		private function prepareContainer():void {
			container = new Sprite();
			if (!container.stage) {container.addEventListener(Event.ADDED_TO_STAGE, el_addedToStage);} else {el_addedToStage();};
		}
		private function el_addedToStage(e:Event = null):void {
			container.removeEventListener(e.type, el_addedToStage);
			container.stage.addEventListener(Event.RESIZE, el_StageResize);
			
			prepareVCs();
			el_StageResize();
		}
		
		private function prepareVCs():void {
			//interfaceLayer.addChild(vcad.get_displayObject());
		}
		
		private function el_StageResize(e:Event=null):void {
			//log(3, 'screen resolution changed:'+AppCfg.appScreenW+'x'+AppCfg.appScreenH);
				positionComponents();
			
			if (listener!=null) {listener(this, ID_E_STAGE_RESIZE, null);}
		}
		
		
		public function get_displayObject():Sprite {return container;}
		private var container:Sprite;
		//} ======= END OF container
		
		
		
		//{ ======= events
		/**
		 * @param	listener function (target:VCMainScreen, eventType:String, details:Object=null):void;
		 */
		public function setListener(listener:Function):void {
			this.listener = listener;
			el_StageResize(null);
		}
		/**
		* (target:VCMainScreen, eventType:String, details:Object=null)
		*/
		private var listener:Function;
		//} ======= END OF events
		
		//{ ======= misc id
		private static const P_ID_B_LOAD_DB:String = 'P_ID_B_LOAD_DB';
		
		//} ======= END OF misc id
		
		//{ ======= events id 
		public static const ID_E_STAGE_RESIZE:String = '>ID_E_STAGE_RESIZE';
		public static const ID_E_B_LOAD_APP_DB:String = '>ID_E_B_LOAD_APP_DB';
		/**
		 * int
		 */
		public static const ID_E_B_ACTION:String = '>ID_E_B_ACTION';
		//} ======= END OF events id
		
		
		
		
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
			LOG(c,"view>"+m,l);
		}
		
		
		
		public static const NAME:String = 'VCMainScreen';
		
	}
}