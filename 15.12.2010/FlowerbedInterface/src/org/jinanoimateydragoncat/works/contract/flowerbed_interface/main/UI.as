// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.main {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.alerts.Alert;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.alerts.AlertImage;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.GUIBook;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_shop.GUIShop;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.GUIStoreroom;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase.GUIVase;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels.InfoPanel;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels.InterfacesPanel;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels.MiscControlsPanel;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels.ToolsPanel;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingManager;
	import org.aswing.BorderLayout;
	import org.aswing.BoxLayout;
	import org.aswing.Component;
	import org.aswing.FlowLayout;
	import org.aswing.GridLayout;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.SolidBackground;
	//} =^_^= END OF import
	
	
	/**
	 * класс пользовательского интерфейса(с тестовым кодом)
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:02
	 */
	public class UI extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		function UI () {
			if (stage) {init();}
			else {addEventListener(Event.ADDED_TO_STAGE, init);}
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function showImage(title:String, image:DisplayObject):void {
			var alertImage:AlertImage = new AlertImage(title, image);
			centerOnScreen(alertImage);
			addChild(alertImage);
			
		}
		
		public function setMouseCursor(cursor:Sprite):void {
			if (!cursor) {
				stopDrag();
				if (mouseCursorImage!=null) {removeChild(mouseCursorImage);}
				mouseCursorImage = null;
				Mouse.show();
				return;
			}
			mouseCursorImage = cursor;
			mouseCursorImage.mouseEnabled = false;
			addChild(mouseCursorImage);
			mouseCursorImage.startDrag(true);
			Mouse.hide();
		}
		
		public var alert:Alert;
		public var shopInterface:GUIShop;
		public var bookInterface:GUIBook;
		public var storeroomInterface:GUIStoreroom;
		public var vaseInterface:GUIVase;
		public const tf:JTextArea = new JTextArea('Debug output');
		private var mouseCursorImage:Sprite;
		private var alertImage:AlertImage;
		
		
		/**
		 * интерфейс готов к использованию
		 */
		protected function initialized():void {
			//override and place your code here
			//инициализация PureMVC
		}
		
		protected function centerOnScreen(target:Component):void {
			target.x  = stage.stageWidth/2-target.getWidth()/2;
			target.y  = stage.stageHeight/2-target.getHeight()/2;
		}
		
		protected var miscControlsPanel:MiscControlsPanel;
		protected var infoPanel:InfoPanel;
		protected var interfacesPanel:InterfacesPanel;
		protected var toolsPanel:ToolsPanel;
		
		
		
		
		private function init(e:Event=null):void{
			if (e) {removeEventListener(e.type, arguments.callee);}
			UILibrary.initialize();
			
			AsWingManager.initAsStandard(this);
			//create other case instance here to test others
			//for example change below with addChild(new Button()); to test buttons.
			//UIManager.setLookAndFeel(new AeonLAF());
			
			//панели с кнопками интерфейсов и инструментов
			preparePanel();
			
			// подготовка интерфейсов
			prepareShop();
			
			prepareBook();
			
			prepareVase();
			
			prepareStoreroom();
			
			//сообщение
			alert = new Alert();
			centerOnScreen(alert);
			addChild(alert);
			
			initialized();
		}
		
		private function preparePanel():void {
			//панель интерфейсов
			interfacesPanel = new InterfacesPanel(panelButtonPressed);
			//панель инструментов
			toolsPanel = new ToolsPanel(panelButtonPressed);
			//информационная панель
			infoPanel = new InfoPanel();
			//панель кнопок fullscreen и музыки
			miscControlsPanel = new MiscControlsPanel(panelButtonPressed);
			
			var lowerPanel:JPanel = new JPanel(new BorderLayout());
			var upperPanel:JPanel = new JPanel(new BorderLayout());
			var panelVertical:JPanel = new JPanel(new BorderLayout());
			
			upperPanel.append(infoPanel,BorderLayout.EAST);
			upperPanel.append(miscControlsPanel,BorderLayout.WEST);
			
			lowerPanel.append(toolsPanel,BorderLayout.WEST);
			lowerPanel.append(tf,BorderLayout.CENTER);
			lowerPanel.append(interfacesPanel,BorderLayout.EAST);
			
			lowerPanel.setHeight(interfacesPanel.getHeight());
			
			panelVertical.setWidth(stage.stageWidth);
			panelVertical.setHeight(stage.stageHeight);
			
			panelVertical.append(lowerPanel,BorderLayout.SOUTH);
			panelVertical.append(upperPanel,BorderLayout.NORTH);
			panelVertical.validate();
			lowerPanel.validate();
			addChild(panelVertical);
		}
		
		private function panelButtonPressed(e:Event):void {
			
			tf.setText('button pressed:'+e.target.name);
			switch (e.target.name) {
			
			case  UIEvents.ID_VASE:
				//alert.alert(UIText.TEXT__NOT_IMPLEMENTED_YET);
				vaseInterface.setVisible(!vaseInterface.isVisible());
				break;
			
			case  UIEvents.ID_BOOK:
				bookInterface.setVisible(!bookInterface.isVisible());
				break;
			
			
			case  UIEvents.ID_SHOP:
				shopInterface.setVisible(!shopInterface.isVisible());
				break;
			
			case  UIEvents.ID_STOREROOM:
				storeroomInterface.setVisible(!storeroomInterface.isVisible());
				break;
			
			
			}
		}
		
		private function prepareShop():void {
			shopInterface = new GUIShop();
			centerOnScreen(shopInterface);
			//addChild(shopInterface);
		}
		
		private function prepareStoreroom():void {
			storeroomInterface = new GUIStoreroom();
			centerOnScreen(storeroomInterface);
			//addChild(storeroomInterface);
		}
		
		
		private function prepareBook():void {
			bookInterface = new GUIBook();
			centerOnScreen(bookInterface);
			//addChild(bookInterface);
		}
		
		private function prepareVase():void {
			vaseInterface = new GUIVase();
			centerOnScreen(vaseInterface);
			//addChild(vaseInterface);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]