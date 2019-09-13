// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} =^_^= END OF import
	
	
	/**
	 * сохранение, загрузка состояния элементов растения
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 */
	public class BranchData {
		
		//{ =^_^= CONSTRUCTOR
		/**
		 * 
		 * @param	dataObject any simple object
		 */
		function BranchData (dataObject:Object) {
			data = dataObject;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function addData(dataObject:Object):void {
			for (var i:String in dataObject) {
				data[i] = dataObject[i];
			}
		}
		
		public function getData():Object {return data;}
		
		private var data:Object;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]