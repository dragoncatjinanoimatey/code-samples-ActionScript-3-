// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	import flash.system.ApplicationDomain;
	
	//{ =^_^= import
	//} =^_^= END OF import
	
	
	/**
	 * определение класса по его имени
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 17.09.2010 20:29
	 */
	public class ClassProvider {
		
		//{ =^_^= CONSTRUCTOR
		
		function ClassProvider () {
			throw new ArgumentError("static container only.");
		}
		//} =^_^= END OF CONSTRUCTOR
		
		private static const domains:Vector.<ApplicationDomain> = new Vector.<ApplicationDomain>();
		
		/**
		 * add a place to search definitions in
		 * @param	domain
		 */
		public static function addDomain(domain:ApplicationDomain):void {
			domains.push(domain);
		}
		
		public static function getClass(className:String):Class {
			for each(var i:ApplicationDomain in domains) {
				if (i.hasDefinition(className)) {
					return i.getDefinition(className);
				}
			}
			return null;
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]