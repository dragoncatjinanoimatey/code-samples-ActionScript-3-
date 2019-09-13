// Project FlowerPhysics
package org.jinanoimateydragoncat.works.contract.flower_physics.serialization {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flower_physics.Flower;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStem;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegment;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegments;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 17.09.2010 20:07
	 */
	public class StemDeserializer {
		
		//{ =^_^= CONSTRUCTOR
		
		function StemDeserializer () {
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
				
				var segmentsList:Array = d.fssSD.split("S");
				
				var arr:Array = [];
				for (var i:uint in segmentsList) {
					arr = segmentsList[i].split("N");
					segmentsList[i] = {segmentSN:arr[0], angle:arr[1], minAngle:arr[2], maxAngle:arr[3]};
				}
				
				var textureClass:Class = ClassProvider.getClass(d.fssTCN);
			
				var segments:FlowerStemSegments = new FlowerStemSegments(d.fssNS, d.fssSH, d.fssSO, textureClass, d.fssSW);
				
				// TODO: carefully set segments data: check Array order
				var arrRef:Vector.<FlowerStemSegment> = segments.get_segments();
				for (i in arrRef) {
					arrRef[i].set_maxAngle(segmentsList[i].maxAngle);
					arrRef[i].set_minAngle(segmentsList[i].minAngle);
					arrRef[i].set_angle(segmentsList[i].angle);
					arrRef[i].segmentSN = segmentsList[i].segmentSN;
				}
				
				
				//,fstB:getBranchesList()
			
				var stem:FlowerStem = new FlowerStem(segments, d.sbY, d.fstSW, d.fstWM, d.fstSMH);
				stem.set_sn(parseInt(d.sbSN));
				stem.get_junction().setSide(d.sbS);
				stem.budPlacementMode = d.sbBPM;
				stem.set_height(d.sbSL);
				
				return stem;
				
		}
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]