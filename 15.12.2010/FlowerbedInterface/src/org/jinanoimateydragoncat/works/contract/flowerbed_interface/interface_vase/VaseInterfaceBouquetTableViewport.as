// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.interface_vase {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	import org.jinanoimateydragoncat.display.utils.Utils;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvent;
	
	import org.aswing.AssetPane;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:45
	 */
	public class VaseInterfaceBouquetTableViewport extends AssetPane {
		
		//{ =^_^= CONSTRUCTOR
		
		function VaseInterfaceBouquetTableViewport (width:Number, height:Number) {
			super(containerSprite, AssetPane.SCALE_STRETCH_PANE);
			setPreferredWidth(width);
			setPreferredHeight(height);
			
			initWidth = width;
			initHeight = height;
			prepareSprites();
			
			initInput();
			
			//activateDebugMode(width, height);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * 
		 * @return id редактируемого элемента
		 */
		public function get_selectedElementId():uint {
			return currentElement.id;
		}
		
		/**
		 * установка редактируемого элемента
		 * @elementId id 
		 */
		public function selectElement(elementId:uint):void {
			log('set_selectedElementId,'+ arguments);
			var foundElement:ElementData = getElementByID(elementId);
			
			if (!foundElement.available) {setElementAvailability(foundElement.id, true);}
			if (currentElement == foundElement) {return;}
			
			displaySelection(currentElement, false);
			currentElement = foundElement;
			displaySelection(currentElement, true);
		}
		
		/**
		 * data format: {displayObject:DisplayObject, bitmapData:BitmapData}
		 * @param callback function (imageData:Object) {addChild(new Bitmap(imageData.bitmapData));}
		 */
		public function getImage(callback:Function):void {
			if (elements.length < 1) {return;}
			displaySelection(currentElement, false);
			Utils.getBitmapData(rootSprite, function (bd:BitmapData):void {
				var s:Sprite = rootSprite;
				renewRootSprite();
				callback({displayObject:s, bitmapData:bd});
			});
		}
		
		/**
		 * установка режима редактирования
		 * @param	a
		 */
		public function set_editMode(a:uint):void {
			log('set_editMode,'+ arguments);
			editMode = a;
		}
		
		/**
		 * перемещение редактируемого элемента ближе к зрителю
		 */
		public function moveSelectedElementUp():void {
			log('moveSelectedElementUp,');
			if (!currentElement || !currentElement.available) {return;}
			var elementIndex:int = sprite.getChildIndex(currentElement.displayObject);
			if (sprite.numChildren > elementIndex+1) {
				sprite.swapChildrenAt(elementIndex, elementIndex+1);
			}
		}
		
		/**
		 * отражение редактируемого элемента по горизонтали
		 */
		public function mirrorSelectedElement():void {
			log('mirrorSelectedElementSelectedElement,');
			if (!currentElement || !currentElement.available) {return;}
			currentElement.displayObject.scaleX *= -1;
		}
		
		/**
		 * перемещение редактируемого элемента дальше от зрителя
		 */
		public function moveSelectedElementDown():void {
			log('moveSelectedElementDown,');
			if (!currentElement || !currentElement.available) {return;}
			var elementIndex:int = sprite.getChildIndex(currentElement.displayObject);
			if (elementIndex>0) {
				sprite.swapChildrenAt(elementIndex, elementIndex-1);
			}
		}
		
		/**
		 * установка доступности для редактирования и видимости элемента
		 * @param	elementID id true==доступен
		 * @param	availability доступность
		 */
		public function setElementAvailability(elementID:uint, availability:Boolean):void {
			log('setElementAvailability,'+ arguments);
			var e:ElementData = getElementByID(elementID);
			if (!e) {return;}
			e.available = availability;
			if (!availability) {
				if (sprite.contains(e.displayObject)) {sprite.removeChild(e.displayObject);}
			} else {
				sprite.addChild(e.displayObject);
			}
		}
		
		/**
		 * очистка списка элементов
		 */
		public function clearContent(removeSprites:Boolean=true):void {
			log('clearContent,');
			currentElement = null;
			for each(var e:ElementData in elements) {
				e.displayObject = null;
			}
			elements = new Vector.<ElementData>();
			
			if (!removeSprites) {return;}
			for (var i:uint = 0; i < sprite.numChildren; i++) {
				sprite.removeChildAt(i);
			}
			
		}
		
		/**
		 * добавление элемента
		 * @param	displayObject элемент
		 * @param	available доступность
		 * @param	id id
		 */
		public function addContent(displayObject:DisplayObject, available:Boolean, id:uint):void {
			log('addContent,'+ arguments);
			
			elements.push(new ElementData(displayObject, available, id));
			if (available) {sprite.addChild(displayObject);}
			
		}
		
		/**
		 * установка изображения вазы
		 * @param	frontImage переднее изображение(перекрывающее обрезки стебей)
		 * @param	backImage заднее изображение(перекрываемое обрезками стебей)
		 * @param xOffset смещение по горизонтали относительно центра 
		 * @param yOffset смещение по вертикали относительно центра 
		 * @param maskSprite маска
		 */
		public function setVaseImage(frontImage:DisplayObject, backImage:DisplayObject, vaseHeight:Number, xOffset:Number=0, yOffset:Number=0):void {
			if (vaseImageFront != null && rootSprite.contains(vaseImageFront)) {rootSprite.removeChild(vaseImageFront);}
			if (vaseImageBack != null && rootSprite.contains(vaseImageBack)) {rootSprite.removeChild(vaseImageBack);}
			
			vaseImageFront = frontImage;
			vaseImageBack = backImage;
			
			backImage.x = sprite.x+ xOffset;
			frontImage.x = sprite.x+ xOffset;
			
			sprite.y = 5+initHeight-vaseHeight;
			backImage.y = frontImage.y = sprite.y+yOffset;
			
			
			rootSprite.addChild(backImage);
			rootSprite.addChild(sprite);
			rootSprite.addChild(frontImage);
		}
		
		/**
		 * отображение черной рамки
		 * @param	value видимость черной рамки
		 */
		public function setBorderVisibility(value:Boolean):void {
			containerSprite.getChildByName('border').visible = value;
		}
		
		/**
		 * множитель скорости вращения
		 */
		public var SETTING_MOVE_SPEED_MULTIPLIER:Number = .5;
		public var SETTING_ROTATION_SPEED_MULTIPLIER:Number = .5;
		
		
		
		//{ debug
		private function activateDebugMode(width:Number, height:Number):void {
			containerSprite.graphics.beginFill(0x008833);
			containerSprite.graphics.drawRect(-width/2, -height/2, width, height);
			containerSprite.graphics.endFill();
			containerSprite.graphics.lineStyle(2,0x00FF00);
			containerSprite.graphics.drawRect(-width/2, -height/2, width-2, height-2);
			
			//logging:
			var tf:TextField = new TextField();
			tf.width = width;
			tf.height = height;
			tf.name = 'tf';
			containerSprite.addChild(tf);
		}
		
		private function log(t:String):void {
			if (!containerSprite.getChildByName('tf')){return;}
			TextField(containerSprite.getChildByName('tf')).appendText(t+ '\n');
			TextField(containerSprite.getChildByName('tf')).scrollV = TextField(containerSprite.getChildByName('tf')).maxScrollV;
		}
		//} END OF debug
		
		//{ Edit
		private function initInput():void {
			containerSprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseInputListener);
			containerSprite.addEventListener(MouseEvent.MOUSE_UP, mouseInputListener);
			containerSprite.addEventListener(MouseEvent.MOUSE_MOVE, mouseInputListener);
			containerSprite.addEventListener(MouseEvent.MOUSE_OUT, mouseInputListener);
		}
		
		private function mouseInputListener(e:MouseEvent):void {
			switch (e.type) {
			
			case MouseEvent.MOUSE_MOVE:
				if (!controlEnabled) {return;}
				if (editMode == ID_EDIT_MODE_TYPE_MOVE) {
					moveItem();
					return;
				}
				//else
				rotateItem();
				return;
			
			case MouseEvent.MOUSE_DOWN:
				if (!currentElement || !currentElement.available) {return;}
				enableControl();
				mouseX0 = containerSprite.mouseX;
				mouseY0 = containerSprite.mouseY;
				elementSpriteX0 = currentElement.displayObject.x;
				elementSpriteY0 = currentElement.displayObject.y;
				elementSpriteRotation0 = currentElement.displayObject.rotation;
				return;
			
			case MouseEvent.MOUSE_OUT:
			case MouseEvent.MOUSE_UP:
				disableControl();
				return;
			
			}
		}
		
		private function moveItem():void {
			currentElement.displayObject.x = elementSpriteX0+ (containerSprite.mouseX- mouseX0)*SETTING_MOVE_SPEED_MULTIPLIER;
			currentElement.displayObject.y = elementSpriteY0+ (containerSprite.mouseY- mouseY0)*SETTING_MOVE_SPEED_MULTIPLIER;
		}
		private function rotateItem():void {
			currentElement.displayObject.rotation = elementSpriteRotation0+(containerSprite.mouseX-mouseX0)*SETTING_ROTATION_SPEED_MULTIPLIER;
		}
		
		private function enableControl():void {
			controlEnabled = true;
			if (editMode == ID_EDIT_MODE_TYPE_MOVE) {
				notifyAppToChangeMouseCursor(ID_CURSOR_TYPE_MOVE);
			} else {
				notifyAppToChangeMouseCursor(ID_CURSOR_TYPE_ROTATE);
			}
		}
		private function disableControl():void {
			notifyAppToChangeMouseCursor(ID_CURSOR_TYPE_DEFAULT);
			controlEnabled = false;
		}
		
		
		private var elementSpriteRotation0:Number;
		private var elementSpriteX0:Number;
		private var elementSpriteY0:Number;
		private var mouseX0:Number;
		private var mouseY0:Number;
		
		private var controlEnabled:Boolean;
		private var editMode:uint = ID_EDIT_MODE_TYPE_MOVE;
		//} END OF Edit
		
		//{ Phys
		private function prepareSprites():void {
			if (rootSprite!= null && containerSprite.contains(rootSprite)) {containerSprite.removeChild(rootSprite);}
			
			rootSprite = containerSprite.addChild(new Sprite());
			sprite = rootSprite.addChild(new Sprite());
			sprite.x = initWidth/2;
			sprite.y = initHeight/2;
			
			if (containerSprite.mouseChildren) {
				containerSprite.mouseChildren = false;
				
				var border:Sprite = containerSprite.addChild(new Sprite());
				border.name = 'border';
				border.graphics.lineStyle(0, 0);
				border.graphics.drawRect(0, 0, initWidth-1, initHeight-1);
				
				
				containerSprite.graphics.beginFill(0, 0);
				containerSprite.graphics.drawRect(0, 0, initWidth, initHeight);
			}
		}
		
		/**
		 * отображение видимого выделения текущего элемента
		 * @param	elementData
		 * @param	display
		 */
		private function displaySelection(elementData:ElementData, display:Boolean):void {
			if (elementData == null) {return;}
			elementData.displayObject.filters = (display)?displayObjectSelectionEffectFilters:[];
		}
		
		private function renewRootSprite():void {
			notifyAppToChangeMouseCursor(ID_CURSOR_TYPE_DEFAULT);
			
			clearContent();
			prepareSprites();
		}
		
		public static const displayObjectSelectionEffectFilters:Array = [new GlowFilter(0x00FF00,.8,6,6,4,2)];
		
		private var initWidth:Number;
		private var initHeight:Number;
		
		private const containerSprite:Sprite = new Sprite();
		private var rootSprite:Sprite;
		private var sprite:Sprite;
		
		private var vaseImageFront:DisplayObject;
		private var vaseImageBack:DisplayObject;
		//} END OF Phys
		
		//{ Data
		private function getElementByID(id:uint):ElementData {
			for each(var i:ElementData in elements) {
				if (i.id == id) {return i;}
			}
			return null;
		}
		
		private var currentElement:ElementData;
		private var elements:Vector.<ElementData> = new Vector.<ElementData>();
		//} END OF Data
		
		//{ id
		/**
		 * режим перемещения элемента мышью
		 */
		public static const ID_EDIT_MODE_TYPE_MOVE:uint = 0;
		/**
		 * режим вращения элемента мышью
		 */
		public static const ID_EDIT_MODE_TYPE_ROTATE:uint = 1;
		
		/**
		 * обычный курсор
		 */
		public static const ID_CURSOR_TYPE_DEFAULT:uint = 0;
		/**
		 * курсор при перемещении
		 */
		public static const ID_CURSOR_TYPE_MOVE:uint = 1;
		/**
		 * курсор при вращении
		 */
		public static const ID_CURSOR_TYPE_ROTATE:uint = 2;
		
		//} END OF id
		
		//{ Events
		private function notifyAppToChangeMouseCursor(cursorType:uint):void {
			dispatchEvent(new UIEvent(EVENT_CHANGE_MOUSE_CURSOR, cursorType, null, null, false, true));
		}
		
		/**
		 * при выполнении операций(перемещение, вращение) в приложении необходимо сменить курсор
		 * UIEvent {type:"event_change_mouse_cursor", uintValue:cursorType(see "id" section))
		 */
		public static const EVENT_CHANGE_MOUSE_CURSOR:String = "event_change_mouse_cursor";
		//} END OF Events
		
	}
}

import flash.display.DisplayObject;

class ElementData {
	
	public function ElementData (displayObject:DisplayObject, available:Boolean, id:uint) {
		this.displayObject = displayObject;
		this.id = id;
		this.available = available;
	}
	
	public var displayObject:DisplayObject;
	public var available:Boolean;
	public var id:uint;
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]