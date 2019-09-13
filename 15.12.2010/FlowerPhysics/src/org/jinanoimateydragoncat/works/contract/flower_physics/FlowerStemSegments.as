package org.jinanoimateydragoncat.works.contract.flower_physics {
	//{ import
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegment;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStem;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	//} END OF import
	
	/**
	 * содержит все данные и методы относящиеся к сегментам
	 * @author Alekperov Samir
	 * @version 0.0.0
	 * @param textureClassName serialization
	 */
	public class FlowerStemSegments {
		
		function FlowerStemSegments (numSegments:uint, segmentHeight:uint, segmentOffset:uint, textureClass:Class, stemWidth:Number) {
			this.textureClassName = getQualifiedClassName(textureClass);
			this.numSegments = numSegments;
			this.segmentHeight = segmentHeight;
			this.segmentOffset = segmentOffset;
			this.textureClass = textureClass;
			this.stemWidth = stemWidth;
			prepareSegments();
		}
		
		//{ DataCache
		
		/**
		 * ширина стебля
		 */
		public var stemWidth:Number;
		//} END OF DataCache
		
		//{ working with segments (data and physical)
		
		public function removeSegmentsAfterAndThis(segmentID:uint):void {
			//trace('removeSegmentsAfterAndThis segmentID='+segmentID)
			//trace('old numSegments'+numSegments)
			numSegments = segmentID;
			//trace('new numSegments'+numSegments)
			
			//var s:Array = [];
			//for each(var i:FlowerStemSegment in segments) {s.push(i.segmentSN);}trace('before'+ s);
			
			
			for each(var i:FlowerStemSegment in segments) {
				if (i.segmentSN == segmentID) {break;}
			}
			i.get_segmentSprite().parent.removeChild(i.get_segmentSprite());
			
			
			segments.splice(segments.indexOf(i), segments.length-segments.indexOf(i));
			
			//s = [];
			//for each(i in segments) {s.push(i.segmentSN);}trace('old stem after'+ s);
			
		}
		
		public function removeSegmentsBefore(segmentID:uint):void {
			//if (segmentID < 2 || segments[0].segmentSN == segmentID) {
			if (segments.length<2 || segmentID<=segments[0].segmentSN) {
				trace('FlowerStemSegments::removeSegmentsBeforeAndThis() can\'t remove segment with ID='+segmentID);
				return;
			}
			for (var i:uint = 1; i < segments.length;i++) {
				if (segments[i].segmentSN == segmentID) {i = Math.max(0,i-1);break;}
			}
			sprite.removeChild(rootSegmentSprite);
			//segments[i].get_segmentSprite().parent.removeChild(segments[i].get_segmentSprite());
			if (rootSegmentSprite.parent!=null) {rootSegmentSprite.parent.removeChild(rootSegmentSprite);}
			
			rootSegmentSprite = segments[i+1].get_segmentSprite();
			sprite.addChild(rootSegmentSprite);
			segments.splice(0, i+1);
		}
		
		//} END OF working with segments (data and physical)
		
		//{ Segments sprites
		/**
		 * находит сегмент под координатами
		 * @param	X
		 * @param	Y
		 */
		public function hitTest(X:Number, Y:Number):FlowerStemSegment {
			var result:FlowerStemSegment;
			for each(var i:FlowerStemSegment in segments) {
				if (i.hitTest(X, Y)) {return i;}
			}
			return null;
		}
		
		private function prepareSegments():void {
			sprite = new Sprite();
			var sp:Sprite;
			
			rootSegmentSprite = new Sprite();
			rootSegmentSprite.name = 's';
			rootSegmentSprite.y = -segmentOffset;
			segments.push(new FlowerStemSegment(0, new textureClass(), rootSegmentSprite, segmentOffset, segmentHeight, stemWidth, 0, 0, 0, Math.max(0, minСoefficientOfElasticity)));
			topSegmentRef = segments[0];
			//
			sprite.addChild(rootSegmentSprite);
			sp = rootSegmentSprite;
			
			for (var i:uint = 0; i < numSegments-1; i++ ) {
				sp = sp.addChild(new Sprite());
				sp.name = 's';
				sp.y = -segmentHeight+ segmentOffset;
				
				segments.push(new FlowerStemSegment(i+1, new textureClass(), sp, segmentOffset, segmentHeight, stemWidth, 0, 0, 0, Math.max(minСoefficientOfElasticity, (i+1)/numSegments+coefficientOfElasticityOffset)));
			}
		}
		
		/**
		 * from 0 to 1
		 * @param	
		 */
		public function setStemWidth(scale:Number):void {
			scale = Math.max(Math.min(1, scale),0);
			for each(var segment:FlowerStemSegment in segments) {
				segment.setStemImageScaleX(scale);
			}
		}
		
		public function get_segments():Vector.<FlowerStemSegment> {
			return segments;
		}
		
		private var segments:Vector.<FlowerStemSegment> = new Vector.<FlowerStemSegment>();
		/**
		 * ссылка на корневой сегмент
		 */
		private var rootSegmentSprite:DisplayObjectContainer;
		/**
		 *ссылка на пустой спрайт с корневым сегментом (для прикрепления цветка и последующего отображения)
		 */
		public var sprite:DisplayObjectContainer;
		
		public function removeEmptySegments():void {
			
		}
		
		/**
		 * всего сегментов
		 */
		private var numSegments:uint;
		private var segmentHeight:uint;
		private var segmentOffset:uint;
		//} END OF Segments sprites
		
		//{ Textures
		/**
		 * pixels
		 * @param offset
		 */
		public function setTextureOffset(offset:Number):void {
			for each(var segment:FlowerStemSegment in segments) {
				segment.setImageOffset(offset);
				if (offset >= segment.yPosition && topSegmentRef!=segment) {
					topSegmentRef = segment;//will it speed up or not??
				}
			}
		}
		
		/**
		 * текстура ствола
		 */
		private var textureClass:Class;
		//} END OF Textures
		
		//{ Branches
		/**
		 * для установки ветвей и обновления их высоты. Установленные ветви are will not be affected
		 * @param	branches
		 */
		public function placeBranches(branches:Vector.<StemBranch>):void {
			// порядок рассчета координат точки прикрепления стеблей аналогично бутону:
			var spnum:uint;
			var targetSprite:FlowerStemSegment;
			var l:uint = segments.length-1;
			for each(var targetBranch:StemBranch in branches) {
				if (targetBranch.get_attached()) {continue;}
				
				// нахождение Sprite с необходимой высотой
				for (var i:uint = 0; i < l; i++) {
					if (targetBranch.get_stemY() < segments[i+1].yPosition) {
						spnum = i;//25.11.2010_[02#14#22]_[4]
						break;
					}
				}
				targetSprite = segments[spnum];
				// установка стебля
				targetSprite.placeStem(targetBranch, targetBranch.get_stemY());
				targetBranch.set_attached(true);
			}
		}
		
		/**
		 * обновляет длину/Scale бутона, дочерних стеблей, листьев
		 * вызывается при :
		 * изменении цветка(рост)
		 */
		public function updateBranches(branches:Vector.<StemBranch>, stemHeight:Number, y:Number):void {
			for each(var targetStem:StemBranch in branches) {
				if (targetStem.budPlacementMode) {
					//findTopSegment().placeStem(targetStem, -77777);
					// TODO: check whether this will speed up the process
					topSegmentRef.placeStem(targetStem, -77777);
				}
				
				if (stemHeight > targetStem.get_stemY()) {
					targetStem.set_height(stemHeight - targetStem.get_stemY());
				}
			}	
		}
		/**
		 * находит сегмент, содержащий верхушку стебля
		 * @return
		 */
		private function findTopSegment():FlowerStemSegment {
			for (var i:uint = segments.length-1; i>0; i--) {
				if (segments[i].stemImageVisible) {return segments[i];}
			}
			return segments[0];
		}
		private var topSegmentRef:FlowerStemSegment;/// performance ??
		//} END OF Branches
		
		//{ Misc
		public function getInitData():Object {
			return {
			numSegments:this.numSegments,
			segmentHeight:this.segmentHeight,
			segmentOffset:this.segmentOffset,
			textureClass:this.textureClass,
			stemWidth:this.stemWidth
			};
			
		}
		
		public function calcMaxStemHeight():Number {
			return (segmentHeight-segmentOffset)*(segments.length);
		}
		//} END OF Misc
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		public function getBranchData():BranchData {
			return new BranchData({
				fssTCN:textureClassName
				,fssSO:segmentOffset
				,fssSH:segmentHeight
				,fssNS:numSegments
				,fssSW:stemWidth
				,fssSD:segments.join("S")
			});
		}
		
		private var textureClassName:String;
		//} END OF serialization
		
		//{ Wind
		
		/**
		 * согнуть, перетаскивая за верхушку(самый верхний сегмент)
		 * @param	angle величина угола сгибания (для каждого шага)
		 * @param	stepDuration длительность шага (мс)
		 * @param	numSteps количество шагов
		 * @param attenuationStrength сила затухания
		 */
		public function bendDraggingTop(angle:Number, stepDuration:Number, numSteps:int, attenuationStrength:Number):void {
			if (runningWind) {return;}
			windTimer = new Timer(stepDuration);
			this.wind_angle = angle;
			this.attenuationStrength = attenuationStrength;
			this.wind_numSteps = numSteps;
			this.wind_initNumSteps = numSteps;
			windTimer.addEventListener(TimerEvent.TIMER, windBendOperation, false, 0, true);
			startWind();
		}
		
		private function startWind():void {
			runningWind = true;
			wind_currentStepNum = 0;
			windTimer.start();
		}
		
		private function windBendOperation(e:TimerEvent):void {
			wind_PrevCurrentStepNum = wind_currentStepNum;
			wind_currentStepNum+= wind_stepIncrementMultiplier;
			if (Math.abs(wind_currentStepNum) > wind_numSteps/2) {
				wind_PrevCurrentStepNum = wind_currentStepNum;
				wind_currentStepNum += wind_stepIncrementMultiplier*Math.ceil((wind_numSteps/10)*((Math.abs(wind_currentStepNum)- wind_numSteps/2)/wind_numSteps));
				//L8XL7CCUR2 = 1+2*((Math.abs(wind_currentStepNum)- wind_numSteps/2)/wind_numSteps);
			}
			
			if (wind_currentStepNum > wind_numSteps || wind_currentStepNum<-wind_numSteps) {
				wind_stepIncrementMultiplier *= -1;
				numWaves+= 1;
			}
			
			if (wind_currentStepNum == 0) {
				wind_numSteps-= attenuationStrength;
				wind_angle -= wind_angle*(attenuationStrength/wind_initNumSteps);
				if (wind_numSteps < 1) {
					runningWind = false;
					windTimer.stop();
					return;
				}
				for each(var ii:FlowerStemSegment in segments) {
					ii.absorbDegrees(wind_angle*L8XL7CCUR2*Math.min(1, (wind_numSteps- Math.abs(wind_PrevCurrentStepNum))/wind_numSteps)*wind_stepIncrementMultiplier)/2;
				}
				return;
			}
			
			for each(var i:FlowerStemSegment in segments) {
				i.absorbDegrees(wind_angle*L8XL7CCUR2*Math.min(1, (wind_numSteps- Math.abs(wind_currentStepNum))/wind_numSteps)*wind_stepIncrementMultiplier);
			}
		}
		
		/**
		 * выполняется?
		 */
		private var runningWind:Boolean;
		private var wind_numSteps:int;
		private var wind_initNumSteps:int;
		private var wind_PrevCurrentStepNum:int;
		private var wind_currentStepNum:int;
		private var wind_stepIncrementMultiplier:int = 1;
		private var wind_angle:Number;
		private var numWaves:uint;
		private var L8XL7CCUR2:Number = 1;
		
		
		/**
		 * сила затухания
		 */
		private var attenuationStrength:Number;
		/**
		 * смещение коэффициента элластичности сегмента
		 */
		private var coefficientOfElasticityOffset:Number = .7;
		/**
		 * минимальная величина коэффициента элластичности сегмента (для всех сегментов)
		 */
		private var minСoefficientOfElasticity:Number = 0;
		
		private var windTimer:Timer;
		//} END OF Wind
	}
}