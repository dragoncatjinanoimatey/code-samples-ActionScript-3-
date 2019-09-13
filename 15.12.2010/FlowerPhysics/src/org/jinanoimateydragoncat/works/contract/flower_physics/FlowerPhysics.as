package org.jinanoimateydragoncat.works.contract.flower_physics {
	//{import
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.jinanoimateydragoncat.display.utils.Utils;
	import org.jinanoimateydragoncat.net.SwfLoader;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStem;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerSheet;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegment;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerBud;
	import org.jinanoimateydragoncat.works.contract.flower_physics.FlowerStemSegments;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.BranchData;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.ClassProvider;
	import org.jinanoimateydragoncat.works.contract.flower_physics.serialization.Deserializer;
	import FlowerPhysicsLib;
	//}
	
	/**
	 * это класс демки - в нем демонстрируется работа со стеблями
	 * @author Alekperov Samir
	 * @version 0.0.0
	 */
	public class FlowerPhysics extends Sprite {
		
		private var ui:Sprite;//интерфейс скомпилирован в Flash IDE - грузится чтоб не компилить каждый раз+у меня на машине почемуто изза Flash IDE система накрываться стала(недостаточно квот для выполнения команды - даже TaskManager не могу открыть) - на расследование сейчас нет времени - либо система умерла либо Flash IDE.
		
		function FlowerPhysics () {
			//для поиска классов текстур, бутонов, листов, etc
			ClassProvider.addDomain(loaderInfo.applicationDomain);
			
			var libraryLoader:SwfLoader = new SwfLoader('', libraryLoaded, null, libraryNotLoaded , new FlowerPhysicsLib.FlowerPhysicsLibrary_swf());
		}
		
		
		
		private function libraryNotLoaded (reason:String):void {
			throw new Error(reason);
		}
		private function libraryLoaded (displayObject:DisplayObject):void {
			
			ui = addChild(new FPUIClass());
			
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			Mouse.hide();
			ui.getChildByName('cursor').startDrag(true);
			
			
			ui.getChildByName('b0').addEventListener(MouseEvent.MOUSE_DOWN, generateAndPlaceSomething);
			//setCursor(CURSOR_NONE);
			setCursor(CURSOR_SEEDS);
			
			ui.getChildByName('b0').x-= ui.getChildByName('b0').width;
			displayText(TEXT_STATE6);
			
			//generateAndPlaceSomething()
		}
		
		//{ Tests
		private function testSerialization():void {
			setCursor(CURSOR_SEEDS);
			displayText(TEXT_STATE5);
			//этот код выполнится при нажатии на клумбу:
			ui.getChildByName('b0').addEventListener(MouseEvent.MOUSE_DOWN, testSerializationPlaceCopy);
			
			//стебель
			flowerStem = createStem(StemTexture0, 0);
			
			//бутон
			flowerStem.addBranch(createBud(new FlowerBud0(), 100));
			//листья
			flowerStem.addBranch(createSheet(new Sheet0() ,83,1));
			flowerStem.addBranch(createSheet(new Sheet0() ,176,1));
			flowerStem.addBranch(createSheet(new Sheet0() ,53, 0, .3));
			flowerStem.addBranch(createSheet(new Sheet0() ,133,1));
			
			//выросло немного
			flowerStem.set_height(222);
			
			// ветка
			var flowerStem0:FlowerStem = createStem(StemTexture1, 90, 150)
			flowerStem0.addBranch(createBud(new FlowerBud0(), 20));
			flowerStem0.addBranch(createSheet(new Sheet0() ,39,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,89));
			flowerStem0.addBranch(createSheet(new Sheet0() ,59,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,109));
			flowerStem.addBranch(flowerStem0);
			
			placeBranch(flowerStem, 350, 350);
			
			// тут особое внимание!
			//класс Flower нужен для работы с частями цветка
			//второй параметр это, предположительно имя класса Твоего конкретного цветка
			var flower0:Flower = new Flower(flowerStem, "Flower000");
			//информация для восстановления цветка(содержит полную инфу о всех частях цветка, в стебле содержится инфа о ответвлениях)
			testSerialization_data = flower0.getBranchData();
			
			//
		}
		
		private var testSerialization_data:BranchData;
		private function testSerializationPlaceCopy(e:Event):void {
			//создаем цветок, используя сохраненные ранее данные
			var stem212:Flower = Deserializer.instantinateFlowerUsingData(testSerialization_data);
			//размещаем готовый цветок на стейдже(точнее размещаем корневой стебель на кот все держится)
			placeBranch(stem212.rootBranch, stage.mouseX, stage.mouseY);
		}
		//} END OF Tests
		
		
		//{ Helpers
		/**
		 * размещает стебель на экране
		 * @param	X
		 * @param	Y
		 * @return
		 */
		private function placeBranch(stem:StemBranch, X:Number, Y:Number):void {
			var sp:Sprite = addChild(stem.get_sprite());
			sp.y = Y;sp.x = X;
		}
		/**
		 * создает новый листик
		 * @param	imageRef
		 * @param	Y
		 * @param side 0- R 1- L
		 * @return
		 */
		private function createSheet(imageRef:MovieClip, Y:Number, side:uint=0, maxScale:Number=1.5):FlowerSheet {
			var f:FlowerSheet = new FlowerSheet(imageRef, Y, .015, 0, maxScale);
			f.get_junction().setSide((side < 1)?Junction.BRANCH_SIDE_RIGHT:Junction.BRANCH_SIDE_LEFT);
			return f;
		}
		private function createStem(texture:Class, Y:Number, maxH:Number=0, side:uint=0):FlowerStem {
			//var ss:FlowerStem = new FlowerStem(new FlowerStemSegments(16, 12.5*2, 2.5*2, texture, 10), Y, .3, 1, maxH);
			var ss:FlowerStem = new FlowerStem(new FlowerStemSegments(16, 18, 2.5, texture, 10), Y, .3, 1, maxH);
			var c:uint;
			var a:Number = 1.1;
			for each(var s:FlowerStemSegment in ss.get_segments().get_segments()) {
				c+= 1;
				s.set_maxAngle(6);
				s.set_minAngle(-6);
				s.set_angle(((5/(c%4))*a)*(((c/6)%2 < 1)?1:-1));
			}
			ss.get_junction().setSide((side < 1)?Junction.BRANCH_SIDE_RIGHT:Junction.BRANCH_SIDE_LEFT);
			return ss;
		}
		/**
		 * создает новый бутон
		 * @param	imageRef
		 * @param	Y
		 * @return
		 */
		private function createBud(imageRef:MovieClip, Y:Number):FlowerBud {
			return new FlowerBud(imageRef, Y, .005);
		}
		//} END OF Helpers
		
		//{ User interface
		private function displayText(value:String=''):void {
			ui.getChildByName('dt0').text = value;
		}
		private static const TEXT_STATE0:String = "Нажмите мышью, чтобы посадить что-нибудь... На клумбе.";
		private static const TEXT_STATE1:String = "Растет... Ждем, пока вырастит.";
		private static const TEXT_STATE2:String = "Выросло. Можно обрезать.";
		private static const TEXT_STATE3:String = "Промахнулся :( Целься лучше.";
		private static const TEXT_STATE4:String = "Обрезал, можешь еще что-нибудь отрезать.";
		private static const TEXT_STATE5:String = "Жми по клумбе, чтобы скопировать цветок.";
		private static const TEXT_STATE6:String = "Тест ветра.";
		
		private function setCursor(type:uint):void {
			ui.getChildByName('cursor').visible = (type != CURSOR_NONE);
			Mouse[(type == CURSOR_NONE)?'show':'hide']();
			
			ui.getChildByName('cursor').gotoAndStop(type);
		}
		private static const CURSOR_NONE:uint = 0;
		private static const CURSOR_SEEDS:uint = 1;
		private static const CURSOR_WAIT:uint = 2;
		private static const CURSOR_SCISSORS:uint = 3;
		
		//} END OF User interface
		
		//{ general
		
		//{ Command
		private function generateAndPlaceSomething(e:Event=null):void {
			if (e) {
				e.target.removeEventListener(e.type, arguments.callee);
			}
			
			setCursor(CURSOR_WAIT);
			displayText(TEXT_STATE1);
			
			flowerStem = createStem(StemTexture0, 0);
			flowerStem.addBranch(createBud(new FlowerBud0(), 100));
			
			flowerStem.addBranch(createSheet(new Sheet0() ,183,1));
			//flowerStem.addBranch(createSheet(new Sheet0() ,256,1));
			flowerStem.addBranch(createSheet(new Sheet0() ,80));
			flowerStem.addBranch(createSheet(new Sheet0() ,53,1));
			
			var flowerStem0:FlowerStem = createStem(StemTexture0, 150, 150)
			flowerStem0.addBranch(createBud(new FlowerBud0(), 30));
			flowerStem0.addBranch(createSheet(new Sheet0() ,59,1,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,109,0,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,89,1,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,149,0,1));
			flowerStem.addBranch(flowerStem0);
			
			flowerStem0 = createStem(StemTexture0, 230, 100)
			flowerStem0.addBranch(createBud(new FlowerBud1(), 40));
			flowerStem0.addBranch(createSheet(new Sheet0() ,29,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,59));
			flowerStem0.addBranch(createSheet(new Sheet0() ,89));
			flowerStem.addBranch(flowerStem0);
			
			flowerStem0 = createStem(StemTexture0, 135, 150, 1)
			flowerStem0.addBranch(createBud(new FlowerBud1(), 50));
			flowerStem0.addBranch(createSheet(new Sheet0() ,43));
			flowerStem0.addBranch(createSheet(new Sheet0() ,73,1));
			flowerStem0.addBranch(createSheet(new Sheet0() ,113));
			flowerStem.addBranch(flowerStem0);
			
			if (e) {
				placeBranch(flowerStem, mouseX, mouseY);
			} else {
				placeBranch(flowerStem, ui.getChildByName('b0').x, ui.getChildByName('b0').y-ui.getChildByName('b0').height/2);
				LKMP6XCFM1 = true;
			}
			
			//t = 3349;
			
			//start animation
			iid = setInterval(i100, 70);
			//wind:
			flowerStem.get_segments().bendDraggingTop(.08, 40, 60, 7);
			
		}
		private var LKMP6XCFM1:Boolean = false;
		private function setCutState():void {
			
			//im:
			
			//Utils.getBitmapData(flowerStem.get_sprite(), function (bd:BitmapData):void {
				//var b:Bitmap = new Bitmap(bd);
				//b.scaleY = b.scaleX = .73;
				//b.y = 5;
				//b.x = 5;
				//addChild(b);
			//});
			
			ui.getChildByName('helpIm0').visible = true;
			if (!LKMP6XCFM1) {
				setCursor(CURSOR_SCISSORS);
				displayText(TEXT_STATE2);
				
				stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			}
			//displayText();
			
			//wind:
			//flowerStem.get_segments().bendDraggingTop(.07, 40, 40, 10);
		}
		//} END OF Command
		
		//{ Engeneering
		/**
		 * рост растения
		 */
		private function i100():void {
			t+= 1;//скорость роста
			if (t >= 350) {//растет с запасом(чтобы дочерние веточки тоже выросли)
				t = 350;
				clearInterval(iid);
				setCutState();
			}
			flowerStem.set_height(t);
		}
		
		//private var previousSprite:Sprite;
		private var count:uint;
		
		private function mouseDownListener(e:MouseEvent):void {
			var stemPart:FlowerStem = flowerStem.cut(mouseX, mouseY);
			if (stemPart != null) {
				count+= 1;
				placeBranch(stemPart, 30+55*count,  (570-220*((count%2<1)?1:0)));
				displayText(TEXT_STATE4);
			} else {
				displayText(TEXT_STATE3);
			}
		}
		//} END OF Engeneering
		
		//} END OF general
		
		
		
		private var flowerStem:FlowerStem;
		
		private var t:Number=1;
		private var iid:uint;
		
	}
}