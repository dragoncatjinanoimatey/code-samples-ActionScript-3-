// optimized for performance
package org.jinanoimateydragoncat.works.contract.flower_physics {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	
	import org.jinanoimateydragoncat.works.contract.flower_physics.Junction;
	
	/**
	 * оветвление (стебель или лист)
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class StemBranch {
		
		//{ Math
		/**
		 * общая высота стебля
		 */
		public function set_height(value:Number):void {
			stemLength = value;// override and place your code here
		}
		/**
		 * общая высота стебля
		 */
		public function get_height():Number {
			return stemLength;// override and place your code here
		}
		/**
		 * расположение на Parent стебле.
		 */
		public function set_stemY(value:uint):void {
			stemY = value;
		}
		/**
		 * расположение на Parent стебле.
		 */
		public function get_stemY():uint {
			return stemY;
		}
		
		/**
		 * угол в градусах
		 */
		public function set_angle(value:Number):void {
			sprite.rotation = value;
		}
		
		/**
		 * прикреплена ли ветвь к родительской ветви
		 */
		private var attached:Boolean = false;// use getters and setters otherwise will not work.
		public function get_attached():Boolean {return attached;}// use getter! otherwise will not work.
		public function set_attached(value:Boolean):void {
			attached = value;
			cachedSegmentSN = uint(-1);
		}
		
		/**
		 * расстояние от начала стебля
		 */
		protected var stemY:Number;
		/**
		 * длина стебля
		 */
		protected var stemLength:Number;
		//} END OF Math
		
		//{ Physics
		/**
		 * ссылка на контейнер стебля или листка
		 */
		public function get_sprite():DisplayObject {
			return sprite;
		}
		/**
		 * ссылка на контейнер стебля или листка
		 */
		protected var sprite:DisplayObjectContainer;
		
		/**
		 * создается в дочерних классах если нужно(для бутона не нужно)
		 */
		protected var junction:Junction;
		public function get_junction():Junction {return junction;}
		
		public function setRealSpriteY(value:Number):void {
			// TODO: override and place your code here
		}
		//} END OF Physics
		
		public var cachedSegmentSN:uint;/// performance

		
		//{ Data
		
		/**
		 * стебель, на кот находится данная ветвь
		 */
		public var parentStem:FlowerStem;
		
		/**
		 * устанавливается на верхушку растущего стебля(используется в бутонах)
		 */
		public var budPlacementMode:Boolean;
		
		//} END OF Data
		
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		public function getBranchData():BranchData {
			return new BranchData({
				sbY:stemY
				,sbS:(get_junction()==null)?0:get_junction().getSide() 
				,sbSL:stemLength
				,sbBPM:budPlacementMode
				,sbSN:sn
			});
		}
		
		/**
		 * part sequence number(valid within Flower)
		 */
		private var sn:uint;
		/**
		 * part sequence number(valid within Flower)
		 * @return
		 */
		public function get_sn():uint {return sn;}
		public function set_sn(a:uint):void {sn = a;}
		
		public static const SERIALIZATION_BRANCH_TYPE_STEM:uint = 0;
		public static const SERIALIZATION_BRANCH_TYPE_SHEET:uint = 1;
		public static const SERIALIZATION_BRANCH_TYPE_BUD:uint = 2;
		//} END OF serialization
		
	}
}