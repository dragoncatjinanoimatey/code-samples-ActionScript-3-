package org.jinanoimateydragoncat.works.contract.flower_physics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegments;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegment;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	import org.jinanoimateydragoncat.works.contract.flower_physics.StemBranch;
	
	
	
	/**
	 * 
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class FlowerStem extends StemBranch {
		
		/**
		 * 
		 * @param	segments
		 * @param	stemY высота на родительском стебле
		 * @param stemMaximumHeight 0 - autodetect
		*/
		function FlowerStem (segments:FlowerStemSegments, Y:Number, startingWidth:Number=0, widthMultiplier:Number = 1, stemMaximumHeight:Number=0) {
			this.segments = segments;
			this.widthMultiplier = widthMultiplier;
			this.startingWidth = startingWidth;
			this.stemMaximumHeight = stemMaximumHeight;
			if (this.stemMaximumHeight<1) {
				this.stemMaximumHeight = segments.calcMaxStemHeight();
			}
			
			set_stemY(Y);
			sprite = segments.sprite;
			sprite.addEventListener(Event.ADDED_TO_STAGE, spriteAddedNowCanSetHeight);
			junction = new Junction(this, sprite);
			set_height(0);
		}
		
		public function get_segments():FlowerStemSegments {
			return segments;
		}
		
		/**
		 * размещение ветки(стебель или лист)
		 * @param	branch
		 */
		public function addBranch(branch:StemBranch):void {
			if (branch.get_stemY() > stemMaximumHeight) {
				branch.set_stemY(stemMaximumHeight);
				//trace('FlowerStem::addBranch()> branch.stemY > stemMaximumHeight\nthe target branch will not be added.');
				//return;
			}
			
			branch.set_attached(false);
			branch.parentStem = this;
			branches.push(branch);
			if (!branch.budPlacementMode) {
				branch.get_junction().rotation = 90;
				branch.get_junction().setSide(branch.get_junction().getSide());// на тот случай, если ветвь была удалена
			}
			segments.placeBranches(branches);
			
		}
		
		public function removeBranch(branch:StemBranch):void {
			branch.get_junction().rotation = 0;
			branch.get_junction().scaleY = 1;
			branches.splice(branches.indexOf(branch), 1);	
		}
		private var addBranchLaterList:Vector.<StemBranch> = new Vector.<StemBranch>();
		
		/**
		 * отрезать от стебля(используется только для создания гербариев)
		 * @param	Y высота точки обрезания на стволе
		 * @return отрезанный кусок ВАЖНО: сделать проверку (отрезаный кусок==от чего отрезаем) - в этом случае отрезается весь стебель - конец обрезания
		 */
		public function cut(X:Number, Y:Number):StemBranch {
			// search for stem and segment
			var stems:Vector.<StemBranch> = new Vector.<StemBranch>();
			// create stems list
			getStems(this, stems);
			
			function getStems(ts:FlowerStem, arr:Vector.<StemBranch>):void {
				arr.push(ts);
				for each(var ii:StemBranch in ts.branches) {
					if (ii is FlowerStem) {
						getStems(ii, arr);
					}
				}
			}
			
			// search for segment
			var targetSegment:FlowerStemSegment;
			var targetStem:FlowerStem;
			for each(targetStem in stems) {
				targetSegment = targetStem.segments.hitTest(X, Y);
				if (targetSegment != null) {break;}//found
			}
			if (targetSegment == null) {return null;}
			if (targetSegment.segmentSN < 1) {
				if (targetStem.parentStem != null) {
					targetStem.parentStem.removeBranch(targetStem);
				}
				return targetStem;
			}
			//targetSegment.backgroundPicture.filters = [new GlowFilter(0xFF0000, .8, 6, 6)];
			//if (1) {return null};// WTF?????????????? FUCK FLASH AVM2 FUCKIN  CODERS!!!!!!!!!!
			
			// find all following branches
			var c:uint;
			var branchesList:Vector.<StemBranch> = new Vector.<StemBranch>();
			for each(var i:StemBranch in targetStem.branches) {
				if (i.get_stemY() >= targetSegment.yPosition || i.budPlacementMode) {
					// add to list
					branchesList.push(i);
					//i.get_sprite().filters = [new GlowFilter(0x0000FF, .8, 7, 7)];
				}
			}
			//trace(targetSegment.yPosition);
			//if (1) {return null;}
			for each(i in branchesList) {
				targetStem.branches.splice(targetStem.branches.indexOf(i), 1);
			}
			var newStem:FlowerStem = targetStem.getCopyWithSegmentsAndDataOnly();
			// cut segments from oldStem
			targetStem.segments.removeSegmentsAfterAndThis(Math.max(0,targetSegment.segmentSN));
			// cut segments from newStem
			newStem.segments.removeSegmentsBefore(Math.max(0,targetSegment.segmentSN));
			
			// add branches to stem and return it
			for each(var b:StemBranch in branchesList) {
				newStem.addBranch(b);
			}
			return newStem;
		}
		
		private function getCopyWithSegmentsAndDataOnly():FlowerStem {
			var segmentsData:Object = this.segments.getInitData();
			//trace('creating new segments:num='+segmentsData.numSegments);
			var newSegments:FlowerStemSegments = new FlowerStemSegments(segmentsData.numSegments, segmentsData.segmentHeight, segmentsData.segmentOffset, segmentsData.textureClass, segmentsData.stemWidth);
			var stem:FlowerStem = new FlowerStem(newSegments, 0, startingWidth, widthMultiplier, stemMaximumHeight);
			stem.set_height(stemLength);
			var s:Array = [];
			for (var i:uint in segments.get_segments()) {
				s.push(segments.get_segments()[i].segmentSN);
				newSegments.get_segments()[i].set_maxAngle(segments.get_segments()[i].get_maxAngle());
				newSegments.get_segments()[i].set_minAngle(segments.get_segments()[i].get_minAngle());
				newSegments.get_segments()[i].set_angle(segments.get_segments()[i].get_angle());
			}
			//trace('new segments:'+s)
			
			return stem;
		}
		
		public override function setRealSpriteY(value:Number):void {
			sprite.y = value;
		}
		
		/**
		 * ссылка на контейнер стебля
		 */
		public override function get_sprite():DisplayObject {
			return junction;
		}
		
		public override function set_height(value:Number):void {
			stemLength = value;
			if (spriteNotAdded) {return;}
			
			if (value > stemMaximumHeight) {value = stemMaximumHeight;}
			
			segments.setStemWidth((value/stemMaximumHeight)*widthMultiplier+startingWidth);
			segments.setTextureOffset(value);
			//}
			
			segments.updateBranches(branches, get_height(), value);
		}
		
		public function getBitmap(transparent:Boolean=false,fillColor:uint=0xFFFFFF):Bitmap {
			junction.graphics.beginFill(0xFF3388,0);
			junction.graphics.lineStyle(1, 0xFF0000);
			junction.graphics.drawRect(0, 0, 470, 450);
			junction.graphics.endFill();
			
			
			junction.getChildAt(0).x = 200;
			junction.getChildAt(0).y = 450;
			junction.x -= 400;
			junction.y -= 500;
			
			junction.addChild(new Sheet0()).y = 35;
			
			var bitmapData:BitmapData = new BitmapData(470, 450,transparent,fillColor);
			
			bitmapData.draw(junction);
			return new Bitmap(bitmapData);
		}
		
		private function getRealBounds(displayObject:DisplayObject):Rectangle {
			var bounds:Rectangle;
			var boundsDispO:Rectangle = displayObject.getBounds(displayObject);
			var bitmapData:BitmapData = new BitmapData(int(boundsDispO.width+0.5),int(boundsDispO.height+0.5), true, 0);
			
			var matrix:Matrix = new Matrix();
			matrix.translate(-boundsDispO.x, -boundsDispO.y);
			
			bitmapData.draw(displayObject, matrix, new ColorTransform( 1, 1, 1, 1, 255, -255, -255, 255 ));
			
			bounds = bitmapData.getColorBoundsRect( 0xFF000000, 0xFF000000 );
			bounds.x += boundsDispO.x;
			bounds.y += boundsDispO.y;
			
			bitmapData.dispose();
			return bounds;
		}
		
		//{ нельзя проводить работы до добавления на сцену(почему-то(подозрение на маски))
		
		private var spriteNotAdded:Boolean = true;
		private function spriteAddedNowCanSetHeight(e:Event=null):void {
			spriteNotAdded = false;
			
			e.target.removeEventListener(e.type, arguments.callee);
			
			set_height(stemLength);
		}
		//}
		
		/**
		 * максимальная длина ствола
		 * #
		 */
		public var stemMaximumHeight:Number;
		/**
		 * множитель ширины
		 * #
		 */
		private var widthMultiplier:Number;
		/**
		 * начальная ширина
		 * #
		 */
		private var startingWidth:Number;
		
		/**
		 * массив с ответвлениями растения
		 */
		private var branches:Vector.<StemBranch> = new Vector.<StemBranch>();
		public function get_branches():Vector.<StemBranch> {return branches;}
		
		private var segments:FlowerStemSegments;
		
		//{ serialization
		/**
		 * генерация данных для сохранения состояния
		 * @return 
		 */
		override public function getBranchData():BranchData {
			var data:BranchData = super.getBranchData();
			
			function getBranchesList():Array {
				var snList:Array=[];
				for each(var i:StemBranch in branches) {
					snList.push(i.get_sn());
				}
				
				return snList;
			}
			
			data.addData({
						type:StemBranch.SERIALIZATION_BRANCH_TYPE_STEM
						,fstSW:startingWidth
						,fstWM:widthMultiplier
						,fstSMH:stemMaximumHeight
						,fstB:getBranchesList()
			});
			//add segments data:
			data.addData(segments.getBranchData().getData());
			return data;
		}
		//} END OF serialization
	}
}