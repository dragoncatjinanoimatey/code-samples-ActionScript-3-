// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	
	//{ =^_^= import
	import flash.utils.getQualifiedClassName;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerBud;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 17.09.2010 20:07
	 */
	public class BudDeserializer {
		
		//{ =^_^= CONSTRUCTOR
		
		function BudDeserializer () {
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
			var c:Class = ClassProvider.getClass(d.fbCN);
			var b:FlowerBud = new FlowerBud(new c(), d.sbY, d.fbSPP, d.fbSS)
			b.set_sn(parseInt(d.sbSN));
			//b.set_height(d.sbSL);
			return b;
		}
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]