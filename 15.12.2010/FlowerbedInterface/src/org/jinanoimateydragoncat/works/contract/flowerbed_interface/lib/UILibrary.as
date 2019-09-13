// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * Library contains image BitmapData available through public static properties. Call "initializeLibrary" static method before using Library.
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:58
	 */
	public class UILibrary {
		
		//{ =^_^= CONSTRUCTOR
		
		function UILibrary () {throw(new ArgumentError('Library contains images that are available through public static properties. Invoke "initialize" static method before using Library.'));}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * prepare library for using
		 */
		public static function initialize():void{
			createBitmaps();
			//processBitmaps();
		}
		
		[Embed(source="im/sampleImage0.jpg")]private static const sampleImage0_jpg:Class;
		public static var sampleImage0:BitmapData;
		
		[Embed(source="im/sampleImage1.jpg")]private static const sampleImage1_jpg:Class;
		public static var sampleImage1:BitmapData;
		
		[Embed(source="im/sampleImage2.jpg")]private static const sampleImage2_jpg:Class;
		public static var sampleImage2:BitmapData;
		
		[Embed(source="im/sampleImage3.jpg")]private static const sampleImage3_jpg:Class;
		public static var sampleImage3:BitmapData;
		
		[Embed(source="im/add.jpg")]private static const add_jpg:Class;
		public static var add:BitmapData;
		
		[Embed(source="im/deco.jpg")]private static const deco_jpg:Class;
		public static var deco:BitmapData;
		
		[Embed(source="im/seeds.jpg")]private static const seeds_jpg:Class;
		public static var seeds:BitmapData;
		
		[Embed(source="im/fet.jpg")]private static const fet_jpg:Class;
		public static var fet:BitmapData;
		
		[Embed(source="im/TexturePan.JPG")]private static const TexturePan_jpg:Class;
		public static var pan:BitmapData;
		
		[Embed(source="im/TextureRotate.JPG")]private static const TextureRotate_jpg:Class;
		public static var rotate:BitmapData;
		
		[Embed(source="im/TextureLevelUp.JPG")]private static const TextureLevelUp_jpg:Class;
		public static var up:BitmapData;
		
		[Embed(source="im/TextureLevelDown.JPG")]private static const TextureLevelDown_jpg:Class;
		public static var down:BitmapData;
		
		[Embed(source="im/MirrorTexture.JPG")]private static const MirrorTexture_jpg:Class;
		public static var mirror:BitmapData;
		
		[Embed(source="im/VaseFront.PNG")]private static const VaseFront_PNG:Class;
		public static var vaseFront:Sprite = new Sprite();
		
		[Embed(source="im/VaseBack.PNG")]private static const VaseBack_PNG:Class;
		public static var vaseBack:Sprite = new Sprite();
		
		[Embed(source="im/BranchSample0.PNG")]private static const BranchSample0:Class;
		public static var branchSample0:Sprite = new Sprite();
		
		[Embed(source="im/BranchSample1.PNG")]private static const BranchSample1:Class;
		public static var branchSample1:Sprite = new Sprite();
		
		[Embed(source="im/BranchSample2.PNG")]private static const BranchSample2:Class;
		public static var branchSample2:Sprite = new Sprite();
		
		[Embed(source="im/BranchSample3.PNG")]private static const BranchSample3:Class;
		public static var branchSample3:Sprite = new Sprite();
		
		[Embed(source="im/mouseCursorMove.PNG")]private static const mouseCursorMove_png:Class;
		public static var mouseCursorMove:Sprite = new Sprite();
		
		[Embed(source="im/mouseCursorRotate.PNG")]private static const mouseCursorRotate_png:Class;
		public static var mouseCursorRotate:Sprite = new Sprite();
		
		//[Embed(source="swfLib/library.swf", symbol="symbol0")]
		//private static const symbol0:Class;
		
		//[Embed(source="sounds/sound0.mp3")]
		//private static const sound0:Class;
		
		//[Embed(source='fonts/FONT.ttf', fontName="Font", mimeType="application/x-font-truetype")]
		//private static const font0:String;
		
		//[Embed(systemFont='Verdana', fontName="Verdana", mimeType="application/x-font-truetype")] 
		//private static const font_verdana:String; 

		
		private static function createBitmaps():void {
			sampleImage0 = new sampleImage0_jpg().bitmapData.clone();
			sampleImage1 = new sampleImage1_jpg().bitmapData.clone();
			sampleImage2 = new sampleImage2_jpg().bitmapData.clone();
			sampleImage3 = new sampleImage3_jpg().bitmapData.clone();
			deco = new deco_jpg().bitmapData.clone();
			add = new add_jpg().bitmapData.clone();
			seeds = new seeds_jpg().bitmapData.clone();
			fet = new fet_jpg().bitmapData.clone();
			up = new TextureLevelUp_jpg().bitmapData.clone();
			down = new TextureLevelDown_jpg().bitmapData.clone();
			pan = new TexturePan_jpg().bitmapData.clone();
			rotate = new TextureRotate_jpg().bitmapData.clone();
			mirror = new MirrorTexture_jpg().bitmapData.clone();
			
			//{branches & cursors
			var branchSample0b:Bitmap = new Bitmap(new BranchSample0().bitmapData.clone());
			var branchSample1b:Bitmap = new Bitmap(new BranchSample1().bitmapData.clone());
			var branchSample2b:Bitmap = new Bitmap(new BranchSample2().bitmapData.clone());
			var branchSample3b:Bitmap = new Bitmap(new BranchSample3().bitmapData.clone());
			
			var cM:Bitmap = new Bitmap(new mouseCursorMove_png().bitmapData.clone());
			var cR:Bitmap = new Bitmap(new mouseCursorRotate_png().bitmapData.clone());
			
			for each(var i:Bitmap in [branchSample0b,branchSample1b,branchSample2b,branchSample3b, cR, cM]) {
				i.bitmapData.floodFill(1, 1, 0x00000000);
			}
			
			branchSample0.addChild(branchSample0b).y = -branchSample0b.height;
			branchSample1.addChild(branchSample1b).y = -branchSample1b.height;
			branchSample2.addChild(branchSample2b).y = -branchSample2b.height;
			branchSample3.addChild(branchSample3b).y = -branchSample3b.height;
			
			mouseCursorRotate.addChild(cR).y = -cR.height;
			mouseCursorMove.addChild(cM).y = -cM.height;
			
			for each(var ii:Sprite in [branchSample0,branchSample1,branchSample2,branchSample3, mouseCursorRotate, mouseCursorMove]) {
				ii.getChildAt(0).x = -ii.getChildAt(0).width/2;
			}
			mouseCursorMove.name = 'm'
			mouseCursorRotate.name = 'r'
			
			//}
			
			//{ Vase
			var f:BitmapData = new VaseFront_PNG().bitmapData.clone();
			var b:BitmapData = new VaseBack_PNG().bitmapData.clone();
			
			f.floodFill(1, 1, 0x00000000);
			b.floodFill(1, 1, 0x00000000);
			vaseFront.addChild(new Bitmap(f));
			vaseBack.addChild(new Bitmap(b));
			//} END OF Vase
		}
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]