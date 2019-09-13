// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.events.UIEvents;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.UIApplicationFacade;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.ShopViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.StoreroomViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.VaseViewComponentMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	//} =^_^= END OF import
	
	
	/**
	 * действия(купить, использовать)
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:40
	 */
	public class UIActionCommand extends SimpleCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		function UIActionCommand () {
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override public function execute(note:INotification):void {
			switch (note.getName()) {
			
			case ShopViewComponentMediator.EVENT_ACTIVATE_ITEM:
				UIApplicationFacade.application.tf.setText('магазин: купить предмет с id#'+ note.getBody());
				break;
			
			case StoreroomViewComponentMediator.EVENT_ACTIVATE_ITEM:
				UIApplicationFacade.application.tf.setText('склад: использовать предмет с id#'+ note.getBody());
				break;
			
			case VaseViewComponentMediator.EVENT_BOUQUET_CREATED:
				UIApplicationFacade.application.tf.setText('ваза: букет готов');
				var bd:BitmapData = note.getBody().bitmapData;
				var spRect:Sprite = new Sprite();
				spRect.graphics.lineStyle(0, 0xFF0000, 1);
				spRect.graphics.drawRect(0, 0, bd.width- 1, bd.height- 1);
				bd.draw(spRect);
				UIApplicationFacade.application.showImage('результат:', new Bitmap(bd));
				UIApplicationFacade.application.vaseInterface.hide();
				break;
			
			case VaseViewComponentMediator.EVENT_CHANGE_MOUSE_CURSOR:
			switch (uint(note.getBody())) {
				
					case UIEvents.ID_CURSOR_TYPE_MOVE:
						UIApplicationFacade.application.setMouseCursor(UILibrary.mouseCursorMove);
						break;
					
					case UIEvents.ID_CURSOR_TYPE_ROTATE:
						UIApplicationFacade.application.setMouseCursor(UILibrary.mouseCursorRotate);
						break;
					
					case UIEvents.ID_CURSOR_TYPE_DEFAULT:
						UIApplicationFacade.application.setMouseCursor(null);
						break;
					
					
					}
				break;
			
			
			}
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]