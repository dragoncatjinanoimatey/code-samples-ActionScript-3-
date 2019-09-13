// Project FlowerPhysics
package {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	//} =^_^= END OF import
	
	
	/**
	 * Library contains image BitmapData available through public static properties. Call "initializeLibrary" static method before using Library.
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 
	 */
	public class FlowerPhysicsLib {
		
		//{ =^_^= EMBED AND PREPARE
		
		[Embed(source="FlowerPhysicsLibrary.swf",mimeType="application/octet-stream")]
		public static const FlowerPhysicsLibrary_swf:Class;
		
		//[Embed(source="images/image0.jpg")]private static const image0_jpg:Class;
		//public static var image0:BitmapData;
		
		//[Embed(source="swfLib/library.swf", symbol="symbol0")]
		//public static const symbol0:Class;
		
		//[Embed(source="sounds/sound0.mp3")]
		//public static const sound0:Class;
		
		//[Embed(source='fonts/FONT.ttf', fontName="Font", mimeType="application/x-font-truetype")]
		//public static const font0:String;
		
		//[Embed(systemFont='Verdana', fontName="Verdana", mimeType="application/x-font-truetype")] 
		//public static const font_verdana:String; 
		

		
		//} =^_^= END OF EMBED AND PREPARE
	
		
		//{ =^_^= CONSTRUCTOR
		function FlowerPhysicsLib () {throw(new ArgumentError('Library contains images that are available through public static properties. Invoke "initialize" static method before using Library.'));}
		//} =^_^= END OF CONSTRUCTOR
		
		
		
		
		/**
		 * prepare library for using
		 */
		public static function initialize():void{
			createBitmaps();
			//processBitmaps();
		}
		private static function createBitmaps():void {
			//image0 = new image0_jpg().bitmapData.clone();
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]