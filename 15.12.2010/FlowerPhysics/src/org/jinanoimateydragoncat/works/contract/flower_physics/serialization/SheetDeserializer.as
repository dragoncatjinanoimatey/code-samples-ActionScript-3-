// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	
	//{ =^_^= import
	import flash.utils.getQualifiedClassName;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerSheet;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 17.09.2010 20:07
	 */
	public class SheetDeserializer {
		
		//{ =^_^= CONSTRUCTOR
		
		function SheetDeserializer () {
			throw new ArgumentError("static container only.");
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * создание элемента цветка  
		 * @param	data
		 * @return елемент(стебель бутон или лист)
		 */
		public static function instantinateUsingData(data:BranchData):StemBranch {
			var d:Object = data.getData();
			var c:Class = ClassProvider.getClass(d.fsCN);
			var s:FlowerSheet = new FlowerSheet(new c(), d.sbY, d.fsSPP, d.fsSS);
			s.set_sn(parseInt(d.sbSN));
			s.get_junction().setSide(d.sbS);
			//s.set_height(d.sbSL);
			return s;
		}
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]