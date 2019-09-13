// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.model {
	
	//{ =^_^= import
	import flash.display.BitmapData;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:34
	 */
	public class UITestProxy extends Proxy {
		
		//{ =^_^= CONSTRUCTOR
		
		function UITestProxy () {
			proxyName = NAME;
			
			initTestVars();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public static const NAME:String = 'UITestProxy';
		
		public var infoPanel_levelText:String;
		public var infoPanel_ratingText:String;
		public var infoPanel_balanceText:String;
		
		public var shopInterface_balance:Number;
		
		//Fertilizers
		public var shopInterface_Fertilizers_title:Vector.<String> = new Vector.<String>();
		public var shopInterface_Fertilizers_img:Vector.<BitmapData> = new Vector.<BitmapData>();
		public var shopInterface_Fertilizers_id:Vector.<uint> = new Vector.<uint>();
		public var shopInterface_Fertilizers_price:Vector.<Number> = new Vector.<Number>();
		//AdditionalForages
		public var shopInterface_AdditionalForages_title:Vector.<String> = new Vector.<String>();
		public var shopInterface_AdditionalForages_img:Vector.<BitmapData> = new Vector.<BitmapData>();
		public var shopInterface_AdditionalForages_id:Vector.<uint> = new Vector.<uint>();
		public var shopInterface_AdditionalForages_price:Vector.<Number> = new Vector.<Number>();
		//Decorations
		public var shopInterface_Decorations_title:Vector.<String> = new Vector.<String>();
		public var shopInterface_Decorations_img:Vector.<BitmapData> = new Vector.<BitmapData>();
		public var shopInterface_Decorations_id:Vector.<uint> = new Vector.<uint>();
		public var shopInterface_Decorations_price:Vector.<Number> = new Vector.<Number>();
		//Seeds
		public var shopInterface_Seeds_title:Vector.<String> = new Vector.<String>();
		public var shopInterface_Seeds_img:Vector.<BitmapData> = new Vector.<BitmapData>();
		public var shopInterface_Seeds_id:Vector.<uint> = new Vector.<uint>();
		public var shopInterface_Seeds_price:Vector.<Number> = new Vector.<Number>();
		
		
		public var book_title_:Array = []
		public var book_descr_:Array = [];
		public var book_img_:Array = [];
		
		
		private function initTestVars():void {
			//{панель справа сверху
			infoPanel_levelText = '4';
			infoPanel_ratingText = '55';
			infoPanel_balanceText = '8444';
			//}
			
			//{ магазин : заполнение контентом(для демонстрации)
			shopInterface_balance = 9996;
			var lastUsedID:uint = 0;
			
			shopInterface_Fertilizers_title.push('удобр 1');
			shopInterface_Fertilizers_title.push('удобр 2');
			shopInterface_Fertilizers_title.push('удобр 3');
			shopInterface_Fertilizers_title.push('удобр 4');
			shopInterface_Fertilizers_title.push('удобр 5');
			shopInterface_Fertilizers_title.push('удобр 6');
			shopInterface_Fertilizers_title.push('удобр 7');
			shopInterface_Fertilizers_title.push('удобр 8');
			
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			shopInterface_Fertilizers_img.push(UILibrary.sampleImage1);
			
			shopInterface_Fertilizers_id.push(lastUsedID++ );
			shopInterface_Fertilizers_id.push(lastUsedID++);
			shopInterface_Fertilizers_id.push(lastUsedID++ );
			shopInterface_Fertilizers_id.push(lastUsedID++);
			shopInterface_Fertilizers_id.push(lastUsedID++ );
			shopInterface_Fertilizers_id.push(lastUsedID++);
			shopInterface_Fertilizers_id.push(lastUsedID++ );
			shopInterface_Fertilizers_id.push(lastUsedID++);
			
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			shopInterface_Fertilizers_price.push(Math.ceil(Math.random()*700));
			//
			
			shopInterface_AdditionalForages_title.push('подкормка 1');
			shopInterface_AdditionalForages_title.push('подкормка 2');
			shopInterface_AdditionalForages_title.push('подкормка 3');
			shopInterface_AdditionalForages_title.push('подкормка 4');
			shopInterface_AdditionalForages_title.push('подкормка 5');
			shopInterface_AdditionalForages_title.push('подкормка 6');
			
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			shopInterface_AdditionalForages_img.push(UILibrary.sampleImage2);
			
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			shopInterface_AdditionalForages_id.push(lastUsedID++);
			
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			shopInterface_AdditionalForages_price.push(Math.ceil(Math.random()*700));
			//
			
			
			shopInterface_Decorations_title.push('украшение 1');
			shopInterface_Decorations_title.push('украшение 2');
			shopInterface_Decorations_title.push('украшение 3');
			shopInterface_Decorations_title.push('украшение 4');
			shopInterface_Decorations_title.push('украшение 5');
			shopInterface_Decorations_title.push('украшение 6');
			shopInterface_Decorations_title.push('украшение 7');
			shopInterface_Decorations_title.push('украшение 7');
			
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			shopInterface_Decorations_img.push(UILibrary.sampleImage3);
			
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			shopInterface_Decorations_id.push(lastUsedID++);
			
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			shopInterface_Decorations_price.push(Math.ceil(Math.random()*700));
			//
			
			
			shopInterface_Seeds_title.push('семена 1');
			shopInterface_Seeds_title.push('семена 2');
			shopInterface_Seeds_title.push('семена 3');
			shopInterface_Seeds_title.push('семена 4');
			//title.push('семена 5');title.push('семена 6');
			
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			shopInterface_Seeds_img.push(UILibrary.sampleImage0);
			
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			shopInterface_Seeds_id.push(lastUsedID++);
			
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			shopInterface_Seeds_price.push(Math.ceil(Math.random()*700));
			
			//}
			
			//{ книга : заполнение контентом(для демонстрации)
			for (var i:uint = 0; i < 21; i++) {
				book_title_.push('Растение#'+ i);
				book_descr_.push('Описание\nрастения\n#'+ i);
				book_img_.push(UILibrary['sampleImage'+(i%4)]);
			}
			//}
			
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]