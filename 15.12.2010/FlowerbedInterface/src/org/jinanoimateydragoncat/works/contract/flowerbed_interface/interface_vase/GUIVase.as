// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import org.jinanoimateydragoncat.display.utils.Utils;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase.VaseInterfaceBouquetTableViewport;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.data.UISettings;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase.VaseInterfaceElementsList;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase.VaseInterfaceElement;
	
	import org.aswing.AssetIcon;
	import org.aswing.AssetPane;
	import org.aswing.border.LineBorder;
	import org.aswing.BoxLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JLabel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.JTextField;
	import org.aswing.BorderLayout;
	import org.aswing.ASColor;
	import org.aswing.JFrame;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	//} =^_^= END OF import
	
	
	/**
	 * интерфейс "книга"
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:40
	 */
	public class GUIVase extends JFrame {
		
		//{ =^_^= CONSTRUCTOR
		
		function GUIVase () {
			super(null, UIText.TEXT_VASE);
			setResizable(false);
			
			var rightPanelVGap:uint = 3;
			var HGap:uint = 3;
			var leftBlock:JPanel = new JPanel(new BorderLayout());
			var rightBlock:JPanel = new JPanel(new BorderLayout(0,rightPanelVGap));
			
			//
			var buttonWidth:Number = UISettings.XMLData.GUIVase.rightBlock.vaseViewportControls.button.@width;
			var buttonHeight:Number = UISettings.XMLData.GUIVase.rightBlock.vaseViewportControls.button.@height;
			//tools
			var button_mirror:JButton = new JButton('', new AssetIcon(new Bitmap(UILibrary.mirror), buttonWidth, buttonHeight));
			button_mirror.setToolTipText(UIText.TEXT_VASE_TOOL_MIRROR);
			var button_rotation:JButton = new JButton('', new AssetIcon(new Bitmap(UILibrary.rotate), buttonWidth, buttonHeight));
			button_rotation.setToolTipText(UIText.TEXT_VASE_TOOL_ROTATE);
			var button_move:JButton = new JButton('', new AssetIcon(new Bitmap(UILibrary.pan), buttonWidth, buttonHeight));
			button_move.setToolTipText(UIText.TEXT_VASE_TOOL_MOVE);
			var button_up:JButton = new JButton('', new AssetIcon(new Bitmap(UILibrary.up),buttonWidth,buttonHeight));
			button_up.setToolTipText(UIText.TEXT_VASE_TOOL_MOVE_UP);
			var button_down:JButton = new JButton('', new AssetIcon(new Bitmap(UILibrary.down), buttonWidth, buttonHeight));
			button_down.setToolTipText(UIText.TEXT_VASE_TOOL_MOVE_DOWN);
			//tools panel
			var buttonsPanel:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 5,0));
			buttonsPanel.append(button_move);
			buttonsPanel.append(button_rotation);
			buttonsPanel.append(button_mirror);
			buttonsPanel.append(button_down);
			buttonsPanel.append(button_up);
			
			//list
			var scrollPane:JScrollPane = new JScrollPane(contentPane, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
			scrollPane.setBorder(new LineBorder());
			scrollPane.setPreferredHeight(UISettings.XMLData.GUIVase.rightBlock.@setPreferredHeight-UISettings.XMLData.GUIVase.rightBlock.buttonDone.@setPreferredHeight-buttonWidth-rightPanelVGap*3);// высота списка
			scrollPane.setPreferredWidth(UISettings.XMLData.GUIVase.rightBlock.@setPreferredWidth);// ширина списка
			
			//кнопка "продолжить"
			buttonDone.setPreferredHeight(UISettings.XMLData.GUIVase.rightBlock.buttonDone.@setPreferredHeight);
			
			//append:
			rightBlock.append(scrollPane, BorderLayout.NORTH);
			rightBlock.append(buttonsPanel, BorderLayout.CENTER);
			rightBlock.append(buttonDone, BorderLayout.SOUTH);
			
			
			//{ set buttons:
			var buttons:Array = [button_mirror, button_down, button_up, button_rotation, button_move, buttonDone];
			var names:Array = [ID_BUTTON_MIRROR, ID_BUTTON_DOWN, ID_BUTTON_UP, ID_BUTTON_ROTATION, ID_BUTTON_MOVE, ID_BUTTON_DONE]
			for (var i:uint in buttons) {
				JButton(buttons[i]).name = names[i];
				JButton(buttons[i]).addActionListener(listener_rightPanelToolsButtonsAction);
			}
			//}
			
			
			// ваза
			leftBlock.append(vp, BorderLayout.CENTER);
			vp.addEventListener(VaseInterfaceBouquetTableViewport.EVENT_CHANGE_MOUSE_CURSOR, defaultEventsPipe);
			
			getContentPane().setLayout(new FlowLayout(FlowLayout.LEFT, HGap, HGap));
			getContentPane().append(leftBlock);
			getContentPane().append(rightBlock);
			pack();
			
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * установка данных для списка
		 * @param	displayObject фрагмент цветка
		 * @param	checked используется для составления букета
		 * @param	id идентификатор
		 */
		public function setContent(displayObject:Vector.<DisplayObject>, checked:Vector.<Boolean>, id:Vector.<uint>):void {
			//{ List
			var bitmaps:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			for (var i:uint in displayObject) {
				new GetBitmapOperation(displayObject[i], bitmaps, i, count);
			}
			
			function count():void {
				if (bitmaps.length == displayObject.length) {
					contentPane.setContent(bitmaps, checked, id);
				}
			}
			//} END OF List
			
			//{ Viewport
			for (i in displayObject) {
				vp.addContent(displayObject[i], checked[i], id[i]);
			}
			//} END OF Viewport
		}
		
		/**
		 * установка изображения вазы
		 * @param	frontImage переднее изображение(перекрывающее обрезки стебей)
		 * @param	backImage заднее изображение(перекрываемое обрезками стебей)
		 * @param xOffset смещение по горизонтали относительно центра 
		 * @param yOffset смещение по вертикали относительно центра 
		 */
		public function setVaseImage(frontImage:DisplayObject, backImage:DisplayObject, vaseHeight:Number, xOffset:Number = 0, yOffset:Number = 0):void {
			vp.setVaseImage(frontImage, backImage, vaseHeight, xOffset, yOffset);
		}
		
		public static const ID_BUTTON_UP:String = 'id_button_up';
		public static const ID_BUTTON_DOWN:String = 'id_button_down';
		public static const ID_BUTTON_ROTATION:String = 'id_button_rotation';
		public static const ID_BUTTON_MOVE:String = 'id_button_move';
		public static const ID_BUTTON_MIRROR:String = 'id_button_mirror';
		public static const ID_BUTTON_DONE:String = 'id_button_done';
		
		
		private var pressRef:Function;
		
		private function listener_rightPanelToolsButtonsAction(e:Event):void {
			switch (JButton(e.target).name) {
			
			case ID_BUTTON_UP:
				vp.moveSelectedElementUp();
				break;
			
			case ID_BUTTON_MIRROR:
				vp.mirrorSelectedElement();
				break;
			
			case ID_BUTTON_DOWN:
				vp.moveSelectedElementDown()
				break;
			
			case ID_BUTTON_ROTATION:
				vp.set_editMode(VaseInterfaceBouquetTableViewport.ID_EDIT_MODE_TYPE_ROTATE);
				break;
			
			case ID_BUTTON_MOVE:
				vp.set_editMode(VaseInterfaceBouquetTableViewport.ID_EDIT_MODE_TYPE_MOVE);
				break;
			
			case ID_BUTTON_DONE:
				vp.getImage(function (imageData:Object):void {
						contentPane.clearContent();
						dispatchEvent(new UIEvent(UIEvents.EVENT_BOUQUET_CREATED, 0, imageData));
					});
				break;	
			
			}
		}
		
		private function defaultEventsPipe(e:UIEvent):void {
			switch (e.type) {
			
			case VaseInterfaceElement.EVENT_ELEMENT_SELECTED:
				vp.selectElement(VaseInterfaceElement(e.target).get_id());
				break;
			
			case VaseInterfaceElement.EVENT_ELEMENT_STATE_CHANGED:
				vp.setElementAvailability(VaseInterfaceElement(e.target).get_id(), Boolean(e.uintValue));
				break;
			
			case VaseInterfaceBouquetTableViewport.EVENT_CHANGE_MOUSE_CURSOR:
				dispatchEvent(new UIEvent(UIEvents.EVENT_CHANGE_MOUSE_CURSOR, e.uintValue, e.objectValue));
				e.stopImmediatePropagation();
				break;
			}
		}
		
		private const contentPane:VaseInterfaceElementsList = new VaseInterfaceElementsList(defaultEventsPipe);
		private const buttonDone:JButton = new JButton(UIText.TEXT_CONTINUE);
		
		
		private var vp:VaseInterfaceBouquetTableViewport = new VaseInterfaceBouquetTableViewport(UISettings.XMLData.GUIVase.leftBlock.@setPreferredWidth, UISettings.XMLData.GUIVase.leftBlock.@setPreferredHeight);
		
		private var displayObject:Vector.<DisplayObject>;
		private var checked:Vector.<Boolean>;
		private var id:Vector.<uint>;
		
	}
}

//{ Import
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
//} END OF Import

import org.jinanoimateydragoncat.display.utils.Utils;

class GetBitmapOperation {
	function GetBitmapOperation(source:DisplayObject, vector:Vector.<DisplayObject>, id:uint, callBack:Function):void {
		Utils.getBitmapData(source, 
			function (bd:BitmapData):void {
				vector[id] = new Bitmap(bd, 'auto', true);
				callBack();
			}
		, true, 0x00FFFFFF);
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]