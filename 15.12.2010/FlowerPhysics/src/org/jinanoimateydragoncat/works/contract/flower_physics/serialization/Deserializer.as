// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flower_physics.Flower;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStem;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 17.09.2010 19:51
	 */
	public class Deserializer {
		
		//{ =^_^= CONSTRUCTOR
		
		function Deserializer () {
			throw new ArgumentError("static container only.");
		}
		
		/**
		 * создание элемента цветка  
		 * @param	data
		 * @return елемент(стебель бутон или лист)
		 */
		public static function instantinateFlowerUsingData(data:BranchData):Flower {
			var d:Object = data.getData();
			// create parts
			var parts:Vector.<StemBranch> = new Vector.<StemBranch>();
			for each(var i:Object in d.parts) {
				parts.push(instantinatePartUsingData(new BranchData(i)));
			}
			var flower:Flower;
			// find and attach root path
			
			var f:uint = 0;
			var l:uint = d.parts.length;
			/**
			 * @return {branch:parts[f], data:d.parts[f]}
			 */
			function getBranchAndDataBySN(sn:uint):Object {
				for (f = 0; f < l; f+= 1) {
					if (parts[f].get_sn() == sn) {
						return {branch:parts[f], data:d.parts[f]};
					}
				}
				return null;
			}
			
			flower = new Flower(getBranchAndDataBySN(parseInt(d.rootBranchSN)).branch, d.className);
			
			if (flower == null) {
				throw new Error("can't find root branch");
			}
			
			var rootPartData:Object;
			
			for each(i in d.parts) {
				if (i.sbSN==d.rootBranchSN) {
					rootPartData = i;
					break;
				}
			}
			
			var bbdd:Object;
			function attachBranches(targetBranch:FlowerStem, targetBranchData:Object):void {
				for each(var s:String in targetBranchData.fstB) {
					bbdd = getBranchAndDataBySN(parseInt(s));
					
					targetBranch.addBranch(bbdd.branch);
					if (bbdd.branch is FlowerStem) {
						attachBranches(bbdd.branch, bbdd.data);
					}
				}
			}
			
			attachBranches(flower.rootBranch, rootPartData);
			
			return flower;
		}
		
		/**
		 * создание элемента цветка  
		 * @param	data
		 * @return елемент(стебель бутон или лист)
		 */
		public static function instantinatePartUsingData(data:BranchData):StemBranch {
			// determine type
			var d:Object = data.getData();
			switch (d.type) {
			
			case StemBranch.SERIALIZATION_BRANCH_TYPE_STEM:
				return StemDeserializer.instantinateUsingData(data);
				break;
			
			case StemBranch.SERIALIZATION_BRANCH_TYPE_SHEET:
				return SheetDeserializer.instantinateUsingData(data);	
				break;
			
			case StemBranch.SERIALIZATION_BRANCH_TYPE_BUD:
				return BudDeserializer.instantinateUsingData(data);
				break;
			
			}
		}
		
		//} =^_^= END OF CONSTRUCTOR
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]