package org.jinanoimateydragoncat.works.contract.flower_physics {
	
	import flash.display.Sprite;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	
	/**
	 * соединение ветки к ветке
	 * (используется для упрощения установки стороны ветки(справа слева))
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class Junction extends Sprite {
		
		/**
		 * 
		 * @param	branch ветвь, прикрепленная соединением
		 */
		function Junction (branch:StemBranch, sprite:Sprite) {
			this.branch = branch;
			addChild(sprite);
		}
		
		/**
		 * ветвь, прикрепленная соединением
		 * @return ветвь, прикрепленная соединением
		 */
		public function get_branch():StemBranch {
			return branch;
		}
		
		/**
		 * утсановка положения ветви(справа или слева)
		 * @param	side
		 */
		public function setSide(side:uint):void {
			this.side = side;
			if (side == BRANCH_SIDE_RIGHT) {
				scaleY = 1;
			} else {
				scaleY = -1;
			}
		}
		public function getSide():uint {return side;}
		
		/**
		 * положение ветви справа(default)
		 */
		public static const BRANCH_SIDE_RIGHT:uint = 0;
		/**
		 * положение ветви слева
		 */
		public static const BRANCH_SIDE_LEFT:uint = 1;
		
		private var branch:StemBranch;
		private var side:uint;
		
	}
}