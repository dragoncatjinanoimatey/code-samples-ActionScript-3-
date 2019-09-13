// optimized for performance
package org.jinanoimateydragoncat.works.contract.flower_physics {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	
	/**
	 * бутон
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class FlowerBud extends StemBranch {
		
		/**
		 * 
		 * @param	sheetRef
		 * @param	scalePerPixel на это значениие увеличивается Scale при изменении height на единицу
		 * @param budClassName serialization
		 */
		public function FlowerBud (sheetRef:MovieClip, Y:Number, scalePerPixel:Number, startingScale:Number=0, maxScale:Number=1) {
			this.budClassName = getQualifiedClassName(sheetRef);
			budPlacementMode = true;
			sprite = sheetRef;
			sprite.scaleX=0;
			sprite.scaleY = 0;
			MovieClip(sprite).stop();
			totalFrames = MovieClip(sprite).totalFrames;
			this.scalePerPixel = scalePerPixel;
			this.startingScale = startingScale;
			this.maxScale = maxScale;
			set_stemY(Y);
		}
		
		/**
		 * общая высота стебля
		 */
		override public function set_height(value:Number):void {
			stemLength = value;
			
			if (sprite.scaleY < maxScale) {
				sprite.scaleY = Math.min(maxScale,stemLength*scalePerPixel+startingScale);
				gotoAndStop(Math.round(totalFrames*(sprite.scaleY/maxScale)));
				sprite.scaleX = sprite.scaleY;
			}
		}
		
		protected function gotoAndStop(frame:uint):void {
			if (currentFrame != frame) {/// performance
				currentFrame = frame;
				sprite.gotoAndStop(currentFrame);
			}
		}
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		override public function getBranchData():BranchData {
			var data:BranchData = super.getBranchData();
			data.addData({
				type:StemBranch.SERIALIZATION_BRANCH_TYPE_BUD
				,fbSPP:scalePerPixel
				,fbSS:startingScale
				,fbCN:budClassName
			});
			return data;
		}
		
		protected var budClassName:String;
		//} END OF serialization
		
		protected var currentFrame:uint;/// performance
		
		protected var totalFrames:uint;
		/**
		 * увеливичать на %1 каждый пиксель
		 */
		protected var scalePerPixel:Number;
		/**
		 * минимальное(начальное) Scale
		 */
		protected var startingScale:Number;
		/**
		 * максимальное Scale
		 */
		protected var maxScale:Number;
		

		protected function StemBranch_getBranchData():BranchData {
			return super.getBranchData();
		}
	}
}