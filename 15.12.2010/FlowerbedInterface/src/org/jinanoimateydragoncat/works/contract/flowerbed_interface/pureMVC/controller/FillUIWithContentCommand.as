// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.main.UI;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.model.UITestProxy;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.BookViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.ShopViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.StoreroomViewComponentMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	//} =^_^= END OF import
	
	
	/**
	 * заполнение интерфейса контентом
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:38
	 */
	public class FillUIWithContentCommand extends SimpleCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		function FillUIWithContentCommand () {
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override public function execute(note:INotification):void {
			var app:UI = note.getBody() as UI;
			
			var content:UITestProxy = facade.retrieveProxy(UITestProxy.NAME);
			
			var book:BookViewComponentMediator = facade.retrieveMediator(BookViewComponentMediator.NAME);
			book.setListData(content.book_title_, content.book_descr_, content.book_img_);
			
			var shop:ShopViewComponentMediator = facade.retrieveMediator(ShopViewComponentMediator.NAME);
			
			shop.setBalance(content.shopInterface_balance);
			shop.setAdditionalForagesContent(
				content.shopInterface_AdditionalForages_title,
				content.shopInterface_AdditionalForages_img,
				content.shopInterface_AdditionalForages_price,
				content.shopInterface_AdditionalForages_id);
			shop.setDecorationsContent(
				content.shopInterface_Decorations_title,
				content.shopInterface_Decorations_img,
				content.shopInterface_Decorations_price,
				content.shopInterface_Decorations_id);
			shop.setFertilizersContent(
				content.shopInterface_Fertilizers_title,
				content.shopInterface_Fertilizers_img,
				content.shopInterface_Fertilizers_price,
				content.shopInterface_Fertilizers_id);
			shop.setSeedsContent(
				content.shopInterface_Seeds_title,
				content.shopInterface_Seeds_img,
				content.shopInterface_Seeds_price,
				content.shopInterface_Seeds_id);
			
			//Vase:
			app.vaseInterface.show();
			var displayObject:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var checked:Vector.<Boolean> = new Vector.<Boolean>();
			var id:Vector.<uint> = new Vector.<uint>();
			var images:Array = [UILibrary.branchSample0, UILibrary.branchSample1, UILibrary.branchSample2, UILibrary.branchSample3];
			var l:uint = images.length;
			for (i = 0; i < l; i++ ) {
				checked.push(!true);
				id.push(i);
				displayObject.push(images.pop());
			}
			app.vaseInterface.setContent(displayObject, checked, id);
			app.vaseInterface.setVaseImage(UILibrary.vaseFront, UILibrary.vaseBack, UILibrary.vaseFront.height, -UILibrary.vaseFront.width/2, -25);
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