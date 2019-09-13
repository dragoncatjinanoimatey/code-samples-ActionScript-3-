// optimized for performance
package org.jinanoimateydragoncat.works.contract.flower_physics {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerBud;
	import flash.display.DisplayObjectContainer;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	
	/**
	 * лист
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class FlowerSheet extends FlowerBud {
		
		/**
		 * 
		 * @param	sheetRef
		 * @param	scalePerPixel на это значениие увеличивается Scale при изменении height на единицу
		 * @param sheetClassName serialization
		 */
		function FlowerSheet (sheetRef:MovieClip, Y:Number, scalePerPixel:Number, startingScale:Number=0) {
			super(sheetRef, Y, scalePerPixel, startingScale);
			this.budClassName = getQualifiedClassName(sheetRef);
			
			junction = new Junction(this, sprite);
			budPlacementMode = false;
		}
		
		/**
		 * общая высота стебля
		 */
		public override function set_height(value:Number):void {
			stemLength = value;
			if (sprite.scaleY<1) {
				sprite.scaleY = stemLength*scalePerPixel+ startingScale;
				gotoAndStop(Math.round(totalFrames*sprite.scaleY));
				sprite.scaleX = sprite.scaleY;
			}
		}
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		override public function getBranchData():BranchData {
			var data:BranchData = super.StemBranch_getBranchData();
			data.addData({
				type:StemBranch.SERIALIZATION_BRANCH_TYPE_SHEET
				,fsSPP:scalePerPixel
				,fsSS:startingScale
				,fsCN:budClassName
			});
			return data;
		}
		//} END OF serialization
		
		
		public override function get_sprite():DisplayObject {return junction;}
		public override function setRealSpriteY(value:Number):void {sprite.y = value;}
		
	}
}