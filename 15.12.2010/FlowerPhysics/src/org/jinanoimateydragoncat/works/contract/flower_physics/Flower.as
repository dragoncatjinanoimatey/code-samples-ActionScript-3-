package org.jinanoimateydragoncat.works.contract.flower_physics {
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	
	/**
	 * класс цветка
	 * все управление частями цветка здесь
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class Flower {
		
		function Flower (rootBranch:StemBranch, flowerClassName:String) {
			this.rootBranch = rootBranch;
			this.flowerClassName = flowerClassName;
		}
		
		/**
		 * корневая ветвь к которой все крепится
		 */
		public var rootBranch:FlowerStem;
		/**
		 * имя класса для конкретного цветка(класс с подгружаемого swf файла)
		 */
		public var flowerClassName:String;
		
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		public function getBranchData():BranchData {
			// create parts list
			var parts:Vector.<StemBranch> = new Vector.<StemBranch>();
			getBranches(rootBranch, parts);
			
			var lastUsedSN:uint = 0;
			
			function getBranches(ts:StemBranch, arr:Vector.<StemBranch>):void {
				arr.push(ts);
				
				ts.set_sn(lastUsedSN);lastUsedSN+= 1;
				
				for each(var ii:StemBranch in ts.get_branches()) {
					arr.push(ii);
					ii.set_sn(lastUsedSN);lastUsedSN+= 1;
					if (ii is FlowerStem) {
						getBranches(ii, arr);
					}
				}
			}
			// collect parts data
			var partsData:Array = new Array();
			for each(var i:StemBranch in parts) {
				partsData.push(i.getBranchData().getData());
			}
			
			return new BranchData({
				parts:partsData
				,rootBranchSN:rootBranch.get_sn()
				,className:flowerClassName
			});
			
		}
		//} END OF serialization
	}
}