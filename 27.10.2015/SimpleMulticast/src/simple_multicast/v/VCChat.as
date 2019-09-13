// Project SimpleMulticast
package simple_multicast.v {
	
	//{ ===== import
	import org.aswing.ASFont;
	import org.aswing.JLabel;
	import simple_multicast.LOG;
	import simple_multicast.v.AVC;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import org.aswing.AssetIcon;
	import org.aswing.BorderLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.JFrame;
	import org.aswing.JTextField;
	import simple_multicast.v.AVC;
	//} ===== END OF import
	
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class VCChat extends AVC {
		
		//{ ===== CONSTRUCTOR
		
		public function construct(windowTitle:String, channelsListLabel:String, channelsButtonImg:DisplayObject, enterButtonImage:DisplayObject, channelsList:VCChatChannelsList, wndMinW:uint=300, wndMinH:uint=200, inputTextMinH:uint=25,inputTextMaxH:uint=50):void {
			if (!channelsList) {
				throw new ArgumentError('!channelsList');
			}
			wnd_title=windowTitle;
			this.channelsListLabel=channelsListLabel;
			this.channelsList=channelsList;
			enterButtonImg=enterButtonImage;
			this.channelsButtonImg=channelsButtonImg;
			
			wnd_minH=wndMinH;
			wnd_minW=wndMinW;
			leftBlock_minW=wnd_minW/2;
			leftBlock_minH=wnd_minH;
			dt_minW=leftBlock_minW;
			it_minH=inputTextMinH;
			it_maxH=inputTextMaxH;
			dt_minH=leftBlock_minH-it_minH;
			b_width = it_minH;
			
			configureVC();
			configureControll();
			//test
			//dt.setHtmlText('text <i>italic</i><b>bold</b>');
			
		}
		//} ===== END OF CONSTRUCTOR
		
		
		//{ ===== user access
		public function setTextInput(inputID:uint, val:String):void {
			switch (inputID) {
			
			case ID_TEXT_IN_0:
				return it.setText(val);
				break;
			}
		}
		public function getTextInput(inputID:uint):String {
			switch (inputID) {
			
			case ID_TEXT_IN_0:
				return it.getText();
				break;
				
			default:
				return null;
			}
			
		}
		
		public function scrollMsgDTToBottom():void {
			dt.scrollToBottomLeft();
		}
		
		public function setOutText(text:String):void {
			dt.setText(text);
		}
		
		public function addToOutText(text:String):void {
			dt.appendText(text);
		}
		
		//} ===== END OF user access
		
		//{ ===== id
		/**
		 * отображаемый в чате html в поле вывода
		 */
		public static const ID_TEXT_OUT_0:uint=0;
		/**
		 * текст для отправки
		 */
		public static const ID_TEXT_IN_0:uint=0;
		//} ===== END OF id
		
		
		//{ ===== view
		private function configureVC():void {
			// prepare frame
			vc=new JFrame(null, wnd_title);
			vc.getContentPane().setLayout(new BorderLayout(0,0));
			var titlebarH:uint=vc.getTitleBar().getSelf().getInsets().getMarginHeight();
			vc.setMinimumWidth(wnd_minW);
			vc.setMinimumHeight(wnd_minH+titlebarH);
			vc.setSizeWH(wnd_minW,wnd_minH+titlebarH);
			
			
			//L
			var leftBlock:JPanel = new JPanel(new BorderLayout(0,0));
			leftBlock.setMinimumWidth(leftBlock_minW);leftBlock.setMinimumHeight(leftBlock_minH);
			// dt
			dt=new JTextArea;
			dt.setEditable(false);dt.setWordWrap(true);
			leftBlock.append(new JScrollPane(dt, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER), BorderLayout.CENTER);
			
			var leftBlockInput:JPanel = new JPanel(new BorderLayout(0,0));
			leftBlockInput.setMinimumWidth(dt_minW);
			leftBlockInput.setMinimumHeight(it_minH);
			
			//it
			it=new JTextField('');
			//var sc:JScrollPane=new JScrollPane(it, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
			
			leftBlockInput.append(it, BorderLayout.CENTER);
			
			
			//enter b
			b= new JButton('',new AssetIcon(enterButtonImg));b.name='bSend';
			b.addActionListener(el_buttons);
			b.setMaximumWidth(b_width);
			//b.setMaximumHeight(it_minH);
			leftBlockInput.append(b, BorderLayout.EAST);
			
			leftBlock.append(leftBlockInput, BorderLayout.SOUTH);
			
			vc.getContentPane().append(leftBlock, BorderLayout.CENTER);
			
			//R
			rightBlock = new JPanel(new BorderLayout());
			
			//contacts b
			bChannels = new JButton('',new AssetIcon(channelsButtonImg));bChannels.name='bChannels';
			bChannels.addActionListener(el_buttons);
			leftBlock.append(bChannels, BorderLayout.EAST);
			
			//list
			channelsListContainer=new JScrollPane(channelsList, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			
			rightBlock.append(channelsListContainer, BorderLayout.EAST);
			
			
			var chLabel:JLabel = new JLabel(channelsListLabel);
			chLabel.setFont(new ASFont("Tahoma", 15, true));
			rightBlock.append(chLabel, BorderLayout.NORTH);
			
			vc.getContentPane().append(rightBlock, BorderLayout.EAST);
			
			
			//c
			vc.show();
		}
		
		public function get_visible():Boolean {
			return vc.isVisible();
		}
		public function set_visible(a:Boolean):void {
			if (a) {
				vc.show();
			} else {
				vc.hide();
			}
		}
		
		public function get_displayObject():DisplayObject {return vc;}
		public function redraw():void { channelsList.repaintAndRevalidate(); vc.repaintAndRevalidate(); }
		
		private var wnd_title:String;
		private var channelsListLabel:String;
		
		private var vc:JFrame;
		private var dt:JTextArea;
		private var it:JTextField;
		private var b:JButton;
		private var bChannels:JButton;
		private var rightBlock:JPanel;
		
		public function get_channelsList():VCChatChannelsList {return channelsList;}
		private var channelsList:VCChatChannelsList;
		private var channelsListContainer:JScrollPane;
		//} ===== END OF view
		
		
		//{ ===== controll
		private function configureControll():void {
		}
		private function el_buttons(e:Event):void {
			switch (e.target.name) {
			
			case 'bChannels':
			
				if (vc.getContentPane().contains(rightBlock)) {
					vc.getContentPane().remove(rightBlock);
				} else {
					vc.getContentPane().append(rightBlock, BorderLayout.EAST);
				}
				redraw();
				break;
			case 'bSend':
				listener(this, ID_E_BUTTON_SEND);
				break;
			
			}
		}
		//} ===== END OF controll
		
		
		//{ ===== events
		/**
		 * @param	listener function (target:VCChat, eventType:String, details:Object=null):void;
		 */
		public function setListener(listener:Function):void {
			this.listener = listener;
		}
		private var listener:Function;
		//} ===== END OF events
		
		
		private var enterButtonImg:DisplayObject;
		private var channelsButtonImg:DisplayObject;
		//{ ===== data
		
		private var groupsList:Vector.<String>=new Vector.<String>;
		private var wnd_minH:uint;
		private var wnd_minW:uint;
		private var leftBlock_minH:uint;
		private var leftBlock_minW:uint;
		private var dt_minW:uint;
		private var dt_minH:uint;
		private var it_minH:uint;
		private var it_maxH:uint;
		private var b_width:uint;
		//} ===== END OF data
		
		//{ ===== id
		public static const ID_E_BUTTON_SEND:String = '>ID_E_BUTTON_SEND';
		//} ===== END OF id
		
		
	}
}
