// optimized for performance
package org.jinanoimateydragoncat.works.contract.flower_physics {
	//{ import
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} END OF import
	
	/**
	 * сегмент ствола
	 * Описание:
	 * для начала это просто квадратные куски графики, скругленные
	 * в месте сгиба.
	 * @author Alekperov Samir
	 * @version 0.0.0
	 * @usage Установите static переменные перед(иначе будут ошибки) созданием экземпляров. 
	 * stemSegmentMaxHeight устанавливается в первую очередь
	 */
	public class FlowerStemSegment {
		
		function FlowerStemSegment (segmentSN:uint, backgroundPicture:DisplayObject, segmentSprite:Sprite, zeroPointOffset:Number, stemSegmentMaxHeight:Number, stemWidth:Number, minAngle:Number=0, maxAngle:Number=0, angle:Number=0, coefficientOfElasticity:Number = 1) {
			if (segmentSprite == null) {
				throw new ArgumentError("segmentSprite must be non-null");}
			this.segmentSprite = segmentSprite;
			this.coefficientOfElasticity = coefficientOfElasticity;
			this.zeroPointOffset = zeroPointOffset;
			this.backgroundPicture = backgroundPicture;
			this.stemSegmentMaxHeight = stemSegmentMaxHeight;
			this.stemWidth = stemWidth;
			this.segmentSN = segmentSN;
			this.minAngle = minAngle;
			this.maxAngle = maxAngle;
			this.defaultAngle = angle;
			
			stemSegmentMaxHeightMINUSzeroPointOffset = stemSegmentMaxHeight- zeroPointOffset;/// performance
			segmentSNMULTIPLYsegmentHeightMINUSsegmentOffset = segmentSN*(stemSegmentMaxHeight-zeroPointOffset);
			
			set_angle(angle);
			yPosition = segmentSN*(stemSegmentMaxHeight-zeroPointOffset);//(segmentSN-1) 25.11.2010_[02#14#22]_[4]
			
			
			segmentSprite.addChild(branchContainerSprite);
			segmentSprite.mouseEnabled = false;/// performance
			segmentSprite.mouseChildren = false;/// performance
			backgroundPictureMaskSprite.mouseEnabled = false;/// performance
			backgroundPictureMaskSprite.mouseChildren = false;/// performance
			backgroundPicture.mouseEnabled = false;/// performance
			backgroundPicture.mouseChildren = false;/// performance
			
			segmentSprite.addChild(backgroundPictureMaskSprite);
			segmentSprite.addChild(backgroundPicture);
			backgroundPictureMaskSprite.y = zeroPointOffset;
			updateMaskSprite();
			backgroundPicture.mask = backgroundPictureMaskSprite;
			
			//
			if (DEBUG_MODE) {
				var tf:TextField = new TextField();
				tf.defaultTextFormat = new TextFormat(null, 10, 0xFFFFFF,true);
				tf.width = 15;
				tf.height = 15;
				tf.text = segmentSN;
				var b:BitmapData = new BitmapData(15, 15, false, 0);
				b.draw(tf);
				var bb:Bitmap = segmentSprite.addChild(new Bitmap(b));
				bb.x = stemWidth;
				bb.y = -15;
				bb.alpha = .6;
				segmentSprite.graphics.lineStyle(1, 0xFF0000);
				segmentSprite.graphics.lineTo(9, 0);
			}
		}
		
		public static var DEBUG_MODE:Boolean = false;
		
		//{ Working with segment
		/**
		 * возвращает копию сегмента
		 * @return
		 */
		public function getCopy():FlowerStemSegment {
			return new FlowerStemSegment(segmentSN, backgroundPicture, segmentSprite, zeroPointOffset, stemSegmentMaxHeight, stemWidth, minAngle, maxAngle, angle);
		}
		public function hitTest(X:Number, Y:Number):Boolean {
			return backgroundPictureMaskSprite.hitTestPoint(X, Y);
		}
		/**
		 * false если изображение стебля в этом сегменте отсутствует(визуально)
		 */
		public function get stemImageVisible():Boolean {
			return backgroundPicture.y<0;
		}
		public var segmentSNMULTIPLYsegmentHeightMINUSsegmentOffset:Number;/// performance
		//} END OF Working with segment
		
		//{ working with branches and textures
		
		/**
		 * установка стебля или листка
		 * @param	stem
		 * @param	targetY if null - budPlacementMode
		 */
		public function placeStem(stem:StemBranch, targetY:Number):void {
			//if (stem.parent != branchContainerSprite) {optimized for performance
			stemSpriteReference = stem.get_sprite();
			if (stem.cachedSegmentSN != segmentSN) {
				stem.cachedSegmentSN = segmentSN;
				branchContainerSprite.addChild(stemSpriteReference);
				stemSpriteReference.x = 0;
			}
			
			if (targetY == -77777) {// bud placement mode
				stemSpriteReference.y = backgroundPicture.y;
				return;
			}
			
			stemSpriteReference.y = zeroPointOffset-targetY%stemSegmentMaxHeightMINUSzeroPointOffset;
		}
		
		private var stemSpriteReference:DisplayObject;/// performance
		private var stemSegmentMaxHeightMINUSzeroPointOffset:Number;/// performance
		
		/**
		 * from 0 to 1
		 * @param	scale
		 */
		public function setStemImageScaleX(scale:Number):void {
			backgroundPicture.scaleX = scale;
		}
		
		public function setImageOffset(offset:Number):void {
			backgroundPicture.y = (zeroPointOffset- offset)+segmentSNMULTIPLYsegmentHeightMINUSsegmentOffset;
		}
		
		/**
		 * рисует скругленную маску для рисунка сегмента. Вызывается после смены толщины стебля
		 */
		private function updateMaskSprite():void {
			backgroundPictureMaskSprite.graphics.clear();
			backgroundPictureMaskSprite.graphics.beginFill(0);
			backgroundPictureMaskSprite.graphics.drawRoundRectComplex(
				-stemWidth/2, -stemSegmentMaxHeight, stemWidth, stemSegmentMaxHeight, 0, 0,stemWidth/4, stemWidth/4);
			
			backgroundPictureMaskSprite.graphics.endFill();
		}
		
		//} END OF working with branches and textures
		
		//{ working with angles
		
		public function set_angle(value:Number):void {
			angle = value;
			if (angle > maxAngle) {
				angle = maxAngle;
			} else if (angle < minAngle) {
				angle = minAngle;
			}
			
			segmentSprite.rotation = angle;
		}
		public function set_minAngle(value:Number):void {minAngle = value;}
		public function set_maxAngle(value:Number):void {maxAngle = value;}
		
		public function get_angle():Number {return angle;}
		public function get_defaultAngle():Number {return defaultAngle;}
		public function get_minAngle():Number {return minAngle;}
		public function get_maxAngle():Number {return maxAngle;}
		
		private var angle:Number;
		private var defaultAngle:Number;
		private var minAngle:Number;
		private var maxAngle:Number;
		
		//} END OF working with angles
		
		//{ Segment data & refs
		
		/**
		 * высота нижней точки сегмента относительно начала стебля
		 */
		public var yPosition:Number;
		/**
		 * номер сегмента
		 */
		public var segmentSN:uint;
		/**
		 * ширина стебля
		 */
		private var stemWidth:Number;
		/**
		 * высота сегмента
		 */
		private var stemSegmentMaxHeight:Number;
		/**
		 * ссылка на стебель
		 */
		private var parentStemReference:FlowerStem;
		/**
		 * рисунок стебля - растровое, векторное or whatever изображение
		 */
		private var backgroundPicture:DisplayObject;
		/**
		 * высота рисунка стебля
		 */
		private var backgroundPictureHeight:uint;
		/**
		 * контейнер всех спрайтов сегмента
		 */
		private var segmentSprite:DisplayObjectContainer;
		public function get_segmentSprite():DisplayObjectContainer {return segmentSprite;}
		/**
		 * контейнер для ответвлений
		 */
		private var branchContainerSprite:Sprite = new Sprite();
		/**
		 * спрайт маска
		 */
		private var backgroundPictureMaskSprite:Sprite = new Sprite();
		/**
		 * положение рисунка по вертикали(для вертикального роста)
		 */
		private var backgroundPictureY:Number = 0;
		/**
		 * макс ширина сегмента
		 */
		private var stemSegmentMaxWidth:Number;
		
		private var zeroPointOffset:Number;
		
		//} END OF Segment data & refs
		
		//{ Wind
		
		/**
		 * 
		 * @param	degrees
		 * @return amount of degrees not absorbed
		 */
		public function absorbDegrees(degrees:Number):Number {
			angle += degrees*coefficientOfElasticity;
			if (angle > maxAngle) {
				angle = maxAngle;
				return degrees;
			} else if (angle < minAngle) {
				angle = minAngle;
				return degrees;
			}
			
			segmentSprite.rotation = angle;
			
			return degrees-degrees*coefficientOfElasticity;
		}
		
		/**
		 * коэффициент упругости 0...1
		 */
		private var coefficientOfElasticity:Number;
		//} END OF Wind
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		public function toString():String {
			return [segmentSN, angle, minAngle, maxAngle].join("N");
		}
		//} END OF serialization
		
	}
}